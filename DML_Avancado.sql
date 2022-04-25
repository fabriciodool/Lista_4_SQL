-- DML INNSERT Usuario
INSERT INTO tb_usuarios
VALUES
(1,'Julio Boaz','julio@email.com','134652','Rua Jeronimo - 456','CARTÃO'),
(2,'Kauane Boaz','kauane@email.com','134652','Rua Matildes - 265','BOLETO'),
(3,'Leonardo Boaz','leonardo@email.com','134652','Rua Camões - 263','CARTÃO'),
(4,'Lucas Boaz','lucas@email.com','134652','Rua São Paulo - 126','PIX');

-- DML INNSERT Produtos
INSERT INTO tb_produtos
VALUES
(1, 'TV LG','70 polegadas HDFUL', 8500.00, 15),
(2, 'SOM Semptoshiba','1500w', 1000.00, 25),
(3, 'Frigideira Tramontina', '127v Branca ante aderente', 400.00, 48),
(4, 'Geladeira Eletrolux','127v 20L Duas portas', 5400.00, 4),
(5, 'Cama BOX','Queen size Colxão de molas ensacadas', 4250.00, 6),
(6, 'Batedeira OSTER', 'Batedeira planetaria', 750.00, 15);

-- DML INNSERT Vendas para pesquisar com INNER JOIN
INSERT INTO tb_vendas
VALUES
(1,1,2),
(1,1,6),
(2,2,1),
(2,2,4),
(2,2,5);

-- DML INNSERT Vendas para pesquisar com LEFT ou RIGHT JOIN
INSERT INTO tb_vendas (id_compra, FK_comprador)
VALUES
(3,3);

INSERT INTO tb_vendas (id_compra, FK_produto)
VALUES
(4,1),
(5,1);

SELECT * FROM tb_usuarios;
SELECT * FROM tb_produtos;
SELECT * FROM tb_vendas;

-- INNER JOIN
SELECT u.nome AS Nome, u.endereco AS Endereço, p.produto AS Produto
FROM tb_usuarios AS u -- Usuarios esta á esquerda de Vendas
INNER JOIN tb_vendas AS v ON u.id_usuario = v.FK_comprador -- Vendas esta á direita de Usuario e a esquerda de Produto
INNER JOIN tb_produtos AS p ON v.FK_produto = p.id_produto; -- Produto esta á direita de Venda

SELECT
tb_usuarios.nome AS Nome,
tb_vendas.id_compra AS IDVENDA
FROM tb_usuarios -- ESQUERDA
LEFT JOIN tb_vendas -- DIREITA
ON tb_usuarios.id_usuario = tb_vendas.FK_comprador;

SELECT
tb_usuarios.nome AS Nome,
tb_vendas.id_compra AS IDVENDA
FROM tb_usuarios -- ESQUERDA
RIGHT JOIN tb_vendas -- DIREITA
ON tb_usuarios.id_usuario = tb_vendas.FK_comprador;

SELECT tb_usuarios.nome AS Nome, COUNT(*) AS 'Quantidade de Produtos'
FROM tb_usuarios
INNER JOIN tb_vendas ON tb_usuarios.id_usuario = tb_vendas.FK_comprador
GROUP BY tb_usuarios.nome;

SELECT
tb_usuarios.nome AS Nome,
SUM(tb_produtos.valor) AS Preço
FROM tb_usuarios
INNER JOIN tb_vendas ON tb_usuarios.id_usuario = tb_vendas.FK_comprador
INNER JOIN tb_produtos ON tb_vendas.FK_produto = tb_produtos.id_produto
WHERE tb_usuarios.nome LIKE '%%'
GROUP BY tb_usuarios.nome;

SELECT
tb_usuarios.nome AS Nome,
AVG(tb_produtos.valor) AS Preço
FROM tb_usuarios
INNER JOIN tb_vendas ON tb_usuarios.id_usuario = tb_vendas.FK_comprador
INNER JOIN tb_produtos ON tb_vendas.FK_produto = tb_produtos.id_produto
WHERE tb_usuarios.nome LIKE '%K%'
GROUP BY tb_usuarios.nome;

SELECT *
FROM tb_usuarios
FULL JOIN tb_vendas ON tb_usuarios.id_usuario = tb_vendas.FK_comprador
FULL JOIN tb_produtos ON tb_vendas.FK_produto = tb_produtos.id_produto;

SELECT * FROM tb_produtos
WHERE tb_produtos.produto IN ('TV LG', 'Cama BOX');

-- DML ALTER
-- ADD campo foto na tabela usuario
ALTER TABLE tb_usuarios ADD foto VARCHAR(100) NULL;

-- Para alterar o campo foto para NOT NULL é necessario validar que não existe nenhum
-- campo nulo, para isso atulizar os locais que estejam nulos
UPDATE tb_usuarios
SET foto = 'LINK DA FOTO';

-- Após alteração sera possivel alterar coluna foto para NOT NULL
ALTER TABLE tb_usuarios ALTER COLUMN foto VARCHAR(200) NOT NULL;

SELECT * FROM tb_usuarios;

