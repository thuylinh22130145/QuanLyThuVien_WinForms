using System;
using System.IO;
using Dapper;
using Microsoft.Data.Sqlite;

namespace QuanLyThuVien.Data
{
    public static class Database
    {
        private static readonly string DatabasePath =
            Path.Combine(AppContext.BaseDirectory, "database.sqlite");
        
        private static readonly string ConnectionString =
            new SqliteConnectionStringBuilder
            {
                DataSource = DatabasePath,
                ForeignKeys = true
            }.ToString();
        
        public static SqliteConnection GetConnection()
        {
            return new SqliteConnection(ConnectionString);
        }
        
        public static void Initialize()
        {
            string schemaPath = Path.Combine(
                AppContext.BaseDirectory,
                "Database",
                "schema.sql"
            );

            if (!File.Exists(schemaPath))
            {
                throw new FileNotFoundException(
                    "Không tìm thấy file schema.sql!",
                    schemaPath
                );
            }
            
            string sql = File.ReadAllText(schemaPath);
            
            using (var connection = GetConnection())
            {
                connection.Open();
                connection.Execute(sql);
            }
        }
    }
}