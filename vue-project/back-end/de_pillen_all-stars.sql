-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 15 okt 2025 om 15:16
-- Serverversie: 10.4.32-MariaDB
-- PHP-versie: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `de pillen all-stars`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `bestelling`
--

CREATE TABLE `bestelling` (
  `bestelling_id` int(11) NOT NULL,
  `klant_id` int(11) NOT NULL,
  `datum` datetime NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'In behandeling',
  `totaal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `bestelregel`
--

CREATE TABLE `bestelregel` (
  `regel_id` int(11) NOT NULL,
  `bestelling_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `hoeveelheid` int(11) NOT NULL,
  `prijs` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `chat`
--

CREATE TABLE `chat` (
  `chat_id` int(11) NOT NULL,
  `klant_id` int(11) NOT NULL,
  `bericht` text NOT NULL,
  `tijd` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `klant`
--

CREATE TABLE `klant` (
  `klant_id` int(11) NOT NULL,
  `naam` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `wachtwoord` varchar(255) NOT NULL,
  `adres` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `naam` varchar(255) NOT NULL,
  `categorie` varchar(100) NOT NULL,
  `prijs` decimal(10,2) NOT NULL,
  `voorraad` int(11) NOT NULL,
  `afbeelding_url` varchar(255) DEFAULT NULL,
  `beschrijving` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Gegevens worden geëxporteerd voor tabel `product`
--

INSERT INTO `product` (`product_id`, `naam`, `categorie`, `prijs`, `voorraad`, `afbeelding_url`, `beschrijving`) VALUES
(1, 'Centrum Women\r\n', 'Vitaminen & Supplements', 12.99, 90, 'src/assets/images/pro5.jpg', 'Centrum Women is een multivitamine die specifiek is afgestemd op de voedingsbehoeften van vrouwen en meisjes (vanaf 12 jaar).\r\nHet supplement is geformuleerd met belangrijke micronutriënten om vier hoofdzaken te ondersteunen:\r\n1. Energie en Vitaliteit: Door toevoeging van Vitamine B6, B12 en IJzer.\r\n2. Weerstand: Met een mix van Vitamine C, Seleen en Zink.\r\n3. Sterke Botten: Met Calcium, Vitamine D en K om het behoud van botmassa te ondersteunen.\r\n4. Huid en Haar: Met Zink.\r\nBelangrijke Kenmerken:\r\n• Het product is gluten- en lactosevrij en geschikt voor diabetici.\r\n• Centrum is wereldwijd de meest verkochte multivitamine.'),
(2, 'Centrum Men\r\n', 'Vitaminen & Supplements', 14.99, 70, 'src/assets/images/pro4.jpg', 'Centrum Men is een complete multivitamine die specifiek is afgestemd op de behoeften van mannen en jongens (vanaf 12 jaar), rekening houdend met hun grotere spiermassa en snellere calorieverbranding.\r\nHet supplement richt zich op vier belangrijke gebieden:\r\n1. Energie en Vitaliteit: Ondersteund door Vitamine B6, B12 en IJzer.\r\n2. Weerstand: Met Vitamine C, Seleen en Zink voor het immuunsysteem.\r\n3. Spierfunctie: Met Calcium, Magnesium en Vitamine D.\r\n4. Concentratie: Met Niacine en Biotine voor een normale psychologische functie.\r\nBelangrijke Kenmerken:\r\n• Het is gluten- en lactosevrij en geschikt voor diabetici.\r\n• Centrum is wereldwijd de meest verkochte multivitamine.'),
(3, 'Centrum zilver', 'Vitaminen & Supplements', 11.58, 38, 'src/assets/images/pro1.jpg', 'Centrum zilver is een compleet multivitamine- en mineralensupplement dat specifiek is afgestemd op de veranderende voedingsbehoeften van mannen en vrouwen vanaf 50 jaar.\r\nDe formule richt zich op vier hoofdgebieden die belangrijk zijn naarmate men ouder wordt:\r\n1. Vitaliteit/Energie: Ondersteund door vitamine B6, B12 en ijzer om het energieniveau te ondersteunen.\r\n2. Weerstand: Het immuunsysteem wordt versterkt door vitamine C, seleen en zink.\r\n3. Ogen: De conditie van de ogen wordt ondersteund door vitamine A en B2.\r\n4. Botten: De formule bevat calcium, vitamine D en K om de botten te ondersteunen.'),
(4, 'Centrum PERFORMANCE', 'Vitaminen & Supplements', 15.99, 46, 'src/assets/images/pro2.jpg', 'Centrum PERFORMANCE\r\nCentrum PERFORMANCE is een compleet multivitamine- en mineralencomplex dat specifiek is aangevuld met de plantenextracten Ginkgo Biloba en Ginseng.\r\nDit supplement is ontworpen om uw vitaliteit, weerstand en concentratie te ondersteunen.\r\n• Energie & Vitaliteit: De formule bevat B-vitamines (zoals B6 en B12) en ijzer om de natuurlijke energie in het lichaam te activeren.\r\n• Weerstand: Bevat vitamine C, seleen en zink ter ondersteuning van het immuunsysteem.\r\n• Concentratie: IJzer en zink zijn toegevoegd om de concentratie te bevorderen.\r\n• Speciale Toevoeging: De aanwezigheid van Ginseng kan helpen om opnieuw fit te worden (claim in afwachting van goedkeuring).\r\nHet is geschikt voor volwassenen en kinderen vanaf 12 jaar en is gluten- en lactosevrij.'),
(5, 'Centrum met Luteïne', 'Vitaminen & Supplements', 11.75, 27, 'src/assets/images/pro3.jpg', 'Centrum met Luteïne is een standaard multivitamine- en mineralensupplement voor volwassenen, waarbij de formule is aangevuld met Luteïne.\r\nLuteïne is een belangrijk carotenoïde pigment dat van nature voorkomt in de gele vlek (macula) van het oog.\r\nDe formule biedt een brede ondersteuning voor het lichaam met de nadruk op:\r\n• Ondersteuning van de Ogen: Luteïne werkt als een antioxidant en een filter in het oog en helpt zo de gevoelige cellen te beschermen tegen oxidatieve stress en UV-licht. (Merk op: Centrum Select 50+ bevat specifiek Luteïne voor de ogen van 50-plussers).\r\n• Energie: Diverse B-vitamines (zoals B1, B2, B6, B12, Niacine, Pantotheenzuur) en ijzer dragen bij aan een normale energiestofwisseling.\r\n• Immuunsysteem: Vitamine C, Seleen en Zink ondersteunen de normale werking van het immuunsysteem.\r\n• Celbescherming: Vitamine C, E en Seleen helpen cellen te beschermen tegen oxidatieve stress (vrije radicalen).\r\n• Huid: Bevat Zink en Vitamine A en Biotine voor het behoud van een gezonde huid.\r\n');

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `bestelling`
--
ALTER TABLE `bestelling`
  ADD PRIMARY KEY (`bestelling_id`),
  ADD KEY `fk_bestelling_klant` (`klant_id`);

--
-- Indexen voor tabel `bestelregel`
--
ALTER TABLE `bestelregel`
  ADD PRIMARY KEY (`regel_id`),
  ADD KEY `fk_regel_bestelling` (`bestelling_id`),
  ADD KEY `fk_regel_product` (`product_id`);

--
-- Indexen voor tabel `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`chat_id`),
  ADD KEY `fk_chat_klant` (`klant_id`);

--
-- Indexen voor tabel `klant`
--
ALTER TABLE `klant`
  ADD PRIMARY KEY (`klant_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexen voor tabel `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `bestelling`
--
ALTER TABLE `bestelling`
  MODIFY `bestelling_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `bestelregel`
--
ALTER TABLE `bestelregel`
  MODIFY `regel_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `chat`
--
ALTER TABLE `chat`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `klant`
--
ALTER TABLE `klant`
  MODIFY `klant_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `bestelling`
--
ALTER TABLE `bestelling`
  ADD CONSTRAINT `fk_bestelling_klant` FOREIGN KEY (`klant_id`) REFERENCES `klant` (`klant_id`) ON DELETE CASCADE;

--
-- Beperkingen voor tabel `bestelregel`
--
ALTER TABLE `bestelregel`
  ADD CONSTRAINT `fk_regel_bestelling` FOREIGN KEY (`bestelling_id`) REFERENCES `bestelling` (`bestelling_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_regel_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Beperkingen voor tabel `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `fk_chat_klant` FOREIGN KEY (`klant_id`) REFERENCES `klant` (`klant_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
