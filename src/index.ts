// src/index.ts
import express, { Express, Request, Response } from 'express';
import dotenv from 'dotenv';
import authRoutes from './routes/authRoutes';

dotenv.config();

const app: Express = express();
const PORT = process.env.PORT || 3000;

app.use(express.json()); // Habilita o express para ler JSON

// Conecte as rotas de autenticação
app.use('/api/auth', authRoutes);

// Rota de teste para ver se o servidor está online
app.get('/', (req: Request, res: Response) => {
  res.send('Servidor do Projeto Integrador de Bombeiros rodando!');
});

app.listen(PORT, () => {
  console.log(`🚀 Servidor rodando na porta ${PORT}`);
});