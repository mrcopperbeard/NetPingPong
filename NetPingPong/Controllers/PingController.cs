using System;

using Microsoft.AspNetCore.Mvc;

namespace NetPingPong.Controllers
{
	[Route("ping")]
	[ApiController]
	public class PingController : ControllerBase
	{
		// GET api/values
		[HttpGet]
		[Route("")]
		public string Ping()
		{
			return "pong";
		}
	}
}
