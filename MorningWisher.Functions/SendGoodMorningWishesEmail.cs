using Azure;
using Azure.Communication.Email;
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
        var emailClient = new EmailClient(_emailCommunicationConfig.ConnectionString);
        EmailSendOperation emailSendOperation = await emailClient.SendAsync(
            WaitUntil.Completed,
            senderAddress: _emailCommunicationConfig.SenderAddress,
            recipientAddress: _emailCommunicationConfig.RecipientAddress,
            subject: "Good Morning!",
            htmlContent:
            "<html><body>" +
            "Open your eyes, see the morning light, <br><br>" +
            "Each day is a chance to reach new height. <br><br>" +
            "Keep going strong, don't ever dismay, <br><br>" +
            "You'll conquer your dreams, come what may! <br><br>" +
            "Lots of love, <br>" +
            "Yamesant" +
            "</body></html>"
        );
    }
}