-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2019-12-03 03:34:16
-- 服务器版本： 10.1.35-MariaDB
-- PHP 版本： 7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `market`
--

-- --------------------------------------------------------

--
-- 表的结构 `admin`
--

CREATE DATABASE `market`;
USE `market`;

CREATE TABLE `admin` (
  `A_ID` varchar(50) NOT NULL,
  `A_NAME` varchar(50) NOT NULL,
  `A_PASS` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `admin`
--

INSERT INTO `admin` (`A_ID`, `A_NAME`, `A_PASS`) VALUES
('cl001', 'loh', '$2b$10$WGzR2qB6W9yE.sU/12AOzOo0ITK0EhutH.9BWrf08r48SgKKypJYW'),
('DI888', 'Wong', '$2b$10$VwK72fqerETZM.k51H5jtegxQvSlHujq0OS6oSCre4SzSSn49mGxC'),
('LI199', 'liqi', '$2b$10$yy84RrdZuyckRE5tU8qS9uR/6Srz68bn/TnSM9u/7AIR4kEqFc9YC');

-- --------------------------------------------------------

--
-- 表的结构 `categories`
--

CREATE TABLE `categories` (
  `C_ID` int(11) NOT NULL,
  `C_Name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `categories`
--

INSERT INTO `categories` (`C_ID`, `C_Name`) VALUES
(1, 'Men Fashion'),
(2, 'Women Fashion'),
(3, 'Electronics'),
(4, 'Mobile Phone & Accessories '),
(6, 'Sports'),
(7, 'BookStationery');

-- --------------------------------------------------------

--
-- 表的结构 `country`
--

CREATE TABLE `country` (
  `C_ID` int(50) NOT NULL,
  `C_NAME` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `country`
--

INSERT INTO `country` (`C_ID`, `C_NAME`) VALUES
(1, 'Malaysia');

-- --------------------------------------------------------

--
-- 表的结构 `deals`
--

CREATE TABLE `deals` (
  `D_ID` int(11) NOT NULL,
  `D_MEETUP` int(11) DEFAULT NULL,
  `D_POS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `deals`
--

INSERT INTO `deals` (`D_ID`, `D_MEETUP`, `D_POS`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10),
(11, 11, 11),
(12, 12, 12),
(13, 13, 13),
(14, 14, 14),
(15, 15, 15),
(16, 16, 16),
(17, 17, 17),
(18, 18, 18),
(19, 19, 19),
(20, 20, 20),
(21, 21, 21),
(22, 22, 22),
(23, 23, 23),
(24, 24, 24),
(25, 25, 25),
(26, 26, 26),
(27, 27, 27),
(28, 28, 28),
(29, 29, 29),
(30, 30, 30),
(31, 31, 31),
(32, 32, 32),
(33, 33, 33),
(34, 34, 34),
(35, 35, 35),
(36, 36, 36),
(37, 37, 37),
(38, 38, 38),
(39, 39, 39);

-- --------------------------------------------------------

--
-- 表的结构 `evaluate`
--

CREATE TABLE `evaluate` (
  `E_ID` int(11) NOT NULL,
  `E_COMMENT` text NOT NULL,
  `E_RATING` int(11) NOT NULL,
  `E_GIVER` varchar(50) DEFAULT NULL,
  `E_RECEIVER` varchar(50) DEFAULT NULL,
  `P_ID` int(11) DEFAULT NULL,
  `RATE_DATE` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `evaluate`
--

INSERT INTO `evaluate` (`E_ID`, `E_COMMENT`, `E_RATING`, `E_GIVER`, `E_RECEIVER`, `P_ID`, `RATE_DATE`) VALUES
(1, 'haha', 5, 'cleong98', 'wj', 38, '2019-12-03 09:34:06'),
(2, '', 5, 'cleong98', 'wensen', 1, '2019-12-03 09:42:37'),
(3, 'sohai', 1, 'menghui', 'wensen', 21, '2019-12-03 09:45:10'),
(4, 'SOHAI', 1, 'cleong98', 'wensen', 2, '2019-12-03 09:47:28'),
(5, 'GTOU\n', 1, 'cleong98', 'gwei', 15, '2019-12-03 09:51:35'),
(6, 'GTOU', 1, 'cleong98', 'gwei', 4, '2019-12-03 09:51:48');

-- --------------------------------------------------------

--
-- 表的结构 `gender`
--

CREATE TABLE `gender` (
  `G_ID` int(50) NOT NULL,
  `G_NAME` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `gender`
--

INSERT INTO `gender` (`G_ID`, `G_NAME`) VALUES
(1, 'Male'),
(2, 'Female');

-- --------------------------------------------------------

--
-- 表的结构 `meetup`
--

CREATE TABLE `meetup` (
  `M_ID` int(11) NOT NULL,
  `M_ADD` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `meetup`
--

INSERT INTO `meetup` (`M_ID`, `M_ADD`) VALUES
(1, 'Bandar Sri Putra'),
(2, 'Bandar Sri Sendayan'),
(3, 'PETRONAS Station'),
(4, ''),
(5, 'rawang town'),
(6, 'Bandar Seri Permaisuri'),
(7, 'Lembah Subang LRT Station'),
(8, 'Shah Alam'),
(9, 'Universiti Tenaga Nasional (UNITEN)'),
(10, 'Kuala Lumpur'),
(11, 'Seksyen 7,shah alam'),
(12, 'Bandar Sunway'),
(13, 'Klang'),
(14, 'Kampung Selamat MRT Station'),
(15, 'Surau TNB Jalan Lahat'),
(16, 'Taman Sri Serdang'),
(17, 'Seri Manjung'),
(18, 'Sunway Pyramid'),
(19, 'Food Court Tesco Extra Kajang'),
(20, 'Hospital selayang'),
(21, 'Econsave'),
(22, ''),
(23, '1 Utama Shopping Centre'),
(24, 'Cheaper'),
(25, 'Johor Bahru'),
(26, 'Alor Setar'),
(27, 'Banting'),
(28, 'SS18 LRT Station'),
(29, 'Ipoh'),
(30, 'Kuala Lumpur'),
(31, 'Shell Seksyen 9'),
(32, 'PDC Suntect Bayan Baru'),
(33, 'Lembah Subang LRT Station'),
(34, 'Johor Bahru'),
(35, 'Puchong'),
(36, 'Ipoh'),
(37, ''),
(38, 'PDC Suntect Bayan Baru'),
(39, 'johor');

-- --------------------------------------------------------

--
-- 表的结构 `orders`
--

CREATE TABLE `orders` (
  `O_ID` int(11) NOT NULL,
  `BUYER` varchar(50) DEFAULT NULL,
  `SELLER` varchar(50) DEFAULT NULL,
  `P_ID` int(11) DEFAULT NULL,
  `P_PRICE` varchar(50) DEFAULT NULL,
  `O_STATUS` int(11) DEFAULT '1',
  `O_DATE` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `orders`
--

INSERT INTO `orders` (`O_ID`, `BUYER`, `SELLER`, `P_ID`, `P_PRICE`, `O_STATUS`, `O_DATE`) VALUES
(2, 'cleong98', 'wj', 38, '20', 0, '2019-12-03 09:33:50'),
(4, 'cleong98', 'wensen', 1, '80', 0, '2019-12-03 09:42:17'),
(5, 'menghui', 'wensen', 21, '1880', 0, '2019-12-03 09:44:51'),
(6, 'cleong98', 'wensen', 2, '50', 0, '2019-12-03 09:47:09'),
(7, 'cleong98', 'gwei', 4, '90', 0, '2019-12-03 09:50:02'),
(8, 'cleong98', 'gwei', 15, '50', 0, '2019-12-03 09:51:00'),
(9, 'cleong98', 'gwei', 5, '100', 1, '2019-12-03 09:56:07');

-- --------------------------------------------------------

--
-- 表的结构 `pos`
--

CREATE TABLE `pos` (
  `P_ID` int(11) NOT NULL,
  `P_DES` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `pos`
--

INSERT INTO `pos` (`P_ID`, `P_DES`) VALUES
(1, ''),
(2, ''),
(3, ''),
(4, 'postage RM10 no include in product price'),
(5, ''),
(6, ''),
(7, 'Postage RM10'),
(8, ''),
(9, ''),
(10, 'Postage RM10'),
(11, ''),
(12, ''),
(13, ''),
(14, ''),
(15, ''),
(16, ''),
(17, ''),
(18, ''),
(19, ''),
(20, ''),
(21, ''),
(22, ''),
(23, ''),
(24, ''),
(25, ''),
(26, ''),
(27, ''),
(28, ''),
(29, ''),
(30, ''),
(31, ''),
(32, ''),
(33, ''),
(34, ''),
(35, ''),
(36, ''),
(37, 'Postage RM8'),
(38, ''),
(39, '');

-- --------------------------------------------------------

--
-- 表的结构 `product`
--

CREATE TABLE `product` (
  `P_ID` int(11) NOT NULL,
  `P_Title` varchar(100) NOT NULL,
  `P_Price` varchar(50) NOT NULL,
  `P_Description` varchar(500) NOT NULL,
  `P_Upload` datetime DEFAULT CURRENT_TIMESTAMP,
  `P_Status` int(11) DEFAULT '1',
  `P_Active` int(11) DEFAULT '1',
  `P_BLOCKED` int(11) DEFAULT '0',
  `P_Deal` int(11) NOT NULL,
  `UploadBy` varchar(50) NOT NULL,
  `ApprovedBy` varchar(50) DEFAULT NULL,
  `P_Category` int(11) DEFAULT NULL,
  `P_Sub` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `product`
--

INSERT INTO `product` (`P_ID`, `P_Title`, `P_Price`, `P_Description`, `P_Upload`, `P_Status`, `P_Active`, `P_BLOCKED`, `P_Deal`, `UploadBy`, `ApprovedBy`, `P_Category`, `P_Sub`) VALUES
(1, 'Beams x herschel backpack', '80', 'Beams x herschel backpack\nCondition 7/10\nSebelah atas ada mcm defect sikit.\nMinat boleh dm.', '2019-12-03 07:04:39', 2, 0, 0, 1, 'wensen', 'LI199', 1, 1),
(2, 'Coleman bag', '50', 'Adjust strap\nAuthentic Coleman\nCondition 9.5/10\nNo defect \nVery good quality ', '2019-12-03 07:06:35', 2, 0, 0, 2, 'wensen', 'LI199', 1, 1),
(3, 'Hugo Boss Card Holder', '150', 'Used but still in good condition. \n\nComes with original box and certs. ', '2019-12-03 07:15:13', 2, 1, 0, 3, 'wensen', 'LI199', 1, 1),
(4, 'Mandarina Duck Bag', '90', 'Condition masih ok 7.5/10\nada defect sdikit....\noriginal by mandarina duck\ncolour hitam', '2019-12-03 07:19:07', 2, 0, 0, 4, 'gwei', 'LI199', 1, 1),
(5, 'Matter wallet', '100', 'walet tahan lasak.cod hanya di rawang town.postage rm10 jika jauh.tq', '2019-12-03 07:20:49', 2, 0, 0, 5, 'gwei', 'LI199', 1, 1),
(6, 'Levis Big E Trucker Jacket', '250', 'Levis Big E Trucker\nButang J58 \nOriginal japan\nCondition almsot new 9.5/10', '2019-12-03 07:23:06', 2, 1, 0, 6, 'gwei', 'LI199', 1, 2),
(7, 'Uniqlo UT KAWS X PEANUTS (XS) Pocket T-shirt', '40', 'Don\'t wear anymore. Only worn 3 times, so condition quite new.', '2019-12-03 07:24:21', 2, 1, 0, 7, 'gwei', 'LI199', 1, 2),
(8, 'WINDBREAKER HOODIE NIKE', '79', 'WINDBREAKER HOODIE NIKE\nPOKET ZIP HADAPAN\nSAIZ: L PIT: 22\" LABUH: 27\"', '2019-12-03 07:26:20', 2, 1, 0, 8, 'wensen', 'LI199', 1, 2),
(9, 'Adidas Energy Boost 9.5 uk (made in Argentina)', '150', 'Authentic Adidas Energy Boost come with Box', '2019-12-03 07:29:08', 2, 1, 0, 9, 'likyang', 'LI199', 1, 3),
(10, 'GUCCI LOAFER', '100', 'MUR MUR JEAK RM120!!\nGUCCI LOAFER \nSIZE: 39-44', '2019-12-03 07:31:02', 2, 1, 0, 10, 'likyang', 'LI199', 1, 3),
(11, 'New Balance', '150', 'Baru beli kat butik new balance. Harga asal RM439.00 !! Aku nak jual balik sbb salah beli size. Harga aku jual RM300 bro. ', '2019-12-03 07:32:45', 2, 1, 0, 11, 'gwei', 'LI199', 1, 3),
(12, 'Casio AE-1200WH', '30', 'Has some light scratches but not obvious. I\'m including the links that I\'ve taken off.', '2019-12-03 07:34:45', 2, 1, 0, 12, 'gwei', 'LI199', 1, 4),
(13, 'Fossil Watch Grant Chronograph Black', '300', 'Fossil Original FS5132 GRANT CHRONOGRAPH BLACK LEATHER WATCH', '2019-12-03 07:38:32', 2, 1, 0, 13, 'gwei', 'LI199', 1, 4),
(14, 'Audiobox U-Cube USB Mini 2.0 Speaker', '20', 'Audiobox', '2019-12-03 07:39:51', 2, 1, 0, 14, 'gwei', 'LI199', 3, 14),
(15, 'Speaker multimedia sonic gear TATOO PRO 321', '50', 'Speaker multimedia 2.1 model  Sonic gear TATOO PRO 321 untuk dilepaskan, condition sound 9/10 and body 9/10, sesuai untuk di sambung pada komputer, mp3, handphone, tv, game, radio, dll\nSebarang pertanyaan bleh Pm... @ www.wasap.my/60195176040\nLocation: ipoh\nSemua speaker telah diuji...????\nBleh nego.. sikit', '2019-12-03 07:41:29', 2, 0, 0, 15, 'gwei', 'LI199', 3, 14),
(16, 'Acer aspire i5 6th Gen gaming laptop tiptop', '1200', 'Acer aspire e1 14\nLike new condition\nIntel i5 6200u 2.3ghz turbo to 2.8ghz\n4gb ram\n1tb hdd\nNvidia GeForce gt 920m\n14 inch lcd\nClean formatted with windows\n\nWith charger and bag', '2019-12-03 07:43:01', 2, 1, 0, 16, 'likyang', 'LI199', 3, 15),
(17, 'LENOVO X240 - 2nd hand laptop', '700', 'Intel® Core™ i5 2520M\nIntel HD Graphics \n12 Inch HD LED\n4GB RAM/128GB SSD\nWifi/Webcam\nWindows 7\n1 Month Hardware Warranty', '2019-12-03 07:44:00', 2, 1, 0, 17, 'likyang', 'LI199', 3, 15),
(18, 'Macbook Pro 13 Retina 3.0ghz , 8gb , 512gb SSD', '3000', 'HIGH SPEC MacBook Pro 13 retina!\n3.0ghz ( highest spec ! )\n8gb Ram\n512gb SSD original Apple ! \nNew battery with low circle count 60+ and running\n\nA very good high spec macbook ! Good for photo editing , video editing , 3D drawing and much more!\n Free software like Photoshop , illustrator , sketch up and ORIGINAL MICROSOFT 360 ( upgradable ! )\nAnd any other software upon request if I have it. ', '2019-12-03 07:45:48', 2, 1, 0, 18, 'likyang', 'LI199', 3, 15),
(19, 'Nintendo Switch', '1000', 'This Nintendo Switch is bought from japan, therefore this is a genuine product from nintendo. My offer has the switch itself, joy cons, charging dock, hdmi cable, type c charger, additional accessories: case and screen protector', '2019-12-03 07:47:43', 2, 1, 0, 19, 'likyang', 'LI199', 3, 16),
(20, 'Huawei mate 20 pro fullset', '1499', 'Huawei mate 20 pro 100%ok all functions\nSenheng warranty 1 +1 warranty till 2021 \n40MP triple camera as live pictures\nFace ID fingerprint all working perfectly\nScreen protector full glue installed 59rm\nWith catching protection\nPls wasap 01six340two366', '2019-12-03 07:50:21', 2, 1, 0, 20, 'wensen', 'LI199', 4, 17),
(21, 'Oppo Reno 2 Sunset Pink', '1880', 'Oppo Reno 2 Sunset Pink \nCondition like new \nFullset will be given \nArrange to view set\nTrade avail\nMore inform do contact\nBobby 016 347 4x4', '2019-12-03 07:51:09', 2, 0, 0, 21, 'wensen', 'LI199', 4, 17),
(22, 'Iphone 6s plus MYset', '400', 'Original set MY. Condition 10/10. Color gold. Storage 128gb. Full set complete. Warranty store 3 bulan.\nSerious berminat boleh chat kita segera.', '2019-12-03 07:52:07', 2, 1, 0, 22, 'wensen', 'LI199', 4, 17),
(23, 'Samsung S10', '2000', 'Samsung S10 Plus 8GB RAM / 128GB ROM Prism Black - New & Sealed Samsung Malaysia Set (1 unit only)', '2019-12-03 07:53:21', 2, 1, 0, 23, 'gwei', 'LI199', 4, 17),
(24, 'Iphone 7 plus 256gb', '1100', 'iPhone 7 Plus\nRed/MattBlack/JetBlack/RoseGold/Gold/Sliver\n32GB RM1138\n128GB Rm1268\n256GB Rm1338', '2019-12-03 07:54:33', 2, 1, 0, 24, 'gwei', 'LI199', 4, 18),
(25, 'Iphone X 256GB MY', '1800', '*MY SET DISPLAY UNIT\n*TIP TOP CONDITION \n*ORIGINAL LCD AND BODY \n*NO CONVERT \n*NO TELCO \n*GOOD CONDITION BATTERY HEALTH\n*FOC CHARGER, CABLE, PUBG GLASS, CASE AND BOX\n\nNOTICE: \n*NO SCAM*', '2019-12-03 07:55:17', 2, 1, 0, 25, 'gwei', 'LI199', 4, 18),
(26, 'Airpods 2 LIKE ORIGINAL', '120', 'AirPods 2 Generation with Wireless Charging Case 1:1  Copy\n(Cheapest price guarantee) \nMY PRICE :RM125 ONLY\n OTHERS price: RM2XX to RM3XX\nORIGINAL PRICE : RM7XX\nMaterial : same as original 10/10\nSize and dimension : same as original 10/10\nBattery : 3-5 hours : same as original 10/10\nPackaging : box and paper work like original 10/10\nCompatible with Android and iOS\nFeature :\nWireless charging like original\nPop up animation (for iOS) same like original (3 real battery)\nAuto pause(ear sensor) like ', '2019-12-03 08:04:57', 2, 1, 0, 26, 'gwei', 'LI199', 4, 19),
(27, 'Lightning Cable - Fast Charging 2.4A', '35', '• Brand - Mcdodo\n• Max Current - 2.4A (Fast charging!!)\n• Length - 1 meter\n• 2017 new auto disconnect high quality lightning cable from Mcdodo\n• Protecting your mobile from overcharging\n• Increase battery performance for long-lasting use\n• LED light indicate charging status', '2019-12-03 08:05:55', 2, 1, 0, 27, 'gwei', 'LI199', 4, 19),
(28, 'Pineng 20000Mah Powerbank', '60', '20000mah Pineng Powerbank\nCondition 9/10\n\nOriginal Price - RM 99\nInclude with 1 usb wire \nWithout box', '2019-12-03 08:06:46', 2, 1, 0, 28, 'gwei', 'LI199', 4, 19),
(29, 'Fixed Gear  Single Speed Bicycle', '250', 'You get what you see.\nGot fixed and single speed gear.\nNego.\nCOD Ipoh area :)', '2019-12-03 08:07:52', 2, 1, 0, 29, 'gwei', 'LI199', 6, 13),
(30, 'Road Bike', '700', 'Spec \nFrame : Alloy \nShifter : MICRONEW Road Shifter  2x9 speed\nCrankset : 52-34T Sealed Bearing\nCassette : 13-34T\nSeat Post : 27.2mm\nFd : MicroShift\nRd : MicroShift\nBrake : Mechanical Disc Brake 160mm rotor \nWheel Hub : steel sealed bearing\nTyre : Kenda 700*25C\nHub : Disc Hub with Seal Bearing\nSaddle : Gomax Sport\nSeatpost: Gomax Alloy\nStem : Gomax Alloy 31.8mm\nHandlebar : Gomax Alloy dropbar 400mm\nRim : 28H Spokes Double Wall Rim\nBike Tube Concealed Routing cable \nWeight : 12kg', '2019-12-03 08:09:02', 2, 1, 0, 30, 'wensen', 'LI199', 6, 13),
(31, 'Original ADIDAS Skateboard', '300', '* Original ADIDAS (lucas)\n* Upgrade the tyres to better brand\n   (The Speakeasy)- worth RM150\n* Rarely used\n* One female owner\n* Meet-up only - Shah Alam\n* Size : 31 x 8 x 3.5 inch', '2019-12-03 08:11:40', 2, 1, 0, 31, 'wensen', 'LI199', 6, 12),
(32, 'Charles & Keith Sling Bag', '120', '', '2019-12-03 08:14:08', 2, 1, 0, 38, 'menghui', 'LI199', 2, 11),
(33, 'Guess HandBag', '130', 'Authentic Guess handbag \nWith dustbag', '2019-12-03 08:15:04', 2, 1, 0, 33, 'menghui', 'LI199', 2, 11),
(34, 'Adidas NEO women\'s flower pattern dress', '50', 'Size in tag XXL small cutting.\nBest fit size M and L\nShoulder: 16.5\"\nPit: 19\"\nLenght: 35\"', '2019-12-03 08:27:01', 2, 1, 0, 34, 'menghui', 'LI199', 2, 9),
(35, 'Korean style trendy dress', '8', 'S/M size. Navy blue. \nPremium quality. \nCondition 9/10.', '2019-12-03 08:27:54', 2, 1, 0, 35, 'menghui', 'LI199', 2, 9),
(36, 'Clark Narrative', '70', 'These beautiful green suede pair had only been worn less than 5 times so it’s totally in a good condition. Original price is RM300++ ', '2019-12-03 08:29:05', 2, 1, 0, 36, 'menghui', 'LI199', 2, 10),
(37, 'Court shoes', '100', 'The item that has been used and worn twice previously. The item may be missing the original packaging materials (such as original box or tag). Still in perfect condition, beautiful, shiny patent high heels in 10.5 cm. ', '2019-12-03 08:30:11', 2, 1, 0, 37, 'menghui', 'LI199', 2, 10),
(38, 'Book', '20', 'qweerr', '2019-12-03 09:30:38', 2, 0, 0, 39, 'wj', 'LI199', 7, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `productimage`
--

CREATE TABLE `productimage` (
  `IMG_ID` int(11) NOT NULL,
  `IMG_ADDRESS` varchar(50) NOT NULL,
  `P_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `productimage`
--

INSERT INTO `productimage` (`IMG_ID`, `IMG_ADDRESS`, `P_ID`) VALUES
(1, '1575327880027wensenmenBag1.jpg', 1),
(2, '1575327880028wensenmenBag2.jpg', 1),
(3, '1575327880029wensenmenBag3.jpg', 1),
(4, '1575327995188wensenmenBag1.jpg', 2),
(5, '1575327995189wensenmenBag2.jpg', 2),
(6, '1575327995190wensenmenBag3.jpg', 2),
(7, '1575328513116wensenmenWallet1.jpg', 3),
(8, '1575328513117wensenmenWallet2.jpg', 3),
(9, '1575328747183gweimenBag1.jpg', 4),
(10, '1575328747184gweimenBag2.jpg', 4),
(11, '1575328747185gweimenBag3.jpg', 4),
(12, '1575328849715gweimenWallet1.jpg', 5),
(13, '1575328849716gweimenWallet2.jpg', 5),
(14, '1575328849717gweimenWallet3.jpg', 5),
(15, '1575328986267gweimenClothes1.jpg', 6),
(16, '1575328986268gweimenClothes2.jpg', 6),
(17, '1575328986268gweimenClothes3.jpg', 6),
(18, '1575329061539gweimenClothes1.jpg', 7),
(19, '1575329061540gweimenClothes2.jpg', 7),
(20, '1575329061541gweimenClothes3.jpg', 7),
(21, '1575329180673wensenmenClothes1.jpg', 8),
(22, '1575329180674wensenmenClothes2.jpg', 8),
(23, '1575329180674wensenmenClothes3.jpg', 8),
(24, '1575329348584likyangmenShoes1.jpg', 9),
(25, '1575329348585likyangmenShoes2.jpg', 9),
(26, '1575329348586likyangmenShoes3.jpg', 9),
(27, '1575329462671likyangmenShoe1.jpg', 10),
(28, '1575329462672likyangmenShoe2.jpg', 10),
(29, '1575329462673likyangmenShoe3.jpg', 10),
(30, '1575329565332gweimenShoes1.jpg', 11),
(31, '1575329565333gweimenShoes2.jpg', 11),
(32, '1575329565334gweimenShoes3.jpg', 11),
(33, '1575329685951gweiwatch1.jpg', 12),
(34, '1575329685952gweiwatch2.jpg', 12),
(35, '1575329685953gweiwatch3.jpg', 12),
(36, '1575329912722gweiwatch1.jpg', 13),
(37, '1575329912723gweiwatch2.jpg', 13),
(38, '1575329912724gweiwatch3.jpg', 13),
(39, '1575329992070gweiminiSpeaker1.jpg', 14),
(40, '1575329992071gweiminiSpeaker2.jpg', 14),
(41, '1575329992072gweiminiSpeaker3.jpg', 14),
(42, '1575330089740gweispeaker1.jpg', 15),
(43, '1575330089741gweispeaker2.jpg', 15),
(44, '1575330089742gweispeaker3.jpg', 15),
(45, '1575330181346likyangcomputer1.jpg', 16),
(46, '1575330181373likyangcomputer2.jpg', 16),
(47, '1575330181374likyangcomputer3.jpg', 16),
(48, '1575330240449likyangcomputer1.jpg', 17),
(49, '1575330240449likyangcomputer2.jpg', 17),
(50, '1575330240450likyangcomputer3.jpg', 17),
(51, '1575330348611likyangcomputer1.jpg', 18),
(52, '1575330348611likyangcomputer2.jpg', 18),
(53, '1575330348612likyangcomputer3.jpg', 18),
(54, '1575330463599likyangns1.jpg', 19),
(55, '1575330463600likyangns2.jpg', 19),
(56, '1575330463600likyangns3.jpg', 19),
(57, '1575330621189wensenhuaweiMate1.jpg', 20),
(58, '1575330621190wensenhuaweiMate2.jpg', 20),
(59, '1575330621191wensenhuaweiMate3.jpg', 20),
(60, '1575330669261wensenoppo1.jpg', 21),
(61, '1575330669262wensenoppo2.jpg', 21),
(62, '1575330669263wensenoppo3.jpg', 21),
(63, '1575330727332wenseniphone6i.jpg', 22),
(64, '1575330727333wenseniphone6ii.jpg', 22),
(65, '1575330727334wenseniphone6iii.jpg', 22),
(66, '1575330801281gweisamsung1.jpg', 23),
(67, '1575330801282gweisamsung2.jpg', 23),
(68, '1575330801283gweisamsung3.jpg', 23),
(69, '1575330873224gweiiphone7i.jpg', 24),
(70, '1575330873225gweiiphone7ii.jpg', 24),
(71, '1575330873226gweiiphone7iii.jpg', 24),
(72, '1575330917601gweiiphonexi.jpg', 25),
(73, '1575330917604gweiiphonexii.jpg', 25),
(74, '1575330917606gweiiphonexiii.jpg', 25),
(75, '1575331497521gweiaccessories1.jpg', 26),
(76, '1575331497524gweiaccessories2.jpg', 26),
(77, '1575331497527gweiaccessories3.jpg', 26),
(78, '1575331555733gweiaccessories1.jpg', 27),
(79, '1575331555736gweiaccessories2.jpg', 27),
(80, '1575331555738gweiaccessories3.jpg', 27),
(81, '1575331606361gweiaccessories1.jpg', 28),
(82, '1575331606365gweiaccessories2.jpg', 28),
(83, '1575331606369gweiaccessories3.jpg', 28),
(84, '1575331672489gweibike1.jpg', 29),
(85, '1575331672491gweibike2.jpg', 29),
(86, '1575331672493gweibike3.jpg', 29),
(87, '1575331742676wensenbike1.jpg', 30),
(88, '1575331742678wensenbike2.jpg', 30),
(89, '1575331742679wensenbike3.jpg', 30),
(90, '1575331901091wensenskate1.jpg', 31),
(91, '1575331901095wensenskate2.jpg', 31),
(92, '1575331901098wensenskate3.jpg', 31),
(93, '1575332048218menghuiwomenBag1.jpg', 32),
(94, '1575332048220menghuiwomenBag2.jpg', 32),
(95, '1575332048223menghuiwomenBag3.jpg', 32),
(96, '1575332104408menghuiwomenBag1.jpg', 33),
(97, '1575332104411menghuiwomenBag2.jpg', 33),
(98, '1575332104414menghuiwomenBag3.jpg', 33),
(99, '1575332821876menghuiwomenClothes1.jpg', 34),
(100, '1575332821878menghuiwomenClothes2.jpg', 34),
(101, '1575332821880menghuiwomenClothes3.jpg', 34),
(102, '1575332874739menghuiwomenClothes1.jpg', 35),
(103, '1575332874742menghuiwomenClothes2.jpg', 35),
(104, '1575332874745menghuiwomenClothes3.jpg', 35),
(105, '1575332945304menghuiwomenShoes1.jpg', 36),
(106, '1575332945307menghuiwomenShoes2.jpg', 36),
(107, '1575332945310menghuiwomenShoes3.jpg', 36),
(108, '1575333011487menghuiwomenShoes1.jpg', 37),
(109, '1575333011490menghuiwomenShoes2.jpg', 37),
(110, '1575333011493menghuiwomenShoes3.jpg', 37),
(111, '1575336638902wjbook1.jpg', 38),
(112, '1575336638905wjbook2.jpg', 38),
(113, '1575336638908wjbook3.jpg', 38);

-- --------------------------------------------------------

--
-- 表的结构 `region`
--

CREATE TABLE `region` (
  `R_ID` int(50) NOT NULL,
  `R_NAME` varchar(50) NOT NULL,
  `C_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `region`
--

INSERT INTO `region` (`R_ID`, `R_NAME`, `C_ID`) VALUES
(1, 'Johor', 1),
(2, 'Kedah', 1),
(3, 'Kelantan', 1),
(4, 'Kuala Lumpur', 1),
(5, 'Labuan', 1),
(6, 'Melaka', 1),
(7, 'Negeri Sembilan', 1),
(8, 'Pahang', 1),
(9, 'Penang', 1),
(10, 'Perak', 1),
(11, 'Perlis', 1),
(12, 'Sabah', 1),
(13, 'Sarawak', 1),
(14, 'Selangor', 1),
(15, 'Terengganu', 1);

-- --------------------------------------------------------

--
-- 表的结构 `subcategories`
--

CREATE TABLE `subcategories` (
  `Sub_ID` int(11) NOT NULL,
  `Sub_Name` varchar(50) NOT NULL,
  `C_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `subcategories`
--

INSERT INTO `subcategories` (`Sub_ID`, `Sub_Name`, `C_ID`) VALUES
(17, 'Android Phone', 4),
(14, 'Audio', 3),
(1, 'Bag & Wallet', 1),
(13, 'Bicycle', 6),
(2, 'Clothes', 1),
(3, 'FootWear', 1),
(18, 'Iphone', 4),
(15, 'Laptop', 3),
(19, 'Phone Accessories', 4),
(10, 'Shoes', 2),
(12, 'Skooter & Skates', 6),
(16, 'TV & Entertainment System', 3),
(4, 'Watch', 1),
(11, 'Women Bag & Wallet', 2),
(9, 'WomenClothes', 2);

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `UserID` varchar(50) NOT NULL,
  `UserPass` varchar(100) NOT NULL,
  `U_Email` varchar(100) NOT NULL,
  `BIO` varchar(500) DEFAULT '',
  `PhoneNum` int(50) DEFAULT NULL,
  `U_Gender` varchar(30) DEFAULT NULL,
  `U_Country` int(11) DEFAULT NULL,
  `U_Region` int(11) DEFAULT NULL,
  `U_avatar` varchar(50) DEFAULT '',
  `U_FirstName` varchar(50) DEFAULT '',
  `U_LastName` varchar(50) DEFAULT '',
  `U_ACTIVED` int(11) DEFAULT '1',
  `created_Time` datetime DEFAULT CURRENT_TIMESTAMP,
  `Status` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`UserID`, `UserPass`, `U_Email`, `BIO`, `PhoneNum`, `U_Gender`, `U_Country`, `U_Region`, `U_avatar`, `U_FirstName`, `U_LastName`, `U_ACTIVED`, `created_Time`, `Status`) VALUES
('cleong98', '$2b$10$CDKHRIqgIjM/RpRroql27.tLidANJDENNEv.z2Fq2kVlDbEYu1xbS', 'wongliqi1999@gmail.com', '', 123, 'Male', 1, 15, '1575335455335cleong98user6.jpg', '', '', 1, '2019-12-03 09:05:49', 1),
('gwei', '$2b$10$aa3qXSs5yqR2.L6lkdWk5.x/PlS6sQ7k.d1Q9y1bQxBVlq/DAGv2q', 'gwei@gmail.com', '', 1114445678, 'Male', 1, 1, '1575328615806gweiuser7.png', '', '', 1, '2019-12-03 07:15:55', 1),
('likyang', '$2b$10$IkgwbuXBpgDqoFmY9Po4lOvaFZE4ZHNTen/n.BmrWfp.T8zbn6Gfe', 'likyang@gmail.com', '', 113422344, 'Male', 1, 4, '1575329290627likyanguser4.png', '', '', 1, '2019-12-03 07:27:32', 1),
('menghui', '$2b$10$OnHeLwdbGlfh86o4n5a6s.VIRXCfBXQ2mYSig7uF8eF6WtfaQbMPO', 'menghui@gmail.com', '', 117138530, 'Female', 1, 1, '1575332750507menghuiuser3.jpg', '', '', 1, '2019-12-03 08:12:27', 1),
('wensen', '$2b$10$spRN2KvgK2rJTzZbVMO/Vu30X/INzfIKTuI/S63niN7uYKss9yUoW', 'wensen@gmail.com', '', 111234566, 'Male', 1, 10, '1575326946698wensenuser5.jpg', '', '', 1, '2019-12-03 06:48:32', 1),
('wj', '$2b$10$GHYjv3cykCYmUSMhbq7BQeNoEmuUoLVbHU9c1euY9R2wAr3jGcYEu', 'wongliqi1999@gmail.com', '', 1134567890, 'Male', 1, 8, '1575336586329wjuser2.png', '', '', 1, '2019-12-03 09:29:21', 1);

--
-- 转储表的索引
--

--
-- 表的索引 `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`A_ID`);

--
-- 表的索引 `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`C_Name`),
  ADD UNIQUE KEY `C_Name` (`C_Name`),
  ADD KEY `C_ID` (`C_ID`);

--
-- 表的索引 `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`C_ID`);

--
-- 表的索引 `deals`
--
ALTER TABLE `deals`
  ADD PRIMARY KEY (`D_ID`),
  ADD KEY `D_POS` (`D_POS`),
  ADD KEY `D_MEETUP` (`D_MEETUP`);

--
-- 表的索引 `evaluate`
--
ALTER TABLE `evaluate`
  ADD PRIMARY KEY (`E_ID`),
  ADD KEY `P_ID` (`P_ID`),
  ADD KEY `E_GIVER` (`E_GIVER`),
  ADD KEY `E_RECEIVER` (`E_RECEIVER`);

--
-- 表的索引 `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`G_NAME`),
  ADD KEY `G_ID` (`G_ID`);

--
-- 表的索引 `meetup`
--
ALTER TABLE `meetup`
  ADD PRIMARY KEY (`M_ID`);

--
-- 表的索引 `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`O_ID`),
  ADD KEY `P_ID` (`P_ID`),
  ADD KEY `BUYER` (`BUYER`),
  ADD KEY `SELLER` (`SELLER`);

--
-- 表的索引 `pos`
--
ALTER TABLE `pos`
  ADD PRIMARY KEY (`P_ID`);

--
-- 表的索引 `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`P_ID`),
  ADD KEY `P_Category` (`P_Category`),
  ADD KEY `P_Sub` (`P_Sub`),
  ADD KEY `UploadBy` (`UploadBy`),
  ADD KEY `ApprovedBy` (`ApprovedBy`),
  ADD KEY `P_Deal` (`P_Deal`);

--
-- 表的索引 `productimage`
--
ALTER TABLE `productimage`
  ADD PRIMARY KEY (`IMG_ID`),
  ADD KEY `P_ID` (`P_ID`);

--
-- 表的索引 `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`R_ID`),
  ADD KEY `country_ID` (`C_ID`);

--
-- 表的索引 `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`Sub_Name`),
  ADD KEY `Sub_ID` (`Sub_ID`),
  ADD KEY `Parent_C` (`C_ID`);

--
-- 表的索引 `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`),
  ADD KEY `U_Gender` (`U_Gender`),
  ADD KEY `U_Country` (`U_Country`),
  ADD KEY `U_Region` (`U_Region`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `categories`
--
ALTER TABLE `categories`
  MODIFY `C_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用表AUTO_INCREMENT `country`
--
ALTER TABLE `country`
  MODIFY `C_ID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `deals`
--
ALTER TABLE `deals`
  MODIFY `D_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- 使用表AUTO_INCREMENT `evaluate`
--
ALTER TABLE `evaluate`
  MODIFY `E_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `gender`
--
ALTER TABLE `gender`
  MODIFY `G_ID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `meetup`
--
ALTER TABLE `meetup`
  MODIFY `M_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- 使用表AUTO_INCREMENT `orders`
--
ALTER TABLE `orders`
  MODIFY `O_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用表AUTO_INCREMENT `pos`
--
ALTER TABLE `pos`
  MODIFY `P_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- 使用表AUTO_INCREMENT `product`
--
ALTER TABLE `product`
  MODIFY `P_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- 使用表AUTO_INCREMENT `productimage`
--
ALTER TABLE `productimage`
  MODIFY `IMG_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- 使用表AUTO_INCREMENT `region`
--
ALTER TABLE `region`
  MODIFY `R_ID` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- 使用表AUTO_INCREMENT `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `Sub_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- 限制导出的表
--

--
-- 限制表 `deals`
--
ALTER TABLE `deals`
  ADD CONSTRAINT `deals_ibfk_1` FOREIGN KEY (`D_POS`) REFERENCES `pos` (`P_ID`),
  ADD CONSTRAINT `deals_ibfk_2` FOREIGN KEY (`D_MEETUP`) REFERENCES `meetup` (`M_ID`);

--
-- 限制表 `evaluate`
--
ALTER TABLE `evaluate`
  ADD CONSTRAINT `evaluate_ibfk_1` FOREIGN KEY (`P_ID`) REFERENCES `product` (`P_ID`),
  ADD CONSTRAINT `evaluate_ibfk_2` FOREIGN KEY (`E_GIVER`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `evaluate_ibfk_3` FOREIGN KEY (`E_RECEIVER`) REFERENCES `user` (`UserID`);

--
-- 限制表 `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`P_ID`) REFERENCES `product` (`P_ID`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`BUYER`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`SELLER`) REFERENCES `user` (`UserID`);

--
-- 限制表 `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`P_Category`) REFERENCES `categories` (`C_ID`),
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`P_Sub`) REFERENCES `subcategories` (`Sub_ID`),
  ADD CONSTRAINT `product_ibfk_3` FOREIGN KEY (`UploadBy`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `product_ibfk_4` FOREIGN KEY (`ApprovedBy`) REFERENCES `admin` (`A_ID`),
  ADD CONSTRAINT `product_ibfk_5` FOREIGN KEY (`P_Deal`) REFERENCES `deals` (`D_ID`);

--
-- 限制表 `productimage`
--
ALTER TABLE `productimage`
  ADD CONSTRAINT `productimage_ibfk_1` FOREIGN KEY (`P_ID`) REFERENCES `product` (`P_ID`);

--
-- 限制表 `region`
--
ALTER TABLE `region`
  ADD CONSTRAINT `country_ID` FOREIGN KEY (`C_ID`) REFERENCES `country` (`C_ID`);

--
-- 限制表 `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `Parent_C` FOREIGN KEY (`C_ID`) REFERENCES `categories` (`C_ID`);

--
-- 限制表 `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`U_Gender`) REFERENCES `gender` (`G_NAME`),
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`U_Country`) REFERENCES `country` (`C_ID`),
  ADD CONSTRAINT `user_ibfk_3` FOREIGN KEY (`U_Region`) REFERENCES `region` (`R_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
