using System;
using System.Net;
using System.Threading.Tasks;
using Company.FunctionApp;
using Microsoft.Azure.Cosmos;
using Microsoft.Azure.Cosmos.Fluent;
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
    [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "application/json", bodyType: typeof(CreateTimestampResponse), Summary = "The response", Description = "This returns the response")]

    [Function("CreateTimestamp")]
    public async Task<HttpResponseData> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "post")] HttpRequestData request,
        FunctionContext executionContext)
    {
        var logger = executionContext.GetLogger("CreateTimestamp");

        var container = this.cosmosClient.GetContainer(this.configuration["DatabaseName"], this.configuration["CollectionName"]);
        TimestampModel model = new TimestampModel()
        {
            Timestamp = System.DateTime.UtcNow
        };

        var result = await container.CreateItemAsync<TimestampModel>(model, new PartitionKey(model.Name));
        
        var response = request.CreateResponse(HttpStatusCode.OK);

        await response.WriteAsJsonAsync<CreateTimestampResponse>(new CreateTimestampResponse() { Id = result.Resource.Id, InsertedTimestamp = result.Resource.Timestamp });

        return response;

    }
}
