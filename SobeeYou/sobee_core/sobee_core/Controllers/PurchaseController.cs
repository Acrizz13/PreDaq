﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using sobee_core.Models.AzureModels;
using sobee_core.Models;
using Microsoft.EntityFrameworkCore;

namespace sobee_core.Controllers {
    public class PurchaseController : Controller {

        // GET: Purchase

        private readonly SobeecoredbContext _context;
        private readonly UserManager<ApplicationUser> _userManager;
        private int shoppingCartID;


        public PurchaseController(SobeecoredbContext context, UserManager<ApplicationUser> userManager) {
            _context = context;
            _userManager = userManager;
        }




        public IActionResult Index(decimal? minPrice, decimal? maxPrice, string sortBy) {
            var products = _context.Tproducts.AsQueryable();

            // Filter by price range
            if (minPrice.HasValue) {
                products = products.Where(p => p.DecPrice >= minPrice.Value);
            }
            if (maxPrice.HasValue) {
                products = products.Where(p => p.DecPrice <= maxPrice.Value);
            }

            // Sort the products
            switch (sortBy) {
                case "price-asc":
                    products = products.OrderBy(p => p.DecPrice);
                    break;
                case "price-desc":
                    products = products.OrderByDescending(p => p.DecPrice);
                    break;
                case "rating-asc":
                    products = products.OrderBy(p => p.Treviews.Any() ? p.Treviews.Average(r => r.IntRating) : 0);
                    break;
                case "rating-desc":
                    products = products.OrderByDescending(p => p.Treviews.Any() ? p.Treviews.Average(r => r.IntRating) : 0);
                    break;
                default:
                    // Default sorting logic
                    break;
            }

            var productsDto = products.Select(p => new ProductDTO {
                intProductID = p.IntProductId,
                strName = p.StrName,
                decPrice = (decimal)p.DecPrice,
                strStockAmount = p.StrStockAmount,
                AverageRating = p.Treviews.Any() ? Math.Round(p.Treviews.Average(r => (double)r.IntRating), 1) : 0,
                strDescription = p.strDescription
            }).ToList();


            return View(productsDto);
        }

        // shows detailed view of products
        public ActionResult Details(int id) {
            var product = _context.Tproducts
                .Where(p => p.IntProductId == id)
                .Select(p => new ProductDTO {
                    intProductID = p.IntProductId,
                    strName = p.StrName,
                    decPrice = (decimal)p.DecPrice,
                    strStockAmount = p.StrStockAmount,
                    strDescription = p.strDescription
                })
                .FirstOrDefault();

            var reviews = _context.Treviews.Where(r => r.IntProductId == id).ToList();

            if (reviews.Any()) {
                var averageRating = reviews.Average(r => r.IntRating);
                ViewBag.AverageRating = Math.Round(averageRating, 1);
            }
            else {
                ViewBag.AverageRating = 0;
            }

            var ratingCounts = Enumerable.Range(1, 5)
                .Select(rating => new {
                    Rating = rating,
                    Count = _context.Treviews.Count(r => r.IntProductId == id && r.IntRating == rating)
                })
                .ToList();

            ViewBag.RatingCounts = ratingCounts;

            var totalReviews = _context.Treviews.Count(r => r.IntProductId == id);
            ViewBag.TotalReviews = totalReviews;

            var userReviews = GetReviews(id);
            ViewBag.UserReviews = userReviews;

            // Retrieve the related products (example query)
            var relatedProducts = _context.Tproducts
                .Where(p => p.IntProductId != id) // Exclude the current product
                .Take(4) // Take the first 4 related products
                .Select(p => new ProductDTO {
                    intProductID = p.IntProductId,
                    strName = p.StrName,
                    decPrice = (decimal)p.DecPrice,
                    strStockAmount = p.StrStockAmount,
                    strDescription = p.strDescription
                })
                .ToList();

            var viewModel = new ProductDetailsViewModel {
                Product = product,
                RelatedProducts = relatedProducts
            };

            return View(viewModel);
        }


        [HttpGet]
        public List<ReviewDTO> GetReviews(int productId) {
            // Retrieve the reviews for the current product
            var reviews = _context.Treviews
                .Where(r => r.IntProductId == productId)
                .Select(r => new ReviewDTO {
                    ReviewId = r.IntReviewId,
                    ReviewText = r.StrReviewText,
                    Rating = r.IntRating,
                    ReviewDate = r.DtmReviewDate,
                    UserFirstName = r.User != null ? r.User.StrFirstName : "Anonymous"
                })
                .ToList();

            return reviews;
        }

        [HttpPost]
        [Authorize]
        public ActionResult SubmitRating(int productId, int rating, string reviewText) {
            // Check if the rating is valid (at least one star)
            if (rating < 1 || rating > 5) {
                return Json(new { success = false, message = "Please select a rating (at least one star)." });
            }

            // Check if the review text is blank
            if (string.IsNullOrWhiteSpace(reviewText)) {
                return Json(new { success = false, message = "Please enter a review text." });
            }

            // Get the current user's ID
            var userId = _userManager.GetUserId(User);

            // Check if the user has already rated this product
            var existingReview = _context.Treviews.FirstOrDefault(r => r.IntProductId == productId && r.UserId == userId);

            if (existingReview != null) {
                // Update the existing review
                existingReview.IntRating = rating;
                existingReview.StrReviewText = reviewText;
                _context.SaveChanges();
            }
            else {
                // Create a new review
                var review = new Treview {
                    IntProductId = productId,
                    UserId = userId,
                    IntRating = rating,
                    StrReviewText = reviewText,
                    DtmReviewDate = DateTime.Now
                };

                _context.Treviews.Add(review);
                _context.SaveChanges();
            }

            return Json(new { success = true });
        }

        [HttpGet]
        public ActionResult GetReviews() {
            int productId = (int)ViewData["productId"];

            // Retrieve the reviews for the current product
            var reviews = _context.Treviews
                .Where(r => r.IntProductId == productId)
                .Select(r => new ReviewDTO {
                    ReviewId = r.IntReviewId,
                    ReviewText = r.StrReviewText,
                    Rating = r.IntRating,
                    ReviewDate = r.DtmReviewDate,
                    UserFirstName = r.User != null ? r.User.StrFirstName : "Anonymous"
                })
                .ToList();

            return PartialView("_Reviews", reviews);
        }


        [HttpPost]
        [Authorize]
        public async Task<IActionResult> AddToFavorites(int productId) {
            // Get the current user's ID
            var userId = _userManager.GetUserId(User);

            // Check if the product is already in the user's favorites
            var existingFavorite = await _context.Tfavorites
                .FirstOrDefaultAsync(f => f.IntProductId == productId && f.UserId == userId);

            if (existingFavorite == null) {
                // Create a new favorite record
                var favorite = new Tfavorite {
                    IntProductId = productId,
                    UserId = userId,
                    DtmDateAdded = DateTime.Now
                };

                // Add the favorite to the database
                _context.Tfavorites.Add(favorite);
                await _context.SaveChangesAsync();
            }

            // Return a JSON response indicating success
            return Json(new { success = true });
        }

    }
}
