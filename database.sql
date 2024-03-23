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
--    constraint PK_DEAN primary key (MADA),
--    constraint FK_DEAN_PHONGBAN foreign key (PHONG) references PHONGBAN(MAPHG) 
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
--    constraint FK_NHANVIEN_NHANVIEN foreign key (MA_NQL) references NHANVIEN(MANV),
--    constraint FK_NHANVIEN_PHONGBAN foreign key (PHG) references PHONGBAN(MAPHG)
);

alter table NHANVIEN
add constraint FK_NHANVIEN_NHANVIEN foreign key (MA_NQL) 
references NHANVIEN(MANV),
add constraint FK_NHANVIEN_PHONGBAN foreign key (PHG) references PHONGBAN(MAPHG);

insert into NHANVIEN
values 
('Đinh', 'Bá', 'Tiên', 009, '1960/02/11', '119 Cống Huỳnh, TP HCM', 'Nam', '30000', 005, 5),
('Nguyễn', 'Thanh', 'Tùng',  005, '1962/08/20', '222 Nguyễn Văn Cừ, TP HCM', 'Nam', '40000', 006, 5),
('Bùi', 'Ngọc', 'Hằng', 007 , '1954/3/11', '332 Nguyễn Thái Học', 'Nam', '25000', 001, 4),
('Lê', 'Quỳnh', 'Như',  001, '1967/02/01', '291 Hồ Văn Huế, TP HCM', 'Nữ', '43000', 006, 4),
('Nguyễn', 'Mạnh', 'Hùng',  004, '1967/03/04', '95 Bà Rịa, Vũng Tàu', 'Nam', '38000', 005, 5),
('Trần', 'Thanh', 'Tâm',  003, '1957/05/04', '34 Mai Thị Lự, Tp HCM', 'Nam', '25000', 005, 4),
('Trần', 'Hồng', 'Quang',  008, '1967/09/01', '80 Lê Hồng Phong, Tp HCM', 'Nam', '25000', 001, 1),
('Phạm', 'Văn', 'Vinh', 006, '1965/01/01', '45 Trưng Vương, Hà Nội', 'Nữ', '55000', null , 1);



create table DIADIEM_PHG(
   MAPHG  INT not null,
   DIADIEM  VARCHAR(15) not null,
   constraint PK_DIADIEM_PHG primary key(MAPHG, DIADIEM)
--    constraint FK_DIADIEM_PHONGBAN foreign key (MAPHG) references PHONGBAN(MAPHG) 
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
--    constraint FK_THANNHAN_NHANVIEN foreign key (MA_NVIEN) references NHANVIEN(MANV)
);

alter table THANNHAN
add constraint FK_THANNHAN_NHANVIEN foreign key (MA_NVIEN) 
references NHANVIEN(MANV);

insert into THANNHAN
values 
(005, 'Trinh', 'Nữ', '1976/04/05', 'Con gái'),
(005, 'Khang', 'Nam', '1973/10/25', 'Con trai'),
(005, 'Phương', 'Nữ', '1947/05/03', 'Vợ chồng'),
(001, 'Minh', 'Nam', '1932/02/29', 'Vợ chồng'),
(009, 'Tiến', 'Nam', '1978/01/01', 'Con trai'),
(009, 'Châu', 'Nữ', '1978/12/30', 'Con gái'),
(009, 'Phương', 'Nữ', '1975/05/05', 'Vợ chồng');



-- drop table PHANCONG;
create table PHANCONG(
   MA_NVIEN  INT not null,
   MADA  INT not null,
   STT  INT not null,
   THOIGIAN  FLOAT not null,
   constraint PK_PHANCONG primary key (MA_NVIEN, MADA, STT)
--    constraint FK_PHANCONG_NHANVIEN foreign key (MA_NVIEN) references NHANVIEN(MANV),
--    constraint FK_PHANCONG_CONGVIEC foreign key (MADA) references CONGVIEC(MADA),
);

alter table PHANCONG
add constraint FK_PHANCONG_NHANVIEN foreign key (MA_NVIEN) references NHANVIEN(MANV),
add constraint FK_PHANCONG_CONGVIEC foreign key (MADA) references CONGVIEC(MADA);

insert into PHANCONG
values
	(009,1,1,'32'),
	(009,2,2, '8'),
	(004,3,1, '40'),
	(003,1,2, '20.0'),
	(003,2,1, '20.0'),
	(008,10,1, '35'),
	(008,10,1, '35'),
	(001,30,1, '20'),
	(001,20,1, '15'),
	(006,20,1, '30'),
	(005,3,1, '10'),
	(005,10,2, '10'),
	(005,20,1, '10'),
	(007,30,2, '30'),
	(007,10,2, '10');
	


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
	(3, 1, 'Khuyến mãi sản phẩm Z'),
	(10, 1, 'Tin học hóa phòng nhân sự'),
	(10, 2, 'Tin học hóa phòng kinh doanh'),
	(20, 1, 'Lăp đặt cáp quang'),
	(30, 1, 'Đào tạo nhân viên Marketing'),
	(30, 2, 'Đào tạo chuyên viên thiết kế');


select * from QLDAn;







