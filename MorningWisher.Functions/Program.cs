using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using MorningWisher.Functions;

var host = new HostBuilder()
    .ConfigureFunctionsWorkerDefaults()
    .ConfigureAppConfiguration((context, config) =>
    {
        config.AddJsonFile("local.settings.json", optional: true, reloadOnChange: true);
    })
    .ConfigureServices((context, services) => {
        services.Configure<EmailCommunicationConfig>(
            context.Configuration.GetRequiredSection("EmailCommunicationConfig"));
        services.AddSingleton<IValidateOptions<EmailCommunicationConfig>, EmailCommunicationConfigValidator>();
    })
    .Build();

host.Run();