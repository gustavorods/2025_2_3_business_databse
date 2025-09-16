CREATE DATABASE BDCOMERCIO;
USE BDCOMERCIO;

CREATE TABLE TBL_Estado_Civil(
	cod_est_civ INT PRIMARY KEY NOT NULL,
	desc_est_civ VARCHAR(256) NOT NULL
);

CREATE TABLE TBL_Cliente(
	cod_cliente INT PRIMARY KEY NOT NULL,
	nome_cliente VARCHAR(256) NOT NULL,
	cod_est_civ INT NOT NULL,
	salario FLOAT NOT NULL,

	FOREIGN KEY (cod_est_civ)
	REFERENCES TBL_Estado_Civil(cod_est_civ)
);

CREATE TABLE TBL_Conjuge(
	cod_conjuge INT PRIMARY KEY NOT NULL,
	nome_conjuge VARCHAR(256) NOT NULL,
	cod_cliente INT NOT NULL,

	FOREIGN KEY(cod_cliente)
	REFERENCES TBL_Cliente(cod_cliente)
);

CREATE TABLE TBL_Func(
	cod_func INT PRIMARY KEY NOT NULL,
	nome_func VARCHAR(256) NOT NULL
);

CREATE TABLE TBL_Dependente(
	cod_dep INT PRIMARY KEY NOT NULL,
	nome_dep VARCHAR(256) NOT NULL,
	data_nasc DATE NOT NULL,
	cod_func INT NOT NULL,

	FOREIGN KEY (cod_func)
	REFERENCES TBL_Func(cod_func)
);

CREATE TABLE TBL_Produto(
	cod_produto INT PRIMARY KEY NOT NULL,
	nome_produto VARCHAR(50) NOT NULL,
	tipo_produto VARCHAR(50) NOT NULL
);

CREATE TABLE TBL_Pedido(
	cod_pedido INT PRIMARY KEY NOT NULL,
	cod_cliente INT NOT NULL,
	cod_func INT NOT NULL,
	data_pedido DATE NOT NULL,

	FOREIGN KEY (cod_cliente)
	REFERENCES TBL_Cliente(cod_cliente),

	FOREIGN KEY (cod_func)
	REFERENCES TBL_Func(cod_func)
);

CREATE TABLE TBL_Item_Pedido(
	cod_pedido INT NOT NULL,
	cod_produto INT NOT NULL,
	qtde_produto INT NOT NULL,

	FOREIGN KEY(cod_produto)
	REFERENCES TBL_Produto(cod_produto),

	FOREIGN KEY(cod_pedido)
	REFERENCES TBL_Pedido(cod_pedido)
);

CREATE TABLE TBL_Premio(
	cod_func INT NOT NULL,
	valor DECIMAL(8,2) NOT NULL,

	FOREIGN KEY (cod_func)
	REFERENCES TBL_Func(cod_func)
);

CREATE TABLE TBL_Tipo_Fone(
	cod_fone INT PRIMARY KEY NOT NULL,
	desc_fone VARCHAR(256) NOT NULL
);

CREATE TABLE TBL_Telefone(
	cod_cliente INT NOT NULL, 
	cod_fone INT NOT NULL,
	numero_fone VARCHAR(20) NOT NULL,

	FOREIGN KEY(cod_cliente)
	REFERENCES TBL_Cliente(cod_cliente),

	FOREIGN KEY(cod_fone)
	REFERENCES TBL_Tipo_Fone(cod_fone)
);

INSERT INTO TBL_Estado_Civil (cod_est_civ, desc_est_civ) VALUES
(1, 'Solteiro'),
(2, 'Casado'),
(3, 'Viúvo');

INSERT INTO TBL_Cliente (cod_cliente, nome_cliente, cod_est_civ, salario) VALUES
(1, 'Daniel Zuckermn', 2, 7200.00),
(2, 'Amanda Rocha', 1, 3100.00),
(3, 'João Vilela', 3, 2800.50),
(4, 'Carla Moura', 2, 5400.00),
(5, 'Rener Fagotti', 1, 3900.00),
(6, 'Natália Alves', 3, 4600.00);

INSERT INTO TBL_Func (cod_func, nome_func) VALUES
(1, 'Roseane Das Flores'),
(2, 'Patrícia Gomes'),
(3, 'Francisco Costa'),
(4, 'Luciana Paes'),
(5, 'Rodrigo Freitas'),
(6, 'Fernanda Castro');

INSERT INTO TBL_Tipo_Fone (cod_fone, desc_fone) VALUES
(1, 'WhatsApp'),
(2, 'Telegram'),
(3, 'Residencial'),
(4, 'Trabalho'),
(5, 'Celular'),
(6, 'Emergência');

INSERT INTO TBL_Telefone (cod_cliente, cod_fone, numero_fone) VALUES
(1, 5, '(11) 91111-2222'),
(2, 3, '(21) 3232-4444'),
(3, 4, '(31) 95555-6666'),
(4, 6, '(41) 97777-8888'),
(5, 2, '(51) 99999-0000');

INSERT INTO TBL_Produto (cod_produto, nome_produto, tipo_produto) VALUES
(1, 'Cafeteira Philips', 'Eletrodoméstico'),
(2, 'Notebook Dell', 'Eletrônico'),
(3, 'Fósforo', 'Consumo'),
(4, 'Arroz 5kg', 'Consumo'),
(5, 'Tênis Nike', 'Esporte'),
(6, 'Monitor LG', 'Periférico');

INSERT INTO TBL_Premio (cod_func, valor) VALUES
(1, 1200.00),
(2, 500.00),
(3, 800.00),
(4, 950.00),
(5, 400.00);

INSERT INTO TBL_Pedido (cod_pedido, cod_cliente, cod_func, data_pedido) VALUES
(1, 1, 3, '2025-08-10'),
(2, 2, 5, '2025-07-21'),
(3, 3, 2, '2025-06-15'),
(4, 4, 1, '2025-05-28'),
(5, 5, 6, '2025-07-02'),
(6, 6, 4, '2025-06-05');

INSERT INTO TBL_Item_Pedido (cod_pedido, cod_produto, qtde_produto) VALUES
(1, 2, 1),
(2, 5, 3),
(3, 3, 5),
(4, 6, 2),
(5, 1, 4);

INSERT INTO TBL_Conjuge (cod_conjuge, nome_conjuge, cod_cliente) VALUES
(1, 'Juliana Prado', 1),
(2, 'Carlos Mendes', 5),
(3, 'Fernanda Dias', 6),
(4, 'André Oliveira', 3),
(5, 'Tatiane Silva', 4);

INSERT INTO TBL_Dependente (cod_dep, nome_dep, data_nasc, cod_func) VALUES
(1, 'Rafael Lima', '2011-04-20', 1),
(2, 'Sofia Torres', '2013-12-15', 2),
(3, 'Daniel Costa', '2009-07-08', 3),
(4, 'Beatriz Lopes', '2016-11-02', 6),
(5, 'Gustavo Martins', '2014-09-25', 5);

-- 1
SELECT c.nome_cliente, t.numero_fone
FROM TBL_Cliente c JOIN TBL_Telefone t ON c.cod_cliente = t.cod_cliente;

-- 2
SELECT c.nome_cliente
FROM TBL_Cliente c JOIN TBL_Estado_Civil ec ON c.cod_est_civ = ec.cod_est_civ
JOIN TBL_Conjuge cj ON c.cod_cliente = cj.cod_cliente
WHERE ec.desc_est_civ = 'Casado';

-- 3
SELECT c.nome_cliente, t.numero_fone, tf.desc_fone
FROM TBL_Cliente c JOIN TBL_Telefone t ON c.cod_cliente = t.cod_cliente
JOIN TBL_Tipo_Fone tf ON t.cod_fone = tf.cod_fone;

-- 4
SELECT p.*, c.nome_cliente, f.nome_func
FROM TBL_Pedido p JOIN TBL_Cliente c ON p.cod_cliente = c.cod_cliente
JOIN TBL_Func f ON p.cod_func = f.cod_func;

-- 5
SELECT p.cod_pedido, p.data_pedido, c.nome_cliente
FROM TBL_Pedido p JOIN TBL_Cliente c ON p.cod_cliente = c.cod_cliente
JOIN TBL_Func f ON p.cod_func = f.cod_func WHERE f.nome_func = 'Francisco Costa';

-- 6
SELECT p.cod_pedido, p.data_pedido, f.nome_func
FROM TBL_Pedido p JOIN TBL_Cliente c ON p.cod_cliente = c.cod_cliente
JOIN TBL_Func f ON p.cod_func = f.cod_func WHERE c.nome_cliente = 'Rener Fagotti';

-- 7
SELECT f.nome_func, d.nome_dep, d.data_nasc
FROM TBL_Func f JOIN TBL_Dependente d ON f.cod_func = d.cod_func;

-- 8
SELECT p.cod_pedido, p.data_pedido, pr.nome_produto
FROM TBL_Pedido p JOIN TBL_Item_Pedido ip ON p.cod_pedido = ip.cod_pedido
JOIN TBL_Produto pr ON ip.cod_produto = pr.cod_produto;

-- 9
SELECT p.cod_pedido, p.data_pedido, f.nome_func
FROM TBL_Pedido p JOIN TBL_Item_Pedido ip ON p.cod_pedido = ip.cod_pedido
JOIN TBL_Produto pr ON ip.cod_produto = pr.cod_produto
JOIN TBL_Func f ON p.cod_func = f.cod_func WHERE pr.nome_produto = 'Fósforo';

-- 10
SELECT p.cod_pedido, p.data_pedido, pr.nome_produto
FROM TBL_Pedido p JOIN TBL_Item_Pedido ip ON p.cod_pedido = ip.cod_pedido
JOIN TBL_Produto pr ON ip.cod_produto = pr.cod_produto
JOIN TBL_Cliente c ON p.cod_cliente = c.cod_cliente WHERE c.nome_cliente = 'Daniel Zuckermn';

-- 11
SELECT f.nome_func, pr.nome_produto
FROM TBL_Pedido p JOIN TBL_Item_Pedido ip ON p.cod_pedido = ip.cod_pedido
JOIN TBL_Produto pr ON ip.cod_produto = pr.cod_produto
JOIN TBL_Func f ON p.cod_func = f.cod_func WHERE f.nome_func = 'Roseane Das Flores';

-- 12
SELECT c.nome_cliente, pr.nome_produto
FROM TBL_Pedido p JOIN TBL_Item_Pedido ip ON p.cod_pedido = ip.cod_pedido
JOIN TBL_Produto pr ON ip.cod_produto = pr.cod_produto
JOIN TBL_Cliente c ON p.cod_cliente = c.cod_cliente;

-- 13
SELECT f.nome_func, pr.nome_produto
FROM TBL_Pedido p JOIN TBL_Item_Pedido ip ON p.cod_pedido = ip.cod_pedido
JOIN TBL_Produto pr ON ip.cod_produto = pr.cod_produto
JOIN TBL_Func f ON p.cod_func = f.cod_func;

-- 14
SELECT f.nome_func, SUM(p.valor)
FROM TBL_Func f LEFT JOIN TBL_Premio p ON f.cod_func = p.cod_func GROUP BY f.nome_func;

-- 15
SELECT f.nome_func, COUNT(d.cod_dep)
FROM TBL_Func f LEFT JOIN TBL_Dependente d ON f.cod_func = d.cod_func GROUP BY f.nome_func;

-- 16
SELECT ec.desc_est_civ, COUNT(c.cod_cliente)
FROM TBL_Estado_Civil ec LEFT JOIN TBL_Cliente c ON ec.cod_est_civ = c.cod_est_civ
WHERE ec.desc_est_civ IN ('Casado', 'Solteiro', 'Separado') GROUP BY ec.desc_est_civ;

-- 17
SELECT c.*
FROM TBL_Cliente c LEFT JOIN TBL_Telefone t ON c.cod_cliente = t.cod_cliente WHERE t.cod_cliente IS NULL;

-- 18
SELECT c.*
FROM TBL_Cliente c JOIN TBL_Estado_Civil ec ON c.cod_est_civ = ec.cod_est_civ WHERE ec.desc_est_civ = 'Solteiro';

-- 19
SELECT c.*
FROM TBL_Cliente c JOIN TBL_Estado_Civil ec ON c.cod_est_civ = ec.cod_est_civ WHERE ec.desc_est_civ = 'Casado';

-- 20
SELECT f.*
FROM TBL_Func f LEFT JOIN TBL_Premio p ON f.cod_func = p.cod_func WHERE p.cod_func IS NULL;

-- 21
SELECT f.*
FROM TBL_Func f LEFT JOIN TBL_Dependente d ON f.cod_func = d.cod_func WHERE d.cod_dep IS NULL;

-- 22
SELECT pr.*
FROM TBL_Produto pr LEFT JOIN TBL_Item_Pedido ip ON pr.cod_produto = ip.cod_produto WHERE ip.cod_produto IS NULL;
