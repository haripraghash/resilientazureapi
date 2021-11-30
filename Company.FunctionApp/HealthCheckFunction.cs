using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Enums;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Company.FunctionApp
{
    public class HealthCheckFunction
    {
        private ILogger<HealthCheckFunction> logger;
        private IConfiguration configuration;
        private HealthCheckService healthCheckService;

        public HealthCheckFunction(IConfiguration configuration, ILogger<HealthCheckFunction> logger, HealthCheckService healthCheckService)
        {
            this.configuration = configuration;
            this.logger = logger;
            this.healthCheckService = healthCheckService;
        }

        [OpenApiOperation(operationId: "HEALTH", tags: new[] { "health" }, Summary = "Health", Description = "This returns the health of the endpoint.", Visibility = OpenApiVisibilityType.Important)]
        [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "application/json", bodyType: typeof(HealthReport), Summary = "The response", Description = "This returns the response")]

        [Function("Health")]
        public async Task<HttpResponseData> Run(
           [HttpTrigger(AuthorizationLevel.Anonymous, "get")] HttpRequestData request,
           FunctionContext executionContext)
        {
            var healthResport = await this.healthCheckService.CheckHealthAsync();
            var response = request.CreateResponse(healthResport.Status == HealthStatus.Healthy ? HttpStatusCode.OK:HttpStatusCode.InternalServerError);

            await response.WriteAsJsonAsync(healthResport);
            return response;

        }
    }
}
