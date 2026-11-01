using System;
using System.Windows.Forms;
using QuanLyThuVien.Data;

namespace QuanLyThuVien
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            ApplicationConfiguration.Initialize();

            try
            {
                Database.Initialize();
                
                Application.Run(new Form1());
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    "Không thể khởi tạo Database!\n\n" + ex.Message,
                    "Lỗi Database",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error
                );
            }
        }
    }
}