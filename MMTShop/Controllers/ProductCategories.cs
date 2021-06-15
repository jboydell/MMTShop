using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using MMTShop.Interfaces;
using MMTShop.Models;

namespace MMTShop.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductCategoriesController : Controller
    {
        private readonly IDAL _dal;

        public ProductCategoriesController(IDAL dal)
        {
            _dal = dal;
        }

        /// <summary>
        /// Returns a list of Product Categories
        /// </summary>
        /// <returns>A list of Product Categories</returns>
        [HttpGet]
        public ActionResult<IEnumerable<ProductCategory>> Get()
        {
            try
            {
                var results = _dal.GetProductCategories();

                if (!results.Any())
                {
                    return NotFound();
                }

                return Ok(results);
            }
            catch (Exception e)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Database Failure");
            }
        }


    }
}
