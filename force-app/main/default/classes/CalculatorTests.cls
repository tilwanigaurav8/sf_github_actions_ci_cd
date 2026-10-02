@isTest
public class CalculatorTests {
    @IsTest
    static void testDivideByZero(){
        try{
            Test.startTest();
            Calculator.divide(10,0);
            Test.stopTest();
            Assert.fail('An exception should have been thrown');
        }
        catch(Calculator.CalculatorException e){
            Assert.isTrue(e.getMessage().equalsIgnoreCase('You still can\'t divide by zero'),'Exception message does not match: ' + e.getMessage());
        }
    }
}