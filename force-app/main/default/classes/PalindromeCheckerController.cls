public with sharing class PalindromeCheckerController {
    @AuraEnabled
    public static Boolean checkPalindrome(String palindrome){
        System.debug('Palindrom: '+ (palindrome == palindrome.reverse()));            
        return (palindrome == palindrome.reverse());
    }
}