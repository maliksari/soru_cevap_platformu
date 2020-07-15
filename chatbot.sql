


-- Tablo için tablo yapısı `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_turkish_ci NOT NULL,
  `email` text COLLATE utf8_turkish_ci NOT NULL,
  `username` text COLLATE utf8_turkish_ci NOT NULL,
  `password` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;


-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `cevapsiz_sorular`
--

CREATE TABLE `cevapsiz_sorular` (
  `id` int(11) NOT NULL,
  `cevapsiz_soru` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;


-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `soru_cevap`
--

CREATE TABLE `soru_cevap` (
  `id` int(11) NOT NULL,
  `soru` text COLLATE utf8_turkish_ci NOT NULL,
  `cevap` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;



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

