public class AnimalLocator {
    public static String getAnimalNameById(Integer animalID){
        HTTP http = new HTTP();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+animalID);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // Deserialize the JSON string into collections of primitive data types.
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        // Cast the values in the 'animal' key as a list
        Map<String, Object> animal = (Map<String, Object>) results.get('animal');
        System.debug('Received the following animal:');
        System.debug(animal.get('name'));
        return animal.get('name')+'';
    }
    
}