-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 30, 2023 at 03:16 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dhaxaldatabase`
--

-- --------------------------------------------------------

--
-- Table structure for table `deceased`
--

CREATE TABLE `deceased` (
  `deceased_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `date_of_death` date NOT NULL,
  `hanti` double NOT NULL,
  `deen` double NOT NULL,
  `dardaaran` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `deceased`
--

INSERT INTO `deceased` (`deceased_id`, `name`, `gender`, `date_of_death`, `hanti`, `deen`, `dardaaran`) VALUES
(3, 'abdulle', 'Male', '2023-04-29', 1000, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `heirs`
--

CREATE TABLE `heirs` (
  `h_id` int(11) NOT NULL,
  `Magac` varchar(30) DEFAULT NULL,
  `wiilal` varchar(10) DEFAULT NULL,
  `gabdho` varchar(10) DEFAULT NULL,
  `aabo` varchar(10) DEFAULT NULL,
  `hooyo` varchar(10) DEFAULT NULL,
  `aboowe` varchar(10) DEFAULT NULL,
  `abaayo` varchar(10) DEFAULT NULL,
  `adeer` varchar(10) DEFAULT NULL,
  `marwo` varchar(10) DEFAULT NULL,
  `xaasle` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `heirs`
--

INSERT INTO `heirs` (`h_id`, `Magac`, `wiilal`, `gabdho`, `aabo`, `hooyo`, `aboowe`, `abaayo`, `adeer`, `marwo`, `xaasle`) VALUES
(1, 'Ali Ganeey', '1', '2', '0', '0', '0', '0', '0', '0', '0'),
(2, 'last Project', '1', '1', '1', '1', '1', '1', '1', '1', '1'),
(6, 'faarax', '3', '3', '3', '3', '3', '2', '33', '3', '3'),
(7, 'qalpi', '1', '1', '1', '1', '1', '1', '1', '1', '1'),
(8, 'qalpi', '1', '1', '1', '1', '1', '1', '1', '1', '1'),
(9, 'gurey', '2', '3', '1', '1', '4', '1', '1', '1', '1'),
(10, 'faadumo', '1', '2', '0', '1', '1', '1', '1', '1', '1'),
(11, 'gg', '1', '2', '1', '1', '1', '1', '1', '1', '1'),
(12, 'magacloow', '1', '1', '1', '1', '1', '1', '1', '1', '1'),
(13, 'Yahye', '2', '4', '1', '1', '1', '1', '1', '1', '1'),
(14, 'Faraax', '2', '1', '0', '0', '0', '0', '0', '0', '0'),
(15, 'faarx', '2', '1', '0', '0', '0', '0', '0', '0', '0'),
(16, 'faarx1', '2', '1', '0', '0', '0', '0', '0', '0', '0'),
(17, 'a', '2', '1', '0', '0', '0', '0', '0', '0', '0'),
(18, '1', '1', '2', '1', '1', '1', '1', '1', '1', '1'),
(19, '1', '2', '1', '0', '0', '0', '0', '0', '0', '0'),
(20, 'ent', '1', '1', '1', '1', '1', '1', '1', '1', '1'),
(21, '1', '0', '1', '0', '0', '0', '0', '0', '0', '0'),
(22, '1', '0', '1', '0', '0', '0', '0', '0', '0', '0'),
(23, 'q', '1', '0', '0', '0', '0', '0', '0', '0', '0'),
(24, 'q', '0', '0', '0', '0', '0', '0', '0', '1', '0'),
(25, '0', '0', '0', '0', '0', '0', '0', '1', '01', '0'),
(26, 'zaki', '2', '1', '0', '0', '0', '0', '0', '0', '0'),
(27, 'aa', '3', '2', '0', '0', '0', '0', '0', '0', '0'),
(28, 'xaawo', '0', '0', '0', '0', '0', '0', '07', '4', '0'),
(29, '', '1', '1', '1', '1', '1', '1', '1', '1', '0'),
(30, '', '0', '0', '0', '0', '10', '10', '1', '1', '0'),
(31, 'maariya', '2', '0', '00', '0', '0', '0', '0', '0', '0');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `email` varchar(20) DEFAULT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `email`, `password`) VALUES
(2, 'zaki', NULL, 'zaki'),
(3, 'safio', '', 'safio'),
(4, 'qalpiuser', 'qlpi', 'qlpi'),
(5, 'd', 'example@g.com', '123456'),
(6, 'Yahye', 'yahye@gmail.com', 'Yahye'),
(7, 'ali', 'sakariy@gmail.com', '123'),
(11, 'zakariye', 'zakariye@gmail.com', 'zakariye'),
(12, 'abc', 'abc@fmail.com', 'abc');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `deceased`
--
ALTER TABLE `deceased`
  ADD PRIMARY KEY (`deceased_id`);

--
-- Indexes for table `heirs`
--
ALTER TABLE `heirs`
  ADD PRIMARY KEY (`h_id`),
  ADD KEY `deceased_id` (`Magac`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `deceased`
--
ALTER TABLE `deceased`
  MODIFY `deceased_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `heirs`
--
ALTER TABLE `heirs`
  MODIFY `h_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
