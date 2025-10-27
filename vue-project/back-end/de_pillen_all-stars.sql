-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 27 okt 2025 om 10:24
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
(1, 'Centrum Women\r\n', 'Vitaminen & Supplements', 12.99, 90, '../src/assets/images/pro5.jpg', 'Centrum Women is een multivitamine die specifiek is afgestemd op de voedingsbehoeften van vrouwen en meisjes (vanaf 12 jaar).\r\nHet supplement is geformuleerd met belangrijke micronutriënten om vier hoofdzaken te ondersteunen:\r\n1. Energie en Vitaliteit: Door toevoeging van Vitamine B6, B12 en IJzer.\r\n2. Weerstand: Met een mix van Vitamine C, Seleen en Zink.\r\n3. Sterke Botten: Met Calcium, Vitamine D en K om het behoud van botmassa te ondersteunen.\r\n4. Huid en Haar: Met Zink.\r\nBelangrijke Kenmerken:\r\n• Het product is gluten- en lactosevrij en geschikt voor diabetici.\r\n• Centrum is wereldwijd de meest verkochte multivitamine.'),
(2, 'Centrum Men\r\n', 'Vitaminen & Supplements', 14.99, 70, '../src/assets/images/pro4.jpg', 'Centrum Men is een complete multivitamine die specifiek is afgestemd op de behoeften van mannen en jongens (vanaf 12 jaar), rekening houdend met hun grotere spiermassa en snellere calorieverbranding.\r\nHet supplement richt zich op vier belangrijke gebieden:\r\n1. Energie en Vitaliteit: Ondersteund door Vitamine B6, B12 en IJzer.\r\n2. Weerstand: Met Vitamine C, Seleen en Zink voor het immuunsysteem.\r\n3. Spierfunctie: Met Calcium, Magnesium en Vitamine D.\r\n4. Concentratie: Met Niacine en Biotine voor een normale psychologische functie.\r\nBelangrijke Kenmerken:\r\n• Het is gluten- en lactosevrij en geschikt voor diabetici.\r\n• Centrum is wereldwijd de meest verkochte multivitamine.'),
(3, 'Centrum zilver', 'Vitaminen & Supplements', 11.58, 38, '../src/assets/images/pro1.jpg', 'Centrum zilver is een compleet multivitamine- en mineralensupplement dat specifiek is afgestemd op de veranderende voedingsbehoeften van mannen en vrouwen vanaf 50 jaar.\r\nDe formule richt zich op vier hoofdgebieden die belangrijk zijn naarmate men ouder wordt:\r\n1. Vitaliteit/Energie: Ondersteund door vitamine B6, B12 en ijzer om het energieniveau te ondersteunen.\r\n2. Weerstand: Het immuunsysteem wordt versterkt door vitamine C, seleen en zink.\r\n3. Ogen: De conditie van de ogen wordt ondersteund door vitamine A en B2.\r\n4. Botten: De formule bevat calcium, vitamine D en K om de botten te ondersteunen.'),
(4, 'Centrum PERFORMANCE', 'Vitaminen & Supplements', 15.99, 46, '../src/assets/images/pro2.jpg', 'Centrum PERFORMANCE\r\nCentrum PERFORMANCE is een compleet multivitamine- en mineralencomplex dat specifiek is aangevuld met de plantenextracten Ginkgo Biloba en Ginseng.\r\nDit supplement is ontworpen om uw vitaliteit, weerstand en concentratie te ondersteunen.\r\n• Energie & Vitaliteit: De formule bevat B-vitamines (zoals B6 en B12) en ijzer om de natuurlijke energie in het lichaam te activeren.\r\n• Weerstand: Bevat vitamine C, seleen en zink ter ondersteuning van het immuunsysteem.\r\n• Concentratie: IJzer en zink zijn toegevoegd om de concentratie te bevorderen.\r\n• Speciale Toevoeging: De aanwezigheid van Ginseng kan helpen om opnieuw fit te worden (claim in afwachting van goedkeuring).\r\nHet is geschikt voor volwassenen en kinderen vanaf 12 jaar en is gluten- en lactosevrij.'),
(5, 'Centrum met Luteïne', 'Vitaminen & Supplements', 11.75, 27, '../src/assets/images/pro3.jpg', 'Centrum met Luteïne is een standaard multivitamine- en mineralensupplement voor volwassenen, waarbij de formule is aangevuld met Luteïne.\r\nLuteïne is een belangrijk carotenoïde pigment dat van nature voorkomt in de gele vlek (macula) van het oog.\r\nDe formule biedt een brede ondersteuning voor het lichaam met de nadruk op:\r\n• Ondersteuning van de Ogen: Luteïne werkt als een antioxidant en een filter in het oog en helpt zo de gevoelige cellen te beschermen tegen oxidatieve stress en UV-licht. (Merk op: Centrum Select 50+ bevat specifiek Luteïne voor de ogen van 50-plussers).\r\n• Energie: Diverse B-vitamines (zoals B1, B2, B6, B12, Niacine, Pantotheenzuur) en ijzer dragen bij aan een normale energiestofwisseling.\r\n• Immuunsysteem: Vitamine C, Seleen en Zink ondersteunen de normale werking van het immuunsysteem.\r\n• Celbescherming: Vitamine C, E en Seleen helpen cellen te beschermen tegen oxidatieve stress (vrije radicalen).\r\n• Huid: Bevat Zink en Vitamine A en Biotine voor het behoud van een gezonde huid.\r\n'),
(6, 'Paracetamol', 'Pijnstillers', 6.25, 90, '../src/assets/images/pijn1.jpg', 'Leidapharm Paracetamol 500mg RVG 21748=52239 AV  Leidapharm Paracetamol 500 mg, tabletten Leidapharm Paracetamol 500 mg behoort tot de groep van de zogenaamde pijnstillende en koortsverlagende geneesmiddelen.  Waarvoor wordt dit middel gebruikt Leidapharm Paracetamol 500 mg wordt gebruikt bij: - hoofdpijn - koorts en pijn bij griep en verkoudheid - koorts en pijn na vaccinatie - kiespijn - zenuwpijn - spit - spierpijn - menstruatiepijn  Niet gebruiken bij Dit middel is niet geschikt voor kinderen jonger dan 4 jaar U bent allergisch voor één van de stoffen in dit geneesmiddel  Extra voorzichtig bij Waarschuwing: #Het is belangrijk om niet te veel te gebruiken, want dan kan dit geneesmiddel lever- en nierklachten geven. Wij adviseren u voor gebruik de bijsluiter te lezen. #Vermijd langdurig gebruik bij hoofdpijn, dit kan hoofdpijn veroorzaken. #Niet gebruiken bij slechte nier- of leverfunctie zonder overleg met een arts. #Bij pijn niet langer dan 5 dagen gebruiken of bij koorts niet langer dan 3 dagen gebruiken'),
(7, 'kinderparacetamol', 'Pijnstillers', 9.99, 78, '../src/assets/images/pijn2.jpg', 'Sinaspril Vloeibaar is een kinderparacetamol met 120mg paracetamol speciaal ontwikkeld om koorts en pijn te verlichten bij kinderen vanaf 3 maanden oud. Kleine kinderen hebben snel een verkoudheid of griepje te pakken. En door de pijn of koorts kunnen zij zich best ellendig voelen…. Ouders willen natuurlijk niets liever dan hun kindje weer snel beter zien! Met paracetamol kunnen pijn en koorts worden aangepakt.  De voordelen van Sinaspril Vloeibaar paracetamol 120mg:  Geschikt voor kindjes vanaf 3 maanden Werkt snel bij koorts, griep, verkoudheid en bij pijn na inenting Gemakkelijk toe te dienen stroop met een lekkere bananensmaak Een goed alternatief voor zetpilletjes Altijd de juiste dosering met het bijgesloten lepeltje Eenvoudig te mengen met de borst- of kunstvoeding of fruithapje Bevat geen gluten en lactose Ook verkrijgbaar in kauwtabletten: Sinaspril Kauwtabletten 120 mg paracetamol Gebruik:  Dosering: * Kinderen van 3 mnd -1 jaar: 2,5 ml per keer, 4 tot 6x per 24 uur * Kinderen van 1-2 jaar: 5 ml per'),
(10, 'Sinaspril Paracetamol', 'Pijnstillers', 14.99, 34, '../src/assets/images/pijn3.jpg', 'Sinaspril Paracetamol 240mg ZetpilSinaspril paracetamol 240 mg zetpillen bevatten paracetamol. Paracetamol heeft pijnstillende en koortsverlagende werking. Te gebruiken bij koorts en pijn bij griep en verkoudheid, koorts en pijn na inenting, hoofdpijn, kiespijn, zenuwpijn, spierpijn. Voor kinderen van 1 tot 6 jaar. * Paracetamol heeft pijnstillende en koortsverlagende werking. * Voor kinderen van 1 tot 6 jaar'),
(11, 'Ibuprofen suikervrije', 'Pijnstillers', 8.99, 56, '../src/assets/images/pijn4.jpg', 'Ibuprofen suikervrije Liquid CapsLinn Ibuprofen 400 mg suikervrije Liquid Caps heeft een pijnstillende, koortswerende, ontstekingsremmende werking die tussen de 4 en 8 uur aanhoudt. Ibuprofen is te gebruiken bij allerlei soorten matige pijn zoals menstruatiepijn, kiespijn, hoofdpijn, koorts en pijn bij griep en verkoudheid of na inenting. Ibuprofen 400 mg is geschikt voor volwassenen en kinderen zwaarder dan 40 kg (ongeveer 12 jaar of ouder) * Makkelijk om door te slikken * Geschikt voor volwassenen en kinderen vanaf 12 jaar (zwaarder dan 40 kg) * Bevat 400 gram ibuprofen * Suikervrije capsules'),
(14, 'Nurofen 400', 'Pijnstillers', 10.68, 34, '../src/assets/images/pijn5.jpg', 'Nurofen 400 is te gebruiken bij koorts, pijn en ontstekingsreacties. Elk tablet bevat 400 mg ibuprofen en ze zijn geschikt voor kinderen vanaf 12 jaar en volwassenen. De tabletten zijn 23% kleiner dan voorheen. De tabletten zijn gemakkelijk in te nemen door kleine, ronde vorm en gladde coating. Vooral geschikt voor stevige pijn.'),
(15, 'Amoxicilline', 'Antibioticum', 9.29, 68, '../src/assets/images/anti1.jpg', '• Wat is het? Amoxicilline is een veelgebruikt breedspectrum antibioticum uit de penicillinegroep. • Werking: Het doodt bacteriën die infecties veroorzaken, en verspreidt zich via het bloed door het hele lichaam. • Gebruik: Het wordt gebruikt voor een breed scala aan bacteriële infecties (zoals longen, blaas, keel, en middenoor). • Toediening: De tabletten moeten in een glas water worden opgelost en de inname moet verdeeld worden over de dag. • De Hoofdregel: Maak de kuur altijd helemaal af, ook als de verschijnselen van de infectie verdwenen zijn. • Allergieën (STOP DIRECT): Krijgt u huiduitslag, met benauwdheid, koorts en soms flauwvallen, dan moet u onmiddellijk stoppen met de inname en uw arts waarschuwen. • Belangrijk: Overleg met uw arts als u bloedverdunners gebruikt of een nierafwijking heeft.'),
(16, 'Cetirizine 10mg', 'Antibioticum', 15.78, 43, '../src/assets/images/anti2.jpg', 'Cetirizine 10mg (Anti-Allergie) Wat is het? • Een effectief antihistaminicum (anti-allergie medicijn), generieke versie van Zyrtec. • Het blokkeert de werking van histamine in het lichaam, wat allergische klachten vermindert. Belangrijkste Voordelen: • Snelle werking: Begint na 30-60 minuten. • Langdurig: Werkt 24 uur na inname van één tablet. • Minder versuffend dan oudere antihistaminica. Waarvoor wordt het gebruikt? • Verlichting van klachten bij hooikoorts, huisstofmijt- en huisdierallergieën. • Vermindering van jeuk en uitslag bij chronische netelroos (urticaria). Dosering (Volwassenen & Kinderen vanaf 12 jaar): • 1 tablet (10mg) per dag, bij voorkeur \'s avonds. Belangrijke Voorzichtigheidspunten: • Niet gebruiken bij ernstige nierproblemen of overgevoeligheid. • Wees voorzichtig bij verminderde nierfunctie, epilepsie of plasproblemen. • Vermijd alcohol tijdens gebruik. Meest Voorkomende Bijwerkingen: • Slaperigheid/vermoeidheid, droge mond, hoofdpijn.'),
(17, 'Allerfre Hooikoorts ', 'Antibioticum', 10.39, 97, '../src/assets/images/anti3.jpg', 'Allerfre Hooikoorts tabletten verhelpt hooikoortsklachten en vergelijkbare allergische reacties zoals bijvoorbeeld huisdier-en huismijtallergie. Klachten als niezen, jeuk aan de ogen, neusloop, roodheid en huiduitslag worden tegengegaan. Het gebruik van 1 klein tablet heeft al een werking van 24 uur om klachten te voorkomen. Per tablet bevat Allerfre 10 mg loratadine.  24 uur werking met 1 tablet Geschikt voor kinderen (vanaf 2 jaar) Snelle werking Bruikbaar en effectief bij vergelijkbare allergische reacties'),
(18, 'Allegra fexotabs', 'Antihistamine', 8.09, 106, '../src/assets/images/alle2.jpg', 'Allegra fexotabs (Fexofenadine 120mg) Wat is het? • Een antihistaminicum dat de werkzame stof fexofenadine hydrochloride bevat. • Het verlicht de symptomen van hooikoorts (seizoensgebonden allergische rhinitis). Waarvoor wordt het gebruikt? • Verlichting van klachten zoals niezen, jeuk, loopneus of verstopte neus, en jeukende, rode, tranende ogen. Gebruik en Dosering: • De aanbevolen dosis is 1 tablet (120 mg) per dag. • Geschikt voor volwassenen en kinderen ouder dan 12 jaar. • Begint te werken binnen 1 uur en houdt 24 uur aan. • Inname met wat water. Belangrijke Adviezen: • Lees altijd de bijsluiter. • Raadpleeg uw arts of apotheker bij zwangerschap of borstvoeding. • Raadpleeg de huisarts als klachten langer dan twee weken aanhouden of verergeren. Wat wilt u nu doen? 1. Vergelijk Cetirizine en Fexofenadine: Wat zijn de belangrijkste verschillen? 2. Stel een vraag over een van de medicijnen. 3. Zoek meer informatie op over een van de middelen (bijvoorbeeld over bijwerkingen van Fexofenadine).'),
(19, 'Hylo Night Oogzalf', 'Antihistamine', 10.19, 83, '../src/assets/images/alle3.jpg', 'Hylo Night Oogzalf Wat is het? • Een medisch hulpmiddel in de vorm van een oogzalf. • Ontwikkeld voor nachtelijk gebruik bij droge, gevoelige ogen. Doel en Voordelen: • Biedt intensieve verzorging en duurzame bescherming aan geïrriteerde, droge ogen. • Voorkomt uitdroging, een vervelend schuurgevoel en de vorming van korstjes of afzetting aan de ooglidrand bij het ontwaken. • Zorgt ervoor dat het hoornvlies en bindvlies \'s nachts goed kunnen herstellen. • Voorkomt het vastkleven van de oogleden tijdens de slaap. Samenstelling: • Bevat Vitamine A (ter verzorging van de natuurlijke traanfilm). • Is zonder conserveringsmiddelen en fosfaten. Gebruik: • Bijzonder geschikt voor gebruik tijdens de slaap. • Wordt overdag aanbevolen om te combineren met hydraterende oogdruppels (zoals HYLO COMOD® of HYLO® GEL).'),
(20, 'Allergo-COMOD®', 'Antihistamine', 10.43, 123, '../src/assets/images/alle4.jpg', 'Allergo-COMOD® Oogdruppels Wat is het? • Een geneesmiddel in de vorm van oogdruppels. • De werkzame stof is dinatriumcromoglicaat (20mg/ml). • Dit is een mestcelstabilisator: het voorkomt het vrijkomen van overdrachtsstoffen (zoals histamine) die allergische reacties veroorzaken. Waarvoor wordt het gebruikt? • Ter voorkoming en behandeling van allergische oogbindvliesontsteking (conjunctivitis) veroorzaakt door overgevoeligheidsreacties op bepaalde stoffen. Belangrijke Kenmerken: • Vrij van conserveringsmiddelen en daardoor geschikt voor patiënten die hier gevoelig voor zijn. • Werkt preventief: regelmatige toediening is belangrijk gedurende de periode van blootstelling aan allergenen. Dosering: • De aanbevolen dosering is vier tot zes maal daags 1-2 druppels in ieder oog. • Niet langer dan 14 dagen gebruiken zonder uw arts te raadplegen. Let op! • Niet gebruiken als u allergisch bent voor één van de bestanddelen. • De toediening is met een speciaal pompmechanisme in de flacon. U heeft nu informatie over: 1.');

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
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
