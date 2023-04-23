-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 18, 2022 at 11:21 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `banking`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adminid` int(11) NOT NULL,
  `adminname` varchar(100) NOT NULL,
  `adminpw` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `contactid` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `messge` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `accno` varchar(100) NOT NULL,
  `balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`name`, `email`, `accno`, `balance`) VALUES
('sohom', 'sohom@gmail.com', '53450000', 18877),
('neogi', 'neogi@gmail.com', '53450001', 20023),
('rohit', 'rohit@gmail.com', '53450002', 46000),
('singh', 'singh@gmail.com', '53450003', 90000),
('raju', 'raju@gmail.com', '53450004', 80000),
('rishi', 'rishi@gmail.com', '53450005', 19100),
('sayak', 'sayak@gmail.com', '53450006', 66000),
('rajesh', 'rajesh@gmail.com', '53450007', 10000),
('sonal', 'sonal@gmail.com', '53450008', 30000),
('seal', 'seal@gmail.com', '53450009', 80600),
('rakesh', 'rakesh@gmail.com', '53450010', 56000);

-- --------------------------------------------------------

--
-- Table structure for table `money`
--

CREATE TABLE `money` (
  `id` int(100) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `receiver` varchar(100) NOT NULL,
  `amount` int(11) NOT NULL,
  `status` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `money`
--

INSERT INTO `money` (`id`, `sender`, `receiver`, `amount`, `status`) VALUES
(2, '53450001', '53450002', 100, 'Success'),
(3, '53450001', '53450002', 100, 'Success'),
(4, '53450005', '53450002', 400, 'Success'),
(5, '53450005', '53450001', 400, 'Success'),
(6, '53450005', '53450002', 100, 'Success'),
(7, '53450005', '53450002', 101001, 'Failed'),
(8, '53450000', '53450002', 80808080, 'Failed'),
(9, '53450000', '53450002', 80808080, 'Failed'),
(10, '53450000', '53450002', 1000, 'Success'),
(11, '53450000', '53450001', 123, 'Success'),
(12, '53450001', '53450002', 200, 'Success');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adminid`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`contactid`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`accno`);

--
-- Indexes for table `money`
--
ALTER TABLE `money`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `money`
--
ALTER TABLE `money`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
