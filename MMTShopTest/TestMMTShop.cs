using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using RestSharp;
using Newtonsoft.Json;

namespace MMTShopTest
{
    public class TestMMTShop
    {
        private const string MTTShopAPI = "http://localhost:7000/api/";
        
        public static void TestAll()
        {
            TestGetFeaturedProducts();
            TestGetProductsByCategory();
            TestGetProductCategories();
        }

        public static void TestGetFeaturedProducts()
        {
            var client = new RestClient(MTTShopAPI);
            
            Console.WriteLine("Testing Featured Products API");
            
            var request = new RestRequest("FeaturedProducts", Method.GET);
            var featuredProductsRequest = client.Execute<List<Product>>(request);

            if (featuredProductsRequest.IsSuccessful)
            {
                var products = JsonConvert.DeserializeObject<List<Product>>(featuredProductsRequest.Content);

                foreach (var product in products)
                {
                    Console.WriteLine($"{product.ProductSKU}, {product.ProductName}, {product.ProductDescription}, {product.ProductUnitPrice} ");
                }
            }
            else
            {
                Console.WriteLine(featuredProductsRequest.ErrorMessage);
            }
        }

        public static void TestGetProductsByCategory()
        {
            var client = new RestClient(MTTShopAPI);

            Console.WriteLine("");
            Console.WriteLine("Testing Products By Category API");
            
            var request = new RestRequest("ProductsByCategory/1", Method.GET);
            var productsByCategoryRequest = client.Execute<List<Product>>(request);

            if (productsByCategoryRequest.IsSuccessful)
            {
                var products = JsonConvert.DeserializeObject<List<Product>>(productsByCategoryRequest.Content);

                foreach (var product in products)
                {
                    Console.WriteLine($"{product.ProductSKU}, {product.ProductName}, {product.ProductDescription}, {product.ProductUnitPrice} ");
                }
            }
            else
            {
                Console.WriteLine(productsByCategoryRequest.ErrorMessage);
            }
        }

        public static void TestGetProductCategories()
        {
            var client = new RestClient(MTTShopAPI);

            Console.WriteLine("");
            Console.WriteLine("Testing Product Categories API");

            var request = new RestRequest("ProductCategories", Method.GET);
            var productCategoriesRequest = client.Execute<List<ProductCategory>>(request);

            if (productCategoriesRequest.IsSuccessful)
            {
                var productCategories = JsonConvert.DeserializeObject<List<ProductCategory>>(productCategoriesRequest.Content);

                foreach (var category in productCategories)
                {
                    Console.WriteLine($"{category.ProductCategoryID}, {category.ProductCategoryName}");
                }
            }
            else
            {
                Console.WriteLine(productCategoriesRequest.ErrorMessage);
            }
        }
    }
}
