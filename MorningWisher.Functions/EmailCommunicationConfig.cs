using Microsoft.Extensions.Options;

namespace MorningWisher.Functions;

public class EmailCommunicationConfig
{
    public string ConnectionString { get; set; } = string.Empty;
    public string SenderAddress { get; set; } = string.Empty;
    public string RecipientAddress { get; set; } = string.Empty;
}

public class EmailCommunicationConfigValidator : IValidateOptions<EmailCommunicationConfig>
{
    public ValidateOptionsResult Validate(string? name, EmailCommunicationConfig options)
    {
        if (options.ConnectionString.Length == 0)
        {
            return ValidateOptionsResult.Fail("Email communication connection string is required");
        }
        
        if (options.SenderAddress.Length == 0)
        {
            return ValidateOptionsResult.Fail("Email communication sender address is required");
        }
        
        if (options.RecipientAddress.Length == 0)
        {
            return ValidateOptionsResult.Fail("Email communication recipient address is required");
        }
        
        return ValidateOptionsResult.Success;
    }
}