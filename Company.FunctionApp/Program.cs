using Microsoft.Extensions.Hosting;
using Microsoft.Azure.Functions.Worker.Extensions.OpenApi.Extensions;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Microsoft.Azure.Cosmos.Fluent;
using System;

namespace Company.FunctionApp
{
public class Program
    {
        public static void Main()
        {
            var cosmosConnectionString = $"AccountEndPoint={Environment.GetEnvironmentVariable("CosmosEndpoint")};AccountKey={Environment.GetEnvironmentVariable("CosmosConnectionString")};";
            var host = new HostBuilder()
                
                 .ConfigureAppConfiguration(e =>
                    e.AddJsonFile("local.settings.json", optional: true, reloadOnChange: true).AddEnvironmentVariables().Build())
                .ConfigureFunctionsWorkerDefaults(worker => worker.UseNewtonsoftJson())
                .ConfigureServices( s=> s.AddHealthChecks().AddCosmosDb(cosmosConnectionString, $"{Environment.GetEnvironmentVariable("DatabaseName")}"))
                .ConfigureServices(s => new CosmosClientBuilder(cosmosConnectionString).WithSerializerOptions(new Microsoft.Azure.Cosmos.CosmosSerializationOptions() { PropertyNamingPolicy = Microsoft.Azure.Cosmos.CosmosPropertyNamingPolicy.CamelCase}) .Build())
                .ConfigureOpenApi()
                .Build();
         
            host.Run();
        }
    }
}