SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `db_cva` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `db_cva`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_clientes_delete` (IN `pid` INT(6))  BEGIN

	DELETE FROM tb_clientes WHERE id = pid;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_clientes_save` (IN `pnomeCliente` VARCHAR(56), IN `pcontatoLocal` VARCHAR(56), IN `pcpf` VARCHAR(14), IN `pcnpj` VARCHAR(18), IN `pinscricaoEstadual` VARCHAR(15), IN `ptelefone` VARCHAR(56), IN `pcelular` VARCHAR(56), IN `pcep` VARCHAR(9), IN `pendereco` VARCHAR(112), IN `pbairro` VARCHAR(56), IN `pcidade` VARCHAR(56), IN `pestado` VARCHAR(2), IN `pemail` VARCHAR(56), IN `pemails` VARCHAR(224), IN `pobservacao` VARCHAR(112), IN `ptipo` VARCHAR(2), IN `palteradoPor` VARCHAR(56), IN `palteradoEm` VARCHAR(16))  BEGIN

	INSERT INTO tb_clientes (nomeCliente, contatoLocal, cpf, cnpj, inscricaoEstadual, telefone, celular, cep, endereco, bairro, cidade, estado, email, emails, observacao, tipo, alteradoPor, alteradoEm)
			VALUES (pnomeCliente, pcontatoLocal, pcpf, pcnpj, pinscricaoEstadual, ptelefone, pcelular, pcep, pendereco, pbairro, pcidade, pestado, pemail, pemails, pobservacao, ptipo, palteradoPor, palteradoEm);

	SELECT * FROM tb_clientes WHERE id = LAST_INSERT_ID();

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_clientes_update` (IN `pid` INT(6), IN `pnomeCliente` VARCHAR(56), IN `pcontatoLocal` VARCHAR(56), IN `pcpf` VARCHAR(14), IN `pcnpj` VARCHAR(18), IN `pinscricaoEstadual` VARCHAR(15), IN `ptelefone` VARCHAR(56), IN `pcelular` VARCHAR(56), IN `pcep` VARCHAR(9), IN `pendereco` VARCHAR(112), IN `pbairro` VARCHAR(56), IN `pcidade` VARCHAR(56), IN `pestado` VARCHAR(2), IN `pemail` VARCHAR(56), IN `pemails` VARCHAR(224), IN `pobservacao` VARCHAR(112), IN `ptipo` VARCHAR(2), IN `palteradoPor` VARCHAR(56), IN `palteradoEm` VARCHAR(16))  BEGIN

	UPDATE tb_clientes
		SET nomeCliente = pnomeCliente,
			contatoLocal = pcontatoLocal,
            cpf = pcpf,
            cnpj = pcnpj,
            inscricaoEstadual = pinscricaoEstadual,
            telefone = ptelefone,
            celular = pcelular,
            cep = pcep,
            endereco = pendereco,
            bairro = pbairro,
            cidade = pcidade,
            estado = pestado,
            email = pemail,
            emails = pemails,
            observacao = pobservacao,
            tipo = ptipo,
            alteradoPor = palteradoPor,
            alteradoEm = palteradoEm
		WHERE id = pid;
        
	SELECT * FROM tb_clientes;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_estados_delete` (IN `pid` INT(6))  NO SQL
BEGIN
	
    DELETE FROM tb_protocolos_estado WHERE id = pid;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_estados_save` (IN `pidprotocolo` INT(6), IN `pestado` VARCHAR(112), IN `pdata` DATE, IN `panexo` VARCHAR(56))  NO SQL
BEGIN

	INSERT INTO tb_protocolos_estado (idprotocolo, estado, data, anexo) VALUES (pidprotocolo, pestado, pdata, panexo);

END$$

CREATE DEFINER=`cva`@`%` PROCEDURE `sp_protocolos_delete` (IN `pid` INT(6))  NO SQL
BEGIN

	DELETE FROM tb_protocolos WHERE id = pid;

END$$

CREATE DEFINER=`cva`@`%` PROCEDURE `sp_protocolos_save` (IN `pidcliente` INT(6), IN `pidservico` INT(6), IN `pnumero` VARCHAR(20))  NO SQL
BEGIN

	INSERT INTO tb_protocolos (idcliente, idservico, numero) VALUES (pidcliente, pidservico, pnumero);
    
    SELECT
		c.nomeCliente as cliente,
    	c.email AS email,
        s.titulo AS servico
	FROM tb_protocolos AS p
    	JOIN tb_clientes AS c ON p.idcliente = c.id
        JOIN tb_servicos AS s ON p.idservico = s.id
	WHERE c.id = pidcliente;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recebimentos_delete` (IN `pid` INT(6))  NO SQL
BEGIN

	DELETE FROM tb_recebimentos WHERE id = pid;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recebimentos_save` (IN `pdataRecebimento` DATE, IN `pidprotocolo` INT(6), IN `pvalorBoleto` DECIMAL(10,2), IN `pdataVencimento` DATE, IN `pdataCompensacao` DATE, IN `pnBoleto` VARCHAR(15), IN `pformaPagamento` VARCHAR(25), IN `pparcelas` VARCHAR(3), IN `preferencia` VARCHAR(112), IN `pformaEnvio` VARCHAR(25), IN `penviadoPor` VARCHAR(56), IN `pmes` INT(2), IN `pano` INT(4), IN `palteradoPor` VARCHAR(56), IN `palteradoEm` VARCHAR(16))  NO SQL
BEGIN

	INSERT INTO tb_recebimentos (dataRecebimento, idprotocolo, valorBoleto, dataVencimento, dataCompensacao, nBoleto, formaPagamento, parcelas, referencia, formaEnvio, enviadoPor, mes, ano, alteradoPor, alteradoEm) VALUES (pdataRecebimento, pidprotocolo, pvalorBoleto, pdataVencimento, pdataCompensacao, pnBoleto, pformaPagamento, pparcelas, preferencia, pformaEnvio, penviadoPor, pmes, pano, palteradoPor, palteradoEm);
    
    SELECT * FROM tb_recebimentos;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recebimentos_update` (IN `pid` INT(6), IN `pdataRecebimento` DATE, IN `pidprotocolo` INT(6), IN `pvalorBoleto` DECIMAL(10,2), IN `pdataVencimento` DATE, IN `pdataCompensacao` DATE, IN `pnBoleto` VARCHAR(15), IN `pformaPagamento` VARCHAR(25), IN `pparcelas` VARCHAR(3), IN `preferencia` VARCHAR(112), IN `pformaEnvio` VARCHAR(25), IN `penviadoPor` VARCHAR(56), IN `palteradoPor` VARCHAR(56), IN `palteradoEm` VARCHAR(16))  NO SQL
BEGIN

	UPDATE tb_recebimentos
		SET dataRecebimento = pdataRecebimento,
            idprotocolo = pidprotocolo,
            valorBoleto = pvalorBoleto,
            dataVencimento = pdataVencimento,
            dataCompensacao = pdataCompensacao,
            nBoleto = pnBoleto,
            formaPagamento = pformaPagamento,
            parcelas = pparcelas,
            referencia = preferencia,
            formaEnvio = pformaEnvio,
            enviadoPor = penviadoPor,
            alteradoPor = palteradoPor,
            alteradoEm = palteradoEm
		WHERE id = pid;
        
	SELECT * FROM tb_recebimentos;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_servicos_delete` (IN `pid` INT(6))  NO SQL
BEGIN

	DELETE FROM tb_servicos WHERE id = pid;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_servicos_save` (IN `ptitulo` VARCHAR(56))  NO SQL
BEGIN

	INSERT INTO tb_servicos (titulo) VALUES (ptitulo);
    
    SELECT * FROM tb_servicos;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_servicos_update` (IN `pid` INT(6), IN `ptitulo` VARCHAR(56))  NO SQL
BEGIN
	
    UPDATE tb_servicos
    	SET titulo = ptitulo
    WHERE id = pid;
    
    SELECT * FROM tb_servicos;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_delete` (IN `pid` INT(6))  NO SQL
BEGIN

	DELETE FROM tb_usuarios WHERE id = pid;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_save` (IN `pnome` VARCHAR(56), IN `pusuario` VARCHAR(25), IN `psenha` VARCHAR(32), IN `pacessoTotal` TINYINT(1))  NO SQL
BEGIN

	INSERT INTO tb_usuarios (nome, usuario, senha, acessoTotal)
    	VALUES (pnome, pusuario, psenha, pacessoTotal);
        
    SELECT * FROM tb_usuarios;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_update` (IN `pid` INT(6), IN `pnome` VARCHAR(56), IN `pusuario` VARCHAR(25), IN `psenha` VARCHAR(32), IN `pacessoTotal` TINYINT(1))  NO SQL
BEGIN

	UPDATE tb_usuarios
		SET nome = pnome,
			usuario = pusuario,
            senha = psenha,
            acessoTotal = pacessoTotal
		WHERE id = pid;
        
	SELECT * FROM tb_usuarios;

END$$

DELIMITER ;

CREATE TABLE `tb_clientes` (
  `id` int(6) NOT NULL,
  `dataCadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nomeCliente` varchar(56) NOT NULL,
  `contatoLocal` varchar(56) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `cnpj` varchar(18) DEFAULT NULL,
  `inscricaoEstadual` varchar(15) DEFAULT NULL,
  `telefone` varchar(56) DEFAULT NULL,
  `celular` varchar(56) DEFAULT NULL,
  `cep` varchar(9) DEFAULT NULL,
  `endereco` varchar(112) DEFAULT NULL,
  `bairro` varchar(56) DEFAULT NULL,
  `cidade` varchar(56) DEFAULT NULL,
  `estado` varchar(56) DEFAULT NULL,
  `email` varchar(56) DEFAULT NULL,
  `emails` varchar(224) DEFAULT NULL,
  `observacao` varchar(112) DEFAULT NULL,
  `tipo` varchar(2) DEFAULT NULL,
  `alteradoPor` varchar(25) NOT NULL,
  `alteradoEm` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tb_clientes` (`id`, `dataCadastro`, `nomeCliente`, `contatoLocal`, `cpf`, `cnpj`, `inscricaoEstadual`, `telefone`, `celular`, `cep`, `endereco`, `bairro`, `cidade`, `estado`, `email`, `emails`, `observacao`, `tipo`, `alteradoPor`, `alteradoEm`) VALUES
(3, '2018-10-14 23:25:59', 'Cliente 1 - Out', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'PF', 'Admin', '2018-10-14 20:25'),
(4, '2018-10-14 23:26:06', 'Cliente 2 - Out', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'PF', 'Admin', '2018-10-14 20:26'),
(5, '2018-10-14 23:26:11', 'Cliente 3 - Out', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'PF', 'Admin', '2018-10-14 20:26'),
(6, '2018-09-14 23:26:18', 'Cliente 1 - Set', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'PF', 'Admin', '2018-10-14 20:26');

CREATE TABLE `tb_clientes_usuarios` (
  `id` int(6) NOT NULL,
  `idcliente` int(6) NOT NULL,
  `nome` varchar(56) NOT NULL,
  `usuario` varchar(25) NOT NULL,
  `senha` varchar(8) NOT NULL,
  `dataCadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tb_clientes_usuarios` (`id`, `idcliente`, `nome`, `usuario`, `senha`, `dataCadastro`) VALUES
(3, 3, 'Cliente 1 - Out', 'cliente.out', '4f5fd228', '2018-10-14 23:25:59'),
(4, 4, 'Cliente 2 - Out', 'cliente.out', '4056a7ff', '2018-10-14 23:26:06'),
(5, 5, 'Cliente 3 - Out', 'cliente.out', '4056a7ff', '2018-10-14 23:26:11'),
(6, 6, 'Cliente 1 - Set', 'cliente.set', '9f829f74', '2018-10-14 23:26:18');

CREATE TABLE `tb_protocolos` (
  `id` int(6) NOT NULL,
  `idcliente` int(6) NOT NULL,
  `idservico` int(6) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `dataCadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tb_protocolos` (`id`, `idcliente`, `idservico`, `numero`, `dataCadastro`) VALUES
(3, 3, 1, 'CVAPROTOCOL-991C60D0', '2018-10-14 23:33:22'),
(4, 3, 3, 'CVAPROTOCOL-D6EB28C5', '2018-10-14 23:33:29'),
(5, 4, 2, 'CVAPROTOCOL-E733B0C8', '2018-10-14 23:38:00'),
(6, 6, 3, 'CVAPROTOCOL-35700BA9', '2018-09-14 23:39:27'),
(7, 6, 1, 'CVAPROTOCOL-2FF03043', '2018-09-14 23:40:11'),
(8, 5, 2, 'CVAPROTOCOL-5F4B15CD', '2018-10-14 23:41:27');

CREATE TABLE `tb_protocolos_estado` (
  `id` int(6) NOT NULL,
  `idprotocolo` int(6) NOT NULL,
  `estado` varchar(112) CHARACTER SET utf8mb4 NOT NULL,
  `data` date NOT NULL,
  `anexo` varchar(56) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tb_protocolos_estado` (`id`, `idprotocolo`, `estado`, `data`, `anexo`) VALUES
(4, 4, 'Visita tÃ©cnica realizada. O documento de avaliaÃ§Ã£o estÃ¡ em anexo.', '2018-10-14', '2018.10.14-20.35.35.png'),
(5, 4, 'Protocolo encerrado.', '2018-10-14', NULL),
(6, 3, 'Anexo do documento de automaÃ§Ã£o.', '2018-10-14', '2018.10.14-20.37.11.jpg'),
(7, 3, 'AutomaÃ§Ã£o realizada.', '2018-10-14', NULL),
(8, 3, 'Protocolo encerrado.', '2018-10-14', NULL),
(9, 5, 'ManutenÃ§Ã£o de peÃ§a X realizada.', '2018-10-14', NULL),
(10, 5, 'Anexo de documento referente Ã  anÃ¡lise da manutenÃ§Ã£o em anexo.', '2018-10-14', '2018.10.14-20.38.57.jpg'),
(11, 5, 'Protocolo encerrado.', '2018-10-14', NULL),
(12, 6, 'Visita tÃ©cnica realizada.', '2018-10-14', NULL),
(13, 6, 'Protocolo encerrado.', '2018-10-14', NULL),
(14, 7, 'Documento de anÃ¡lise de automaÃ§Ã£o em anexo.', '2018-10-14', '2018.10.14-20.40.30.jpg'),
(15, 7, 'AutomaÃ§Ã£o iniciada.', '2018-10-14', NULL),
(16, 7, 'AutomaÃ§Ã£o finalizada.', '2018-10-14', NULL),
(17, 7, 'Protocolo encerrado. Documento em anexo.', '2018-10-14', '2018.10.14-20.41.08.jpg'),
(18, 8, 'ManutenÃ§Ã£o de peÃ§a Y realizada.', '2018-10-14', NULL),
(19, 8, 'Protocolo encerrado.', '2018-10-14', NULL);

CREATE TABLE `tb_recebimentos` (
  `id` int(6) NOT NULL,
  `dataRecebimento` date NOT NULL,
  `idprotocolo` int(6) DEFAULT NULL,
  `valorBoleto` decimal(10,2) NOT NULL,
  `dataVencimento` date NOT NULL,
  `dataCompensacao` date DEFAULT NULL,
  `nBoleto` varchar(15) DEFAULT NULL,
  `formaPagamento` varchar(25) DEFAULT NULL,
  `parcelas` varchar(3) DEFAULT NULL,
  `referencia` varchar(112) DEFAULT NULL,
  `formaEnvio` varchar(25) DEFAULT NULL,
  `enviadoPor` varchar(56) DEFAULT NULL,
  `mes` int(2) NOT NULL,
  `ano` int(4) NOT NULL,
  `alteradoPor` varchar(56) NOT NULL,
  `alteradoEm` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tb_recebimentos` (`id`, `dataRecebimento`, `idprotocolo`, `valorBoleto`, `dataVencimento`, `dataCompensacao`, `nBoleto`, `formaPagamento`, `parcelas`, `referencia`, `formaEnvio`, `enviadoPor`, `mes`, `ano`, `alteradoPor`, `alteradoEm`) VALUES
(5, '2018-10-14', 3, '4520.00', '2018-10-21', '2018-10-16', '', 'Boleto', '1/1', '', 'E-mail', 'Admin', 10, 2018, 'Admin', '2018-10-14 21:06'),
(6, '2018-10-10', 4, '250.00', '2018-10-17', '2018-10-14', '', 'Boleto', '1/1', '', 'E-mail', 'Admin', 10, 2018, 'Admin', '2018-10-14 20:50'),
(7, '2018-10-01', 5, '750.50', '2018-10-08', '2018-10-03', '', 'Boleto', '1/1', '', 'E-mail', 'Admin', 10, 2018, 'Admin', '2018-10-14 20:52'),
(8, '2018-10-14', 8, '860.23', '2018-10-21', NULL, '', 'Boleto', '1/1', '', 'E-mail', 'Admin', 10, 2018, 'Admin', '2018-10-14 20:52'),
(9, '2018-09-05', 7, '4570.20', '2018-09-12', '2018-09-08', '', 'Boleto', '1/1', '', 'E-mail', 'Admin', 9, 2018, 'Admin', '2018-10-14 20:52'),
(10, '2018-09-20', 6, '250.00', '2018-09-27', '2018-09-24', '', 'Boleto', '1/1', '', 'E-mail', 'Admin', 9, 2018, 'Admin', '2018-10-14 20:54');

CREATE TABLE `tb_servicos` (
  `id` int(6) NOT NULL,
  `titulo` varchar(56) CHARACTER SET utf8 NOT NULL,
  `dataCadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tb_servicos` (`id`, `titulo`, `dataCadastro`) VALUES
(1, 'AutomaÃ§Ã£o', '2018-10-14 21:36:42'),
(2, 'ManutenÃ§Ã£o', '2018-10-14 23:32:16'),
(3, 'Visita TÃ©cnica', '2018-10-14 23:32:23');

CREATE TABLE `tb_usuarios` (
  `id` int(6) NOT NULL,
  `nome` varchar(56) NOT NULL,
  `usuario` varchar(25) NOT NULL,
  `senha` varchar(32) NOT NULL,
  `acessoTotal` tinyint(1) DEFAULT '0',
  `dataCadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tb_usuarios` (`id`, `nome`, `usuario`, `senha`, `acessoTotal`, `dataCadastro`) VALUES
(2, 'Admin', 'admin', '21232f297a57a5a743894a0e4a801fc3', 1, '2018-10-06 02:13:17');


ALTER TABLE `tb_clientes`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `tb_clientes_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idcliente_idx` (`idcliente`);

ALTER TABLE `tb_protocolos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idcliente_idx` (`idcliente`);

ALTER TABLE `tb_protocolos_estado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idprotocolo_idx` (`idprotocolo`);

ALTER TABLE `tb_recebimentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idprotocolo_idx` (`idprotocolo`);

ALTER TABLE `tb_servicos`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `tb_usuarios`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `tb_clientes`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `tb_clientes_usuarios`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `tb_protocolos`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `tb_protocolos_estado`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

ALTER TABLE `tb_recebimentos`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `tb_servicos`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `tb_usuarios`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;


ALTER TABLE `tb_clientes_usuarios`
  ADD CONSTRAINT `fk_idcliente_cu` FOREIGN KEY (`idcliente`) REFERENCES `tb_clientes` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `tb_protocolos`
  ADD CONSTRAINT `fk_idcliente_p` FOREIGN KEY (`idcliente`) REFERENCES `tb_clientes` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `tb_protocolos_estado`
  ADD CONSTRAINT `fk_idprotocolo_e` FOREIGN KEY (`idprotocolo`) REFERENCES `tb_protocolos` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `tb_recebimentos`
  ADD CONSTRAINT `fk_idprotocolo_r` FOREIGN KEY (`idprotocolo`) REFERENCES `tb_protocolos` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
