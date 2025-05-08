// Test class for NameSorter class
@isTest
public class NameSorterTest {
    
	// Test method for sorting and outputting names
    @isTest
    static void testSortAndOutput() {
        List<String> names = new List<String>{
            'Janet Parsons',
            'Vaughn Lewis',
            'Adonis Julius Archer',
            'Shelby Nathan Yoder',
            'Marin Alvarez',
            'London Lindsey',
            'Beau Tristan Bentley',
            'Leo Gardner',
            'Hunter Uriah Mathew Clarke',
            'Mikayla Lopez',
            'Frankie Conner Ritter'
        };

        Test.startTest();
        ContentVersion result = NameSorter.sortAndOutput(names);
        Test.stopTest();

        System.assertNotEquals(null, result, 'Expected sorted ContentVersion file');
        System.assertEquals('sorted-names-list', result.Title);
    }

    // Test method for running NameSorter from an uploaded file
    @isTest
    static void testRunFromUploadedFile() {
        List<String> names = new List<String>{
            'Janet Parsons',
            'Vaughn Lewis',
            'Adonis Julius Archer',
            'Shelby Nathan Yoder',
            'Marin Alvarez',
            'London Lindsey',
            'Beau Tristan Bentley',
            'Leo Gardner',
            'Hunter Uriah Mathew Clarke',
            'Mikayla Lopez',
            'Frankie Conner Ritter'
        };

        String content = String.join(names, '\n');
        Blob contentBlob = Blob.valueOf(content);

        // Creating a ContentVersion to simulate the uploaded file
        ContentVersion uploaded = new ContentVersion(
            Title = 'unsorted-names-list',
            PathOnClient = 'unsorted-names-list.txt',
            VersionData = contentBlob,
            IsMajorVersion = true
        );
        insert uploaded;

        Test.startTest();
        ContentVersion result = NameSorter.runFromUploadedFile();
        Test.stopTest();

        System.assertNotEquals(null, result, 'Expected result ContentVersion');
        System.assertEquals('sorted-names-list', result.Title);
    }
}