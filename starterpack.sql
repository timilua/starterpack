CREATE TABLE IF NOT EXISTS `starterpack` (
  `identifier` varchar(69) NOT NULL,
  `pack` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
   PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
