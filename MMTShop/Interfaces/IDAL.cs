using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MMTShop.Models;

namespace MMTShop.Interfaces
{
    public interface IDAL
    {
        public IEnumerable<Product> GetFeaturedProducts();
        public IEnumerable<Product> GetProductsByCategory(int ProductCategoryID);
        public IEnumerable<ProductCategory> GetProductCategories();
    }
}
