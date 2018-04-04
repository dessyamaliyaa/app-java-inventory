-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 04, 2018 at 03:50 AM
-- Server version: 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbmotor`
--

CREATE TABLE `tbmotor` (
  `TIPE_MODEL` char(20) NOT NULL,
  `ID_KTG` varchar(5) DEFAULT NULL,
  `ID_SUPPLIER` varchar(5) DEFAULT NULL,
  `NOMOR_RANGKA` char(20) DEFAULT NULL,
  `NOMOR_MESIN` char(20) DEFAULT NULL,
  `NAMA_MOTOR` varchar(35) DEFAULT NULL,
  `HARGA_MOTOR` float DEFAULT NULL,
  `STOK_MOTOR` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbmotor`
--

INSERT INTO `tbmotor` (`TIPE_MODEL`, `ID_KTG`, `ID_SUPPLIER`, `NOMOR_RANGKA`, `NOMOR_MESIN`, `NAMA_MOTOR`, `HARGA_MOTOR`, `STOK_MOTOR`) VALUES
('1', '1', '1', '35679877FF', '35679877FF', 'Honda Beat', 16000000, 146);

-- --------------------------------------------------------

--
-- Table structure for table `tbmotor_keluar`
--

CREATE TABLE `tbmotor_keluar` (
  `NO_BARANG_KELUAR` char(7) NOT NULL,
  `ID_USER` char(5) DEFAULT NULL,
  `TIPE_MODEL` char(20) DEFAULT NULL,
  `TGL_KELUAR` date DEFAULT NULL,
  `JML_BARANG` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbmotor_keluar`
--

INSERT INTO `tbmotor_keluar` (`NO_BARANG_KELUAR`, `ID_USER`, `TIPE_MODEL`, `TGL_KELUAR`, `JML_BARANG`) VALUES
('22', 'ID002', '1', '1970-01-01', 66);

--
-- Triggers `tbmotor_keluar`
--
DELIMITER $$
CREATE TRIGGER `TG_MOTOR_KELUAR1` AFTER INSERT ON `tbmotor_keluar` FOR EACH ROW BEGIN UPDATE tbmotor SET STOK_MOTOR = STOK_MOTOR - NEW.JML_BARANG WHERE TIPE_MODEL=NEW.TIPE_MODEL; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_MOTOR_KELUAR2` AFTER UPDATE ON `tbmotor_keluar` FOR EACH ROW BEGIN UPDATE tbmotor SET STOK_MOTOR = STOK_MOTOR + OLD.JML_BARANG- NEW.JML_BARANG WHERE TIPE_MODEL=NEW.TIPE_MODEL; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbmotor_masuk`
--

CREATE TABLE `tbmotor_masuk` (
  `NO_BARANG_MASUK` char(7) NOT NULL,
  `ID_USER` char(5) DEFAULT NULL,
  `TIPE_MODEL` char(20) DEFAULT NULL,
  `TGL_MASUK` date DEFAULT NULL,
  `JML_MASUK` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbmotor_masuk`
--

INSERT INTO `tbmotor_masuk` (`NO_BARANG_MASUK`, `ID_USER`, `TIPE_MODEL`, `TGL_MASUK`, `JML_MASUK`) VALUES
('1', 'ID001', '1', '1970-01-01', 3),
('2', 'ID001', '1', '2018-01-11', 1),
('3', 'ID001', '1', '1970-01-01', 2);

--
-- Triggers `tbmotor_masuk`
--
DELIMITER $$
CREATE TRIGGER `TG_MOTOR_MASUK1` AFTER INSERT ON `tbmotor_masuk` FOR EACH ROW BEGIN 
UPDATE tbmotor SET STOK_MOTOR = STOK_MOTOR + NEW.JML_MASUK WHERE TIPE_MODEL = NEW.TIPE_MODEL; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_MOTOR_MASUK2` AFTER UPDATE ON `tbmotor_masuk` FOR EACH ROW BEGIN 
UPDATE tbmotor SET STOK_MOTOR = STOK_MOTOR + OLD.JML_MASUK + NEW.JML_MASUK WHERE TIPE_MODEL = NEW.TIPE_MODEL; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tborder_motor`
--

CREATE TABLE `tborder_motor` (
  `KD_ORDER_MOTOR` char(8) NOT NULL,
  `TIPE_MODEL` char(20) DEFAULT NULL,
  `ID_USER` char(5) DEFAULT NULL,
  `TGL_ORDER_MOTOR` date DEFAULT NULL,
  `JML_ORDER_MOTOR` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tborder_motor`
--

INSERT INTO `tborder_motor` (`KD_ORDER_MOTOR`, `TIPE_MODEL`, `ID_USER`, `TGL_ORDER_MOTOR`, `JML_ORDER_MOTOR`) VALUES
('2', '1', 'ID001', '2018-01-11', 11),
('3', '1', 'ID001', '2018-01-11', 22);

-- --------------------------------------------------------

--
-- Table structure for table `tborder_sparepart`
--

CREATE TABLE `tborder_sparepart` (
  `KD_ORDER_SPAREPART` char(8) NOT NULL,
  `NOMOR_SERI` char(17) DEFAULT NULL,
  `ID_USER` char(5) DEFAULT NULL,
  `TGL_ORDER_SPAREPART` date DEFAULT NULL,
  `JML_ORDER_SPAREPART` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tborder_sparepart`
--

INSERT INTO `tborder_sparepart` (`KD_ORDER_SPAREPART`, `NOMOR_SERI`, `ID_USER`, `TGL_ORDER_SPAREPART`, `JML_ORDER_SPAREPART`) VALUES
('1', '1', 'ID001', '2018-01-11', 29);

-- --------------------------------------------------------

--
-- Table structure for table `tbretur_pembelian_motor`
--

CREATE TABLE `tbretur_pembelian_motor` (
  `NO_RETUR_PEMBELIAN_MOTOR` int(11) NOT NULL,
  `ID_USER` char(5) DEFAULT NULL,
  `TIPE_MODEL` char(20) DEFAULT NULL,
  `TGL_RETUR_PEMBELIAN_MOTOR` date DEFAULT NULL,
  `JML_RETUR_PEMBELIAN_MOTOR` int(11) DEFAULT NULL,
  `STATUS_RETUR_PEMBELIAN_MOTOR` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `tbretur_pembelian_motor`
--
DELIMITER $$
CREATE TRIGGER `TG_RETUR_BELI_MOTOR1` AFTER INSERT ON `tbretur_pembelian_motor` FOR EACH ROW BEGIN 
UPDATE tbmotor SET STOK_MOTOR = STOK_MOTOR - NEW.JML_RETUR_PEMBELIAN_MOTOR WHERE TIPE_MODEL=NEW.TIPE_MODEL;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_RETUR_BELI_MOTOR2` AFTER UPDATE ON `tbretur_pembelian_motor` FOR EACH ROW BEGIN 
UPDATE tbmotor SET STOK_MOTOR = STOK_MOTOR + OLD.JML_RETUR_PEMBELIAN_MOTOR- NEW.JML_RETUR_PEMBELIAN_MOTOR WHERE TIPE_MODEL=NEW.TIPE_MODEL;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbretur_pembelian_sparepart`
--

CREATE TABLE `tbretur_pembelian_sparepart` (
  `NO_RETUR_PEMBELIAN_SPAREPART` int(11) NOT NULL,
  `ID_USER` char(5) DEFAULT NULL,
  `NOMOR_SERI` char(17) DEFAULT NULL,
  `TGL_RETUR_PEMBELIAN_SPAREPART` date DEFAULT NULL,
  `JML_RETUR_PEMBELIAN_SPAREPART` int(11) DEFAULT NULL,
  `STATUS_RETUR_PEMBELIAN_SPAREPART` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbretur_pembelian_sparepart`
--

INSERT INTO `tbretur_pembelian_sparepart` (`NO_RETUR_PEMBELIAN_SPAREPART`, `ID_USER`, `NOMOR_SERI`, `TGL_RETUR_PEMBELIAN_SPAREPART`, `JML_RETUR_PEMBELIAN_SPAREPART`, `STATUS_RETUR_PEMBELIAN_SPAREPART`) VALUES
(1, 'ID001', '1', '2018-01-11', 4, 'sg');

--
-- Triggers `tbretur_pembelian_sparepart`
--
DELIMITER $$
CREATE TRIGGER `TG_RETUR_BELI_SP1` AFTER INSERT ON `tbretur_pembelian_sparepart` FOR EACH ROW BEGIN 
UPDATE tbsparepart SET STOK_SPAREPAR = STOK_SPAREPAR - NEW.JML_RETUR_PEMBELIAN_SPAREPART WHERE 	NOMOR_SERI=NEW.NOMOR_SERI;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_RETUR_BELI_SP2` AFTER UPDATE ON `tbretur_pembelian_sparepart` FOR EACH ROW BEGIN 
UPDATE tbsparepart SET STOK_SPAREPAR = STOK_SPAREPAR + OLD.JML_RETUR_PEMBELIAN_SPAREPART - NEW.JML_RETUR_PEMBELIAN_SPAREPART WHERE NOMOR_SERI=NEW.NOMOR_SERI;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbretur_penjualan_motor`
--

CREATE TABLE `tbretur_penjualan_motor` (
  `NO_RETUR_PENJUALAN_MOTOR` int(11) NOT NULL,
  `ID_USER` char(5) DEFAULT NULL,
  `TIPE_MODEL` char(20) DEFAULT NULL,
  `TGL_RETUR_PENJUALAN_MOTOR` date DEFAULT NULL,
  `JML_RETUR_PENJUALAN_MOTOR` int(11) DEFAULT NULL,
  `STATUS_RETUR_PENJUALAN_MOTOR` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `tbretur_penjualan_motor`
--
DELIMITER $$
CREATE TRIGGER `TG_RT_JUAL_M1` AFTER UPDATE ON `tbretur_penjualan_motor` FOR EACH ROW BEGIN
UPDATE tbmotor SET STOK_MOTOR = STOK_MOTOR - OLD.JML_RETUR_PENJUALAN_MOTOR + NEW.JML_RETUR_PENJUALAN_MOTOR 
WHERE TIPE_MODEL=NEW.TIPE_MODEL;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_RT_JUAL_M2` AFTER INSERT ON `tbretur_penjualan_motor` FOR EACH ROW BEGIN
UPDATE tbmotor SET STOK_MOTOR = STOK_MOTOR+NEW.JML_RETUR_PENJUALAN_MOTOR WHERE TIPE_MODEL=NEW.TIPE_MODEL;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbretur_penjualan_sparepart`
--

CREATE TABLE `tbretur_penjualan_sparepart` (
  `NO_RETUR_PENJUALAN` int(11) NOT NULL,
  `ID_USER` char(5) DEFAULT NULL,
  `NOMOR_SERI` char(17) DEFAULT NULL,
  `TGL_RETUR_PENJUALAN_SPAREPART` date DEFAULT NULL,
  `JML_RETUR_PENJUALAN` int(11) DEFAULT NULL,
  `STATUS_RETUR_PENJUALAN` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `tbretur_penjualan_sparepart`
--
DELIMITER $$
CREATE TRIGGER `TG_RT_JUAL_SP1` AFTER UPDATE ON `tbretur_penjualan_sparepart` FOR EACH ROW BEGIN
UPDATE tbsparepart SET STOK_SPAREPAR = STOK_SPAREPAR - OLD.JML_RETUR_PENJUALAN + NEW.JML_RETUR_PENJUALAN 
WHERE NOMOR_SERI=NEW.NOMOR_SERI;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_RT_JUAL_SP2` AFTER INSERT ON `tbretur_penjualan_sparepart` FOR EACH ROW BEGIN
UPDATE tbsparepart SET STOK_SPAREPAR = STOK_SPAREPAR+NEW.JML_RETUR_PENJUALAN WHERE NOMOR_SERI=NEW.NOMOR_SERI;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbsparepart`
--

CREATE TABLE `tbsparepart` (
  `NOMOR_SERI` char(17) NOT NULL,
  `ID_KTG` varchar(5) DEFAULT NULL,
  `ID_SUPPLIER` varchar(5) DEFAULT NULL,
  `NAMA_SPAREPART` varchar(35) DEFAULT NULL,
  `STOK_SPAREPAR` int(11) DEFAULT NULL,
  `HARGA_SPAREPART` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbsparepart`
--

INSERT INTO `tbsparepart` (`NOMOR_SERI`, `ID_KTG`, `ID_SUPPLIER`, `NAMA_SPAREPART`, `STOK_SPAREPAR`, `HARGA_SPAREPART`) VALUES
('1', '1', '1', 'SP', 675, 300000);

-- --------------------------------------------------------

--
-- Table structure for table `tbsparepart_keluar`
--

CREATE TABLE `tbsparepart_keluar` (
  `NO_SPAREPART_KELUAR` char(7) NOT NULL,
  `ID_USER` char(5) DEFAULT NULL,
  `NOMOR_SERI` char(17) DEFAULT NULL,
  `TGL_SPAREPART_KELUAR` date DEFAULT NULL,
  `JML_SPAREPART_KELUAR` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbsparepart_keluar`
--

INSERT INTO `tbsparepart_keluar` (`NO_SPAREPART_KELUAR`, `ID_USER`, `NOMOR_SERI`, `TGL_SPAREPART_KELUAR`, `JML_SPAREPART_KELUAR`) VALUES
('1', 'ID001', '1', '1970-01-01', 1);

--
-- Triggers `tbsparepart_keluar`
--
DELIMITER $$
CREATE TRIGGER `TG_SP_KELUAR1` AFTER INSERT ON `tbsparepart_keluar` FOR EACH ROW BEGIN UPDATE tbsparepart SET STOK_SPAREPAR = STOK_SPAREPAR - NEW.JML_SPAREPART_KELUAR WHERE NOMOR_SERI=NEW.NOMOR_SERI; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_SP_KELUAR2` AFTER UPDATE ON `tbsparepart_keluar` FOR EACH ROW BEGIN UPDATE tbsparepart SET STOK_SPAREPAR = STOK_SPAREPAR + OLD.JML_SPAREPART_KELUAR - NEW.JML_SPAREPART_KELUAR WHERE NOMOR_SERI=NEW.NOMOR_SERI; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbsparepart_masuk`
--

CREATE TABLE `tbsparepart_masuk` (
  `NO_SPAREPART_MASUK` char(7) NOT NULL,
  `ID_USER` char(5) DEFAULT NULL,
  `NOMOR_SERI` char(17) DEFAULT NULL,
  `TGL_SPAREPART_MASUK` date DEFAULT NULL,
  `JML_SPAREPART_MASUK` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbsparepart_masuk`
--

INSERT INTO `tbsparepart_masuk` (`NO_SPAREPART_MASUK`, `ID_USER`, `NOMOR_SERI`, `TGL_SPAREPART_MASUK`, `JML_SPAREPART_MASUK`) VALUES
('1', 'ID001', '1', '2018-01-11', 5),
('2', 'ID001', '1', '1970-01-01', 3);

--
-- Triggers `tbsparepart_masuk`
--
DELIMITER $$
CREATE TRIGGER `TG_SP_MASUK1` AFTER INSERT ON `tbsparepart_masuk` FOR EACH ROW BEGIN UPDATE tbsparepart SET STOK_SPAREPAR = STOK_SPAREPAR + NEW.JML_SPAREPART_MASUK WHERE NOMOR_SERI = NEW.NOMOR_SERI; 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TG_SP_MASUK2` AFTER UPDATE ON `tbsparepart_masuk` FOR EACH ROW BEGIN UPDATE tbsparepart SET STOK_SPAREPAR = STOK_SPAREPAR +OLD.JML_SPAREPART_MASUK + NEW.JML_SPAREPART_MASUK WHERE NOMOR_SERI=NEW.NOMOR_SERI; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbsupplier`
--

CREATE TABLE `tbsupplier` (
  `ID_SUPPLIER` varchar(5) NOT NULL,
  `NAMA_SUPPLIER` varchar(50) DEFAULT NULL,
  `ALAMAT_SUPPLIER` text,
  `NO_HP_SUPPLIER` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbsupplier`
--

INSERT INTO `tbsupplier` (`ID_SUPPLIER`, `NAMA_SUPPLIER`, `ALAMAT_SUPPLIER`, `NO_HP_SUPPLIER`) VALUES
('1', 'Setno', 'Kajen', '09876542'),
('2', 'Ratna', 'Kajen', '0858557346');

-- --------------------------------------------------------

--
-- Table structure for table `tb_kategori`
--

CREATE TABLE `tb_kategori` (
  `ID_KTG` varchar(5) NOT NULL,
  `TAHUN_PEMBUATAN` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_kategori`
--

INSERT INTO `tb_kategori` (`ID_KTG`, `TAHUN_PEMBUATAN`) VALUES
('1', 2013);

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `ID_USER` char(5) NOT NULL,
  `PASS_USER` varchar(50) NOT NULL,
  `NAMA_USER` varchar(20) NOT NULL,
  `LEV_USER` varchar(20) NOT NULL,
  `ALAMAT_USER` varchar(50) NOT NULL,
  `NOTELP_USER` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`ID_USER`, `PASS_USER`, `NAMA_USER`, `LEV_USER`, `ALAMAT_USER`, `NOTELP_USER`) VALUES
('ID001', '21232f297a57a5a743894a0e4a801fc3', 'admin', 'Admin', 'kajen', '0123456789'),
('ID002', '21232f297a57a5a743894a0e4a801fc3', 'Manager', 'Manager', 'kajen', '0123456789');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbmotor`
--
ALTER TABLE `tbmotor`
  ADD PRIMARY KEY (`TIPE_MODEL`),
  ADD KEY `FK_RELATIONSHIP_2` (`ID_KTG`),
  ADD KEY `FK_RELATIONSHIP_27` (`ID_SUPPLIER`);

--
-- Indexes for table `tbmotor_keluar`
--
ALTER TABLE `tbmotor_keluar`
  ADD PRIMARY KEY (`NO_BARANG_KELUAR`),
  ADD KEY `FK_RELATIONSHIP_14` (`ID_USER`),
  ADD KEY `FK_RELATIONSHIP_22` (`TIPE_MODEL`);

--
-- Indexes for table `tbmotor_masuk`
--
ALTER TABLE `tbmotor_masuk`
  ADD PRIMARY KEY (`NO_BARANG_MASUK`),
  ADD KEY `FK_RELATIONSHIP_15` (`ID_USER`),
  ADD KEY `FK_RELATIONSHIP_23` (`TIPE_MODEL`);

--
-- Indexes for table `tborder_motor`
--
ALTER TABLE `tborder_motor`
  ADD PRIMARY KEY (`KD_ORDER_MOTOR`),
  ADD KEY `FK_RELATIONSHIP_28` (`TIPE_MODEL`),
  ADD KEY `FK_RELATIONSHIP_30` (`ID_USER`);

--
-- Indexes for table `tborder_sparepart`
--
ALTER TABLE `tborder_sparepart`
  ADD PRIMARY KEY (`KD_ORDER_SPAREPART`),
  ADD KEY `FK_RELATIONSHIP_29` (`NOMOR_SERI`),
  ADD KEY `FK_RELATIONSHIP_31` (`ID_USER`);

--
-- Indexes for table `tbretur_pembelian_motor`
--
ALTER TABLE `tbretur_pembelian_motor`
  ADD PRIMARY KEY (`NO_RETUR_PEMBELIAN_MOTOR`),
  ADD KEY `FK_RELATIONSHIP_10` (`ID_USER`),
  ADD KEY `FK_RELATIONSHIP_18` (`TIPE_MODEL`);

--
-- Indexes for table `tbretur_pembelian_sparepart`
--
ALTER TABLE `tbretur_pembelian_sparepart`
  ADD PRIMARY KEY (`NO_RETUR_PEMBELIAN_SPAREPART`),
  ADD KEY `FK_RELATIONSHIP_11` (`ID_USER`),
  ADD KEY `FK_RELATIONSHIP_20` (`NOMOR_SERI`);

--
-- Indexes for table `tbretur_penjualan_motor`
--
ALTER TABLE `tbretur_penjualan_motor`
  ADD PRIMARY KEY (`NO_RETUR_PENJUALAN_MOTOR`),
  ADD KEY `FK_RELATIONSHIP_12` (`ID_USER`),
  ADD KEY `FK_RELATIONSHIP_19` (`TIPE_MODEL`);

--
-- Indexes for table `tbretur_penjualan_sparepart`
--
ALTER TABLE `tbretur_penjualan_sparepart`
  ADD PRIMARY KEY (`NO_RETUR_PENJUALAN`),
  ADD KEY `FK_RELATIONSHIP_13` (`ID_USER`),
  ADD KEY `FK_RELATIONSHIP_21` (`NOMOR_SERI`);

--
-- Indexes for table `tbsparepart`
--
ALTER TABLE `tbsparepart`
  ADD PRIMARY KEY (`NOMOR_SERI`),
  ADD KEY `FK_RELATIONSHIP_26` (`ID_SUPPLIER`),
  ADD KEY `FK_RELATIONSHIP_3` (`ID_KTG`);

--
-- Indexes for table `tbsparepart_keluar`
--
ALTER TABLE `tbsparepart_keluar`
  ADD PRIMARY KEY (`NO_SPAREPART_KELUAR`),
  ADD KEY `FK_RELATIONSHIP_17` (`ID_USER`),
  ADD KEY `FK_RELATIONSHIP_25` (`NOMOR_SERI`);

--
-- Indexes for table `tbsparepart_masuk`
--
ALTER TABLE `tbsparepart_masuk`
  ADD PRIMARY KEY (`NO_SPAREPART_MASUK`),
  ADD KEY `FK_RELATIONSHIP_16` (`ID_USER`),
  ADD KEY `FK_RELATIONSHIP_24` (`NOMOR_SERI`);

--
-- Indexes for table `tbsupplier`
--
ALTER TABLE `tbsupplier`
  ADD PRIMARY KEY (`ID_SUPPLIER`);

--
-- Indexes for table `tb_kategori`
--
ALTER TABLE `tb_kategori`
  ADD PRIMARY KEY (`ID_KTG`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`ID_USER`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbmotor`
--
ALTER TABLE `tbmotor`
  ADD CONSTRAINT `FK_RELATIONSHIP_2` FOREIGN KEY (`ID_KTG`) REFERENCES `tb_kategori` (`ID_KTG`),
  ADD CONSTRAINT `FK_RELATIONSHIP_27` FOREIGN KEY (`ID_SUPPLIER`) REFERENCES `tbsupplier` (`ID_SUPPLIER`);

--
-- Constraints for table `tbmotor_keluar`
--
ALTER TABLE `tbmotor_keluar`
  ADD CONSTRAINT `FK_RELATIONSHIP_14` FOREIGN KEY (`ID_USER`) REFERENCES `tb_user` (`ID_USER`),
  ADD CONSTRAINT `FK_RELATIONSHIP_22` FOREIGN KEY (`TIPE_MODEL`) REFERENCES `tbmotor` (`TIPE_MODEL`);

--
-- Constraints for table `tbmotor_masuk`
--
ALTER TABLE `tbmotor_masuk`
  ADD CONSTRAINT `FK_RELATIONSHIP_15` FOREIGN KEY (`ID_USER`) REFERENCES `tb_user` (`ID_USER`),
  ADD CONSTRAINT `FK_RELATIONSHIP_23` FOREIGN KEY (`TIPE_MODEL`) REFERENCES `tbmotor` (`TIPE_MODEL`);

--
-- Constraints for table `tborder_motor`
--
ALTER TABLE `tborder_motor`
  ADD CONSTRAINT `FK_RELATIONSHIP_28` FOREIGN KEY (`TIPE_MODEL`) REFERENCES `tbmotor` (`TIPE_MODEL`),
  ADD CONSTRAINT `FK_RELATIONSHIP_30` FOREIGN KEY (`ID_USER`) REFERENCES `tb_user` (`ID_USER`);

--
-- Constraints for table `tborder_sparepart`
--
ALTER TABLE `tborder_sparepart`
  ADD CONSTRAINT `FK_RELATIONSHIP_29` FOREIGN KEY (`NOMOR_SERI`) REFERENCES `tbsparepart` (`NOMOR_SERI`),
  ADD CONSTRAINT `FK_RELATIONSHIP_31` FOREIGN KEY (`ID_USER`) REFERENCES `tb_user` (`ID_USER`);

--
-- Constraints for table `tbretur_pembelian_motor`
--
ALTER TABLE `tbretur_pembelian_motor`
  ADD CONSTRAINT `FK_RELATIONSHIP_10` FOREIGN KEY (`ID_USER`) REFERENCES `tb_user` (`ID_USER`),
  ADD CONSTRAINT `FK_RELATIONSHIP_18` FOREIGN KEY (`TIPE_MODEL`) REFERENCES `tbmotor` (`TIPE_MODEL`);

--
-- Constraints for table `tbretur_pembelian_sparepart`
--
ALTER TABLE `tbretur_pembelian_sparepart`
  ADD CONSTRAINT `FK_RELATIONSHIP_11` FOREIGN KEY (`ID_USER`) REFERENCES `tb_user` (`ID_USER`),
  ADD CONSTRAINT `FK_RELATIONSHIP_20` FOREIGN KEY (`NOMOR_SERI`) REFERENCES `tbsparepart` (`NOMOR_SERI`);

--
-- Constraints for table `tbretur_penjualan_motor`
--
ALTER TABLE `tbretur_penjualan_motor`
  ADD CONSTRAINT `FK_RELATIONSHIP_12` FOREIGN KEY (`ID_USER`) REFERENCES `tb_user` (`ID_USER`),
  ADD CONSTRAINT `FK_RELATIONSHIP_19` FOREIGN KEY (`TIPE_MODEL`) REFERENCES `tbmotor` (`TIPE_MODEL`);

--
-- Constraints for table `tbretur_penjualan_sparepart`
--
ALTER TABLE `tbretur_penjualan_sparepart`
  ADD CONSTRAINT `FK_RELATIONSHIP_13` FOREIGN KEY (`ID_USER`) REFERENCES `tb_user` (`ID_USER`),
  ADD CONSTRAINT `FK_RELATIONSHIP_21` FOREIGN KEY (`NOMOR_SERI`) REFERENCES `tbsparepart` (`NOMOR_SERI`);

--
-- Constraints for table `tbsparepart`
--
ALTER TABLE `tbsparepart`
  ADD CONSTRAINT `FK_RELATIONSHIP_26` FOREIGN KEY (`ID_SUPPLIER`) REFERENCES `tbsupplier` (`ID_SUPPLIER`),
  ADD CONSTRAINT `FK_RELATIONSHIP_3` FOREIGN KEY (`ID_KTG`) REFERENCES `tb_kategori` (`ID_KTG`);

--
-- Constraints for table `tbsparepart_keluar`
--
ALTER TABLE `tbsparepart_keluar`
  ADD CONSTRAINT `FK_RELATIONSHIP_17` FOREIGN KEY (`ID_USER`) REFERENCES `tb_user` (`ID_USER`),
  ADD CONSTRAINT `FK_RELATIONSHIP_25` FOREIGN KEY (`NOMOR_SERI`) REFERENCES `tbsparepart` (`NOMOR_SERI`);

--
-- Constraints for table `tbsparepart_masuk`
--
ALTER TABLE `tbsparepart_masuk`
  ADD CONSTRAINT `FK_RELATIONSHIP_16` FOREIGN KEY (`ID_USER`) REFERENCES `tb_user` (`ID_USER`),
  ADD CONSTRAINT `FK_RELATIONSHIP_24` FOREIGN KEY (`NOMOR_SERI`) REFERENCES `tbsparepart` (`NOMOR_SERI`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
