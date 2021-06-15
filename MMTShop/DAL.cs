using System;
using System.Collections.Generic;
using System.Reflection;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Dynamic;
using System.Linq;
using MMTShop;
using MMTShop.Interfaces;
using MMTShop.Models;

namespace DAL
{
    internal class DAL : IDAL
    {
        private readonly string _connectionString;
        public DAL(IConfiguration config)
        {
            _connectionString = ConfigurationExtensions.GetConnectionString(config, "MMTShop");
        }

        public IEnumerable<Product> GetFeaturedProducts()
        {
            using var conn = new SqlConnection(_connectionString);
            conn.Open();

            using var cmd = new SqlCommand("dbo.spsSelectFeaturedProducts", conn)
            {
                CommandType = CommandType.StoredProcedure, CommandTimeout = 600
            };
            SqlCommandBuilder.DeriveParameters(cmd);

            using var dr = cmd.ExecuteReader();
            var records = dr.Cast<IDataRecord>()
                .Select(r => new Product()
                {
                    ProductSKU = r["ProductSKU"].ToString(),
                    ProductName = r["ProductName"].ToString(),
                    ProductDescription = r["ProductDescription"].ToString(),
                    ProductUnitPrice = (decimal)r["ProductUnitPrice"]

                })
                .ToList().AsQueryable();

            dr.Close();

            return records;
        }

        public IEnumerable<Product> GetProductsByCategory(int ProductCategoryID)
        {
            using var conn = new SqlConnection(_connectionString);
            conn.Open();

            using var cmd = new SqlCommand("dbo.spsSelectProductsbyCategory", conn)
            {
                CommandType = CommandType.StoredProcedure, CommandTimeout = 600
            };
            SqlCommandBuilder.DeriveParameters(cmd);
            cmd.Parameters["@ProductCategoryID"].Value = (int)ProductCategoryID;

            using var dr = cmd.ExecuteReader();
            var records = dr.Cast<IDataRecord>()
                .Select(r => new Product()
                {
                    ProductSKU = r["ProductSKU"].ToString(),
                    ProductName = r["ProductName"].ToString(),
                    ProductDescription = r["ProductDescription"].ToString(),
                    ProductUnitPrice = (decimal)r["ProductUnitPrice"]

                })
                .ToList().AsQueryable();

            dr.Close();

            return records;
        }

        public IEnumerable<ProductCategory> GetProductCategories()
        {
            using var conn = new SqlConnection(_connectionString);
            conn.Open();

            using var cmd = new SqlCommand("dbo.spsSelectCategories", conn)
            {
                CommandType = CommandType.StoredProcedure, CommandTimeout = 600
            };
            SqlCommandBuilder.DeriveParameters(cmd);

            using var dr = cmd.ExecuteReader();
            var records = dr.Cast<IDataRecord>()
                .Select(r => new ProductCategory()
                {
                    ProductCategoryID = (int)r["ProductCategoryID"],
                    ProductCategoryName = r["CategoryName"].ToString()
                })
                .ToList().AsQueryable();

            dr.Close();

            return records;
        }
    }
}