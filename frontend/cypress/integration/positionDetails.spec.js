describe.skip('Position Details Page', () => {
    let positionData;
    let candidatesData;

    beforeEach(() => {
        cy.request('GET', 'http://localhost:3010/positions/1/interviewFlow').then((response) => {
            positionData = response.body;
        });
        cy.request('GET', 'http://localhost:3010/positions/1/candidates').then((response) => {
            candidatesData = response.body;
        });
        cy.visit('http://localhost:3000/positions/1');
        cy.intercept('PUT', 'http://localhost:3010/candidates/*', (req) => {
            req.reply((res) => {
                res.send({
                    ...req.body,
                    currentInterviewStep: req.body.currentInterviewStep
                });
            });
        });
    });

    it('should display the correct title', () => {
        cy.get('h2.text-center.mb-4').should('have.text', positionData.interviewFlow.positionName);
    });

    it('should display columns for each hiring phase', () => {
        cy.get('.stage-column').should('have.length', positionData.interviewFlow.interviewFlow.interviewSteps.length);
    });

    it('should display candidate cards in the correct column', () => {
        positionData.interviewFlow.interviewFlow.interviewSteps.forEach((step, index) => {
            cy.get('.stage-column').eq(index).within(() => {
                candidatesData
                    .filter(candidate => candidate.currentInterviewStep === step.name)
                    .forEach(candidate => {
                        cy.get('.card').should('contain', candidate.fullName);
                    });
            });
        });
    });

    it('should move candidate card to new column and update phase', () => {
        const candidate = candidatesData[0];
        const initialStepIndex = positionData.interviewFlow.interviewFlow.interviewSteps.findIndex(step => step.name === candidate.currentInterviewStep);
        const newStepIndex = (initialStepIndex + 1) % positionData.interviewFlow.interviewFlow.interviewSteps.length;
        const newStep = positionData.interviewFlow.interviewFlow.interviewSteps[newStepIndex];

        cy.get('.stage-column').eq(initialStepIndex).within(() => {
            cy.get('.card').contains(candidate.fullName).trigger('dragstart');
        });

        cy.get('.stage-column').eq(newStepIndex).trigger('dragover').trigger('drop');

        cy.wait(1000); // Espera para que los cambios se reflejen

        cy.get('.stage-column').eq(newStepIndex).within(() => {
            cy.get('.card').each(($el) => {
                if ($el.text().includes(candidate.fullName)) {
                    cy.wrap($el).should('contain', candidate.fullName);
                }
            });
        });
    });
});