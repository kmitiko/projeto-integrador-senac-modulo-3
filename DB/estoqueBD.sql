-- -----------------------------------------------------
-- DATABASE estoqueBD
-- -----------------------------------------------------
DROP DATABASE IF EXISTS estoquebd;
CREATE DATABASE IF NOT EXISTS estoquebd DEFAULT CHARACTER SET UTF8;
USE estoquebd;

-- -----------------------------------------------------
-- Table Usuario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Usuario (
  Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(100) NOT NULL,
  Login VARCHAR(45) NOT NULL,
  Senha VARCHAR(45) NOT NULL,
  NivelAcesso VARCHAR(45) NULL
);
SELECT * FROM Usuario;
INSERT INTO Usuario (Nome, Login, Senha)
VALUES ('Administrador', 'admin', '123');
INSERT INTO Usuario (Nome, Login, Senha)
VALUES ('Isaque', 'zaque@email.com', '123');



-- -----------------------------------------------------
-- Table Endereco
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Endereco (
    Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Logradouro VARCHAR(100) NOT NULL,
    Numero INT NOT NULL,
    Complemento VARCHAR(45) NULL,
    Bairro VARCHAR(45) NOT NULL,
    Cidade VARCHAR(45) NOT NULL,
    Estado CHAR(2) NOT NULL,
		CHECK (Estado IN ('AC', 'AL', 'AP', 'AM', ' BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO')),    
	CEP VARCHAR(45) NOT NULL
);

SELECT * FROM Endereco;
insert into Endereco (Logradouro, Numero, Complemento, Bairro, Cidade, Estado, CEP)
values ('lorem', 0, 'lorem','lorem','lorem','RJ','lorem');
insert into Endereco (Logradouro, Numero, Complemento, Bairro, Cidade, Estado, CEP)
values ('loremlorem', 1, 'loremlorem','loremlorem','loremlorem','SP','loremlorem');
-- -----------------------------------------------------
-- Table Fornecedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Fornecedor (
    Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    CNPJ VARCHAR(45) NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Telefone VARCHAR(45) NOT NULL,
    Email VARCHAR(45) NOT NULL,
    Site VARCHAR(100) NOT NULL,
    Endereco_Id INT NOT NULL,
    FOREIGN KEY (Endereco_Id)
        REFERENCES Endereco (Id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
SELECT * FROM Fornecedor;
insert  into Fornecedor (CNPJ, Nome, Telefone, Email, Site, Endereco_Id)
values ('lorem', 'lorem', 'lorem', 'lorem', 'lorem', 1);
insert  into Fornecedor (CNPJ, Nome, Telefone, Email, Site, Endereco_Id)
values ('loremlorem', 'loremlorem', 'loremlorem', 'loremlorem', 'loremlorem', 2);

create or replace view listagemFornecedor as 
select 
f.Id, f.Nome, f.Telefone, f.Email,
en.Estado, en.Cidade, en.CEP, en.Bairro, en.Logradouro, en.Numero, en.Complemento
from Fornecedor f
inner join Endereco en
on f.Endereco_Id = en.Id;
select * from listagemFornecedor;

select * from listagemFornecedor order by Id;



-- -----------------------------------------------------
-- Table Produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Produto (
    CodigoBarra INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Categoria VARCHAR(45) NOT NULL,
		CHECK (Categoria IN ('Equipamentos de Limpeza' , 'Acessórios de Limpeza', 'Produtos Químicos de Limpeza', 'Papéis')),
    Fornecedor_Id INT NOT NULL,
    EstoqueMinimo INT NOT NULL,
    EstoqueMaximo INT NOT NULL,
    Descricao VARCHAR(100) NOT NULL,
    FOREIGN KEY (Fornecedor_Id)
        REFERENCES Fornecedor (Id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
SELECT * FROM Produto;
insert into Produto (Nome, Categoria, Fornecedor_Id, EstoqueMinimo, EstoqueMaximo, Descricao)
values('lorem', 'Papéis', 1,'lorem', 'lorem', 'lorem');
insert into Produto (Nome, Categoria, Fornecedor_Id, EstoqueMinimo, EstoqueMaximo, Descricao)
values('loremlorem', 'Equipamentos de Limpeza', 2,'loremlorem', 'loremlorem', 'loremlorem');
insert into Produto (Nome, Categoria, Fornecedor_Id, EstoqueMinimo, EstoqueMaximo, Descricao)
values('ar', 'Equipamentos de Limpeza', 2,'loremlorem', 'loremlorem', 'loremlorem');


create or replace view listagemProduto as 
select 
p.CodigoBarra, p.Nome, p.Categoria,
f.Nome as Fornecedor
from Produto p
inner join Fornecedor f
on p.Fornecedor_Id = f.Id;
select * from listagemProduto;

select * from listagemProduto order by Nome;

-- -----------------------------------------------------
-- Table Estoque
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Estoque (
    Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Produto_CodigoBarra INT NOT NULL,
    Fornecedor_Id INT NOT NULL,
    Quantidade INT NOT NULL,
    ValorUnitario DOUBLE(8,2) NULL,
    LocalizacaoEstoque VARCHAR(45) NOT NULL,
    FOREIGN KEY (Produto_CodigoBarra)
        REFERENCES Produto (CodigoBarra)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (Fornecedor_Id)
        REFERENCES Fornecedor (Id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

SELECT * FROM Estoque;

-- -----------------------------------------------------
-- Table ControleEntrada
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ControleEntrada (
    Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    DataEntrada DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
    Produto_CodigoBarra INT NOT NULL,
    Fornecedor_Id INT NOT NULL,
    Quantidade INT NOT NULL,
    ValorUnitario DOUBLE(8,2) NOT NULL,
    FOREIGN KEY (Produto_CodigoBarra)
        REFERENCES Produto (CodigoBarra)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (Fornecedor_Id)
        REFERENCES Fornecedor (Id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

SELECT * FROM ControleEntrada;

-- -----------------------------------------------------
-- Table ControleSaida
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ControleSaida (
    Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    DataSaida DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
    Produto_CodigoBarra INT NOT NULL,
    Quantidade INT NOT NULL,
    ValorUnitario DOUBLE(8,2) NOT NULL,
    Justificativa VARCHAR(100) NOT NULL,
    FOREIGN KEY (Produto_CodigoBarra)
        REFERENCES Produto (CodigoBarra)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

SELECT * FROM ControleSaida;

-- -----------------------------------------------------
-- Table Procedure
-- -----------------------------------------------------
DELIMITER //
  CREATE PROCEDURE SP_AtualizaEstoque ( ES_Produto_CodigoBarra INT, ES_Quantidade INT, ES_ValorUnitario decimal(8,2))
BEGIN
    DECLARE Contador INT(11);

    SELECT count(*) INTO Contador FROM Estoque WHERE Produto_CodigoBarra = ES_Produto_CodigoBarra;

    IF Contador > 0 THEN
        UPDATE Estoque SET Quantidade=Quantidade + ES_Quantidade, ValorUnitario= ES_ValorUnitario
        WHERE Produto_CodigoBarra = ES_Produto_CodigoBarra;
    ELSE
        INSERT INTO Estoque (Produto_CodigoBarra, Quantidade, ValorUnitario) values (ES_Produto_CodigoBarra, ES_Quantidade, ES_ValorUnitario);
    END IF;
END //
DELIMITER ;

-- -----------------------------------------------------
-- Table Trigger Entrada Produto After Insert
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER TRG_EntradaProduto_AI AFTER INSERT ON ControleEntrada
FOR EACH ROW
BEGIN
      CALL SP_AtualizaEstoque (new.Produto_CodigoBarra, new.Quantidade, new.ValorUnitario);
END //
DELIMITER ;

-- -----------------------------------------------------
-- Table Trigger Entrada Produto After Update
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER TRG_EntradaProduto_AU AFTER UPDATE ON ControleEntrada
FOR EACH ROW
BEGIN
      CALL SP_AtualizaEstoque (new.Produto_CodigoBarra, new.Quantidade - old.Quantidade, new.ValorUnitario);
END //
DELIMITER ;

-- -----------------------------------------------------
-- Table Trigger Entrada Produto After Delete
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER TRG_EntradaProduto_AD AFTER DELETE ON ControleEntrada
FOR EACH ROW
BEGIN
      CALL SP_AtualizaEstoque (old.Produto_CodigoBarra, old.Quantidade * -1, old.ValorUnitario);
END //
DELIMITER ;

-- -----------------------------------------------------
-- Table Trigger Saída Produto After Insert
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER TRG_SaidaProduto_AI AFTER INSERT ON ControleSaida
FOR EACH ROW
BEGIN
      CALL SP_AtualizaEstoque (new.Produto_CodigoBarra, new.Quantidade * -1, new.ValorUnitario);
END //
DELIMITER ;

-- -----------------------------------------------------
-- Table Trigger Saída Produto After Update
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER TRG_SaidaProduto_AU AFTER UPDATE ON ControleSaida
FOR EACH ROW
BEGIN
      CALL SP_AtualizaEstoque (new.Produto_CodigoBarra, old.Quantidade - new.Quantidade, new.ValorUnitario);
END //
DELIMITER ;

-- -----------------------------------------------------
-- Table Trigger Saída Produto After Delete
-- -----------------------------------------------------
DELIMITER //
CREATE TRIGGER TRG_SaidaProduto_AD AFTER DELETE ON ControleSaida
FOR EACH ROW
BEGIN
      CALL SP_AtualizaEstoque (old.Produto_CodigoBarra, old.Quantidade, old.ValorUnitario);
END //
DELIMITER ;