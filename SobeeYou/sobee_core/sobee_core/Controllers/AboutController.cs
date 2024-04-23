﻿using Microsoft.AspNetCore.Mvc;
using System.Net;
using System.Net.Mail;

namespace sobee_core.Controllers {
	public class AboutController : Controller {

		public IActionResult Index() {
			return View();      // returns view
		}



		public IActionResult FAQ() {

			return View();
		}

		public IActionResult RefundPolicy() {
			return View();
		}

		public IActionResult ShippingReturns() {

			return View();

		}

		public IActionResult TermsOfService() {
			return View();
		}


		public IActionResult FindUs() {
			return View();
		}

		public IActionResult Contact() {
			return View();
		}


		[HttpPost]
		public ActionResult Contact(string email, string message) {
			// TODO: Implement email sending functionality
			// Send email using the provided email and message
			string workEmail = "sobeeyoubusiness@gmail.com"; // replace with sobee email
			string fromPassword = "yplu kfwq wufa jpjp"; // replace with sobee app password

			SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
			smtpClient.EnableSsl = true;
			smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
			smtpClient.UseDefaultCredentials = false;
			smtpClient.Credentials = new NetworkCredential(workEmail, fromPassword);

			// Create the password reset email
			MailMessage mailMessage = new MailMessage();
			mailMessage.From = new MailAddress(workEmail);
			mailMessage.To.Add(workEmail);
			mailMessage.Subject = "New Inquiry from Customer!";
			mailMessage.Body = "Here is a new message from " + email + ": " + message;

			// Send the email
			smtpClient.Send(mailMessage);
			TempData["SuccessMessage"] = "Your message to SoBee You has been sent! Please check your email for a reply within 1-2 business days.";
			return RedirectToAction("Contact");
		}











	}
}

// FAQ
// Shipping and Returns
// Contact
//Refund Policy
// Terms of service