using System.Windows.Forms;
using System.Drawing;

namespace QuanLyThuVien;

public class Form1 : Form
{
    public Form1()
    {
        InitializeForm();
    }

    private void InitializeForm()
    {
        Text = "QUẢN LÝ THƯ VIỆN";
        Size = new Size(1000, 600);
        StartPosition = FormStartPosition.CenterScreen;

        Label title = new Label();
        title.Text = "PHẦN MỀM QUẢN LÝ THƯ VIỆN";
        title.Font = new Font("Arial", 22, FontStyle.Bold);
        title.AutoSize = true;
        title.Location = new Point(250, 100);

        Controls.Add(title);
    }
}