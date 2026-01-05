-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Jan 2026 pada 04.19
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tubes`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `games`
--

CREATE TABLE `games` (
  `id` int(11) NOT NULL,
  `game_key` varchar(50) NOT NULL,
  `game_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `games`
--

INSERT INTO `games` (`id`, `game_key`, `game_name`, `created_at`) VALUES
(1, 'tetris', 'Tetris', '2026-01-04 12:49:16'),
(2, 'snake', 'Snake Game', '2026-01-04 12:49:16');

-- --------------------------------------------------------

--
-- Struktur dari tabel `scores`
--

CREATE TABLE `scores` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `scores`
--

INSERT INTO `scores` (`id`, `user_id`, `game_id`, `score`, `created_at`) VALUES
(1, 2, 1, 106, '2026-01-04 13:26:11'),
(2, 1, 1, 218, '2026-01-04 13:38:10'),
(3, 1, 1, 216, '2026-01-04 13:38:47'),
(4, 1, 2, 10, '2026-01-04 14:04:21'),
(5, 1, 2, 70, '2026-01-04 14:05:16'),
(6, 1, 1, 280, '2026-01-04 14:55:18'),
(7, 2, 2, 10, '2026-01-04 15:02:20'),
(8, 2, 1, 238, '2026-01-04 15:06:35'),
(9, 2, 1, 222, '2026-01-04 15:10:51'),
(10, 2, 1, 210, '2026-01-04 15:10:56'),
(11, 2, 1, 194, '2026-01-04 18:24:01'),
(12, 2, 2, 30, '2026-01-04 19:27:14'),
(13, 2, 2, 10, '2026-01-04 19:33:55'),
(14, 2, 2, 0, '2026-01-04 19:43:06'),
(15, 2, 2, 20, '2026-01-04 19:43:15'),
(16, 2, 2, 10, '2026-01-04 19:43:21'),
(17, 2, 2, 10, '2026-01-04 19:45:13'),
(18, 2, 1, 262, '2026-01-04 20:54:07'),
(19, 2, 1, 200, '2026-01-04 20:54:19'),
(20, 2, 1, 336, '2026-01-04 20:57:34'),
(21, 2, 1, 218, '2026-01-04 20:58:50'),
(22, 2, 1, 238, '2026-01-04 20:58:54'),
(23, 2, 1, 192, '2026-01-04 20:58:58'),
(24, 1, 1, 182, '2026-01-04 20:59:18'),
(25, 1, 1, 204, '2026-01-04 20:59:23'),
(26, 1, 2, 20, '2026-01-04 21:03:34'),
(27, 1, 2, 40, '2026-01-04 21:03:44'),
(28, 1, 2, 10, '2026-01-04 21:06:44'),
(29, 1, 2, 0, '2026-01-04 21:06:47'),
(30, 1, 2, 0, '2026-01-04 21:06:48'),
(31, 1, 2, 0, '2026-01-04 21:06:49'),
(32, 1, 2, 0, '2026-01-04 21:06:49'),
(33, 1, 2, 0, '2026-01-04 21:06:51'),
(34, 1, 2, 0, '2026-01-04 21:06:52'),
(35, 1, 2, 40, '2026-01-04 21:08:01'),
(36, 1, 2, 20, '2026-01-04 21:08:10'),
(37, 1, 2, 10, '2026-01-04 21:08:23'),
(38, 1, 1, 664, '2026-01-04 21:09:33'),
(39, 1, 2, 90, '2026-01-04 21:10:07'),
(40, 1, 1, 566, '2026-01-04 21:27:24'),
(41, 1, 1, 242, '2026-01-04 21:41:23'),
(42, 1, 1, 198, '2026-01-04 21:41:31'),
(43, 1, 1, 218, '2026-01-04 21:41:39'),
(44, 1, 1, 230, '2026-01-04 21:41:44'),
(45, 1, 2, 60, '2026-01-04 21:42:06');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT 'uploads/users/default.png',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `photo`, `created_at`) VALUES
(1, 'bijikenari', 'ian.teuku05@gmail.com', '$2y$10$GtKlMc0QydndD9B/KKk2FuRED83xucnLG8mSEaFukhKqATYUKx0qG', '../uploads/users/695a80c97afac.png', '2025-12-30 13:57:48'),
(2, 'tes1234', 'ian.teuku06@gmail.com', '$2y$10$Vsl5mKUqTmu1pyuv3Gj5UOngBJRkb/IZIya80VJd4wIcpHy.Dg5yC', '../uploads/users/695aa1feeed6e.jpeg', '2026-01-02 11:10:01');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `game_key` (`game_key`);

--
-- Indeks untuk tabel `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `game_id` (`game_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `games`
--
ALTER TABLE `games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `scores`
--
ALTER TABLE `scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `scores`
--
ALTER TABLE `scores`
  ADD CONSTRAINT `scores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `scores_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
