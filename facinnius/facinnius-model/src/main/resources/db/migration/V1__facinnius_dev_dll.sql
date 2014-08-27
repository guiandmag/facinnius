----------------------------------------------------- Tabela: TBL_CATEGORIA_PRODUTO -----------------------------------------------

----------------------------------------------------- DROP TABLE TBL_CATEGORIA_PRODUTO; -------------------------------------------

CREATE TABLE TBL_CATEGORIA_PRODUTO
(
  categoria_produto_id BIGINT NOT NULL,
  categoria_ativa BOOLEAN NOT NULL,
  categoria_produto_nome CHARACTER VARYING(255) NOT NULL,
  CONSTRAINT tbl_categoria_produto_pkey PRIMARY KEY (categoria_produto_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE TBL_CATEGORIA_PRODUTO
  OWNER TO bodyland;

----------------------------------------------------- Index: categoria_produto_ix_categoria_produto_nome --------------------------

----------------------------------------------------- DROP INDEX ix_categoria_produto; --------------------------------------------

CREATE INDEX categoria_produto_ix_categoria_produto_nome
  ON TBL_CATEGORIA_PRODUTO
  USING btree
  (categoria_produto_nome COLLATE pg_catalog."default");
  
---------------------------------------------------- Tabela: TBL_REPRESENTANTE ---------------------------------------------------

---------------------------------------------------- DROP TABLE TBL_REPRESENTANTE; -----------------------------------------------

CREATE TABLE TBL_REPRESENTANTE
(
  representante_id BIGINT NOT NULL,
  representante_email CHARACTER VARYING(255) NOT NULL,
  representante_nome CHARACTER VARYING(255) NOT NULL,
  credencial_senha CHARACTER VARYING(50) NOT NULL,
  credencial_usuario CHARACTER VARYING(255) NOT NULL,
  CONSTRAINT tbl_representante_pkey PRIMARY KEY (representante_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE TBL_REPRESENTANTE
  OWNER TO bodyland;

---------------------------------------------------- Index: representante_ix_representante_nome ----------------------------------

---------------------------------------------------- DROP INDEX representante_ix_representante_nome; -----------------------------

CREATE INDEX representante_ix_representante_nome
  ON TBL_REPRESENTANTE
  USING btree
  (representante_nome COLLATE pg_catalog."default");
  
  
---------------------------------------------------- Tabela: TBL_ROTAS -----------------------------------------------------------

---------------------------------------------------- DROP TABLE TBL_ROTAS; -------------------------------------------------------

CREATE TABLE TBL_ROTAS
(
  rotas_id BIGINT NOT NULL,
  rotas_data_rota DATE NOT NULL,
  representante_id BIGINT NOT NULL,
  CONSTRAINT tbl_rotas_pkey PRIMARY KEY (rotas_id),
  CONSTRAINT fk_representante_rotas FOREIGN KEY (representante_id)
      REFERENCES TBL_REPRESENTANTE (representante_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE TBL_ROTAS
  OWNER TO bodyland;

---------------------------------------------------- Index: rotas_ix_rotas_data_rota ---------------------------------------------

---------------------------------------------------- DROP INDEX rotas_ix_rotas_data_rota; ----------------------------------------

CREATE INDEX rotas_ix_rotas_data_rota
  ON TBL_ROTAS
  USING btree
  (rotas_data_rota);
  
  
----------------------------------------------------- Tabela: TBL_FICHA ----------------------------------------------------------

----------------------------------------------------- DROP TABLE TBL_FICHA; ------------------------------------------------------

CREATE TABLE TBL_FICHA
(
  ficha_id BIGINT NOT NULL,
  ficha_numero_ficha BIGINT NOT NULL,
  rotas_id BIGINT NOT NULL,
  CONSTRAINT TBL_FICHA_PKEY PRIMARY KEY (ficha_id),
  CONSTRAINT fk_rotas_ficha FOREIGN KEY (rotas_id)
      REFERENCES TBL_ROTAS (rotas_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE TBL_FICHA
  OWNER TO bodyland;

----------------------------------------------------- Index: ficha_ix_ficha_numero_ficha -----------------------------------------

----------------------------------------------------- DROP INDEX ficha_ix_ficha_numero_ficha; ------------------------------------

CREATE INDEX ficha_ix_ficha_numero_ficha
  ON tbl_ficha
  USING btree
  (ficha_numero_ficha);

  
----------------------------------------------------- Tabela: TBL_CLIENTE ---------------------------------------------------------

----------------------------------------------------- DROP TABLE TBL_CLIENTE; -----------------------------------------------------

CREATE TABLE TBL_CLIENTE
(
  cliente_id BIGINT NOT NULL,
  cliente_data_visita DATE,
  cliente_email CHARACTER VARYING(255) NOT NULL,
  cliente_nome CHARACTER VARYING(255) NOT NULL,
  credencial_senha CHARACTER VARYING(50) NOT NULL,
  credencial_usuario CHARACTER VARYING(255) NOT NULL,
  ficha_id BIGINT NOT NULL,
  CONSTRAINT tbl_cliente_pkey PRIMARY KEY (cliente_id),
  CONSTRAINT fk_ficha_cliente FOREIGN KEY (ficha_id)
      REFERENCES TBL_FICHA (ficha_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uq_cliente_ficha UNIQUE (ficha_id),
  CONSTRAINT uq_cliente_email UNIQUE (cliente_email)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE TBL_CLIENTE
  OWNER TO bodyland;

------------------------------------------------------ Index: cliente_ix_cliente_nome ---------------------------------------------

------------------------------------------------------ DROP INDEX cliente_ix_cliente_nome; ----------------------------------------

CREATE INDEX cliente_ix_cliente_nome
  ON TBL_CLIENTE
  USING btree
  (cliente_nome COLLATE pg_catalog."default");


------------------------------------------------------ Tabela: TBL_ENDERECO -------------------------------------------------------

------------------------------------------------------ DROP TABLE TBL_ENDERECO; ---------------------------------------------------

CREATE TABLE TBL_ENDERECO
(
  endereco_id BIGINT NOT NULL,
  endereco_cep CHARACTER VARYING(12) NOT NULL,
  endereco_bairro CHARACTER VARYING(100) NOT NULL,
  endereco_cidade CHARACTER VARYING(100) NOT NULL,
  endereco_nome CHARACTER VARYING(50) NOT NULL,
  endereco_rua CHARACTER VARYING(100) NOT NULL,
  endereco_numero INTEGER NOT NULL,
  cliente_id BIGINT NOT NULL,
  ficha_id BIGINT NOT NULL,
  CONSTRAINT tbl_endereco_pkey PRIMARY KEY (endereco_id),
  CONSTRAINT fk_ficha_endereco FOREIGN KEY (ficha_id)
      REFERENCES TBL_FICHA (ficha_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cliente_endereco FOREIGN KEY (cliente_id)
      REFERENCES TBL_CLIENTE (cliente_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE TBL_ENDERECO
  OWNER TO bodyland;

----------------------------------------------------- Index: endereco_ix_endereco_nome --------------------------------------------

----------------------------------------------------- DROP INDEX endereco_ix_endereco_nome; ---------------------------------------

CREATE INDEX endereco_ix_endereco_nome
  ON TBL_ENDERECO
  USING btree
  (endereco_nome COLLATE pg_catalog."default");
  

----------------------------------------------------- Tabela: TBL_PEDIDO ---------------------------------------------------------

----------------------------------------------------- DROP TABLE TBL_PEDIDO; -----------------------------------------------------

CREATE TABLE TBL_PEDIDO
(
  pedido_id BIGINT NOT NULL,
  pedido_data DATE NOT NULL,
  pedido_status CHARACTER VARYING(255) NOT NULL,
  cliente_id BIGINT NOT NULL,	
  CONSTRAINT tbl_pedido_pkey PRIMARY KEY (pedido_id),
  CONSTRAINT fk_cliente_pedido FOREIGN KEY (cliente_id)
      REFERENCES TBL_CLIENTE (cliente_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE TBL_PEDIDO
  OWNER TO bodyland;

----------------------------------------------------- Index: pedido_ix_pedido_id -------------------------------------------------

----------------------------------------------------- DROP INDEX pedido_ix_pedido_id; --------------------------------------------

CREATE INDEX pedido_ix_pedido_id
  ON TBL_PEDIDO
  USING btree
  (pedido_id);
  
  
----------------------------------------------------- Tabela: TBL_PEDIDO_ITEM ----------------------------------------------------

----------------------------------------------------- DROP TABLE TBL_PEDIDO_ITEM; ------------------------------------------------

CREATE TABLE TBL_PEDIDO_ITEM
(
  pedido_item_id BIGINT NOT NULL,
  pedido_item_cancelado BOOLEAN NOT NULL,
  pedido_item_quantidade_produtos INTEGER NOT NULL,
  pedido_tipo_pagamento CHARACTER VARYING(255) NOT NULL,
  pedido_id BIGINT NOT NULL,
  CONSTRAINT tbl_pedido_item_pkey PRIMARY KEY (pedido_item_id),
  CONSTRAINT fk_pedido_pedido_item FOREIGN KEY (pedido_id)
      REFERENCES TBL_PEDIDO (pedido_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT tbl_pedido_item_pedido_item_quantidade_produtos_check CHECK (pedido_item_quantidade_produtos >= 1)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE TBL_PEDIDO_ITEM
  OWNER TO bodyland;

---------------------------------------------------- Index: pedido_item_ix_pedido_item_preco_unitario ----------------------------

---------------------------------------------------- DROP INDEX pedido_item_ix_pedido_item_preco_unitario; -----------------------

CREATE INDEX pedido_item_ix_pedido_item_preco_unitario
  ON TBL_PEDIDO_ITEM
  USING btree
  (pedido_item_id);


---------------------------------------------------- Tabela: TBL_PRODUTO ---------------------------------------------------------

---------------------------------------------------- DROP TABLE TBL_PRODUTO; -----------------------------------------------------

CREATE TABLE TBL_PRODUTO
(
  produto_id BIGINT NOT NULL,
  produto_estoque INTEGER,
  produto_foto CHARACTER VARYING(255) NOT NULL,
  produto_preco_unitario NUMERIC(19,2) NOT NULL,
  produto_nome CHARACTER VARYING(255) NOT NULL,
  produto_observacao CHARACTER VARYING(500) NOT NULL,
  categoria_produto_id BIGINT NOT NULL,
  pedido_item_id BIGINT NOT NULL,
  CONSTRAINT tbl_produto_pkey PRIMARY KEY (produto_id),
  CONSTRAINT fk_categoria_produto_produto FOREIGN KEY (categoria_produto_id)
      REFERENCES TBL_CATEGORIA_PRODUTO (categoria_produto_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_pedido_item_produto FOREIGN KEY (pedido_item_id)
      REFERENCES TBL_PEDIDO_ITEM (pedido_item_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uq_pedido_item_id UNIQUE (pedido_item_id),
  CONSTRAINT tbl_produto_produto_estoque_check CHECK (produto_estoque >= 0)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE TBL_PRODUTO
  OWNER TO bodyland;

---------------------------------------------------- Index: produto_ix_produto_nome ----------------------------------------------

---------------------------------------------------- DROP INDEX produto_ix_produto_nome; -----------------------------------------

CREATE INDEX produto_ix_produto_nome
  ON TBL_PRODUTO
  USING btree
  (produto_nome COLLATE pg_catalog."default");


---------------------------------------------------- Tabela: TBL_TELEFONE --------------------------------------------------------

---------------------------------------------------- DROP TABLE TBL_TELEFONE; ----------------------------------------------------

CREATE TABLE TBL_TELEFONE
(
  telefone_id BIGINT NOT NULL,
  telefone_numero CHARACTER VARYING(25) NOT NULL,
  telefone_operadora CHARACTER VARYING(25) NOT NULL,
  telefone_tipo CHARACTER VARYING(25) NOT NULL,
  cliente_id BIGINT NOT NULL,
  representante_id BIGINT NOT NULL,
  CONSTRAINT tbl_telefone_pkey PRIMARY KEY (telefone_id),
  CONSTRAINT fk_representante_telefone FOREIGN KEY (representante_id)
      REFERENCES TBL_REPRESENTANTE (representante_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cliente_telefone FOREIGN KEY (cliente_id)
      REFERENCES TBL_CLIENTE (cliente_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE TBL_TELEFONE
  OWNER TO bodyland;

---------------------------------------------------- Index: telefone_ix_telefone_numero ------------------------------------------

---------------------------------------------------- DROP INDEX telefone_ix_telefone_numero; -------------------------------------

CREATE INDEX telefone_ix_telefone_numero
  ON TBL_TELEFONE
  USING btree
  (telefone_numero COLLATE pg_catalog."default");


---------------------------------------------------- Tabela: TBL_VENDA -----------------------------------------------------------

---------------------------------------------------- DROP TABLE TBL_VENDA; -------------------------------------------------------

CREATE TABLE TBL_VENDA
(
  venda_id BIGINT NOT NULL,
  venda_data DATE NOT NULL,
  venda_status CHARACTER VARYING(255) NOT NULL,
  venda_valor_total NUMERIC(19,2) NOT NULL,
  endereco_id BIGINT NOT NULL,
  ficha_id BIGINT NOT NULL,
  pedido_id BIGINT NOT NULL,
  representante_id BIGINT NOT NULL,
  CONSTRAINT tbl_venda_pkey PRIMARY KEY (venda_id),
  CONSTRAINT fk_endereco_venda FOREIGN KEY (endereco_id)
      REFERENCES TBL_ENDERECO (endereco_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_ficha_venda FOREIGN KEY (ficha_id)
      REFERENCES TBL_FICHA (ficha_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_pedido_venda FOREIGN KEY (pedido_id)
      REFERENCES TBL_PEDIDO (pedido_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_representante_venda FOREIGN KEY (representante_id)
      REFERENCES TBL_REPRESENTANTE (representante_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uq_pedido_id UNIQUE (pedido_id),
  CONSTRAINT tbl_venda_venda_valor_total_check CHECK (venda_valor_total >= 0::NUMERIC)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE TBL_VENDA
  OWNER TO bodyland;

---------------------------------------------------- Index: venda_ix_venda_data --------------------------------------------------

---------------------------------------------------- DROP INDEX venda_ix_venda_data; ---------------------------------------------

CREATE INDEX venda_ix_venda_data
  ON TBL_VENDA
  USING btree
  (venda_data);


----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ SEQUENCES -----------------------------------------------------------------
  
------------------------------------------------------ SEQUENCE: CATEGORIA_PRODUTO_SEQUENCIA -------------------------------------

------------------------------------------------------ DROP SEQUENCE CATEGORIA_PRODUTO_SEQUENCIA; --------------------------------

CREATE SEQUENCE CATEGORIA_PRODUTO_SEQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE CATEGORIA_PRODUTO_SEQUENCIA
  OWNER TO bodyland;
  
  
------------------------------------------------------ SEQUENCE: CLIENTE_SUQUENCIA ------------------------------------------------

------------------------------------------------------ DROP SEQUENCE CLIENTE_SUQUENCIA; -------------------------------------------

CREATE SEQUENCE CLIENTE_SUQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE CLIENTE_SUQUENCIA
  OWNER TO bodyland;
  
  
------------------------------------------------------ SEQUENCE: CREDENCIAL_SUQUENCIA ------------------------------------------------

------------------------------------------------------ DROP SEQUENCE CREDENCIAL_SUQUENCIA; -------------------------------------------

CREATE SEQUENCE CREDENCIAL_SUQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE CREDENCIAL_SUQUENCIA
  OWNER TO bodyland;

  
------------------------------------------------------ SEQUENCE: ENDERECO_SEQUENCIA ----------------------------------------------

------------------------------------------------------ DROP SEQUENCE ENDERECO_SEQUENCIA; -----------------------------------------

CREATE SEQUENCE ENDERECO_SEQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE ENDERECO_SEQUENCIA
  OWNER TO bodyland;

  
------------------------------------------------------ SEQUENCE: FICHA_SEQUENCIA -------------------------------------------------

------------------------------------------------------ DROP SEQUENCE FICHA_SEQUENCIA; --------------------------------------------

CREATE SEQUENCE FICHA_SEQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE FICHA_SEQUENCIA
  OWNER TO bodyland;

  
------------------------------------------------------ SEQUENCE: PEDIDO_ITEM_SEQUENCIA -------------------------------------------

------------------------------------------------------ DROP SEQUENCE PEDIDO_ITEM_SEQUENCIA; --------------------------------------

CREATE SEQUENCE PEDIDO_ITEM_SEQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE PEDIDO_ITEM_SEQUENCIA
  OWNER TO bodyland;

  
------------------------------------------------------ SEQUENCE: PEDIDO_SEQUENCIA ------------------------------------------------

------------------------------------------------------ DROP SEQUENCE PEDIDO_SEQUENCIA; -------------------------------------------

CREATE SEQUENCE PEDIDO_SEQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE PEDIDO_SEQUENCIA
  OWNER TO bodyland;

  
------------------------------------------------------ SEQUENCE: PRODUTO_SEQUENCIA -----------------------------------------------

------------------------------------------------------ DROP SEQUENCE PRODUTO_SEQUENCIA; ------------------------------------------

CREATE SEQUENCE PRODUTO_SEQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE PRODUTO_SEQUENCIA
  OWNER TO bodyland;

  
------------------------------------------------------ SEQUENCE: REPRESENTANTE_SEQUENCIA -----------------------------------------

------------------------------------------------------ DROP SEQUENCE REPRESENTANTE_SEQUENCIA; ------------------------------------

CREATE SEQUENCE REPRESENTANTE_SEQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE REPRESENTANTE_SEQUENCIA
  OWNER TO bodyland;

  
------------------------------------------------------ SEQUENCE: ROTAS_SEQUENCIA -------------------------------------------------

------------------------------------------------------ DROP SEQUENCE rotas_sequencia; --------------------------------------------

CREATE SEQUENCE ROTAS_SEQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE ROTAS_SEQUENCIA
  OWNER TO bodyland;

  
------------------------------------------------------ SEQUENCE: TELEFONE_SUQUENCIA ----------------------------------------------

------------------------------------------------------ DROP SEQUENCE TELEFONE_SUQUENCIA; -----------------------------------------

CREATE SEQUENCE TELEFONE_SUQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE TELEFONE_SUQUENCIA
  OWNER TO bodyland;

  
------------------------------------------------------ SEQUENCE: VENDA_SEQUENCIA -------------------------------------------------

------------------------------------------------------ DROP SEQUENCE VENDA_SEQUENCIA; --------------------------------------------

CREATE SEQUENCE VENDA_SEQUENCIA
  INCREMENT 50
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE VENDA_SEQUENCIA
  OWNER TO bodyland;

  
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ INSERT --------------------------------------------------------------------
INSERT INTO tbl_representante(
            representante_id, representante_email, representante_nome, credencial_senha, 
            credencial_usuario)
    VALUES (1, 'guiandmag@gmail.com', 'Guilherme Magalhaes', 'guiandmag', 
            'guiandmag');