SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `default` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `default`;

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

CREATE DEFINER=`root`@`%` PROCEDURE `sp_protocolos_delete` (IN `pid` INT(6))  NO SQL
BEGIN

	DELETE FROM tb_protocolos WHERE id = pid;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_protocolos_finalize` (IN `pid` TINYINT(1))  NO SQL
BEGIN

	UPDATE tb_protocolos SET finalized = 1 WHERE id = pid;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `sp_protocolos_save` (IN `pidcliente` INT(6), IN `pidservico` INT(6), IN `pnumero` VARCHAR(20))  NO SQL
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recebimentos_delete` (IN `pnum` VARCHAR(64))  NO SQL
BEGIN

	DELETE r FROM `tb_recebimentos` AS r LEFT JOIN tb_protocolos AS p ON p.id = r.idprotocolo WHERE p.numero = pnum;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recebimentos_save` (IN `pdataRecebimento` DATE, IN `pidprotocolo` INT(6), IN `pvalorBoleto` DECIMAL(10,2), IN `pdataVencimento` DATE, IN `pdataCompensacao` DATE, IN `pnBoleto` VARCHAR(15), IN `pformaPagamento` VARCHAR(25), IN `pparcelas` VARCHAR(3), IN `preferencia` VARCHAR(112), IN `pformaEnvio` VARCHAR(25), IN `penviadoPor` VARCHAR(56), IN `pmes` INT(2), IN `pano` INT(4), IN `palteradoPor` VARCHAR(56), IN `palteradoEm` VARCHAR(16))  NO SQL
BEGIN

	INSERT INTO tb_recebimentos (dataRecebimento, idprotocolo, valorBoleto, dataVencimento, dataCompensacao, nBoleto, formaPagamento, parcelas, referencia, formaEnvio, enviadoPor, mes, ano, alteradoPor, alteradoEm) VALUES (pdataRecebimento, pidprotocolo, pvalorBoleto, pdataVencimento, pdataCompensacao, pnBoleto, pformaPagamento, pparcelas, preferencia, pformaEnvio, penviadoPor, pmes, pano, palteradoPor, palteradoEm);
    
    SELECT * FROM tb_recebimentos;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recebimentos_update` (IN `pid` INT(6), IN `pdataCompensacao` DATE)  NO SQL
BEGIN

	UPDATE tb_recebimentos SET dataCompensacao = pdataCompensacao WHERE id = pid;

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_save` (IN `pnome` VARCHAR(56), IN `pusuario` VARCHAR(25), IN `psenha` VARCHAR(32))  NO SQL
BEGIN

	INSERT INTO tb_usuarios (nome, usuario, senha)
    	VALUES (pnome, pusuario, psenha);
        
    SELECT * FROM tb_usuarios;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_update` (IN `pid` INT(6), IN `pnome` VARCHAR(56), IN `pusuario` VARCHAR(25), IN `psenha` VARCHAR(32))  NO SQL
BEGIN

	UPDATE tb_usuarios
		SET nome = pnome,
			usuario = pusuario,
            senha = psenha
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

CREATE TABLE `tb_clientes_usuarios` (
  `id` int(6) NOT NULL,
  `idcliente` int(6) NOT NULL,
  `nome` varchar(56) NOT NULL,
  `usuario` varchar(25) NOT NULL,
  `senha` varchar(8) NOT NULL,
  `dataCadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tb_pesquisa_satisfacao` (
  `id` int(6) NOT NULL,
  `id_protocolo` int(6) NOT NULL,
  `obs` varchar(112) DEFAULT NULL,
  `nota` tinyint(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tb_protocolos` (
  `id` int(6) NOT NULL,
  `idcliente` int(6) NOT NULL,
  `idservico` int(6) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `dataCadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finalized` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tb_protocolos_estado` (
  `id` int(6) NOT NULL,
  `idprotocolo` int(6) NOT NULL,
  `estado` varchar(112) CHARACTER SET utf8mb4 NOT NULL,
  `data` date NOT NULL,
  `anexo` varchar(56) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE `tb_servicos` (
  `id` int(6) NOT NULL,
  `titulo` varchar(56) NOT NULL,
  `dataCadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tb_usuarios` (
  `id` int(6) NOT NULL,
  `nome` varchar(56) NOT NULL,
  `usuario` varchar(25) NOT NULL,
  `senha` varchar(32) NOT NULL,
  `dataCadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tb_usuarios` (`id`, `nome`, `usuario`, `senha`, `dataCadastro`) VALUES
(2, 'Admin', 'admin', '21232f297a57a5a743894a0e4a801fc3', '2018-10-06 02:13:17');


ALTER TABLE `tb_clientes`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `tb_clientes_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idcliente_idx` (`idcliente`);

ALTER TABLE `tb_pesquisa_satisfacao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idprotocolo_x` (`id_protocolo`);

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
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

ALTER TABLE `tb_clientes_usuarios`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

ALTER TABLE `tb_pesquisa_satisfacao`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

ALTER TABLE `tb_protocolos`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

ALTER TABLE `tb_protocolos_estado`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

ALTER TABLE `tb_recebimentos`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

ALTER TABLE `tb_servicos`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

ALTER TABLE `tb_usuarios`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;


ALTER TABLE `tb_clientes_usuarios`
  ADD CONSTRAINT `fk_idcliente_cu` FOREIGN KEY (`idcliente`) REFERENCES `tb_clientes` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `tb_pesquisa_satisfacao`
  ADD CONSTRAINT `fk_idprotocolo_x` FOREIGN KEY (`id_protocolo`) REFERENCES `tb_protocolos` (`id`) ON DELETE CASCADE;

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
