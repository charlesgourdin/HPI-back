DROP TABLE IF EXISTS `messages`;
DROP TABLE IF EXISTS `tickets`;
DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL COMMENT 'Seulement pour les collaborateurs',
  `password` varchar(45) DEFAULT NULL COMMENT 'Seulement pour les psychologues',
  `token` varchar(45) DEFAULT NULL COMMENT 'Seulement pour les collaborateurs',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role` varchar(45) NOT NULL COMMENT 'Psy\nCollab',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `state` varchar(45) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL COMMENT 'Open\nClosed\nWaiting\n',
  `channel` varchar(45) NOT NULL,
  `pseudo` varchar(45) DEFAULT NULL,
  `collab_id` int(11) NOT NULL,
  `psy_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tickets_users1_idx` (`collab_id`),
  KEY `fk_tickets_users2_idx` (`psy_id`),
  CONSTRAINT `fk_tickets_users1` FOREIGN KEY (`collab_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tickets_users2` FOREIGN KEY (`psy_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `message` text NOT NULL,
  `sender_id` int(11) NOT NULL,
  `tickets_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_messages_users_idx` (`sender_id`),
  KEY `fk_messages_tickets1_idx` (`tickets_id`),
  CONSTRAINT `fk_messages_tickets1` FOREIGN KEY (`tickets_id`) REFERENCES `tickets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_users` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;



