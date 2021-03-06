﻿USE MASTER
GO
----------
IF  EXISTS ( 	SELECT * FROM sysdatabases 	WHERE name = N'LAB4' )
														-- NẾU TỒN TẠI DATABASE LAB2 TRONG HỆ THỐNG 
DROP DATABASE LAB4
GO														-- XÓA BỎ DB LAB2


CREATE DATABASE LAB4
														/*-- TẠO DATABASE CÓ TÊN LÀ LAB2
														VỚI CÁC THÔNG TIN*/ 
ON
( name = 'LAB4', FILENAME='G:\LAB4.mdf', --  TÊN LÀ: LAB2, ĐỊA CHỈ FILE LÀ: D:\LAB2.MDF
size= 5MB,									-- DUNG LƯỢNG DATABASE: 5 MB, 
maxsize=10MB,								--  DUNG LƯỢNG TỐI ĐA: 10 MB
filegrowth=1MB)								/*--KHI DÙNG HẾT DUNG LƯỢNG LÀ 5 MB FILE DL SẼ MỞ RỘNG THÊM 1 MB = 6MB,
													DÙNG HẾT 6MB LẠI MỞ RỘNG THÊM 1MB NỮA ... ĐẾN TỐI ĐA LÀ 10MB*/
LOG ON 
( name = 'LAB4_log', FILENAME='G:\LAB4.ldf',
size= 1MB,
maxsize=4MB,
filegrowth=1MB) 
GO
											/*-- TẠO TÀI KHOẢN ĐĂNG NHẬP TÊN LÀ LAB2, ĐỊA CHỈ FILE LƯU: d:\LAB2.LDF,
											 DUNG LƯỢNG 1MB, TỐI ĐA 4MB, MỨC TĂNG THÊM 1MB*/
 
 
----------------------------------------------

USE LAB4
GO
--BẢNG KHOA -----------------------

IF  EXISTS ( 	SELECT * FROM sysobjects 	WHERE name = N'KHOA' )
DROP TABLE KHOA

CREATE TABLE dbo.KHOA
(
    MAKHOA        CHAR(5)        NOT NULL,
    TENKHOA        NVARCHAR(50)    NOT NULL,
	
	CONSTRAINT PK_KHOA_MAKHOA PRIMARY KEY (MAKHOA)
        )

--BANG SINH VIEN ------------------------------------------------

IF  EXISTS ( 	SELECT * FROM sysobjects 	WHERE name = N'SINHVIEN' )
DROP TABLE SINHVIEN

CREATE TABLE	dbo.SINHVIEN
(
    HOSV        NVARCHAR(50)    NOT NULL,
    TENSV        NVARCHAR(50)    NOT NULL,
    MASV        CHAR(5)        NOT NULL,
    NGAYSINH    DATETIME,
    PHAI        CHAR(3),
    MAKHOA        CHAR(5),
	CONSTRAINT PK_SINHVIEN_MASV PRIMARY KEY (MASV),
	CONSTRAINT FK_SINHVIEN_MAKHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
        ) 


--- BANG MON

IF  EXISTS ( 	SELECT * FROM sysobjects 	WHERE name = N'MONHOC' )
DROP TABLE MONHOC

CREATE TABLE dbo.MONHOC
(
    TENMH        NVARCHAR(50)    NOT NULL,
    MAMH        CHAR(5)        NOT NULL,
    SOTIET        INT,
	
	CONSTRAINT PK_MONHOC_MAMH PRIMARY KEY (MAMH)
        )

-- BANG KET QUA
IF  EXISTS ( 	SELECT * FROM sysobjects 	WHERE name = N'KETQUA' )
DROP TABLE KETQUA
 
CREATE TABLE dbo.KETQUA
(
    MASV        CHAR(5)        NOT NULL,
    MAMH        CHAR(5)        NOT NULL,
    LANTHI        DECIMAL        NOT NULL,
    DIEM        DECIMAL        NOT NULL,

	CONSTRAINT PK_KETQUA_MASV_MAMH_LANTHI PRIMARY KEY (MASV,MAMH,LANTHI),
	CONSTRAINT FK_KETQUA_MASV FOREIGN KEY (MASV) REFERENCES SINHVIEN(MASV),
	CONSTRAINT FK_KETQUA_MAMH FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
        )

-------------------
----------------- YÊU CẦU:

--1.1: XOA CAC RANG BUOC KHOA NGOAI THAM CHIEU DEN BANG SINHVIEN VA BANG MONHOC
alter table KETQUA
drop constraint FK_KETQUA_MASV

alter table KETQUA
drop constraint FK_KETQUA_MAMH

SELECT * FROM SINHVIEN
--1.2: XOA BANG KHOA VA MONHOC
 DROP TABLE KHOA
 DROP TABLE MONHOC

--1.3: TAO LAI CAC BANG VA CAC KHOA NGOAI DA XOA O CAU 1 VA 2
CREATE TABLE dbo.KHOA
(
    MAKHOA        CHAR(5)        NOT NULL,
    TENKHOA        NVARCHAR(50)    NOT NULL,
	
	CONSTRAINT PK_KHOA_MAKHOA PRIMARY KEY (MAKHOA)
        )
  CREATE TABLE dbo.MONHOC
(
    TENMH        NVARCHAR(50)    NOT NULL,
    MAMH        CHAR(5)        NOT NULL,
    SOTIET        INT,
	
	CONSTRAINT PK_MONHOC_MAMH PRIMARY KEY (MAMH)
        )
--1.4: NHAP DU LIEU CHO TAT CA CAC BANG

INSERT INTO KHOA values('CNTT','Cong Nghe Thong tin')
INSERT INTO KHOA values('QTKD','Quan Tri Kinh Doanh')
INSERT INTO KHOA values('DTVT','Dien Tu Vien Thong')
INSERT INTO KHOA values('AVAN','Khoa anh Van')

SELECT * FROM KHOA
-----------------------------

INSERT INTO SINHVIEN values('Tran Minh','Son','S001','01/05/1985','Nam','CNTT')
INSERT INTO SINHVIEN values('Nguyen Quoc','Bao','S002','03/16/1986','Nam','CNTT')
INSERT INTO SINHVIEN values('Phan Anh','Tung','S003','12/29/1983','Nam','QTKD')
INSERT INTO SINHVIEN values('Bui Thi anh','Thu','S004','01/02/1985','Nu','QTKD')
INSERT INTO SINHVIEN values('Le Thi Lan','Anh','S005','03/07/1987','Nu','DTVT')
INSERT INTO SINHVIEN values('Nguyen Thi','Lam','S006','11/11/1984','Nu','DTVT')
INSERT INTO SINHVIEN values('Phan Thi','Ha','S007','03/07/1988','Nu','CNTT')
INSERT INTO SINHVIEN values('Tran The','Dung','S008','11/10/1985','Nam','CNTT')

SELECT * FROM SINHVIEN
----------------------------------------

INSERT INTO MONHOC values('Ke Toan Tai Chinh','KTTC',45)
INSERT INTO MONHOC values('Toan Cao Cap','TCC',60)
INSERT INTO MONHOC values('Co So Du Lieu','CSDL',45)
INSERT INTO MONHOC values('Ky Thuat Lap Trinh','KTLT',60)
INSERT INTO MONHOC values('Tin Hoc Van Phong','THVP',30)
INSERT INTO MONHOC values('Anh Van','AV',45)
INSERT INTO MONHOC values('Tri Tue Nhan Tao','TTNT',45)

SELECT * FROM MONHOC
---------------------------

INSERT INTO KETQUA values('S001','TCC',1,5.5)
INSERT INTO KETQUA values('S002','CSDL',1,3)
INSERT INTO KETQUA values('S008','AV',1,7)
INSERT INTO KETQUA values('S002','CSDL',2,6)
INSERT INTO KETQUA values('S003','KTTC',1,4.5)
INSERT INTO KETQUA values('S004','AV',1,8)
INSERT INTO KETQUA values('S004','THVP',1,3.5)
INSERT INTO KETQUA values('S006','TCC',1,5)
INSERT INTO KETQUA values('S001','CSDL',1,4)
INSERT INTO KETQUA values('S007','AV',1,2)
INSERT INTO KETQUA values('S004','THVP',2,7.5)
INSERT INTO KETQUA values('S007','KTLT',1,6)
INSERT INTO KETQUA values('S007','AV',2,9)
	 
SELECT * FROM KETQUA
--------------------------------

--1.5: XOA KET QUA CUA SINH VIEN CO MA S001
SELECT * FROM KETQUA
DELETE FROM KETQUA WHERE MASV ='S001'

--1.6: CHEN LAI CAC BO CUA SINH VIEN S001 VUA XOA O CAU 7
INSERT INTO KETQUA VALUES('S001', 'CSDL',2,9)
--1.7: SUA SINH VIEN 'NGUYEN THI LAM' THANH 'NGUYEN THANH SON' VA PHAI THANH 'NAM'
SELECT * FROM dbo.SINHVIEN
UPDATE SINHVIEN SET HOSV='NGUYEN '
WHERE MASV ='S006'
UPDATE SINHVIEN SET TENSV='THANH SON '
WHERE MASV ='S006'

UPDATE SINHVIEN SET PHAI='Nam'
WHERE MASV='S006'
--1.8: CHUYEN SINH VIEN 'LE THI LAN ANH' SANG KHOA CNTT
UPDATE SINHVIEN SET MAKHOA='CNTT'
WHERE MASV='S005'
--2.1: CHO BIET KET QUA HOC TAP CUA SINH VIEN CO MA S007

SELECT * FROM KETQUA WHERE MASV='S007'
--2.2: LIET KE NHUNG SINH VIEN SINH VAO NGAY 07 THANG 03

SELECT * FROM SINHVIEN
WHERE DAY(NGAYSINH) ='07'AND MONTH(NGAYSINH)='03'
--2.3: CHO BIET DANH SACH SINH VIEN MA HO CO CHUA CHU : NGUYỄN
SELECT * FROM SINHVIEN
WHERE  HOSV LIKE  N'NGUYEN%'

--2.4: LIET KE NHUNG SINH VIEN TU 22 TUOI TRO LEN
SELECT * FROM SINHVIEN WHERE YEAR(NGAYSINH) < '1991'
--2.5: CHO BIET SINH VIEN NAO TRƯỢT MON CSDL O LAN THI THU NHAT

SELECT * FROM KETQUA WHERE LANTHI= '1'  AND DIEM < '4'
--2.6: DEM SO LUONG SINH VIEN CUA KHOA 'QUAN TRI KINH DOANH'
SELECT * FROM SINHVIEN
SELECT COUNT(*) AS [TONG SO SV] FROM SINHVIEN WHERE MAKHOA='QTKD'

--2.7: DEM SO LUONG SINH VIEN CUA TUNG KHOA

--2.8: CHO BIET DIEM THAP NHAT CUA MOI MON HOC

--3.1: CHO BIET TEN KHOA NAO KHONG CO SINH VIEN ( Not in)
SELECT TENKHOA FROM khoa 
WHERE KHOA.MAKHOA NOT IN (SELECT SINHVIEN.MAKHOA FROM SINHVIEN)

--3.2: CHO BIET DANH SACH SINH VIEN SINH VIEN CHUA HOC MON NAO, THONG TIN GOM HO, TEN, NGAY SINH, TEN KHOA

SELECT * FROM SINHVIEN 
INNER JOIN KHOA ON SINHVIEN.MAKHOA = KHOA.MAKHOA
WHERE SINHVIEN.MASV NOT IN ( SELECT KETQUA.MASV FROM KETQUA )

--3.2: CHO BIET DANH SACH SINH VIEN SINH VIEN CHUA HOC MON NAO, THONG TIN GOM HO, TEN, NGAY SINH, TEN KHOA

SELECT * FROM SINHVIEN 
INNER JOIN KHOA ON SINHVIEN.MAKHOA = KHOA.MAKHOA
WHERE SINHVIEN.MASV not in ( SELECT KETQUA.MASV FROM KETQUA )

--3.3: CHO BIET TEN SINH VIEN DUOC DIEM CAO NHAT
SELECT SINHVIEN.HOSV ,SINHVIEN.TENSV ,KETQUA.DIEM , MONHOC.MAMH  FROM  KETQUA
INNER JOIN MONHOC ON MONHOC.MAMH = KETQUA.MAMH
INNER JOIN SINHVIEN ON KETQUA.MASV = SINHVIEN.MASV
AND diem =(SELECT MAX(diem) FROM KETQUA)

--3.4: CHO BIET DIEM TRUNG BINH, DIEM LON NHAT, DIEM NHO NHAT LAN THU NHAT CUA TUNG SINH VIEN.
--   THONG TIN GOM TENSV, TENKHOA, DIEMTB
SELECT HOSV, TENSV , TENKHOA , MAX(diem) AS 'Điểm Max' , MIN(diem) AS 'Điểm Min' , AVG(Diem) AS 'Điểm TB' 
FROM SINHVIEN 
INNER JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV
INNER JOIN KHOA ON KHOA.MAKHOA = SINHVIEN.MAKHOA
GROUP BY TENSV,TENKHOA, HOSV
-----------------------------------------------------
