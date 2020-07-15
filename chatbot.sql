-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 24 Oca 2020, 10:29:00
-- Sunucu sürümü: 10.1.38-MariaDB
-- PHP Sürümü: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `chatbot`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_turkish_ci NOT NULL,
  `email` text COLLATE utf8_turkish_ci NOT NULL,
  `username` text COLLATE utf8_turkish_ci NOT NULL,
  `password` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `admin`
--

INSERT INTO `admin` (`id`, `name`, `email`, `username`, `password`) VALUES
(1, 'malik sari', 'malik.sari06@gmail.com', 'malik_admin', '$5$rounds=535000$YWmhgBt90qvOuxuY$9Petqcqu0q1VgqqgwLhpdK.0ZhEsWPgXBgeKNXhkoC9'),
(2, 'malik sari', 'malik.sari06@gmail.com', 'malik_sari1', '$5$rounds=535000$l6byHLMoxi4XiEgZ$t/yq7LqfttnIQptJzG2D.lkn.MZehK9BR/dQsIoRch8'),
(3, 'malik sari', 'deneme@gmail.com', 'deneme', '$5$rounds=535000$aoiTy7lynjTBK19w$WedSlsHlYQSLFhv3uJ5yec/L76IODpAEHKRKgwpThm6');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `cevapsiz_sorular`
--

CREATE TABLE `cevapsiz_sorular` (
  `id` int(11) NOT NULL,
  `cevapsiz_soru` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `cevapsiz_sorular`
--

INSERT INTO `cevapsiz_sorular` (`id`, `cevapsiz_soru`) VALUES
(55, 'deneme'),
(57, 'deneme'),
(58, 'eldssldşmvs');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `soru_cevap`
--

CREATE TABLE `soru_cevap` (
  `id` int(11) NOT NULL,
  `soru` text COLLATE utf8_turkish_ci NOT NULL,
  `cevap` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `soru_cevap`
--

INSERT INTO `soru_cevap` (`id`, `soru`, `cevap`) VALUES
(1, 'Naive Bayes algoritmasının avantajı nedir ?', 'Naive Bayes algorimasının avantajı küçük bir veri kümesiyle de eğitilebilmesi ve rakiplerine göre daha hızlı çalışmasıdır. Dezavantajı ise değişkenler arasındaki ilişkinin gösterilememesidir.'),
(2, 'Genetik programlama nedir?', 'Genetik algoritmalarının alt kolu olarak düşünülebilecek bir alan olan genetik programlamada belirlenen hedef fonksiyonunun sonuca ulaşması için yazılımın nasıl çalışması gerektiği bulunmaya çalışılır.'),
(3, 'Makine öğrenmesinde model seçimi nedir?', 'Makine öğrenmesinde doğru model seçimine ihtiyaç duyarız. Aynı veri setinde farklı sonuçlar doğurabilen bu model seçimi istatistik,veri madenciliği gibi alanlara da uygulanabilmektedir.'),
(4, 'Veri madenciliği nedir?', 'Veri madenciliği, büyük ölçekli veriler arasından faydalı bilgiye ulaşma, bilgiyi madenleme işidir. Büyük veri yığınları içerisinden gelecekle ilgili tahminde bulunabilmemizi sağlayabilecek bağıntıların bilgisayar programı kullanarak aranması olarak da tanımlanabilir.'),
(7, 'deneme güncelleme', 'güncellendi'),
(9, 'merhaba', 'merhaba'),
(10, 'deneme', 'deneme cevap'),
(11, 'deneme soru', 'deneme cevap'),
(13, 'merhaba', 'deneme merhaba'),
(18, 'yeni soru', 'yeni cevap'),
(19, 'deneme soru ekle ', 'eklendi');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_turkish_ci NOT NULL,
  `email` text COLLATE utf8_turkish_ci NOT NULL,
  `username` text COLLATE utf8_turkish_ci NOT NULL,
  `password` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `password`) VALUES
(1, 'malik sari', 'malik.sari06@gmail.com', 'malik_sari', '$5$rounds=535000$.Rbxvd4XRBJd4O1W$/VfW0U8GgFF8ij7oJgH.z.Cz0p8bNTFcV.q2apDC3m2'),
(2, 'malik sari1', 'malik.sari@gmail.com', 'malik_sari1', '$5$rounds=535000$X/vI0HK9fDyjJDyR$2S3QBly4JUTUbRmnbZ6RQmjIPSfhPiDELgRVCesq49.'),
(3, 'malik sari1', 'malik.sari@gmail.com', 'malik_sari1', '$5$rounds=535000$TkwMrneUnRYEZgGu$82d8vgsbxlCwkfTAxTfPJlmmlcBkMDiW1qu3g.4iO30'),
(4, 'malik sari1', 'malik.sari@gmail.com', 'malik_sari1', '$5$rounds=535000$oDkb4E2yZVQGtjmc$pe0MaR13XYmisqSXOnUAyDuPlaX.aoJMZeLAMSZT2y7'),
(5, 'deneme deneme', 'deneme@gmail.com', 'deneme', '$5$rounds=535000$Q5Lebik8rDYT8QH5$KZKJOxjz3N/S4tZ6YCFPG6LBCO2KyphCxKlXaXKoYd5');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `cevapsiz_sorular`
--
ALTER TABLE `cevapsiz_sorular`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `soru_cevap`
--
ALTER TABLE `soru_cevap`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `cevapsiz_sorular`
--
ALTER TABLE `cevapsiz_sorular`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- Tablo için AUTO_INCREMENT değeri `soru_cevap`
--
ALTER TABLE `soru_cevap`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
