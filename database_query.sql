create database QLDAn;
use QLDAN;

-- drop database QLDAn;

-- drop table DEAN;
create table DEAN(
   TENDA  VARCHAR(30) not null,
   MADA  INT not null,
   DDIEM_DA  VARCHAR(15) not null,
   PHONG  INT not null,
   constraint UC_DEAN unique (MADA)
);
alter table DEAN
add constraint FK_DEAN_PHONGBAN foreign key (PHONG) 
references PHONGBAN(MAPHG);

insert into DEAN 
values 
('Sản phẩm X', 1, 'Vũng tàu', 5),
('Sản phẩm Y', 2,'Nha Trang', 5),
('Sản phẩm Z', 3,'TP HCM', 5),
('Tin học hóa', 10,'Hà Nội', 4),
('Cáp quang', 20,'TP HCM', 1),
('Đào tạo', 30,'Hà Nội', 4);

-- drop table PHONGBAN;
create table PHONGBAN(
   TENPHG VARCHAR(15),
   MAPHG  INT not null,
   TRPHG  INT not null,
   NG_NHANCHUC  DATE not null,
   constraint UC_PHONGBAN unique(MAPHG, TRPHG)
--    constraint PK_PHONGBAN primary key(MAPHG),
--    constraint FK_PHONGBAN_NHANVIEN foreign key (TRPHG) references NHANVIEN(MANV) 
);

alter table PHONGBAN
add constraint FK_PHONGBAN_NHANVIEN foreign key (TRPHG) 
references NHANVIEN(MANV);

insert into PHONGBAN
values
('Nghiên cứu', 5, 005, '1978/05/22'),
('Điều hành', 4, 008, '1985/01/01'),
('Quản lý', 1, 006, '1971/08/19');


create table NHANVIEN(
   HONV  VARCHAR(15),
   TENLOT  VARCHAR(15),
   TENNV  VARCHAR(15) not null,
   MANV  INT not null,
   NGSINH  DATE,
   DCHI  VARCHAR(30) not null,
   PHAI  VARCHAR(3),
   LUONG  FLOAT not null,
   MA_NQL  INT,
   PHG  INT not null,
   constraint UC_NHANVIEN unique (MANV, MA_NQL),
   constraint PK_NHANVIEN primary key (MANV)
);

alter table NHANVIEN
add constraint FK_NHANVIEN_NHANVIEN foreign key (MA_NQL) 
references NHANVIEN(MANV),
add constraint FK_NHANVIEN_PHONGBAN foreign key (PHG) references PHONGBAN(MAPHG);

insert into NHANVIEN
values 
('Đinh', 'Bá', 'Tiên', 009, '1960/02/11', '119 Cống Huỳnh, TP HCM', 'Nam', '30000', 005, 5),
('Nguyễn', 'Thanh', 'Tùng',  005, '1962/08/20', '222 Nguyễn Văn Cừ, TP HCM', 'Nam', '40000', 006, 5),
('Bùi', 'Ngọc', 'Hằng', 007 , '1954/3/11', '332 Nguyễn Thái Học', 'Nam', '25000', 001, 4)

create table DIADIEM_PHG(
   MAPHG  INT not null,
   DIADIEM  VARCHAR(15) not null,
   constraint PK_DIADIEM_PHG primary key(MAPHG, DIADIEM)
);

alter table DIADIEM_PHG
add constraint FK_DIADIEM_PHONGBAN foreign key (MAPHG) 
references PHONGBAN(MAPHG);

insert into DIADIEM_PHG
values 
(1, 'TPHCM'),
(4, 'HÀ NỘI'),
(5, 'TAU'),
(5, 'NHA TRANG'),
(5, 'TPHCM');


-- drop table THANNHAN;
create table THANNHAN(
   MA_NVIEN  int not null,
   TENTN  VARCHAR(15),
   PHAI  VARCHAR(3) not null,
   NGSINH  DATE,
   QUANHE  VARCHAR(15),
   constraint PK_THANNHAN primary key (MA_NVIEN, TENTN)
);
alter table THANNHAN
add constraint FK_THANNHAN_NHANVIEN foreign key (MA_NVIEN) 
references NHANVIEN(MANV);

insert into THANNHAN
values 
(005, 'Trinh', 'Nữ', '1976/04/05', 'Con gái'),
(005, 'Khang', 'Nam', '1973/10/25', 'Con trai'),
(005, 'Phương', 'Nữ', '1947/05/03', 'Vợ chồng'),
(001, 'Minh', 'Nam', '1932/02/29', 'Vợ chồng')

-- drop table PHANCONG;
create table PHANCONG(
   MA_NVIEN  INT not null,
   MADA  INT not null,
   STT  INT not null,
   THOIGIAN  FLOAT not null,
   constraint PK_PHANCONG primary key (MA_NVIEN, MADA, STT)
);
alter table PHANCONG
add constraint FK_PHANCONG_NHANVIEN foreign key (MA_NVIEN) references NHANVIEN(MANV),
add constraint FK_PHANCONG_CONGVIEC foreign key (MADA) references CONGVIEC(MADA);

insert into PHANCONG
values
	(009,1,1,'32'),
	(009,2,2, '8'),
	(004,3,1, '40'),
	(003,1,2, '20.0')
	
create table CONGVIEC(
   MADA  INT not null,
   STT  INT not null,
   TEN_CONG_VIEC  VARCHAR(50) not null,
   constraint PK_CONGVIEC primary key (MADA, STT)
--    constraint FK_CONGVIEC_DEAN foreign key (MADA) references DEAN(MADA)
);
alter table CONGVIEC
add constraint FK_CONGVIEC_DEAN foreign key (MADA) 
references DEAN(MADA);

insert into CONGVIEC
values
    (1, 1, 'Thiết kế sản phẩm X'),
	(1, 2, 'Thử nghiệm sảm phẩm X'),
	(2, 1, 'Sản xuất phẩm Y'),
	(2, 2, 'Quảng cáo sản phẩm Y'),
	(3, 1, 'Khuyến mãi sản phẩm Z')

--TRUY VẤN CƠ BẢN
-- Câu 3: Tìm các nhân viên có mức lương trên 25,000 ở phòng 4 hoặc các nhân viên có mức lương trên 30,000 ở phòng 5
SELECT *
FROM NHANVIEN
WHERE (LUONG > 25000 AND PHG = 4)
	OR (LUONG > 30000 AND PHG = 5)

-- Câu 4: Cho biết họ tên đầy đủ của các nhân viên ở TP HCM
SELECT	HONV, TENLOT, TENNV AS HoTen, DCHI
FROM	NHANVIEN
WHERE	NHANVIEN.DCHI LIKE N'%TP HCM%'

-- Câu 5: Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'
SELECT	HONV , TENLOT,  TENNV, AS HoTen, DCHI
FROM	NHANVIEN
WHERE	HONV LIKE N'N%'

-- Câu 6: Cho biết ngày sinh và địa chỉ của nhân viên Dinh Ba Tien
SELECT	NHANVIEN.NGSINH, DCHI
FROM	NHANVIEN
WHERE	HONV = N'Đinh' AND TENLOT = N'Bá' AND TENNV = N'Tiên'

-- Câu 7: Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965
SELECT	*
FROM	NHANVIEN
WHERE	YEAR(NGSINH) BETWEEN 1960 AND 1965

-- Câu 8: Cho biết các nhân viên và năm sinh của nhân viên
SELECT	HONV, TENLOT,  TENNV  AS HoTen, YEAR(NGSINH) NamSinh, DCHI
FROM	NHANVIEN

-- Câu 9: Cho biết các nhân viên và tuổi của nhân viên
SELECT	HONV, TENLOT, TENNV AS HoTen, YEAR(GETDATE()) - YEAR(NGSINH) AS Tuoi
FROM	NHANVIEN

--(join)
Với mỗi phòng ban, cho biết tên phòng ban và địa điểm phòng
SELECT	PHONGBAN.MAPHG, TENPHG, DIADIEM_PHG.DIADIEM
FROM	PHONGBAN, DIADIEM_PHG
WHERE	PHONGBAN.MAPHG = DIADIEM_PHG.MAPHG

(select p.MAPHG, TENPHG, dp.DIADIEM  from phongban p 
inner join diadiem_phg dp ON p.MAPHG = dp.MAPHG)

-- Câu 11: Tìm tên những người trưởng phòng của từng phòng ban
SELECT	HONV, TENLOT, TENNV  AS HoTen
FROM	PHONGBAN, NHANVIEN
WHERE	PHONGBAN.TRPHG = NHANVIEN.MANV

select p.TENPHG, n.TENNV from phongban p 
inner join nhanvien n ON p.TRPHG = n.MANV  


-- Câu 12: Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Nghiên cứu"
SELECT	HONV, TENLOT, TENNV AS HoTen, DCHI
FROM	PHONGBAN, NHANVIEN
WHERE	PHONGBAN.MAPHG = NHANVIEN.PHG AND TENPHG = N'Nghiên cứu'

(select p.MAPHG, n.DCHI, n.TENNV  from phongban p 
inner join nhanvien n ON p.MAPHG  = n.PHG  
where  TENPHG = N'Nghiên cứu')

-- Câu 13: Với mỗi đề án ở Hà Nội, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó
SELECT	DEAN.TENDA, TENPHG, HONV,TENLOT, TENNV AS HoTen, NG_NHANCHUC
FROM	PHONGBAN, NHANVIEN, DEAN
WHERE	PHONGBAN.TRPHG = NHANVIEN.MANV AND PHONGBAN.MAPHG = DEAN.PHONG
	AND DEAN.DDIEM_DA = N'Hà Nội'
	
(select d.TENDA, p.TENPHG, n.HONV, n.TENNV, p.NG_NHANCHUC from dean d 
inner join phongban p 
on d.PHONG = p.MAPHG 
inner join nhanvien n 
on d.PHONG = n.PHG 
where DDIEM_DA = N'Hà Nội')

-- Câu 15: Với mỗi nhân viên, cho biết họ tên nhân viên và họ tên người quản lý trực tiếp của nhân viên đó
SELECT	nv.HONV, nv.TENLOT, nv.TENNV AS HoTenNV, nql.HONV, nql.TENLOT, nql.TENNV AS HoTenNQL
FROM	NHANVIEN nv, NHANVIEN nql
WHERE	nv.MA_NQL = nql.MANV

SELECT	nv.HONV, nv.TENLOT, nv.TENNV  AS HoTenNV, nql.HONV, nql.TENLOT, nql.TENNV  AS HoTenNQL
FROM	NHANVIEN nv LEFT JOIN NHANVIEN nql ON nv.MA_NQL = nql.MANV

-- Câu 16: Với mỗi nhân viên, cho biết họ tên của nhân viên đó, họ tên người trưởng phòng và họ tên người quản lý trực tiếp của nhân viên đó
SELECT	nv.HONV, nv.TENLOT, nv.TENNV AS HoTenNV, nql.HONV, nql.TENLOT, nql.TENNV AS HoTenNQL, tp.HONV + ' ' + tp.TENLOT + ' ' + tp.TENNV + ' ' AS HoTenTP
FROM	NHANVIEN nv, NHANVIEN nql, PHONGBAN pb, NHANVIEN tp
WHERE	nv.MA_NQL = nql.MANV AND pb.MAPHG = nv.PHG AND pb.TRPHG = tp.MANV

SELECT	nv.HONV , nv.TENLOT, nv.TENNV, AS HoTenNV, nql.HONV, nql.TENLOT, nql.TENNV AS HoTenNQL, tp.HONV + ' ' + tp.TENLOT + ' ' + tp.TENNV + ' ' AS HoTenTP
FROM	NHANVIEN nv LEFT JOIN NHANVIEN nql ON nv.MA_NQL = nql.MANV, PHONGBAN pb, NHANVIEN tp
WHERE	pb.MAPHG = nv.PHG AND pb.TRPHG = tp.MANV

-- Câu 17: Tên những nhân viên phòng số 5 có tham gia vào đề án "Sản phẩm X" và nhân viên này do "Nguyễn Thanh Tùng" quản lý trực tiếp
SELECT	nv.*
FROM	NHANVIEN nv, NHANVIEN nql, PHONGBAN pb, PHANCONG pc, DEAN da
WHERE	nv.MA_NQL = nql.MANV
	AND nql.HONV = N'Nguyễn' AND nql.TENLOT = N'Thanh' AND nql.TENNV = N'Tùng'
	AND pb.MAPHG = nv.PHG AND nv.MANV = pc.MA_NVIEN AND pc.MADA = da.MADA
	AND TENDA = N'Sản phẩm X'

-- Câu 18: Cho biết tên các đề án mà nhân viên Đinh Bá Tiên đã tham gia
SELECT	TENDA
FROM	NHANVIEN nv, PHANCONG pc, DEAN da
WHERE	nv.MANV = pc.MA_NVIEN AND pc.MADA = da.MADA
	AND nv.HONV = N'Đinh' AND nv.TENLOT = N'Bá' AND nv.TENNV = N'Tiên'
	
-- CÂU LỆNH UPDATE	
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;

-- CÂU LIMIT GIỚI HẠN DÒNG SẼ TRẢ VỀ:
SELECT column_name(s)
FROM table_name
WHERE condition
LIMIT number;

-- HÀM COUNT DÙNG ĐỂ ĐẾM
SELECT COUNT(column_name)
FROM table_name
WHERE condition;
-- TÍNH TỔNG
SELECT SUM(column_name)
FROM table_name
WHERE condition;

-- LIKE Ý nghĩa
WHERE CustomerName LIKE 'a%' Tìm chuỗi bắt đầu bằng "a"
WHERE CustomerName LIKE '%a' Tìm chuỗi kết thúc bằng "a"
WHERE CustomerName like '%kmin%' -- Tìm chuỗi có “kmin” xuất hiện ở bất cứ đâu
WHERE CustomerName LIKE '_r%'  -- Tìm chuỗi có “r” ở ký tự thứ 2
WHERE CustomerName LIKE 'a_%' -- Tìm chuỗi có “a” ở ký tự đầu tiên và có ít nhất 2 ký tự.
WHERE CustomerName like 'a__%' -- Tìm chuỗi có “a” ở ký tự đầu tiên và có ít nhất 3ký tự.
WHERE ContactName LIKE 'a%o' -- Tìm chuỗi có “a” ở ký tự đầu tiên và “o” ở cuối cùng.

-- ORDER BY được dùng để sắp xếp dữ liệu theo thứ tự tăng dần hoặc giảm dần.
-- Dùng ASC để sắp tăng dần hoặc DESC để sắp giảm dần
SELECT column1, column2, ...
FROM table_name
ORDER BY column1, column2, ... ASC|DESC;