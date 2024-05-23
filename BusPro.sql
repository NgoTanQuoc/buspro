-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 02, 2024 lúc 06:08 AM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `BusPro`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bookings`
--

CREATE TABLE `bookings` (
  `id` int(100) NOT NULL,
  `booking_id` varchar(255) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  `route_id` varchar(255) NOT NULL,
  `customer_route` varchar(200) NOT NULL,
  `booked_amount` int(100) NOT NULL,
  `booked_seat` varchar(100) NOT NULL,
  `booking_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `bookings`
--

INSERT INTO `bookings` (`id`, `booking_id`, `customer_id`, `route_id`, `customer_route`, `booked_amount`, `booked_seat`, `booking_created`) VALUES
(70, 'Q62FJ70', 'CUST-7106442', 'RT-3553161', 'HA NOI &rarr; TP_HCM', 1000000, '2', '2024-04-30 23:32:58'),
(73, 'PQJPE73', 'KH-5326443', 'RT-3835554', 'HUế &rarr; QUảNG NGãI', 130000, '4', '2024-05-01 11:03:31'),
(74, '867NZ74', 'CUST-9997540', 'RT-3835554', 'HUế &rarr; QUảNG NGãI', 130000, '1', '2024-05-01 20:44:01'),
(75, 'V49PZ75', 'CUST-9997540', 'RT-5887160', 'Đà NẵNG &rarr; QUảNG NAM', 40000, '14', '2024-05-01 20:44:27'),
(76, '9NSAE76', 'CUST-5585037', 'RT-9941455', 'Hà NộI &rarr; THANH HóA', 60000, '15', '2024-05-01 20:47:31'),
(77, 'ZCGPV77', 'CUST-8996235', 'RT-9941455', 'Hà NộI &rarr; THANH HóA', 60000, '12', '2024-05-01 20:50:36'),
(78, 'T2YYR78', 'CUST-2114034', 'RT-775557', 'HUế &rarr; QUảNG NAM', 100000, '14', '2024-05-01 20:50:56'),
(79, '29HTM79', 'CUST-9474738', 'RT-6028759', 'QUảNG NAM &rarr; Đà NẵNG', 130000, '1', '2024-05-01 20:54:47'),
(81, 'XHYSU81', 'CUST-8996235', 'RT-9069556', 'QUảNG BìNH &rarr; Đà NẵNG', 125000, '1', '2024-05-01 21:41:00'),
(82, 'GUUCT82', 'CUST-9474738', 'RT-9069556', 'QUảNG BìNH &rarr; Đà NẵNG', 125000, '4', '2024-05-01 21:49:28'),
(83, 'R4FVH83', 'CUST-8996235', 'RT-3553161', 'HA NOI &rarr; TP_HCM', 1000000, '1', '2024-05-01 21:52:06');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `buses`
--

CREATE TABLE `buses` (
  `id` int(100) NOT NULL,
  `bus_no` varchar(255) NOT NULL,
  `bus_assigned` tinyint(1) NOT NULL DEFAULT 0,
  `bus_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `buses`
--

INSERT INTO `buses` (`id`, `bus_no`, `bus_assigned`, `bus_created`) VALUES
(45, 'XB0010', 1, '2021-10-17 22:32:46'),
(46, 'XB0009', 1, '2021-10-17 22:33:15'),
(47, 'XB0008', 0, '2021-10-17 22:33:22'),
(48, 'XB0007', 1, '2021-10-17 22:33:36'),
(49, 'XB0006', 1, '2021-10-18 00:05:32'),
(50, 'XB0005', 1, '2021-10-18 00:06:02'),
(51, 'XB0004', 1, '2021-10-18 00:06:42'),
(52, 'XB0003', 1, '2021-10-18 00:06:52'),
(53, 'XB0002', 1, '2021-10-18 09:27:49'),
(54, 'XB0001', 1, '2021-10-18 09:36:54');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customers`
--

CREATE TABLE `customers` (
  `id` int(100) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  `customer_name` varchar(30) NOT NULL,
  `customer_phone` varchar(10) NOT NULL,
  `customer_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `customers`
--

INSERT INTO `customers` (`id`, `customer_id`, `customer_name`, `customer_phone`, `customer_created`) VALUES
(34, 'CUST-2114034', 'Trân sjdhbs', '0976958545', '2021-10-16 22:09:12'),
(35, 'CUST-8996235', 'Nguyễn qxa', '0293237232', '2021-10-17 22:30:23'),
(36, 'CUST-2017936', 'Hà snadb', '0923703282', '2021-10-17 22:30:53'),
(37, 'CUST-5585037', 'Phan ada', '0927382734', '2021-10-17 22:31:20'),
(38, 'CUST-9474738', 'Trần Abc', '0237823367', '2021-10-18 09:32:02'),
(39, 'CUST-4031139', 'Lê Sjshd', '0922378123', '2021-10-18 09:33:08'),
(40, 'CUST-9997540', 'Trần akda', '0127232873', '2021-10-18 09:39:10'),
(42, 'CUST-7106442', 'Nguyen Van A', '0987654320', '2024-04-30 23:31:12'),
(43, 'KH-5326443', 'Nguyễn âs', '0934793534', '2024-05-01 11:02:04');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `routes`
--

CREATE TABLE `routes` (
  `id` int(100) NOT NULL,
  `route_id` varchar(255) NOT NULL,
  `bus_no` varchar(155) NOT NULL,
  `route_cities` varchar(255) NOT NULL,
  `route_dep_date` date NOT NULL,
  `route_dep_time` time NOT NULL,
  `route_step_cost` int(100) NOT NULL,
  `route_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `routes`
--

INSERT INTO `routes` (`id`, `route_id`, `bus_no`, `route_cities`, `route_dep_date`, `route_dep_time`, `route_step_cost`, `route_created`) VALUES
(54, 'RT-3835554', 'XB0006', 'HUế,QUảNG NGãI', '2024-05-02', '17:00:00', 130000, '2021-10-16 22:12:32'),
(55, 'RT-9941455', 'XB0004', 'Hà NộI,THANH HóA', '2024-05-03', '10:00:00', 60000, '2021-10-17 22:34:47'),
(56, 'RT-9069556', 'XB0005', 'QUảNG BìNH,Đà NẵNG', '2024-04-24', '11:40:00', 125000, '2021-10-17 23:39:57'),
(57, 'RT-775557', 'XB0010', 'HUế,QUảNG NAM', '2024-04-18', '13:30:00', 100000, '2021-10-17 23:42:12'),
(58, 'RT-753558', 'XB0009', 'QUảNG NAM,QUảNG NGãI', '2024-03-30', '12:04:00', 70000, '2021-10-18 00:04:42'),
(59, 'RT-6028759', 'XB0007', 'QUảNG NAM,Đà NẵNG', '2024-04-26', '16:50:00', 40000, '2021-10-18 00:07:50'),
(60, 'RT-5887160', 'XB0003', 'Đà NẵNG,QUảNG NAM', '2024-05-08', '10:30:00', 40000, '2021-10-18 09:38:30'),
(61, 'RT-3553161', 'XB0002', 'HA NOI,TP_HCM', '2024-05-01', '21:00:00', 1000000, '2024-04-30 23:12:30'),
(62, 'RT-5210562', 'XB0001', 'Đà NẵNG,HUế', '2024-05-02', '07:00:00', 75000, '2024-05-01 09:04:59'),
(63, 'RT-412663', 'XB0002', 'Đà NẵNG,QUảNG NAM', '2024-05-16', '19:40:00', 40000, '2024-05-01 20:40:49');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `seats`
--

CREATE TABLE `seats` (
  `bus_no` varchar(155) NOT NULL,
  `seat_booked` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `seats`
--

INSERT INTO `seats` (`bus_no`, `seat_booked`) VALUES
('XB0001', NULL),
('XB0002', '1'),
('XB0003', NULL),
('XB0004', NULL),
('XB0005', '1,4'),
('XB0006', NULL),
('XB0007', NULL),
('XB0008', NULL),
('XB0009', NULL),
('XB0010', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_fullname` varchar(100) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`user_id`, `user_fullname`, `user_name`, `user_password`, `user_created`) VALUES
(1, 'Liam Moore', 'admin', '$2y$10$7rLSvRVyTQORapkDOqmkhetjF6H9lJHngr4hJMSM2lHObJbW5EQh6', '2021-06-02 13:55:21'),
(3, 'Quoc Ngo Tan', 'Test', '$2y$10$bRJpGnZV2hbafz7nQcOwneEw3BLUku3Ui408AEk8gtVi.tHuubr1G', '2024-05-01 13:38:26');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `buses`
--
ALTER TABLE `buses`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`bus_no`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT cho bảng `buses`
--
ALTER TABLE `buses`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT cho bảng `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT cho bảng `routes`
--
ALTER TABLE `routes`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
