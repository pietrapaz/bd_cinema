CREATE DATABASE cineSenac;
USE cineSenac;
-- DROP DATABASE cineSenac;

-- DESC tb_cliente;
-- DROP TABLE tb_sala;

CREATE TABLE tb_genero(
	id_genero int not null primary key,
    nome varchar(45) not null
);

CREATE TABLE tb_filme(
	id_filme int not null primary key,
    titulo varchar(100) not null,
    sinopse text not null,
    classificacao enum('L', '10', '12', '14', '16', '+18')
);

CREATE TABLE tb_cliente(
	email varchar(100) not null,
    nome varchar(80) not null,
    cpf varchar(11) not null,
    senha varchar(150) not null,
    primary key (email)
);

/*
-- criar uma tabela com o nome errado da coluna
CREATE TABLE tb_produto(
	codigo int not null primary key,
    nomi varchar(100) not null
);

DESC tb_produto;
ALTER TABLE tb_produto RENAME COLUMN nomi TO nome;
DESC tb_produto;
ALTER TABLE tb_produto MODIFY COLUMN nome varchar(150) not null;
DESC tb_produto;
*/

/*
-- para apagar a tabela produto
DROP TABLE tb_produto;
*/

CREATE TABLE tb_cinema(
	cnpj varchar(14) not null primary key,
    nome varchar(80) not null
);

CREATE TABLE tb_sala(
	num_sala int not null,
    cnpj varchar(14) not null,
    capacidade int not null,
    tipo_tela enum('2D', '3D'),
    primary key (num_sala, cnpj),
    foreign key (cnpj) references tb_cinema (cnpj)
);

CREATE TABLE tb_pedido(
	num_pedido int not null,
    email varchar(100) not null,
    data_pedido date not null,
    primary key (num_pedido),
    foreign key (email) references tb_cliente (email)
);

CREATE TABLE rl_genero_filme(
	id_genero int not null,
    id_filme int not null,
    primary key (id_genero, id_filme),
    foreign key (id_genero) references tb_genero (id_genero),
    foreign key (id_filme) references tb_filme (id_filme)
);

CREATE TABLE tb_sessao(
	id_sessao int not null primary key,
    horario time not null,
    data_sessao date not null,
    id_filme int not null,
    num_sala int not null,
    cnpj varchar(14) not null,
    foreign key (id_filme) references tb_filme (id_filme),
    foreign key (num_sala, cnpj) references tb_sala (num_sala, cnpj),
    foreign key (cnpj) references tb_cinema (cnpj)
);

CREATE TABLE tb_assento(
	id_assento varchar(3) not null primary key,
    ds_status boolean not null default 0,
    id_sessao int not null,
    foreign key (id_sessao) references tb_sessao (id_sessao)
);

CREATE TABLE tb_ingresso(
	num_ingresso int not null primary key,
    tipo enum('meia', 'inteira') not null,
    preco decimal (3,2) not null,
    num_pedido int not null,
    id_assento varchar(3) not null,
    foreign key (num_pedido) references tb_pedido (num_pedido),
    foreign key (id_assento) references tb_assento (id_assento)
);

SHOW TABLES;

INSERT INTO tb_genero (idGenero, nome) values ('1', 'Ação');
INSERT INTO tb_genero (idGenero, nome) values ('2', 'Aventura');
INSERT INTO tb_genero (idGenero, nome) values ('3', 'Comédia');
INSERT INTO tb_genero (idGenero, nome) values ('4', 'Terror');
INSERT INTO tb_genero (idGenero, nome) values ('5', 'Ficção');
INSERT INTO tb_genero (idGenero, nome) values ('6', 'Suspense');
INSERT INTO tb_genero (idGenero, nome) values ('7', 'Romance');
INSERT INTO tb_genero (idGenero, nome) values ('8', 'Drama');
INSERT INTO tb_genero (idGenero, nome) values ('9', 'Fantasia');
INSERT INTO tb_genero (idGenero, nome) values ('10', 'Mistério');
INSERT INTO tb_genero (idGenero, nome) values ('11', 'Musical');
INSERT INTO tb_genero (idGenero, nome) values ('12', 'Guerra');
INSERT INTO tb_genero (idGenero, nome) values ('13', 'Esporte');
INSERT INTO tb_genero (idGenero, nome) values ('14', 'Culinária');
INSERT INTO tb_genero (idGenero, nome) values ('15', 'Policial');
INSERT INTO tb_genero (idGenero, nome) values ('16', 'Infantil');
INSERT INTO tb_genero (idGenero, nome) values ('17', 'Animação');
INSERT INTO tb_genero (idGenero, nome) values ('18', 'Super-herói');
INSERT INTO tb_genero (idGenero, nome) values ('19', 'Crime');

SELECT * FROM tb_genero;
SELECT * FROM tb_genero ORDER BY nome;

INSERT INTO tb_filme (idFilme, titulo, sinopse, classificacao) values 
	('1', 'Divertidamente', 'Riley é uma garota divertida de 11 anos de idade, que deve enfrentar mudanças importantes em sua vida quando seus pais decidem deixar a sua cidade natal, no estado de Minnesota, para viver em San Francisco. Dentro do cérebro de Riley, convivem várias emoções diferentes, como a Alegria, o Medo, a Raiva, o Nojinho e a Tristeza. A líder deles é Alegria, que se esforça bastante para fazer com que a vida de Riley seja sempre feliz. Entretanto, uma confusão na sala de controle faz com que ela e Tristeza sejam expelidas para fora do local. Agora, elas precisam percorrer as várias ilhas existentes nos pensamentos de Riley para que possam retornar à sala de controle - e, enquanto isto não acontece, a vida da garota muda radicalmente.',
    'L');
INSERT INTO tb_filme (idFilme, titulo, sinopse, classificacao) values 
    ('2', 'Madagascar', 'O leão Alex (Ben Stiller) é a grande atração do zoológico do Central Park, em Nova York. Ele e seus melhores amigos, a zebra Marty (Chris Rock), a girafa Melman (David Schwimmer) e a hipopótamo Gloria (Jada Pinkett Smith), sempre passaram a vida em cativeiro e desconhecem o que é morar na selva. Curioso em saber o que há por trás dos muros do zoo, Marty decide fugir e explorar o mundo. Ao perceberem, Alex, Gloria e Melman decidem partir à sua procura. O trio encontra Marty na estação Grand Central do metrô, mas antes que consigam voltar para casa são atingidos por dardos tranquilizantes e capturados. Embarcados em um navio rumo à África, eles acabam na ilha de Madagascar, onde precisam encontrar meios de sobrevivência em uma selva verdadeira.', 
    'L');
INSERT INTO tb_filme (idFilme, titulo, sinopse, classificacao) values 
    ('3', 'Homem-aranha no aranhaverso', 'Em Homem-Aranha no Aranhaverso, Miles Morales é um jovem negro do Brooklyn que se tornou o Homem-Aranha inspirado no legado de Peter Parker, já falecido. Entretanto, ao visitar o túmulo de seu ídolo em uma noite chuvosa, ele é surpreendido com a presença do próprio Peter, vestindo o traje do herói aracnídeo sob um sobretudo. A surpresa fica ainda maior quando Miles descobre que ele veio de uma dimensão paralela, assim como outras versões do Homem-Aranha.', 
    '10');
INSERT INTO tb_filme (idFilme, titulo, sinopse, classificacao) values 
    ('4', 'Luca', 'Em Luca, acompanhamos o curioso monstro do mar chamado Luca, enquanto ele vive pastoreando alguns peixes e vive com os pais e a avó, que não o deixam chegar perto da superfície, já que lá habitam os humanos que podem matá-los. Em um dia qualquer, Luca, com muita curiosidade, acha alguns objetos que vieram da superfície e acaba conhecendo Alberto, outro monstro marinho e que coleciona objetos de humanos. Luca então decide ir com Alberto para superfície, onde ele percebe que ao entrar em contato com a terra, fica com corpo de humano e consegue andar, mas ao tocar na água suas escamas voltam. Ficando apaixonado pela amizade e por coisas que os humanos criaram, Luca e Alberto combinam de ir para a vila mais próxima e conseguir uma Vespa, assim poderão viajar o mundo. Eles conhecem Júlia, uma garota humana e seu pai, e se estufam de gelattos e massas enquanto não podem falar quem realmente são. ', 
    'L');
INSERT INTO tb_filme (idFilme, titulo, sinopse, classificacao) values 
    ('5', 'Zootopia', 'Em Zootopia: Essa Cidade é o Bicho, acompanhamos a história de Judy Hopps, uma pequena fazendeira que é filha de agricultores. Insatisfeita com a vida no interior, ela tem sonhos maiores: se mudar para a cidade grande, Zootopia, e se tornar a primeira coelha policial. Quando Judy consegue alcançar o seu objetivo, ela é designada para a sua primeira e grande missão, que é encontrar um animal perdido. Contando com a ajuda inesperada de Nick, uma raposa conhecida por sua malícia e infrações, ela descobre que existe uma conspiração que afetará toda a cidade.', 
    'L');
    
SELECT * FROM tb_filme; 
SELECT * FROM tb_filme ORDER BY titulo; 

ALTER TABLE tb_filme ADD trailer text; 
ALTER TABLE tb_filme ADD poster text; 

UPDATE tb_filme
SET trailer = 'https://www.youtube.com/watch?v=LSpeM7G4zfY', 
	poster = 'https://br.web.img3.acsta.net/pictures/15/05/14/14/20/365361.jpg'
WHERE idFilme = 1;

UPDATE tb_filme
SET trailer = 'https://www.youtube.com/watch?v=fq5zU9T_Hl4', 
	poster = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.adorocinema.com%2Ffilmes%2Ffilme-16591%2Ffotos%2Fdetalhe%2F%3Fcmediafile%3D20150796&psig=AOvVaw1dMUTLdSCUMAmcVAc_Ddh_&ust=1677779833976000&source=images&cd=vfe&ved=0CBIQjhxqFwoTCJiU8oqnu_0CFQAAAAAdAAAAABAE'
WHERE idFilme = 2;

UPDATE tb_filme
SET trailer = 'https://www.youtube.com/watch?v=SS6ABPkfmBE', 
	poster = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.microsoft.com%2Fpt-br%2Fp%2Fhomem-aranha-aranhaverso%2F8d6kgwxn3lnk&psig=AOvVaw1ZPJYrJnOgOSAWNd8d14ya&ust=1677780013754000&source=images&cd=vfe&ved=0CBIQjhxqFwoTCICjvuCnu_0CFQAAAAAdAAAAABAE'
WHERE idFilme = 3;

UPDATE tb_filme
SET trailer = 'https://www.youtube.com/watch?v=mYfJxlgR2jw', 
	poster = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.atoupeira.com.br%2Fconfira-o-novo-poster-nacional-e-o-segundo-trailer-da-animacao-luca%2F&psig=AOvVaw3FsqFORDYiWedFkqPeejJi&ust=1677780256339000&source=images&cd=vfe&ved=0CBIQjhxqFwoTCPiH2NOou_0CFQAAAAAdAAAAABAE'
WHERE idFilme = 4;

UPDATE tb_filme
SET trailer = 'https://www.youtube.com/watch?v=jWM0ct-OLsM', 
	poster = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fritzcinema.net%2Fmovie-information%2Fzootopia-poster-1%2F&psig=AOvVaw0_a5cIXhPI8dsU-cyoFwCV&ust=1677780296389000&source=images&cd=vfe&ved=0CBEQjhxqFwoTCLDkiOaou_0CFQAAAAAdAAAAABAE'
WHERE idFilme = 5;

SELECT * FROM tb_filme; 

INSERT INTO tb_cinema (cnpj, nome) values ('79307685000173', 'Cinemark Iguatemi');
INSERT INTO tb_cinema (cnpj, nome) values ('67565131000197', 'Kinoplex Boulevard');
INSERT INTO tb_cinema (cnpj, nome) values ('39210806000140', 'Kinoplex ParkShopping');
INSERT INTO tb_cinema (cnpj, nome) values ('30532368000161', 'Cinemark Pier 21');

SELECT * FROM tb_cinema; 

SHOW TABLES;

INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('1', '79307685000173', '50', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('2', '79307685000173', '200', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('3', '79307685000173', '100', '3D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('4', '79307685000173', '80', '3D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('5', '79307685000173', '120', '2D'); 
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('1', '67565131000197', '100', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('2', '67565131000197', '150', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('3', '67565131000197', '100', '3D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('4', '67565131000197', '50', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('5', '67565131000197', '100', '2D'); 
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('1', '39210806000140', '120', '3D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('2', '39210806000140', '50', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('3', '39210806000140', '100', '3D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('4', '39210806000140', '130', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('5', '39210806000140', '80', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('1', '30532368000161', '80', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('2', '30532368000161', '80', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('3', '30532368000161', '140', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('4', '30532368000161', '100', '2D');
INSERT INTO tb_sala (numSala, cnpj, capacidade, tipoTela) values ('5', '30532368000161', '100', '3D');
    
SELECT * FROM tb_sala; 

-- como inserir data e hora '2023-02-28 18:30'

SELECT * FROM tb_genero ORDER BY nome;
SELECT * FROM tb_filme; 
SELECT * FROM rl_genero_filme;
SELECT * FROM tb_sessao;
SELECT * FROM tb_cliente;

INSERT INTO rl_genero_filme (idGenero, idFilme) values ('17', '1');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('2', '1');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('3', '1');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('8', '1');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('9', '1');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('16', '1');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('17', '2');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('2', '2');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('3', '2');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('16', '2');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('1', '3');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('2', '3');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('17', '3');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('3', '3');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('16', '3');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('18', '3');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('5', '3');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('9', '3');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('2', '4');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('17', '4');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('3', '4');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('9', '4');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('2', '5');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('17', '5');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('19', '5');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('3', '5');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('16', '5');
INSERT INTO rl_genero_filme (idGenero, idFilme) values ('10', '5');
    
INSERT INTO tb_sessao (idSessao, horario, dataSessao, idFilme, numSala, cnpj) values
	(1, '12:00', '2023-03-03', '1', '3', '79307685000173');
INSERT INTO tb_sessao (idSessao, horario, dataSessao, idFilme, numSala, cnpj) values
    (2, '13:00', curdate(), '2', '2', '67565131000197');
INSERT INTO tb_sessao (idSessao, horario, dataSessao, idFilme, numSala, cnpj) values
    (3, '14:00', curdate(), '3', '2', '79307685000173');
INSERT INTO tb_sessao (idSessao, horario, dataSessao, idFilme, numSala, cnpj) values    
    (4, '15:00', '2023-03-07', '4', '1', '67565131000197');
INSERT INTO tb_sessao (idSessao, horario, dataSessao, idFilme, numSala, cnpj) values
    (5, '14:00', '2023-03-06', '3', '4', '39210806000140');
INSERT INTO tb_sessao (idSessao, horario, dataSessao, idFilme, numSala, cnpj) values    
    (6, '17:00', curdate(), '2', '5', '79307685000173');
INSERT INTO tb_sessao (idSessao, horario, dataSessao, idFilme, numSala, cnpj) values
    (7, '18:00', '2023-03-08', '5', '5', '67565131000197');
INSERT INTO tb_sessao (idSessao, horario, dataSessao, idFilme, numSala, cnpj) values
    (8, '19:00', '2023-03-05', '5', '4', '79307685000173');
INSERT INTO tb_sessao (idSessao, horario, dataSessao, idFilme, numSala, cnpj) values
    (9, '20:00', curdate(), '1', '2', '39210806000140');
INSERT INTO tb_sessao (idSessao, horario, dataSessao, idFilme, numSala, cnpj) values
    (10, '12:00', '2023-03-07', '3', '1', '30532368000161');
    
INSERT INTO tb_cliente (email, nome, cpf, senha) values
	('maria31hp@gmail.com', 'Maria Eduarda da Silva', '19775030048', 'H82#7&00mGB5');
INSERT INTO tb_cliente (email, nome, cpf, senha) values
    ('ceciliameireles@outlook.com', 'Cecilia Meireles da Corte', '00033796041', 'KIfi426Sz%lUnpj');
INSERT INTO tb_cliente (email, nome, cpf, senha) values
    ('ri63jss@gmail.com', 'Ricardo de Almeida', '56565527059', 'o9e0t#YH5H9@k8N');
INSERT INTO tb_cliente (email, nome, cpf, senha) values
    ('thiagoferreira@yahoo.com.br', 'Thiago Costa Ferreira', '70472479040', '@#C74sCfr84d');
INSERT INTO tb_cliente (email, nome, cpf, senha) values
    ('joanasoares@hotmail.com', 'Joana Soares', '53277592022', '&80kOD4Ru!Q');
    
INSERT INTO tb_assento (id_assento, id_sessao) values ('A1', '1'); 
INSERT INTO tb_assento (id_assento, id_sessao) values ('A2', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('A3', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('A4', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('A5', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('B1', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('B2', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('B3', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('B4', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('B5', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('C1', '1'); 
INSERT INTO tb_assento (id_assento, id_sessao) values ('C2', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('C3', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('C4', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('C5', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('D1', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('D2', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('D3', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('D4', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('D5', '1');
INSERT INTO tb_assento (id_assento, id_sessao) values ('A1', '2'); 
INSERT INTO tb_assento (id_assento, id_sessao) values ('A2', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('A3', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('A4', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('A5', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('B1', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('B2', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('B3', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('B4', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('B5', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('C1', '2'); 
INSERT INTO tb_assento (id_assento, id_sessao) values ('C2', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('C3', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('C4', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('C5', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('D1', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('D2', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('D3', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('D4', '2');
INSERT INTO tb_assento (id_assento, id_sessao) values ('D5', '2');
    
/*
-- para apagar um registro da tabela
SELECT * FROM tb_pedido;
DELETE FROM tb_cliente WHERE email = 'carlos@exemplo.com.br';
SELECT * FROM tb_cliente;
*/

/*
-- apagar toda a coluna a coluna senha da tabela tb_cliente
ALTER TABLE tb_cliente DROP COLUMN senha;
*/

/*estudando o comando SELECT*/
SELECT * FROM tb_filme;
SELECT titulo, classificacao
  FROM tb_filme
  ORDER BY titulo ;


SELECT titulo, classificacao
  FROM tb_filme
  ORDER BY titulo desc;

SELECT titulo, classificacao
  FROM tb_filme
  ORDER BY classificacao ; 
  
/*selecionar apenas os filmes de classificacao 10*/
SELECT titulo, classificacao
 FROM  tb_filme
WHERE  classificacao = '10'; 

/*seleciona filmes com classificacao livre e 10 anos*/
SELECT titulo, classificacao
 FROM  tb_filme
WHERE  classificacao = 'L'
  OR   classificacao = '10'; 
  
/*selecione as hora da sessao e num da sala e cnpj das sessões após as 18h*/
SELECT horario, num_sala, cnpj
 FROM tb_sessao
 WHERE horario >= '18:00'; 

SELECT * from tb_filme;

SELECT titulo, classificacao, sinopse
  FROM tb_filme 
WHERE  titulo = 'Divertidamente'; 

SELECT * FROM tb_filme;

INSERT INTO tb_filme (id_filme, titulo, sinopse, classificacao, trailer, poster) 
values
(6, 'Homem Aranha', 'Quando o morde uma aranha, o inteligente, e tímido Peter Parker ganha habilidades que deberá usar para lutar contra o mal.',
'L', 'https://www.imdb.com/video/vi1376109081/?playlistId=tt0145487&ref_=tt_pr_ov_vi', null),
(7, 'Homem-Aranha: Longe de Casa', 'Após os eventos de Vingadores: Ultimato, o Homem-Aranha deve se preparar para enfrentar novas ameaças em um mundo que tihna mudado para sempre.',
'10', 'https://www.imdb.com/video/vi2600385561/?playlistId=tt6320628&ref_=tt_pr_ov_vi', null);

SELECT * FROM tb_filme;

SELECT * FROM tb_filme WHERE titulo = 'Homem aranha';

/*seleciona qualquer titulo que inicia com a palavra HOMEM*/
SELECT * FROM tb_filme WHERE titulo LIKE 'homem%';

/*seleciona qualquer titulo que contenha a palavra ARANHA*/
SELECT * FROM tb_filme WHERE titulo LIKE '%aranha%';

SELECT titulo, classificacao FROM tb_filme ORDER BY titulo;

SELECT titulo, classificacao 
FROM tb_filme 
WHERE classificacao = '10'
   OR classificacao = '12'
   OR classificacao = 'L'
ORDER BY titulo;

/*selecionar titulo e classificacao de filmes exceto os filmes de classificacao livre*/
SELECT titulo, classificacao AS classificação_indicativa
  FROM tb_filme
 WHERE classificacao != 'L';
 
 SELECT 2+3 AS soma;

 /*now() é uma função do mysql que retorna a data e hora do servidor*/
 SELECT now() AS data_hora_atual_do_servidor;
 
 /*curdate() é uma função do mysql que retorna a data atual do servidor*/
 SELECT curdate() AS data_atual_do_servidor;
 
 -- retorna o horario atual
 SELECT curtime() AS hora_atual_servidor;
 
 -- mudar o formato da data
 SELECT DATE_FORMAT(curdate(), '%d-%m-%Y') 
 AS data_formatada;
 SELECT * FROM tb_sessao;
 
 SELECT 
     num_sala, 
     date_format(data_sessao, '%d/%m/%Y') AS data_sessao, 
     horario
  FROM tb_sessao;

/*acrescentar uma coluna dt_nascimento do tipo date na tabela cliente */ 
ALTER TABLE tb_cliente ADD COLUMN dt_nascimento DATE;

SELECT * FROM tb_cliente;

/*atualize os registros dos clientes colocando um valor de data de nascimento para cada cliente*/ 
UPDATE tb_cliente SET dataNascimento = '2000-02-28' WHERE email= 'ceciliameireles@outlook.com';
UPDATE tb_cliente SET dataNascimento = '2000-03-8' WHERE email= 'joanasoares@hotmail.com';
UPDATE tb_cliente SET dataNascimento = '1990-03-6' WHERE email= 'maria31hp@gmail.com';
UPDATE tb_cliente SET dataNascimento = '1985-06-18' WHERE email= 'ri63jss@gmail.com';
UPDATE tb_cliente SET dataNascimento = '2003-01-27' WHERE email= 'thiagoferreira@yahoo.com.br';

SELECT * FROM tb_cliente;

/*Selecionar o nome dos clientes, data de nascimento no formato DD/MM/AAAA e a idade*/
SELECT nome, date_format(dataNascimento, '%d/%m/%Y') AS data_de_nascimento,
       timestampdiff(YEAR, dataNascimento, curdate()) AS idade
  FROM tb_cliente;
  
/*Selecionar todos os clientes que fazem aniversário em março*/
SELECT nome, date_format(dataNascimento, '%d/%m/%Y') AS data_de_nascimento
  FROM tb_cliente
WHERE  month(dataNascimento) = 3
ORDER BY day(dataNascimento);  

 SELECT nome, date_format(dataNascimento, '%d/%m/%Y') AS data_de_nascimento,
       timestampdiff(YEAR, dataNascimento, curdate()) AS idade
 FROM tb_cliente 
WHERE  timestampdiff(YEAR, dataNascimento, curdate()) > 30;

/*NASCIDOS EM MARÇO E QUE TENHA MAIS DE 30 ANOS*/
SELECT nome, date_format(dataNascimento, '%d/%m/%Y') AS data_nascimento,
       timestampdiff(YEAR, dataNascimento, curdate()) AS idade
FROM   tb_cliente
WHERE  month(dataNascimento) = 3 
  AND  timestampdiff(YEAR, dataNascimento, curdate()) > 30;
  
SELECT * FROM tb_genero;  
SELECT idgenero,nome
 FROM  tb_genero
 WHERE nome='Ação'
    OR nome='Ficção';
    
SELECT * FROM tb_filme;

SELECT * FROM tb_filme WHERE trailer IS NULL;
SELECT * FROM tb_filme WHERE trailer IS NOT NULL;
