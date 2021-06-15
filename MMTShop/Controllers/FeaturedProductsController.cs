using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using MMTShop.Interfaces;
using MMTShop.Models;

namespace MMTShop.Controllers
{
    /// <summary>
    /// API methods related to Products
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    public class FeaturedProductsController : ControllerBase
    {
        private readonly IDAL _dal;

        public FeaturedProductsController(IDAL dal)
        {
            _dal = dal;
        }

        /// <summary>
        /// Returns a list of products that are currently featured.
        /// </summary>
        /// <returns>A list of Products</returns>
        [HttpGet]
        public ActionResult<IEnumerable<Product>> Get()
        {
            try
            {
                var results = _dal.GetFeaturedProducts();

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
