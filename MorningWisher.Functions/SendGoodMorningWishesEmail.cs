using Microsoft.Azure.Functions.Worker;

namespace MorningWisher.Functions;

public class SendGoodMorningWishesEmail
{
    [Function("SendGoodMorningWishesEmail")]
    public async Task Run([TimerTrigger("0 0 22 * * *", RunOnStartup = true)] TimerInfo myTimer)
    {
        
    }
}