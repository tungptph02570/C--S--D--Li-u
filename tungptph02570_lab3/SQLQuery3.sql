use master
go
--------------------------------------------
IF  EXISTS ( 	SELECT * FROM sysdatabases 	WHERE name = N'tungptph02570_lab3' )
														
DROP DATABASE tungptph02570_lab3
GO														

CREATE DATABASE tungptph02570_lab3
													
ON
( name = 'tungptph02570_lab3', FILENAME='G:\tungptph02570_lab3.mdf',
size= 5MB,								
maxsize=10MB,								
filegrowth=1MB)								
LOG ON 
( name = 'tungptph02570_lab3_log', FILENAME='G:\tungptph02570_lab3.ldf',
size= 1MB,
maxsize=4MB,
filegrowth=1MB) 
GO
-----------------------------------------------

use tungptph02570_lab3 
go
-----------------------------------------------

if exists (select * from sysobjects where name = N'Khachhang')
drop table Khachhang
create table dbo.Khachhang
(
MA_KH nvarchar(50) not null,
Ten_KH nvarchar(50) null,
Diachi nvarchar(50) null,
Phone nvarchar(50) null
constraint pk_Khachhang primary key (Ma_KH)
)

--------------------------------------------------

if exists ( select * from sysobjects where name  = N'TAI_KHOAN')
drop table TAI_KHOAN
create table dbo.TAI_KHOAN
(
SO_TK nvarchar(50) not null,
MA_KH nvarchar(50) null,
KIEU_TK	nvarchar(50) null,
NGAYMO_TK	Date null,
SoTien	money null
constraint pk_TAI_KHOAN primary key (SO_TK)
constraint fk_TAI_KHOAN foreign key (MA_KH) references Khachhang
)
--------------------------------------------------

if exists ( select * from sysobjects where name = N'Giao_Dich')
drop table Giao_Dich
create table dbo.Giao_Dich
 
( Ma_GD nvarchar(50) not null,
  SO_Tk nvarchar(50) null,
  THOIGIAN_GD DATE null,
  Sotien_GD money null,
  MoTa_GD		nvarchar(50) null,
  SoDu_TK	money null

  constraint pk_GiaoDich primary key (Ma_GD)
  constraint fk_GiaoDich foreign  key(SO_TK) references TAI_KHOAN
  )

---------------------------------------------------------------


----------------------------------------------------------------
DELETE FROM dbo.Khachhang 
INSERT INTO dbo.Khachhang (MA_KH , Ten_KH , Diachi , Phone ) VALUES (N'M001', N'Pham Trong Tung', N'Bac Giang', N'0196991766')
INSERT INTO dbo.Khachhang (MA_KH , Ten_KH , Diachi , Phone  ) VALUES (N'M002', N'Do Van Manh', N'Ha Noi', N'0132654798')
INSERT INTO dbo.Khachhang (MA_KH , Ten_KH , Diachi , Phone  ) VALUES (N'M003', N'Nguyen Van Khuong', N'Nam Dinh', N'0123654789')

SELECT *FROM  dbo.Khachhang 
----------------------------------------------------------------
DELETE  FROM dbo.TAI_KHOAN  
INSERT INTO dbo.TAI_KHOAN (SO_TK  , MA_KH  , KIEU_TK  , NGAYMO_TK  , SoTien ) VALUES (N'S001', N'M001', N'Loai01', N' 2012-1-1', N'10000')
INSERT INTO dbo.TAI_KHOAN (SO_TK  , MA_KH  ,KIEU_TK  ,NGAYMO_TK  ,SoTien  ) VALUES (N'S002', N'M002', N'Loai02', N'2010-02-02',N'10000')
INSERT INTO dbo.TAI_KHOAN (SO_TK  ,MA_KH  ,KIEU_TK  ,NGAYMO_TK  ,SoTien ) VALUES (N'S003', N'M003', N'Loai03', N'2009-01-01', N'20000')
SELECT * FROM dbo.TAI_KHOAN  
----------------------------------
DELETE FROM dbo.Giao_Dich  
INSERT INTO dbo.Giao_Dich(Ma_GD , SO_Tk ,THOIGIAN_GD,Sotien_GD,MoTa_GD,SoDu_TK) VALUES(N'M001', N'S001',N'2010-01-01',N'100000',N'MO', N'20000')
INSERT INTO dbo.Giao_Dich(Ma_GD , SO_Tk ,THOIGIAN_GD,Sotien_GD,MoTa_GD,SoDu_TK)VALUES(N'M002', N'S002', N'2006-02-02',N'200000', N'KHOA',N'10000')
INSERT INTO dbo.Giao_Dich(Ma_GD , SO_Tk ,THOIGIAN_GD,Sotien_GD,MoTa_GD,SoDu_TK )VALUES(N'M003', N'S003',N'2007-07-20',N'3000000',N'KHOA',N'30000')

SELECT * FROM dbo.Giao_Dich  
--------------------------------------------------------------------

-------------------truy vấn--------------------
---2.1---
---1--
select * from TAI_KHOAN 
--2--
Select SO_TK, MA_KH, KIEU_TK, NGAYMO_TK FROM TAI_KHOAN 
--3--
SELECT MA_KH , TEN_KH , DiaChi FROM Khachhang where Diachi  = 'Ha Noi' 
--4--
select * from TAI_KHOAN where YEAR (NGAYMO_TK ) < 2011-07-01
----2.2----
--1--
select KIEU_TK, NGAYMO_TK FROM TAI_KHOAN 
--2--
select * from TAI_KHOAN ,Giao_Dich    where YEAR (NGAYMO_TK ) > 2011-07-01
--3--
select * from TAI_KHOAN ,Giao_Dich    where YEAR (NGAYMO_TK ) > 2011-07-01 
--4--
select   KIEU_TK  ,Sotien_GD, MoTa_GD, THOIGIAN_GD, SoDu_TK
  from Giao_Dich, TAI_KHOAN  where YEAR (THOIGIAN_GD) > 2007-07-20

--5--
SELECT TEN_KH, DiaChi ,SO_Tk  KIEU_TK
from  Khachhang  , TAI_KHOAN WHERE SO_TK = 'S001' 

