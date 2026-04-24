-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-04-2026 a las 23:32:13
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `album_store`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `albums`
--

CREATE TABLE `albums` (
  `id` int(11) NOT NULL,
  `tittle` varchar(50) NOT NULL,
  `artist` varchar(50) NOT NULL,
  `id_genre` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `anio` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `albums`
--

INSERT INTO `albums` (`id`, `tittle`, `artist`, `id_genre`, `price`, `stock`, `anio`, `activo`) VALUES
(1, 'Clancy ', 'Twenty One Pilots', 1, 1000.00, 32, 2024, 1),
(3, 'Un Verano Sin Ti', 'Bad Bunny', 12, 8500.00, 17, 2022, 1),
(4, 'In Utero', 'Nirvana', 2, 2000.00, 43, 1993, 1),
(5, 'Meteora', 'Linkin Park', 6, 1899.00, 26, 2003, 1),
(7, '$ad Boyz 4 Life ll', 'Junior H', 14, 4500.00, 27, 2022, 1),
(8, 'Reinventing The Steel', 'Pantera', 8, 5000.00, 1, 2001, 1),
(9, 'Ten', 'Pearl Jam', 2, 5000.00, 69, 1991, 0),
(10, 'Scaled and icy', 'Twenty one pilots ', 1, 3000.00, 50, 2021, 0),
(11, 'hola', 'Bad Bunny', 12, 4000.00, 40, 2025, 0),
(12, 'Debi Tirar ', 'Bad Bunny', 11, 4000.00, 50, 2026, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `album_id` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id`, `venta_id`, `album_id`, `cantidad`, `precio`) VALUES
(1, 1, 1, 1, 1000.00),
(2, 1, 4, 1, 2000.00),
(3, 2, 5, 1, 1899.00),
(4, 3, 5, 1, 1899.00),
(5, 4, 1, 1, 1000.00),
(6, 5, 3, 1, 8500.00),
(7, 6, 5, 1, 1899.00),
(8, 6, 5, 1, 1899.00),
(9, 6, 5, 1, 1899.00),
(10, 7, 1, 1, 1000.00),
(11, 7, 4, 1, 2000.00),
(12, 8, 4, 1, 2000.00),
(13, 8, 1, 1, 1000.00),
(14, 9, 1, 1, 1000.00),
(15, 9, 3, 1, 8500.00),
(16, 10, 5, 1, 1899.00),
(17, 10, 3, 1, 8500.00),
(18, 11, 1, 1, 1000.00),
(19, 12, 1, 1, 1000.00),
(20, 13, 3, 1, 8500.00),
(21, 13, 5, 1, 1899.00),
(22, 13, 7, 1, 4500.00),
(23, 14, 8, 1, 5000.00),
(24, 14, 8, 1, 5000.00),
(25, 15, 8, 1, 5000.00),
(26, 15, 8, 1, 5000.00),
(27, 15, 8, 1, 5000.00),
(28, 15, 8, 1, 5000.00),
(29, 15, 8, 1, 5000.00),
(30, 15, 8, 1, 5000.00),
(31, 15, 8, 1, 5000.00),
(32, 15, 8, 1, 5000.00),
(33, 15, 8, 1, 5000.00),
(34, 15, 8, 1, 5000.00),
(35, 15, 8, 1, 5000.00),
(36, 16, 4, 1, 2000.00),
(37, 16, 3, 1, 8500.00),
(38, 17, 3, 1, 8500.00),
(39, 17, 5, 1, 1899.00),
(40, 17, 7, 1, 4500.00),
(41, 17, 1, 1, 1000.00),
(42, 17, 3, 1, 8500.00),
(43, 17, 8, 1, 5000.00),
(44, 18, 1, 1, 1000.00),
(45, 19, 1, 1, 1000.00),
(46, 19, 8, 1, 5000.00),
(47, 20, 1, 1, 1000.00),
(48, 20, 4, 1, 2000.00),
(49, 21, 1, 1, 1000.00),
(50, 21, 4, 1, 2000.00),
(51, 22, 8, 1, 5000.00),
(52, 22, 3, 1, 8500.00),
(53, 22, 1, 1, 1000.00),
(54, 23, 8, 1, 5000.00),
(55, 23, 7, 1, 4500.00),
(56, 24, 9, 1, 5000.00),
(57, 25, 1, 1, 1000.00),
(58, 26, 3, 1, 8500.00),
(59, 26, 1, 1, 1000.00),
(60, 27, 1, 1, 1000.00),
(61, 27, 8, 1, 5000.00),
(62, 28, 5, 1, 1899.00),
(63, 28, 8, 1, 5000.00),
(64, 29, 3, 1, 8500.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genre`
--

CREATE TABLE `genre` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `genre`
--

INSERT INTO `genre` (`id`, `name`) VALUES
(1, 'Alternative Rock'),
(2, 'Indie Rock'),
(5, 'K-Pop'),
(6, 'Nu Metal'),
(7, 'Hard Rock'),
(8, 'Heavy Metal'),
(9, 'Trash Metal'),
(10, 'Rap'),
(11, 'Trapp'),
(12, 'Regueton'),
(13, 'Pop'),
(14, 'Regional Mexicano');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `password`) VALUES
(1, 'Danna', '123456'),
(5, 'Stephanie', '7373353101'),
(14, 'Alexa', '12345');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `fecha`, `total`) VALUES
(1, '2026-04-14 21:36:31', 3000.00),
(2, '2026-04-14 21:36:31', 1899.00),
(3, '2026-04-14 21:36:31', 1899.00),
(4, '2026-04-14 21:36:31', 1000.00),
(5, '2026-04-14 21:36:31', 8500.00),
(6, '2026-04-14 21:36:31', 5697.00),
(7, '2026-04-14 21:36:31', 3000.00),
(8, '2026-04-14 21:36:31', 3000.00),
(9, '2026-04-14 21:36:31', 9500.00),
(10, '2026-04-14 21:36:31', 10399.00),
(11, '2026-04-14 21:36:31', 1000.00),
(12, '2026-04-14 21:36:31', 1000.00),
(13, '2026-04-14 21:36:31', 14899.00),
(14, '2026-04-14 21:43:11', 10000.00),
(15, '2026-04-14 21:43:41', 55000.00),
(16, '2026-04-14 21:47:10', 10500.00),
(17, '2026-04-15 08:43:38', 29399.00),
(18, '2026-04-20 16:46:26', 1000.00),
(19, '2026-04-20 16:53:28', 6000.00),
(20, '2026-04-20 17:05:45', 3000.00),
(21, '2026-04-20 17:08:08', 3000.00),
(22, '2026-04-20 17:20:05', 14500.00),
(23, '2026-04-20 18:22:35', 9500.00),
(24, '2026-04-20 18:22:58', 5000.00),
(25, '2026-04-20 19:06:13', 1000.00),
(26, '2026-04-20 19:11:08', 9500.00),
(27, '2026-04-22 18:45:35', 6000.00),
(28, '2026-04-24 14:49:08', 6899.00),
(29, '2026-04-24 15:10:17', 8500.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_genre` (`id_genre`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `venta_id` (`venta_id`),
  ADD KEY `album_id` (`album_id`);

--
-- Indices de la tabla `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `albums`
--
ALTER TABLE `albums`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `genre`
--
ALTER TABLE `genre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `albums`
--
ALTER TABLE `albums`
  ADD CONSTRAINT `albums_ibfk_1` FOREIGN KEY (`id_genre`) REFERENCES `genre` (`id`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
