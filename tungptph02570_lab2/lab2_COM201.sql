USE master
GO
------------------------------
IF  EXISTS ( 	SELECT * FROM sysdatabases 	WHERE name = N'tungptph02570_lab2' )
														-- NẾU TỒN TẠI DATABASE LAB2 TRONG HỆ THỐNG 
DROP DATABASE tungptph02570_lab2
GO														-- XÓA BỎ DB LAB2


CREATE DATABASE tungptph02570_lab2
														/*-- TẠO DATABASE CÓ TÊN LÀ LAB2
														VỚI CÁC THÔNG TIN*/ 
ON
( name = 'tungptph02570_lab2', FILENAME='D:\tungptph02570_lab2.mdf', --  TÊN LÀ: LAB2, ĐỊA CHỈ FILE LÀ: D:\LAB2.MDF
size= 5MB,									-- DUNG LƯỢNG DATABASE: 5 MB, 
maxsize=10MB,								--  DUNG LƯỢNG TỐI ĐA: 10 MB
filegrowth=1MB)								/*--KHI DÙNG HẾT DUNG LƯỢNG LÀ 5 MB FILE DL SẼ MỞ RỘNG THÊM 1 MB = 6MB,
													DÙNG HẾT 6MB LẠI MỞ RỘNG THÊM 1MB NỮA ... ĐẾN TỐI ĐA LÀ 10MB*/
LOG ON 
( name = 'tungptph02570_lab2_log', FILENAME='D:\tungptph02570_lab2.ldf',
size= 1MB,
maxsize=4MB,
filegrowth=1MB) 
GO
											/*-- TẠO TÀI KHOẢN ĐĂNG NHẬP TÊN LÀ LAB2, ĐỊA CHỈ FILE LƯU: d:\LAB2.LDF,
											 DUNG LƯỢNG 1MB, TỐI ĐA 4MB, MỨC TĂNG THÊM 1MB*/
 
 
----------------------------------------------

USE tungptph02570_lab2
GO
--------------------------------------------------
IF  EXISTS ( 	SELECT * FROM sysobjects 	WHERE name = N'KHACHHANG' )
DROP TABLE KHACHHANG

CREATE TABLE	dbo.KHACHHANG
(
	MA_KH		NVARCHAR(10) NOT NULL,
	HOTEN_KH	NVARCHAR (30) NULL,
	DIA_CHI		NVARCHAR (50) NULL,
	SODT		NVARCHAR (15) NULL,
												--NÊN KHAI BÁO DỮ LIỆU XONG THÌ THIẾT LẬP KHÓA	
	CONSTRAINT PK_KHACHHANG PRIMARY KEY (MA_KH)
	)
----------------------------------------------------

IF  EXISTS ( 	SELECT * FROM sysobjects 	WHERE name = N'TAIKHOAN' )
DROP TABLE TAIKHOAN

CREATE TABLE	dbo.TAIKHOAN
(
	SO_TK		NVARCHAR(12) NOT NULL,
	MA_TK		NVARCHAR(10) NOT NULL,
	KIEU_TK		NVARCHAR (50) NULL,
	NGAYMO_TK	DATE  NULL,
	SOTIEN		MONEY NULL
	
	CONSTRAINT PK_TAIKHOAN PRIMARY KEY (SO_TK)

	)
--------------------------------------------	
IF  EXISTS ( 	SELECT * FROM sysobjects 	WHERE name = N'GIAODICH' )
DROP TABLE GIAODICH
	
	
CREATE TABLE dbo.GIAODICH
(
	MA_GD		NVARCHAR(10) NOT NULL,
	SO_TK		NVARCHAR(12) NOT NULL,
	THOIGIAN_GD	DATE  NULL,
	SOTIEN_GD	MONEY NULL,
	MOTA_GD		NVARCHAR (50) NULL,
	SODU_TK		MONEY NULL
	
	CONSTRAINT PK_GIAODICH PRIMARY KEY (MA_GD)
	CONSTRAINT FK_GIAODICH FOREIGN KEY (SO_TK) REFERENCES TAIKHOAN
	
	)
	
------------------------------------------------
	
--- CAP NHAT DU LIEU VÀO BẢNG KHÁCH HÀNG

DELETE FROM KHACHHANG

INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00001',N'NGUYEN A')-- CHÈN VÀO CỘT MA_KH VÀ HOTEN_KH CÁC THÔNG TIN
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00002',N'NGUYEN B')
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00003',N'NGUYEN C')
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00004',N'NGUYEN D')
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00005',N'NGUYEN E')
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00006',N'NGUYEN F')
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00007',N'NGUYEN G')
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00008',N'NGUYEN H')
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00009',N'NGUYEN Y')
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00010',N'NGUYEN K')
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00011',N'NGUYEN L')
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00012',N'NGUYEN M')
INSERT INTO dbo.KHACHHANG (MA_KH, HOTEN_KH) VALUES (N'TK00013',N'NGUYEN N')



-- CHÈN DỮ LIỆU BẢNG TÀI KHOẢN

DELETE FROM TAIKHOAN
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100001',N'TK00001',N'CÁ NHÂN','02/13/2000',3000000)
-- CHÈN ĐẦY ĐỦ DỮ LIỆU CÁC CỘT TRONG BẢNG TÀI KHOẢN
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100002',N'TK00003',N'CÁ NHÂN','02/15/2000',5000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100003',N'TK00004',N'CÁ NHÂN','02/16/2000',6000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100004',N'TK00005',N'CÁ NHÂN','02/17/2000',7000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100005',N'TK00006',N'CÁ NHÂN','02/18/2000',8000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100006',N'TK00007',N'CÁ NHÂN','02/19/2000',9000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100007',N'TK00008',N'DOANH NGHIỆP','03/13/2000',1000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100008',N'TK00009',N'DOANH NGHIỆP','04/27/2000',2000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100009',N'TK00010',N'DOANH NGHIỆP','05/28/2000',30000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100010',N'TK00011',N'DOANH NGHIỆP','06/13/2000',300000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100011',N'TK00012',N'DOANH NGHIỆP','07/31/2000',4000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100012',N'TK00013',N'DOANH NGHIỆP','08/29/2000',3500000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100013',N'TK00001',N'DOANH NGHIỆP','09/23/2000',30700000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100014',N'TK00005',N'DOANH NGHIỆP','10/03/2000',56000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100015',N'TK00006',N'DOANH NGHIỆP','12/23/2000',9000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100016',N'TK00007',N'DOANH NGHIỆP','11/23/2000',1000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100017',N'TK00008',N'DOANH NGHIỆP','04/23/2000',1000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100018',N'TK00009',N'DOANH NGHIỆP','05/03/2000',4000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100019',N'TK00011',N'DOANH NGHIỆP','06/21/2000',6000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100020',N'TK00011',N'CÁ NHÂN','07/20/2000',9000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100021',N'TK00012',N'CÁ NHÂN','08/19/2000',7000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100022',N'TK00013',N'CÁ NHÂN','09/18/2000',9000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100023',N'TK00004',N'CÁ NHÂN','02/17/2000',5000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100024',N'TK00005',N'CÁ NHÂN','01/16/2000',4000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100025',N'TK00006',N'CÁ NHÂN','03/15/2000',3000000)
INSERT INTO dbo.TAIKHOAN VALUES (N'00002100026',N'TK00007',N'CÁ NHÂN','04/14/2000',1000000)


-------CHÈN DỮ LIỆU TRONG BẢNG GIAO DỊCH
DELETE FROM GIAODICH
INSERT INTO dbo.GIAODICH VALUES(N'GD00000001',N'00002100026', '02/04/2011', 100000,N'TRẢ NỢ',3000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000002',N'00002100025', '03/04/2011', 1400000,N'TRẢ NỢ',34000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000003',N'00002100024', '04/04/2011', 1300000,N'TRẢ NỢ',31000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000004',N'00002100023', '05/04/2011', 1200000,N'TRẢ NỢ',32000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000005',N'00002100022', '06/04/2011', 100000,N'TRẢ NỢ',33000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000006',N'00002100021', '07/04/2012', 100000,N'TRẢ NỢ',3400000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000007',N'00002100020', '08/04/2012', 1500000,N'TRẢ NỢ',35000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000008',N'00002100016', '09/04/2012', 100000,N'TRẢ NỢ',36000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000009',N'00002100016', '10/04/2012', 1500000,N'TRẢ NỢ',37000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000010',N'00002100019', '12/04/2012', 1500000,N'TRẢ NỢ',30800000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000011',N'00002100018', '02/03/2011', 1500000,N'TIỀN LƯƠNG',39000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000012',N'00002100017', '01/04/2011', 100000,N'TIỀN LƯƠNG',300100)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000013',N'00002100016', '02/05/2011', 100000,N'TIỀN LƯƠNG',300000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000014',N'00002100015', '03/06/2011', 15500000,N'TIỀN LƯƠNG',300000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000015',N'00002100014', '04/07/2011', 1400000,N'TIỀN LƯƠNG',30000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000016',N'00002100013', '05/08/2011', 1500000,N'TIỀN LƯƠNG',30004000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000017',N'00002100012', '06/09/2011', 1200000,N'TIỀN LƯƠNG',2000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000018',N'00002100011', '07/10/2011', 1100000,N'TIỀN LƯƠNG',1000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000019',N'00002100010', '08/11/2011', 1000000,N'TIỀN LƯƠNG',4000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000020',N'00002100009', '09/12/2012', 1900000,N'TIỀN LƯƠNG',300000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000021',N'00002100007', '10/01/2012', 1800000,N'THANH TOÁN DV',5000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000022',N'00002100006', '12/02/2012', 1500000,N'THANH TOÁN DV',600000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000023',N'00002100005', '11/03/2012', 1100000,N'THANH TOÁN DV',7000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000024',N'00002100004', '11/04/2012', 1200000,N'THANH TOÁN DV',8000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000025',N'00002100003', '12/05/2012', 1300000,N'THANH TOÁN DV',9000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000026',N'00002100002', '12/06/2012', 1400000,N'THANH TOÁN DV',10000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000027',N'00002100001', '12/07/2012', 1500000,N'THANH TOÁN DV',80500000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000028',N'00002100026', '12/08/2012', 1600000,N'THANH TOÁN DV',5000000)
INSERT INTO dbo.GIAODICH VALUES(N'GD00000029',N'00002100025', '02/09/2011', 1700000,N'THANH TOÁN DV',1000000)


------ BỔ SUNG DỮ LIỆU CHO BẢNG KHÁCH HÀNG

UPDATE dbo.KHACHHANG SET DIA_CHI =N'CẦU GIẤY,MỸ ĐÌNH, TỪ LIÊM, HÀ NỘI'


--THỰC HIỆN CÁC TRUY VẤN CƠ BẢN



--1. 1. Hiển thị thông tin bảng Khách Hàng.
select * from KHACH_HANG 
--1. 2. Hiển thị thông tin bảng Khách Hàng săp xếp họ tên theo a - z
Select * from KHACH_HANG 
- order by HOTEN_KH asc 
--1. 3. Hiển thị thông tin bảng Giao dịch.
select * from GIAO_DICH 
--1. 4. Hiển thị thông tin bảng Giao dịch sắp xếp theo số tiền giao dịch từ cao xuống thấp.
select * from GIAO_DICH 
-order by SOTIEN_GD desc


--2.1.1 -- THÔNG TIN CÁC TÀI KHOẢN CÓ KIỂU DOANH NGHIỆP

SELECT * FROM dbo.TAIKHOAN 
WHERE (KIEU_TK = N'DOANH NGHIỆP') --- CHÚ Ý VỚI DẠNH CHỮ TIẾNG VIỆT PHẢI NẰM TRONG VÙNG (N'')

--2.1.2 THÔNG TIN VỀ SỐ, MÃ , KIỂU, NGÀY CHO ĐỐI TƯỢNG LÀ CÁ NHÂN CÓ SẮP XẾP THEO THỜI GIAN GIẢM DẦN

SELECT  FROM TAI_KHOAN 
WHERE (KIEU_TK = )
ORDER BY DESC
--2.1.3 TÊN, ĐỊA CHỈ KHÁCH HÀNG TẠI HÀ NỘI SẮP XẾP THEO A-Z

SELECT  FROM 
WHERE  LIKE 
ORDER BY ASC

--2.1.4 THÔNG TIN KHÁCH HÀNG MỞ TK TRƯỚC THÁNG 6 NĂM 2000

SELECT FROM WHERE 


-
