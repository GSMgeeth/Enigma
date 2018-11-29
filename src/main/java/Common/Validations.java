package Common;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validations
{
    private Pattern regexPattern;
    private Matcher regMatcher;

    public boolean validateEmailAddress(String emailAddress)
    {
        regexPattern = Pattern.compile("^[(a-zA-Z-0-9-\\_\\+\\.)]+@[(a-z-A-z)]+\\.[(a-zA-z)]{2,3}$");
        regMatcher   = regexPattern.matcher(emailAddress);

        if(regMatcher.matches())
            return true;
        else
            return false;
    }

    public boolean validateMobileNumber(String mobileNumber)
    {
        regexPattern = Pattern.compile("^[0-9]{2,3}+-[0-9]{10}$");
        regMatcher = regexPattern.matcher(mobileNumber);

        if (regMatcher.matches())
            return true;
        else
            return false;
    }
}
