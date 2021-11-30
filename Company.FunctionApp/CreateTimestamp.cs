using System.Net;
using Company.FunctionApp;
using Microsoft.Azure.Cosmos;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Enums;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;

namespace Company.FunctionApp;

    public class CreateTimestamp
    {
        private CosmosClient cosmosClient;
        private ILogger<CreateTimestamp> logger;
        private IConfiguration configuration;

    public CreateTimestamp(CosmosClient cosmosClient, IConfiguration configuration, ILogger<CreateTimestamp> logger)
    {
        this.logger = logger;
        this.cosmosClient = cosmosClient;   
        this.configuration = configuration;

    }
        [OpenApiOperation(operationId: "createtimestamp", tags: new[] { "timestamp" }, Summary = "Timestamps", Description = "This created a timestamp entry.", Visibility = OpenApiVisibilityType.Important)]
        [OpenApiSecurity("function_key", SecuritySchemeType.ApiKey, Name = "code", In = OpenApiSecurityLocationType.Query)]
        [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "application/json", bodyType: typeof(CreateTimestampResponse), Summary = "The response", Description = "This returns the response")]

        [Function("CreateTimestamp")]
        public HttpResponseData Run(
            [HttpTrigger(AuthorizationLevel.Function, "post")]HttpRequestData request,
            FunctionContext executionContext)
        {
            var logger = executionContext.GetLogger("CreateTimestamp");
            logger.LogInformation("C# HTTP trigger function processed a request.");

            var response = request.CreateResponse(HttpStatusCode.OK);
            response.Headers.Add("Content-Type", "text/plain; charset=utf-8");

            response.WriteString("Welcome to Azure Functions!");

            return response;
            
        }
    }
