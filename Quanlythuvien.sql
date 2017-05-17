create proc select_user 
as
begin
select *from TaiKhoan
end

select_user

-- load mã thủ thư lên cbo

create proc select_matt
as
begin
select matt
from ThuThu
end

select_matt

--- lay thong tin dau sach len dgv

alter proc select_dgvdausach
as
begin
select *from DauSach
end

select_dgvdausach

--- lay ma hd
create proc select_mahd(@ma varchar(10))
as
begin
select mahd,soluong
from ChiTietHoaDon
where masach = @ma
end

select_mahd 'ms01'

---thong tin hoa don

alter proc select_tthd(@masach varchar(10),@mahd varchar(10))
as
begin
select matt,ngaynhap,soluong
from ChiTietHoaDon,HoaDon
where ChiTietHoaDon.mahd=HoaDon.mahd and HoaDon.mahd=@mahd and ChiTietHoaDon.masach=@masach
end
 select_tthd 'ms02','hd01'

 --- xoa dau sach
 create  proc delete_dausach(@masach varchar(10))
 as
 begin
 delete DauSach
 where masach=@masach
 end

 create trigger xoadausach on DauSach instead of Delete
 as
 declare @masach varchar(10)
 begin
 select @masach=masach from deleted
 delete ChiTietHoaDon
 where masach=@masach
 delete DauSach
 where masach=@masach
 end

 ---- xoas hoa don
 create  proc delete_hoadon(@mahd varchar(10))
 as
 begin
 delete HoaDon
 where mahd=@mahd
 end


 -------- them dau sach
 alter proc insert_dausach(@masach varchar(10),@tensach nvarchar(50),@tacgia nvarchar(50),@nxb nvarchar(50),@theloai nvarchar(20),@vitri nvarchar(20))
 as
 begin
 insert DauSach
 values(@masach,@tensach,@nxb,@tacgia,@theloai,@vitri)
 end

 alter proc insert_hoadon(@mahd varchar(10),@ngaynhap datetime,@matt varchar(10))
 as
 begin
 insert HoaDon
 values(@mahd,@ngaynhap,@matt)
 end

 insert_hoadon 'ds','09/05/2017','tt01'

 create proc insert_chitiethoadon(@mahd varchar(10),@masach varchar(10),@soluong int)
 as
 begin
 insert ChiTietHoaDon
 values (@mahd,@masach,@soluong)
 end

 -------- sửa đầu sách
 create proc update_dausach(@masach varchar(10),@tensach nvarchar(50),@tacgia nvarchar(50),@nxb nvarchar(50),@theloai nvarchar(20),@vitri nvarchar(20))
 as
 begin update DauSach
 set tensach=@tensach,tacgia=@tacgia,nxb=@nxb,theloai=@theloai,vitri=@vitri
 where masach=@masach
 end

 create proc update_chitiethoadon(@mahd varchar(10),@masach varchar(10),@soluong int)
 as
 begin
 update ChiTietHoaDon
 set soluong=@soluong
 where mahd=@mahd and masach=@masach
 end

 alter proc update_hoadon(@mahd varchar(10),@ngaynhap Date,@matt varchar(10))
 as
 begin
 update HoaDon
 set ngaynhap=@ngaynhap,matt=@matt
 where mahd=@mahd
 end


