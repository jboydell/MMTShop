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
    public class ProductsByCategoryController : Controller
    {
        private readonly IDAL _dal;

        public ProductsByCategoryController(IDAL dal)
        {
            _dal = dal;
        }
        
        /// <summary>
        /// Returns a list of Products that are in the supplied Product Category.
        /// </summary>
        /// <param name="id"></param>
        /// <returns>A list of Products</returns>
        [HttpGet("{id:int}")]
        public ActionResult<IEnumerable<Product>> Get(int id)
        {
            try
            {
                var results = _dal.GetProductsByCategory(id);

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
