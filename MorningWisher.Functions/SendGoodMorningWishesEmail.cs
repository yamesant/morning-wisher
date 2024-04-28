using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Options;

namespace MorningWisher.Functions;

public class SendGoodMorningWishesEmail
{
    private readonly EmailCommunicationConfig _emailCommunicationConfig;
    public SendGoodMorningWishesEmail(IOptions<EmailCommunicationConfig> emailCommunicationOptions)
    {
        _emailCommunicationConfig = emailCommunicationOptions.Value;
    }
    [Function("SendGoodMorningWishesEmail")]
    public async Task Run([TimerTrigger("0 0 22 * * *", RunOnStartup = true)] TimerInfo myTimer)
    {
        string recipientAddress = _emailCommunicationConfig.RecipientAddress;
    }
}