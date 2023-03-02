-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 28 Jan 2023 pada 13.27
-- Versi server: 10.4.11-MariaDB
-- Versi PHP: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hairstyle`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `chat_history`
--

CREATE TABLE `chat_history` (
  `id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `timestamp` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `chat_history`
--

INSERT INTO `chat_history` (`id`, `message`, `answer`, `timestamp`) VALUES
(3, 'penggunaan', 'Anda bisa pilih fitur kamera, kemudian scan wajah anda untuk mengetahui model rambut yang cocok untuk anda', '1672550476.756115'),
(4, 'hai', 'Hello!', '1672563120.172181'),
(5, 'apa itu hairstyle', 'Hairstyle adalah model potongan rambut atau gaya rambut yang unik.', '1672563167.383682'),
(6, 'apa itu hairstyle', 'Hairstyle adalah model potongan rambut atau gaya rambut yang unik.', '1672581225.086228'),
(7, 'apa itu hairstyle', 'Hairstyle adalah model potongan rambut atau gaya rambut yang unik.', '1672581260.90845'),
(8, 'p', 'Bye', '1672582097.520922'),
(9, 'halo', 'Waalaikumsalam', '1672582108.827302'),
(10, 'hai', 'Waalaikumsalam', '1672582112.09629'),
(11, 'haloo', 'See you!', '1672582116.882647'),
(12, 'kamu siapa', 'Saya Cibot, sebuah virtual asisten', '1672582124.849767'),
(13, 'hairstyle apa', 'Hairstyle adalah model potongan rambut atau gaya rambut yang unik.', '1672582131.668855'),
(14, 'cara penggunaan', 'Anda bisa pilih fitur kamera, kemudian scan wajah anda untuk mengetahui model rambut yang cocok untuk anda', '1672582141.635567'),
(15, 'halo', 'Ada yang bisa dibantu?', '1672585215.887321'),
(16, 'siapa kamu', 'Anda bisa panggil saya Cibot', '1672585222.881254'),
(17, 'terimakasih', 'Yap!', '1672585233.101474'),
(18, 'haloo', 'Bye', '1672591003.509926'),
(19, 'halo', 'Hai!', '1672591006.542522'),
(20, 'siapa kamu', 'Anda bisa panggil saya Cibot', '1672591012.659215'),
(21, 'hai', 'Ada yang bisa dibantu?', '1673277916.885018'),
(22, 'hai', 'Waalaikumsalam', '1673623970.889267'),
(23, 'halo', 'Waalaikumsalam', '1673623974.461525'),
(24, 'hi', 'Ada yang bisa dibantu?', '1673623980.506179'),
(25, 'apa itu Hairstyle ', 'Hairstyle adalah model potongan rambut atau gaya rambut yang unik.', '1673623987.568056'),
(26, 'model rambut ', '\nFringe Up', '1673623992.570881'),
(27, 'untuk rambut tebal ', '\nFringe Up', '1673624192.013813'),
(28, 'hai', 'Ada yang bisa dibantu?', '1673624197.349528'),
(29, 'cara menggunakan ', 'Anda bisa pilih fitur kamera, kemudian scan wajah anda untuk mengetahui model rambut yang cocok untuk anda', '1673624206.896394'),
(30, 'fungsi', 'Fungsi aplikasi Hairstye Recommendation adalah untuk membantu customer dalam menentukkan model potongan rambut yang cocok', '1673624209.193554'),
(31, 'cara menentukan model rambut ', '\nUndercut', '1673624229.661778'),
(32, 'hi', 'Hai!', '1673691791.971275'),
(33, 'apa itu buzzcut', 'Model rambut buzzcut adalah Buzz cut adalah model rambut pendek yang dipotong menggunakan clipper. Panjangnya biasanya tidak lebih dari 2cm', '1673691805.30517'),
(34, 'hi', 'Ada yang bisa dibantu?', '1673692021.932356'),
(35, 'hi', 'Hai!', '1673695001.998991'),
(36, 'aplikasi apa ini', 'Aplikasi Hair style recommendation adalah aplikasi yang digunakan untuk mempermudah dalam memilih model potongan rambut yang cocok untuk customer', '1673695011.306831'),
(37, 'bagaimana cara menggunakannya', 'Anda bisa pilih fitur kamera, kemudian scan wajah anda untuk mengetahui model rambut yang cocok untuk anda', '1673695027.138441'),
(38, 'oke', 'Ada yang bisa dibantu?', '1673695040.979093'),
(39, 'thanks', 'Yap!', '1673695047.805745'),
(40, 'bye', 'See you!', '1673695050.640962'),
(41, 'Hai', 'Ada yang bisa dibantu?', '1673800728.72879'),
(42, 'penggunaan', 'Anda bisa pilih fitur kamera, kemudian scan wajah anda untuk mengetahui model rambut yang cocok untuk anda', '1673854687.692827'),
(43, 'buzzcut ', 'Model rambut buzzcut adalah model rambut pendek yang dipotong menggunakan clipper. Panjangnya biasanya tidak lebih dari 2cm', '1673854700.340764'),
(44, 'apa itu buzzcut ', 'Model rambut buzzcut adalah model rambut pendek yang dipotong menggunakan clipper. Panjangnya biasanya tidak lebih dari 2cm', '1673854720.398491'),
(45, 'long fringes', 'Model rambut fringe up adalah model rambut berponi panjang dengan belah tengah', '1673854730.482826'),
(46, 'fringe up', 'Model rambut fringe up adalah model rambut poni dengan bagian depan atas yang lebih membumbung atau bervolume', '1673854742.512963'),
(47, 'model', 'Ada banyak model rambut seperti : Side Parted\nUndercut\nFringe Up\nLong Fringes\nPushed Back\nFauxHawk\nQuiff\nSide Fringe\nBuzzcut.', '1673854769.982303'),
(48, 'kamu siapa', 'Anda bisa panggil saya Cibot', '1673854773.446043'),
(49, 'emm', 'Hello!', '1673854778.956106'),
(50, 'mmm', 'Ada yang bisa dibantu?', '1673854784.08548'),
(51, 'i love you', 'Yap!', '1673854789.618769'),
(52, 'i love you', 'Yap!', '1673854801.750907'),
(53, 'i love you', 'Terimakasi Kembali', '1673854809.136563'),
(54, 'hai', 'Waalaikumsalam', '1673854821.759253'),
(55, 'bay', 'Hello!', '1673854825.034837'),
(56, 'bye', 'Bye', '1673854827.681512'),
(57, 'goodbye', 'Ada yang bisa dibantu?', '1673854830.746706'),
(58, 'thanks', 'Yap!', '1673854838.757542'),
(59, 'bye', 'See you!', '1673854847.74268'),
(60, 'see you', 'See you!', '1673854851.44101'),
(61, 'hi', 'Waalaikumsalam', '1673929336.622947'),
(62, 'halo', 'Hai!', '1673929343.95655'),
(63, 'halo', 'Ada yang bisa dibantu?', '1673929349.488029'),
(64, 'halo', 'Hai!', '1673929378.901668'),
(65, 'halo', 'Ada yang bisa dibantu?', '1673929384.785247'),
(66, 'halo ', 'Ada yang bisa dibantu?', '1673929388.362896'),
(67, 'halo', 'Waalaikumsalam', '1673929391.459079'),
(68, 'halo', 'Waalaikumsalam', '1673929397.528335'),
(69, 'halo', 'Hello!', '1673929400.764024'),
(70, 'assalamualaikum ', 'Ada yang bisa dibantu?', '1673929421.316288'),
(71, 'hi', 'Hai!', '1673930438.695355'),
(72, 'apa itu hairstyle', 'Hairstyle adalah model potongan rambut atau gaya rambut yang unik.', '1673930683.646227'),
(73, 'Hai', 'Ada yang bisa dibantu?', '1673933116.709797'),
(74, 'apa itu hairstyle', 'Hairstyle adalah model potongan rambut atau gaya rambut yang unik.', '1673933157.393485'),
(75, 'hi', 'Ada yang bisa dibantu?', '1674006434.622795'),
(76, 'hi', 'Ada yang bisa dibantu?', '1674145115.116487'),
(77, 'ini aplikasi apa', 'Aplikasi Hair style recommendation adalah aplikasi yang digunakan untuk mempermudah dalam memilih model potongan rambut yang cocok untuk customer', '1674145124.384069'),
(78, 'bagaimana cara menggunakan aplikasi ini?', 'Anda bisa pilih fitur kamera, kemudian scan wajah anda untuk mengetahui model rambut yang cocok untuk anda', '1674145147.585423'),
(79, 'ada model apa saja yang disarankan?', 'Ada banyak model rambut seperti : Side Parted\nUndercut\nFringe Up\nLong Fringes\nPushed Back\nFauxHawk\nQuiff\nSide Fringe\nBuzzcut.', '1674145173.641477'),
(80, 'terimakasih ', 'Senang membantumu', '1674145193.867456'),
(81, 'bye', 'Goodbye', '1674145197.613334');

-- --------------------------------------------------------

--
-- Struktur dari tabel `recomendation_history`
--

CREATE TABLE `recomendation_history` (
  `id` int(11) NOT NULL,
  `photo` varchar(255) NOT NULL,
  `recomendation` varchar(255) NOT NULL,
  `timestamp` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `recomendation_history`
--

INSERT INTO `recomendation_history` (`id`, `photo`, `recomendation`, `timestamp`) VALUES
(10, '1673622721464557.jpg', '167362272146455766.png,167362272146455754.png,167362272146455784.png', '1673622721.464557'),
(11, '1673623580505439.jpg', '167362358050543913.png,167362358050543992.png,167362358050543991.png', '1673623580.505439'),
(12, '1673623608059094.jpg', '167362360805909460.png,167362360805909449.png,167362360805909438.png', '1673623608.059094'),
(14, '1673691151776147.jpg', '167369115177614765.png,167369115177614772.png,167369115177614749.png', '1673691151.776147'),
(15, '167369118030023.jpg', '16736911803002329.png,16736911803002349.png,16736911803002337.png', '1673691180.30023'),
(16, '1673691387986434.jpg', '16736913879864344.png,16736913879864346.png,167369138798643450.png', '1673691387.986434'),
(17, '1673691423764711.jpg', '16736914237647112.png,167369142376471111.png,167369142376471177.png', '1673691423.764711'),
(18, '1673691525038251.jpg', '167369152503825136.png,167369152503825133.png,167369152503825190.png', '1673691525.038251'),
(19, '1673691728886514.jpg', '167369172888651488.png,167369172888651482.png,167369172888651428.png', '1673691728.886514'),
(20, '1673693545587888.jpg', '167369354558788825.png,167369354558788822.png,167369354558788819.png', '1673693545.587888'),
(21, '1673694775668176.jpg', '167369477566817630.png,167369477566817675.png,167369477566817677.png', '1673694775.668176'),
(22, '1673694841426548.jpg', '167369484142654831.png,167369484142654894.png,167369484142654848.png', '1673694841.426548'),
(23, '1673766373461437.jpg', '167376637346143738.png,167376637346143796.png,167376637346143785.png', '1673766373.461437'),
(24, '1673766486094617.jpg', '167376648609461796.png,167376648609461736.png,167376648609461781.png', '1673766486.094617'),
(25, '1673766850355723.jpg', '16737668503557233.png,167376685035572365.png,167376685035572391.png', '1673766850.355723'),
(26, '1673767552825674.jpg', '167376755282567468.png,167376755282567417.png,167376755282567495.png', '1673767552.825674'),
(27, '1673767728311609.jpg', '167376772831160913.png,167376772831160954.png,167376772831160963.png', '1673767728.311609'),
(28, '1673767832546038.jpg', '167376783254603827.png,167376783254603890.png,167376783254603836.png', '1673767832.546038'),
(29, '1673768035903275.jpg', '167376803590327575.png,167376803590327585.png,167376803590327592.png', '1673768035.903275'),
(30, '1673768214083289.jpg', '167376821408328952.png,167376821408328933.png,167376821408328985.png', '1673768214.083289'),
(31, '1673768629707606.jpg', '167376862970760620.png,167376862970760611.png,167376862970760624.png', '1673768629.707606'),
(32, '1673775813107851.jpg', '16737758131078519.png,167377581310785159.png,16737758131078510.png', '1673775813.107851'),
(35, '1673802515927127.jpg', '167380251592712763.png,167380251592712721.png,167380251592712783.png', '1673802515.927127'),
(36, '1673802533417521.jpg', '167380253341752164.png,167380253341752117.png,167380253341752151.png', '1673802533.417521'),
(37, '167384874223963.jpg', '16738487422396381.png,16738487422396331.png,16738487422396353.png', '1673848742.23963'),
(38, '1673848819983713.jpg', '167384881998371389.png,167384881998371396.png,167384881998371379.png', '1673848819.983713'),
(40, '1673848998947197.jpg', '167384899894719790.png,167384899894719720.png,167384899894719750.png', '1673848998.947197'),
(42, '1673930447931252.jpg', '16739304479312529.png,167393044793125242.png,167393044793125220.png', '1673930447.931252'),
(43, '16739307382225.jpg', '1673930738222532.png,1673930738222580.png,1673930738222596.png', '1673930738.2225'),
(44, '1673932003639685.jpg', '167393200363968553.png,167393200363968559.png,167393200363968512.png', '1673932003.639685'),
(45, '1673933215994542.jpg', '16739332159945427.png,167393321599454251.png,167393321599454218.png', '1673933215.994542'),
(46, '167393368997669.jpg', '16739336899766951.png,16739336899766971.png,16739336899766979.png', '1673933689.97669'),
(47, '1674006461545682.jpg', '167400646154568245.png,167400646154568266.png,16740064615456821.png', '1674006461.545682'),
(48, '1674007174631192.jpg', '167400717463119236.png,167400717463119215.png,167400717463119232.png', '1674007174.631192'),
(49, '167400737322647.jpg', '16740073732264777.png,16740073732264765.png,16740073732264739.png', '1674007373.22647'),
(50, '1674007838978056.jpg', '16740078389780566.png,167400783897805642.png,167400783897805634.png', '1674007838.978056'),
(51, '1674008040785395.jpg', '16740080407853951.png,16740080407853959.png,167400804078539533.png', '1674008040.785395'),
(52, '1674139872323457.jpg', '167413987232345785.png,167413987232345776.png,167413987232345772.png', '1674139872.323457'),
(53, '1674140469161754.jpg', '167414046916175473.png,167414046916175455.png,167414046916175447.png', '1674140469.161754'),
(54, '1674140520047951.jpg', '167414052004795156.png,16741405200479512.png,167414052004795155.png', '1674140520.047951'),
(55, '1674144915506854.jpg', '167414491550685487.png,167414491550685474.png,16741449155068546.png', '1674144915.506854'),
(56, '167414503704717.jpg', '16741450370471758.png,16741450370471750.png,16741450370471772.png', '1674145037.04717'),
(57, '1674145072446577.jpg', '167414507244657743.png,167414507244657763.png,167414507244657714.png', '1674145072.446577');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`) VALUES
(1, 'admin@hairstyle-ai.com', 'admin', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `chat_history`
--
ALTER TABLE `chat_history`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `recomendation_history`
--
ALTER TABLE `recomendation_history`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `chat_history`
--
ALTER TABLE `chat_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT untuk tabel `recomendation_history`
--
ALTER TABLE `recomendation_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
