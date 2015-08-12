use master
go
----------------------

If exists (select * from sysdatabases where name = N'tungptph02570_lab7')

Drop database tungptph02570_lab7
go
--------------------------------

Create database tungptph02570_lab7
On
(name = 'tungptph02570_lab7', filename = 'D:\tungptph02570_lab7.mdf',
size = 10mb,
maxsize = 10mb,
filegrowth = 1mb)

log on
(name = 'tungptph02570_lab7', filename = 'D:\tungptph02570_lab7.ldf',
size = 1mb,
maxsize = 4mb,
filegrowth = 1mb)
Go
----------------------------
Use tungptph02570_lab7
Go
----------------------------
If exists (select * from sysobjects where name = 'TruSo')

Drop table TruSo
Create table dbo.TruSo
(
Ma_TS nvarchar(10) not null,
Ten_TS nvarchar(50) not null,
Dia_Chi nvarchar(50) null

Constraint PK_TruSo primary key (Ma_TS)
)

-----------------------------

If exists (select * from sysobjects where name = 'DuAn')

Drop table DuAn
Create table dbo.DuAn
(
Ma_DA nvarchar(10) not null,
Ten_DA nvarchar(50) not null,
Noi_Trien_Khai nvarchar(50) null,
Ngay_BD datetime null,
Ngay_KT datetime null

constraint PK_DuAn primary key (Ma_DA)
)
-----------------------------

If exists (select * from sysobjects where name = 'PhongBan')

Drop table PhongBan
Create table dbo.PhongBan
(
Ma_PB nvarchar(10) not null,
Ten_PB nvarchar(50) not null,
Dia_chi nvarchar(50) null,
Dien_Thoai int null

Constraint PK_PhongBan primary key (Ma_PB)
)

----------------------------
If exists (select * from sysobjects where name = 'Phongban_Truso')

Drop table Phongban_Truso
Create table dbo.Phongban_Truso
(
Ma_PB nvarchar(10) not null,
Ma_TS nvarchar(10) not null

Constraint PK_PhongBan_TruSo primary key (Ma_PB, Ma_TS)
Constraint FK_PhongBan_TruSo_PhongBan foreign key (Ma_PB) references PhongBan,
Constraint FK_PhongBan_TruSo_TruSo foreign key (Ma_TS) references TruSo,
)

----------------------------
If exists (select * from sysobjects where name = 'NhanVien')

Drop table NhanVien
Create table dbo.NhanVien
(
Ma_NV nvarchar(10) not null,
Ten_NV nvarchar(50) not null,
Ma_PB nvarchar(10) not null,
Dia_Chi Datetime null,
Dien_Thoai int null,
Ten_CV nvarchar(50) null

Constraint PK_NhanVien primary key (Ma_NV)
Constraint FK_NhanVien_PhongBan foreign key (Ma_PB) references PhongBan
)

------------------------------
If exists (select * from sysobjects where name = 'NhanVien_DuAn')

Drop table NhanVien_DuAn
Create table dbo.NhanVien_DuAn
(
Ma_NV nvarchar(10) not null,
Ma_DA nvarchar(10) not null

Constraint PK_NhanVien_DuAn primary key (Ma_NV, Ma_DA)
Constraint FK_NhanVien_DuAn_NhanVien foreign key (Ma_NV) references NhanVien,
Constraint FK_PhongBan_DuAn_DuAn foreign key (Ma_DA) references DuAn
)


-----------------------------
If exists (select * from sysobjects where name = 'PhongBan_DuAn')

Drop table PhongBan_DuAn
Create table dbo.PhongBan_DuAn
(
Ma_PB nvarchar(10) not null,
Ma_DA nvarchar(10) not null

Constraint PK_PhongBan_DuAn primary key (Ma_PB, Ma_DA)
Constraint FKPhongBan_DuAn1 foreign key (Ma_PB) references PhongBan,
Constraint FK_PhongBan_DuAn2 foreign key (Ma_DA) references DuAn
)
-----------------------------------
