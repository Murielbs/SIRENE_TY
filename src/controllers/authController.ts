// src/controllers/authController.ts
import { Request, Response } from 'express';
import bcrypt from 'bcryptjs';
import prisma from '../models/prisma';

export const register = async (req: Request, res: Response) => {
    try {
        const { nome, matricula, posto, email, senha, perfil_acesso } = req.body;

        if (!email || !senha || !perfil_acesso) {
            return res.status(400).json({ message: 'Email, senha e perfil de acesso são obrigatórios.' });
        }

        const hashedPassword = await bcrypt.hash(senha, 10);

        const novoMilitar = await prisma.militar.create({
            data: {
                nome,
                matricula,
                posto,
                email,
                senha_hash: hashedPassword,
                perfil_acesso,
            },
        });

        res.status(201).json({ message: 'Usuário registrado com sucesso!', militar: novoMilitar });
    } catch (error) {
        if (error.code === 'P2002') {
            return res.status(409).json({ message: 'Já existe um militar com essa matrícula.' });
        }
        res.status(500).json({ message: 'Erro ao registrar usuário.', error });
    }
};

export const login = async (req: Request, res: Response) => {
    // A lógica de login será implementada aqui em seguida
};