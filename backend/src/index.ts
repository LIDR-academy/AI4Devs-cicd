import { Request, Response, NextFunction } from 'express';
import express from 'express';
import { PrismaClient } from '@prisma/client';
import dotenv from 'dotenv';
import candidateRoutes from './routes/candidateRoutes';
import positionRoutes from './routes/positionRoutes';
import { uploadFile } from './application/services/fileUploadService';
import cors from 'cors';
import helmet from 'helmet';
import rateLimit from 'express-rate-limit';

// Extender la interfaz Request para incluir prisma
declare global {
  namespace Express {
    interface Request {
      prisma: PrismaClient;
    }
  }
}

dotenv.config();
const prisma = new PrismaClient();

export const app = express();
export default app;

// Security: Add helmet to set secure HTTP headers
app.use(helmet());

// Security: Limit JSON payload size to prevent DoS attacks
app.use(express.json({ limit: '10mb' }));

// Security: Rate limiting to prevent brute force and DoS attacks
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP, please try again later.',
  standardHeaders: true,
  legacyHeaders: false,
});
app.use(limiter);

// Middleware para adjuntar prisma al objeto de solicitud
app.use((req, res, next) => {
  req.prisma = prisma;
  next();
});

// Security: Configure CORS from environment variable
const corsOrigin = process.env.CORS_ORIGIN || 'http://localhost:4000';
app.use(cors({
  origin: corsOrigin,
  credentials: true
}));

// Logging middleware - should be before routes
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// Import and use candidateRoutes
app.use('/candidates', candidateRoutes);

// Route for file uploads
app.post('/upload', uploadFile);

// Route to get candidates by position
app.use('/positions', positionRoutes);

const port = 8080;

app.get('/', (req, res) => {
  res.send('Hola LTI!');
});

// Security: Improved error handling without exposing stack traces in production
app.use((err: any, req: Request, res: Response, next: NextFunction) => {
  // Log error for debugging (should use proper logging in production)
  console.error(err.stack);
  
  // Don't expose stack traces in production
  const isProduction = process.env.NODE_ENV === 'production';
  res.status(err.status || 500).json({
    error: {
      message: isProduction ? 'Internal server error' : err.message,
      ...(isProduction ? {} : { stack: err.stack })
    }
  });
});
app.listen(port, () => {
  console.log(`Server is running at http://yourip:${port}`);
});

