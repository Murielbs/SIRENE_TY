-- CreateTable
CREATE TABLE `Militar` (
    `id_militar` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(100) NOT NULL,
    `matricula` VARCHAR(20) NOT NULL,
    `posto` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `senha_hash` VARCHAR(255) NOT NULL,
    `perfil_acesso` VARCHAR(20) NOT NULL,

    UNIQUE INDEX `Militar_matricula_key`(`matricula`),
    PRIMARY KEY (`id_militar`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Equipe` (
    `id_equipe` INTEGER NOT NULL AUTO_INCREMENT,
    `nome_equipe` VARCHAR(100) NOT NULL,
    `turno` VARCHAR(20) NOT NULL,
    `id_militar_lider` INTEGER NULL,

    PRIMARY KEY (`id_equipe`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Ocorrencia` (
    `id_ocorrencia` INTEGER NOT NULL AUTO_INCREMENT,
    `data_hora` TIMESTAMP NOT NULL,
    `tipo_ocorrencia` VARCHAR(50) NOT NULL,
    `descricao` TEXT NULL,
    `localizacao_gps` VARCHAR(100) NULL,
    `status` VARCHAR(20) NOT NULL,
    `assinatura_digital` TEXT NULL,
    `foto_url` TEXT NULL,
    `video_url` TEXT NULL,
    `modo_treinamento` BOOLEAN NOT NULL,

    PRIMARY KEY (`id_ocorrencia`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RegistroOcorrencia` (
    `id_registro` INTEGER NOT NULL AUTO_INCREMENT,
    `id_ocorrencia` INTEGER NOT NULL,
    `id_militar` INTEGER NOT NULL,
    `id_equipe` INTEGER NOT NULL,
    `data_registro` TIMESTAMP NOT NULL,
    `observacoes` TEXT NULL,

    PRIMARY KEY (`id_registro`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `LogAuditoria` (
    `id_log` INTEGER NOT NULL AUTO_INCREMENT,
    `id_militar` INTEGER NOT NULL,
    `acao` TEXT NULL,
    `data_hora` TIMESTAMP NOT NULL,
    `ip_origem` VARCHAR(45) NULL,

    PRIMARY KEY (`id_log`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Relatorio` (
    `id_relatorio` INTEGER NOT NULL AUTO_INCREMENT,
    `id_ocorrencia` INTEGER NOT NULL,
    `gerado_por` INTEGER NOT NULL,
    `data_geracao` TIMESTAMP NOT NULL,
    `formato` VARCHAR(10) NOT NULL,
    `url_arquivo` TEXT NULL,

    PRIMARY KEY (`id_relatorio`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MilitarEquipe` (
    `id_militar` INTEGER NOT NULL,
    `id_equipe` INTEGER NOT NULL,
    `data_entrada` DATE NULL,
    `data_saida` DATE NULL,

    PRIMARY KEY (`id_militar`, `id_equipe`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Equipe` ADD CONSTRAINT `Equipe_id_militar_lider_fkey` FOREIGN KEY (`id_militar_lider`) REFERENCES `Militar`(`id_militar`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RegistroOcorrencia` ADD CONSTRAINT `RegistroOcorrencia_id_ocorrencia_fkey` FOREIGN KEY (`id_ocorrencia`) REFERENCES `Ocorrencia`(`id_ocorrencia`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RegistroOcorrencia` ADD CONSTRAINT `RegistroOcorrencia_id_militar_fkey` FOREIGN KEY (`id_militar`) REFERENCES `Militar`(`id_militar`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RegistroOcorrencia` ADD CONSTRAINT `RegistroOcorrencia_id_equipe_fkey` FOREIGN KEY (`id_equipe`) REFERENCES `Equipe`(`id_equipe`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LogAuditoria` ADD CONSTRAINT `LogAuditoria_id_militar_fkey` FOREIGN KEY (`id_militar`) REFERENCES `Militar`(`id_militar`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Relatorio` ADD CONSTRAINT `Relatorio_id_ocorrencia_fkey` FOREIGN KEY (`id_ocorrencia`) REFERENCES `Ocorrencia`(`id_ocorrencia`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Relatorio` ADD CONSTRAINT `Relatorio_gerado_por_fkey` FOREIGN KEY (`gerado_por`) REFERENCES `Militar`(`id_militar`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MilitarEquipe` ADD CONSTRAINT `MilitarEquipe_id_militar_fkey` FOREIGN KEY (`id_militar`) REFERENCES `Militar`(`id_militar`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MilitarEquipe` ADD CONSTRAINT `MilitarEquipe_id_equipe_fkey` FOREIGN KEY (`id_equipe`) REFERENCES `Equipe`(`id_equipe`) ON DELETE RESTRICT ON UPDATE CASCADE;
