use master
go
--------------------------------------------
IF  EXISTS ( 	SELECT * FROM sysdatabases 	WHERE name = N'tungptph02570_lab6' )
														
DROP DATABASE tungptph02570_lab6
GO														

CREATE DATABASE tungptph02570_lab6
										
										
										 			
ON
(name ='tungptph02570_lab6', filename ='E:\tungptph02570_lab6.mdf',
size=5MB,
maxsize=10MB,
filegrowth=1MB)

							
													
LOG ON 
(name='tungptph02570_lab6_log', filename='E:\tungptph02570_lab6.ldf',
size=1MB,
maxsize=4MB,
filegrowth=1MB)

GO
-----------------------------------------------
use tungptph02570_lab6
go
-----------------------------------------------
if exists (select * from sysobjects where name = N'TruSo')
drop table TruSo
create table dbo.TruSo
(
Ma_truso	nvarchar(10) not  null,
Ten_truso	nvarchar(10) null,

constraint PK_TruSo primary key (Ma_truso)
)
----------------------
if exists (select * from sysobjects where name = N'PhongBan')
drop table PhongBan
create table dbo.PhongBan
(
Ten_Phong nvarchar(50) not null,
Ma_TruongPhong	nvarchar(50) not null,
Ten_TruongPhong	nvarchar(50) null,
Ma_truso	nvarchar(10)  not null,
Ma_Duan	nvarchar(10)  not null

constraint PK_PhongBan primary key (Ma_TruongPhong)
constraint FK_PhongBan	foreign key (Ma_truso) references TruSo,
constraint FK_PhongBan_DuAn foreign key (Ma_Duan) references DuAn

)
-------------------------------
if exists (select * from sysobjects where name = N'NhanVien')
drop table NhanVien
create table dbo.NhanVien
(
Ma_nv	nvarchar(10) not null,
ten_nv	nvarchar(10) null,
gioitinh	nvarchar(20) null,
SDT	int null,
maphong	nvarchar(20) null,
Ma_Duan	nvarchar(10)  not null

constraint PK_NhanVien primary key (Ma_nv),
)
---------------------------------------
if exists (select * from sysobjects where name = N'DuAn')
drop table DuAn
create table dbo.DuAn
(
Ma_Duan	nvarchar(10) not null,
Ten_duan	nvarchar(20) null,
noitrienkhai	nvarchar(50) null,

constraint PK_DuAn primary key (Ma_Duan)

)
----------------------------
