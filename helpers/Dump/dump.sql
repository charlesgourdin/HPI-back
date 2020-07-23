USE test_hpi;

DROP TABLE IF EXISTS messages;

DROP TABLE IF EXISTS tickets;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id int(11) NOT NULL AUTO_INCREMENT,
  firstname varchar(45) NOT NULL,
  lastname varchar(45) NOT NULL,
  email varchar(45) NOT NULL COMMENT 'Seulement pour les collaborateurs',
  password varchar(45) DEFAULT NULL COMMENT 'Seulement pour les psychologues',
  token varchar(45) DEFAULT NULL COMMENT 'Seulement pour les collaborateurs',
  timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  role varchar(45) NOT NULL COMMENT 'Psy\nCollab',
  PRIMARY KEY (id)
);

CREATE TABLE tickets (
  id int(11) NOT NULL AUTO_INCREMENT,
  updated_on timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  state varchar(45) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL COMMENT 'Open\nClosed\nWaiting\n',
  channel varchar(45) NOT NULL,
  pseudo varchar(45) DEFAULT NULL,
  collab_id int(11) NOT NULL,
  psy_id int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_tickets_users1_idx (collab_id),
  KEY fk_tickets_users2_idx (psy_id),
  CONSTRAINT fk_tickets_users1 FOREIGN KEY (collab_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_tickets_users2 FOREIGN KEY (psy_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE messages (
  id int(11) NOT NULL AUTO_INCREMENT,
  timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  message text NOT NULL,
  sender_id int(11) NOT NULL,
  tickets_id int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY fk_messages_users_idx (sender_id),
  KEY fk_messages_tickets1_idx (tickets_id),
  CONSTRAINT fk_messages_tickets1 FOREIGN KEY (tickets_id) REFERENCES tickets (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_messages_users FOREIGN KEY (sender_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);


LOCK TABLES users WRITE;

INSERT INTO users VALUES (1,'Gérald','B','bar.ge@gmail.om','','123','2020-01-11 22:52:08','collab'),(2,'John','Doe','john.doe@gmail.com','1234','','2020-06-15 20:54:58','psy_busy'),(6,'Robert','Durand','robert.durand@gmail.com','1234',NULL,'2020-05-18 15:59:03','psy_busy'),(7,'Marion','Laforest','marion.laforest@gmail.com','1234',NULL,'2020-05-18 16:07:24','psy_busy'),(8,'Charlotte','Lacroix','charlotte.lacroix@gmail.com','1234',NULL,'2020-05-18 16:07:24','psy_offline'),(9,'Adèle','Létourneau','adele.letourneau@gmail.com','1234',NULL,'2020-05-18 16:07:24','psy_online'),(10,'Matthieu','Fréchette','matthieu.frechette@gmail.com','1234',NULL,'2020-05-18 16:07:24','psy_offline'),(11,'Julien','Bernier','julien.bernier@gmail.com','1234',NULL,'2020-05-18 16:07:24','psy_offline'),(12,'Ben','Smith','ben.smith@gmail.com','','1234','2020-06-15 20:50:05','collab');

UNLOCK TABLES;

LOCK TABLES tickets WRITE;

INSERT INTO tickets VALUES (20,'2020-06-13 14:16:43','pending','202004181755_1','anonyme',1,2),(21,'2020-06-15 20:54:58','pending','202005152252_12','Julien',12,2);

UNLOCK TABLES;

LOCK TABLES messages WRITE;

INSERT INTO messages VALUES (8,'2020-06-15 20:55:11','Bonjour, je suis votre psychologue.',2,21),(9,'2020-06-15 20:55:19','Bonjour, merci.',12,21),(10,'2020-06-15 20:55:26','Comment allez-vous? ',2,21),(11,'2020-06-15 20:55:39','Je voulais vous parlez d\'un sujet personnel. ',12,21),(12,'2020-06-15 20:55:48','Concernant mon supérieur. ',12,21),(13,'2020-06-15 20:56:02','Très bien je vous écoute. ',2,21),(14,'2020-06-15 20:56:19','d',2,21),(15,'2020-06-15 20:56:19','d',2,21),(16,'2020-06-15 20:56:19','d',2,21),(17,'2020-06-15 20:56:20','d',2,21),(18,'2020-06-15 20:56:20','d',2,21),(19,'2020-06-15 20:56:33','Effectivement, c\'est un bon conseil. ',12,21),(20,'2020-06-15 20:56:46','Je pense que ça ira mieux si je m\'impose. ',12,21),(21,'2020-06-15 20:56:56','Vous pouvez le faire, j\'en suis convaincu. ',2,21),(22,'2020-06-15 20:57:07','Super, merci. ',12,21),(23,'2020-06-15 20:57:20','Avez-vous besoin d\'autre chose? ',2,21),(24,'2020-06-15 20:57:32','Non c\'est parfait!',12,21),(25,'2020-06-15 20:57:37','Merci',12,21),(26,'2020-06-15 20:58:52','Très bien, merci! ',2,21),(27,'2020-06-15 20:59:24','Bonne continuation. Je vous invite à clôturer la conversation. ',2,21),(28,'2020-06-15 20:59:31','Très bien merci',12,21);

UNLOCK TABLES;
