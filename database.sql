CREATE TABLE IF NOT EXISTS `doors` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `owner` varchar(50) NOT NULL,
    `door_id` int(11) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `keys` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `owner` varchar(50) NOT NULL,
    `door_id` int(11) NOT NULL,
    PRIMARY KEY (`id`)
);