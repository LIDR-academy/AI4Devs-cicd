# Security Review Findings and Remediation

**Date**: October 2, 2025  
**Project**: LTI - Sistema de Seguimiento de Talento (Backend)  
**Reviewer**: Copilot Security Agent

## Executive Summary

A comprehensive security review was conducted on the backend codebase. Multiple vulnerabilities and security issues were identified and remediated. This document details the findings, actions taken, and recommendations for ongoing security maintenance.

## Findings and Remediation

### 1. Vulnerable Dependencies (HIGH) ✅ FIXED

**Finding**: The project had 9 npm package vulnerabilities:
- 4 low severity
- 2 moderate severity  
- 3 high severity

**Vulnerable Packages Identified**:
- `@babel/helpers` - Inefficient RegExp complexity
- `brace-expansion` - ReDoS vulnerability
- `cookie` - Out of bounds characters acceptance
- `cross-spawn` - ReDoS vulnerability
- `micromatch` - ReDoS vulnerability
- `path-to-regexp` - ReDoS vulnerability
- `send` - Template injection leading to XSS
- `express` - Depends on vulnerable packages
- `serve-static` - Depends on vulnerable packages

**Remediation**: 
- Executed `npm audit fix` which updated 17 packages
- All vulnerabilities successfully resolved
- No breaking changes introduced

**Verification**: `npm audit` now reports 0 vulnerabilities

---

### 2. Missing Security Headers (HIGH) ✅ FIXED

**Finding**: Application did not set any security-related HTTP headers, leaving it vulnerable to various attacks including:
- Clickjacking attacks
- XSS attacks
- MIME type sniffing
- DNS prefetch attacks

**Remediation**:
- Installed and configured `helmet` (v8.0.0)
- Automatically sets secure headers including:
  - `X-DNS-Prefetch-Control: off`
  - `X-Frame-Options: SAMEORIGIN`
  - `Strict-Transport-Security` (when HTTPS is used)
  - `X-Download-Options: noopen`
  - `X-Content-Type-Options: nosniff`
  - `X-XSS-Protection: 0` (modern approach)

**Code Change**: `backend/src/index.ts`
```typescript
import helmet from 'helmet';
app.use(helmet());
```

---

### 3. No Rate Limiting (HIGH) ✅ FIXED

**Finding**: API endpoints had no rate limiting, making the application vulnerable to:
- Brute force attacks
- Denial of Service (DoS) attacks
- Resource exhaustion
- Credential stuffing attacks

**Remediation**:
- Installed and configured `express-rate-limit` (v7.5.0)
- Configuration:
  - Window: 15 minutes
  - Max requests: 100 per IP per window
  - Standard headers enabled for client feedback
  - Clear error message for rate-limited requests

**Code Change**: `backend/src/index.ts`
```typescript
import rateLimit from 'express-rate-limit';

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP, please try again later.',
  standardHeaders: true,
  legacyHeaders: false,
});
app.use(limiter);
```

**Recommendation**: Consider implementing more granular rate limits for sensitive endpoints (e.g., login, registration).

---

### 4. Path Traversal Vulnerability (MEDIUM) ✅ FIXED

**Finding**: File upload functionality did not properly sanitize filenames, potentially allowing path traversal attacks through malicious filenames like:
- `../../../etc/passwd`
- `..\\..\\..\\windows\\system32\\config\\sam`

**Remediation**:
- Implemented filename sanitization function
- Extracts only the basename (removes path components)
- Replaces potentially dangerous characters with underscores
- Validates CV file paths to ensure they start with `uploads/`
- Blocks paths containing `..` or `~`

**Code Changes**:

`backend/src/application/services/fileUploadService.ts`:
```typescript
import path from 'path';

const sanitizeFilename = (filename: string): string => {
    const baseName = path.basename(filename);
    return baseName.replace(/[^a-zA-Z0-9.-]/g, '_');
};
```

`backend/src/application/validator.ts`:
```typescript
if (cv.filePath.includes('..') || cv.filePath.includes('~') || !cv.filePath.startsWith('uploads/')) {
    throw new Error('Invalid file path');
}
```

---

### 5. Uncontrolled Request Size (MEDIUM) ✅ FIXED

**Finding**: No limit on JSON payload size, allowing potential DoS attacks through:
- Extremely large JSON payloads
- Memory exhaustion
- Service unavailability

**Remediation**:
- Set JSON body parser limit to 10MB
- Protects against memory exhaustion attacks
- Still allows reasonable file metadata and candidate data

**Code Change**: `backend/src/index.ts`
```typescript
app.use(express.json({ limit: '10mb' }));
```

---

### 6. Information Disclosure via Error Messages (MEDIUM) ✅ FIXED

**Finding**: Stack traces were exposed in all error responses, potentially revealing:
- Internal application structure
- File paths and directory structure
- Library versions
- Implementation details

**Remediation**:
- Modified error handler to check NODE_ENV
- Stack traces only shown in development
- Generic error messages in production
- Maintains detailed logging for debugging

**Code Change**: `backend/src/index.ts`
```typescript
app.use((err: any, req: Request, res: Response, next: NextFunction) => {
  console.error(err.stack); // Still log for debugging
  
  const isProduction = process.env.NODE_ENV === 'production';
  res.status(err.status || 500).json({
    error: {
      message: isProduction ? 'Internal server error' : err.message,
      ...(isProduction ? {} : { stack: err.stack })
    }
  });
});
```

---

### 7. Hardcoded Configuration Values (MEDIUM) ✅ FIXED

**Finding**: CORS origin was hardcoded to `http://localhost:4000`, making it:
- Difficult to configure for different environments
- Potentially allowing unintended origins in production

**Remediation**:
- Moved CORS origin to environment variable
- Created `.env.example` template
- Maintains backward compatibility with fallback value

**Code Change**: `backend/src/index.ts`
```typescript
const corsOrigin = process.env.CORS_ORIGIN || 'http://localhost:4000';
app.use(cors({
  origin: corsOrigin,
  credentials: true
}));
```

**New File**: `backend/.env.example`
```env
CORS_ORIGIN=http://localhost:4000
```

---

### 8. Insufficient File Type Validation (MEDIUM) ✅ FIXED

**Finding**: While file types were checked, validation could be bypassed and wasn't consistently enforced across the application.

**Remediation**:
- Enhanced CV validator with strict MIME type checking
- Only allows: `application/pdf` and `application/vnd.openxmlformats-officedocument.wordprocessingml.document`
- Centralized validation logic

**Code Change**: `backend/src/application/validator.ts`
```typescript
const allowedMimeTypes = [
  'application/pdf', 
  'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
];
if (!allowedMimeTypes.includes(cv.fileType)) {
    throw new Error('Invalid file type');
}
```

---

### 9. Logging Middleware Placement (LOW) ✅ FIXED

**Finding**: Logging middleware was placed after route definitions, causing:
- Inconsistent logging
- Missed requests to defined routes
- Difficulty in debugging and monitoring

**Remediation**:
- Moved logging middleware before route definitions
- Ensures all requests are logged
- Includes timestamp, method, and path

**Code Change**: `backend/src/index.ts` - Moved logging middleware to occur before route registration

---

### 10. .gitignore Configuration (LOW) ✅ FIXED

**Finding**: `.gitignore` had `.env` files commented out, potentially allowing sensitive files to be committed.

**Remediation**:
- Uncommented `.env` exclusion
- Added additional patterns: `.env.local`, `.env.*.local`
- Added comment to allow `.env.example` files
- Created `.env.example` template

**Note**: Existing `.env` files with credentials are already tracked in git history. These should be:
1. Removed from git history using `git filter-branch` or BFG Repo-Cleaner
2. Database credentials should be rotated immediately

---

## Outstanding Security Concerns

### 1. No Authentication/Authorization (CRITICAL) ⚠️

**Finding**: All API endpoints are publicly accessible without any authentication.

**Impact**: 
- Anyone can create, read, update candidate data
- No audit trail of who performed actions
- No way to restrict access to sensitive information

**Recommendation**: Implement authentication before production deployment:
- JWT-based authentication
- Role-based access control (RBAC)
- Protect all endpoints except health checks
- Consider using libraries like `passport.js` or `jsonwebtoken`

**Example Architecture**:
```
User → Login → JWT Token → Protected Endpoints
                    ↓
             Verify & Decode → Check Permissions → Allow/Deny
```

---

### 2. Credentials in Git History (HIGH) ⚠️

**Finding**: `.env` files with actual database credentials were committed to git.

**Impact**: 
- Credentials are permanently in repository history
- Anyone with access to the repository has database credentials
- Credentials can be found even after files are deleted

**Immediate Actions Required**:
1. **Rotate all credentials immediately**
   - Change database password
   - Update connection strings
   - Update any API keys

2. **Remove from git history**:
```bash
# Option 1: BFG Repo-Cleaner (recommended)
git clone --mirror git://example.com/repo.git
java -jar bfg.jar --delete-files '.env' repo.git
cd repo.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git push

# Option 2: git filter-branch
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch backend/.env .env" \
  --prune-empty --tag-name-filter cat -- --all
```

3. **Use secrets management**:
   - AWS Secrets Manager
   - HashiCorp Vault
   - Azure Key Vault
   - Environment variables in CI/CD

---

### 3. Database Security (MEDIUM) ⚠️

**Recommendations**:
- Implement connection pooling with limits
- Use read-only database users where appropriate
- Enable SSL/TLS for database connections
- Implement query timeouts
- Regular database backups with encryption
- Monitor for unusual query patterns
- Use prepared statements (already done via Prisma)

---

### 4. HTTPS/TLS Not Enforced (MEDIUM) ⚠️

**Finding**: Application runs on HTTP in development.

**Recommendation**:
- Use HTTPS in all environments
- Configure reverse proxy (nginx, Cloudflare) for TLS termination
- Add HSTS headers (already done via helmet when HTTPS detected)
- Consider automatic HTTP to HTTPS redirect

---

### 5. File Upload Storage (MEDIUM) ⚠️

**Current State**: Files stored on local filesystem

**Recommendations**:
- Move to object storage (AWS S3, Azure Blob Storage)
- Store files outside web root
- Implement virus scanning (ClamAV integration)
- Add file size limits per user/organization
- Implement file cleanup for old/orphaned files
- Generate presigned URLs for downloads
- Don't serve files directly from application

---

### 6. Logging and Monitoring (MEDIUM) ⚠️

**Current State**: Basic console logging

**Recommendations**:
- Implement structured logging (Winston, Pino)
- Log security events:
  - Failed authentication attempts
  - Rate limit violations
  - Validation failures
  - File upload attempts
- Centralize logs (ELK Stack, CloudWatch, Datadog)
- Set up alerts for suspicious patterns
- Don't log sensitive data (passwords, tokens, PII)

---

### 7. Input Validation (LOW) ⚠️

**Current State**: Good basic validation

**Additional Recommendations**:
- Add email verification for new candidates
- Implement phone number validation with international format support
- Add HTML sanitization if rich text is supported
- Consider using validation libraries like `joi` or `yup`
- Validate file content, not just extensions

---

## Security Testing Recommendations

### Manual Testing
- [ ] Test rate limiting with rapid requests
- [ ] Verify helmet headers in HTTP responses
- [ ] Test file upload with malicious filenames
- [ ] Verify path traversal protection
- [ ] Test with oversized JSON payloads
- [ ] Verify production error messages don't expose details
- [ ] Test CORS with different origins

### Automated Testing
- [ ] Set up `npm audit` in CI/CD pipeline
- [ ] Add security-focused integration tests
- [ ] Configure Dependabot or Renovate for dependency updates
- [ ] Consider SAST tools (Snyk, SonarQube)
- [ ] Run DAST tools (OWASP ZAP, Burp Suite)

### Penetration Testing
- [ ] Schedule professional penetration testing before production
- [ ] Test for OWASP Top 10 vulnerabilities
- [ ] Review authentication/authorization once implemented

---

## Compliance Considerations

Depending on your use case, consider:

- **GDPR**: If handling EU citizen data
  - Right to erasure (delete candidate data)
  - Data portability
  - Consent management
  - Privacy policy

- **CCPA**: If handling California resident data
  - Similar to GDPR requirements

- **SOC 2**: If selling to enterprises
  - Access controls
  - Audit logging
  - Incident response

---

## Security Maintenance Plan

### Daily
- Monitor application logs for errors and anomalies
- Review rate limit violations

### Weekly
- Review security logs
- Check for failed authentication attempts (once implemented)

### Monthly
- Run `npm audit` and update dependencies
- Review and update firewall rules
- Check for new CVEs affecting your stack

### Quarterly
- Security code review
- Update security documentation
- Review and test incident response procedures
- Update dependencies to latest stable versions

### Annually
- Professional security audit
- Penetration testing
- Review and update security policies

---

## Incident Response

If a security incident occurs:

1. **Contain**: Isolate affected systems
2. **Assess**: Determine scope and impact
3. **Eradicate**: Remove the threat
4. **Recover**: Restore normal operations
5. **Document**: Record timeline and actions
6. **Learn**: Update procedures to prevent recurrence

---

## Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/)
- [Node.js Security Best Practices](https://nodejs.org/en/docs/guides/security/)
- [Express Security Best Practices](https://expressjs.com/en/advanced/best-practice-security.html)
- [npm Security Best Practices](https://docs.npmjs.com/security-best-practices)

---

## Conclusion

The security review identified and remediated 10 security issues in the backend codebase. All high and medium priority issues within scope have been addressed. The application now has:

✅ No vulnerable dependencies  
✅ Security headers configured  
✅ Rate limiting protection  
✅ Input sanitization and validation  
✅ Secure error handling  
✅ Protected against common attacks  

However, critical work remains:

⚠️ **Authentication/Authorization must be implemented before production**  
⚠️ **Database credentials must be rotated and removed from git history**  
⚠️ **HTTPS must be configured for production**  

The codebase is significantly more secure, but should not be deployed to production without addressing the outstanding critical concerns, particularly authentication.
