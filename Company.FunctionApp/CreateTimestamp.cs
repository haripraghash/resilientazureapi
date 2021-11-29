using System.Net;
using Company.FunctionApp;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Enums;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;

namespace Company.FunctionApp;

    public static class CreateTimestamp
    {
        [OpenApiOperation(operationId: "createtimestamp", tags: new[] { "timestamp" }, Summary = "Timestamps", Description = "This created a timestamp entry.", Visibility = OpenApiVisibilityType.Important)]
        [OpenApiSecurity("function_key", SecuritySchemeType.ApiKey, Name = "code", In = OpenApiSecurityLocationType.Query)]
        [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "application/json", bodyType: typeof(CreateTimestampResponse), Summary = "The response", Description = "This returns the response")]

        [Function("CreateTimestamp")]
        public static HttpResponseData Run(
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
