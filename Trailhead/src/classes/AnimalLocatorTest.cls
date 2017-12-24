@isTest
public class AnimalLocatorTest {
    public static TestMethod void testHTTP(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String response = AnimalLocator.getAnimalNameById(1);
        System.assertEquals(response, 'chicken');
    }
}