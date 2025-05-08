/**
 * NameSorter class
 *  - Reads a list of full names (from a ContentVersion or input),
 *  - Sorts them by last name, then given names,
 *  - Outputs sorted names to debug logs and saves as a ContentVersion file.
 */

public class NameSorter {

    // Inner class to represent a name, with sorting logic based on last name and given names
    public class NameWrapper implements Comparable {
        public String fullName;       // Original full name
        public String lastName;       // Last name (used as primary sort key)
        public List<String> givenNames; // Given names (used as secondary sort key)

        // Constructor splits the full name into last name and given names
        public NameWrapper(String name) {
            this.fullName = name.trim(); // Remove extra spaces
            List<String> parts = new List<String>();
            parts.addAll(fullName.split(' ')); // Split by space

            Integer len = parts.size();
            lastName = parts.get(len - 1); // Last element is the last name
            givenNames = new List<String>();

            // All elements before the last one are given names
            if (len > 1) {
                for (Integer i = 0; i < len - 1; i++) {
                    givenNames.add(parts.get(i));
                }
            }
        }

        // compareTo method to sort by last name, then given names
        public Integer compareTo(Object obj) {
            NameWrapper other = (NameWrapper) obj;

            // First compare last names (case-insensitive)
            Integer lastNameCompare = this.lastName.toLowerCase().compareTo(other.lastName.toLowerCase());
            if (lastNameCompare != 0) return lastNameCompare;

            // If last names are equal, compare given names one by one
            Integer minLen = Math.min(this.givenNames.size(), other.givenNames.size());
            for (Integer i = 0; i < minLen; i++) {
                Integer cmp = this.givenNames[i].toLowerCase().compareTo(other.givenNames[i].toLowerCase());
                if (cmp != 0) return cmp;
            }

            // If given names match up to minLen, shorter list comes first
            return this.givenNames.size() - other.givenNames.size();
        }
    }

    // Main method to sort and output the list of names
    public static ContentVersion sortAndOutput(List<String> unsortedNames) {
        List<NameWrapper> wrapped = new List<NameWrapper>();

        // Wrap each non-blank name for sorting
        for (String name : unsortedNames) {
            if (String.isNotBlank(name)) {
                wrapped.add(new NameWrapper(name));
            }
        }

        wrapped.sort(); // Sort using compareTo logic

        List<String> sorted = new List<String>();
        for (NameWrapper w : wrapped) {
            sorted.add(w.fullName); // Extract sorted names
        }

        // Print sorted names to debug log
        System.debug('Sorted Names:');
        for (String s : sorted) {
            System.debug(s);
        }

        // Create a newline-separated string for the file
        String content = String.join(sorted, '\n');
        Blob bodyBlob = Blob.valueOf(content);

        // Create and insert a ContentVersion record with sorted names
        ContentVersion file = new ContentVersion(
            Title = 'sorted-names-list',
            PathOnClient = 'sorted-names-list.txt',
            VersionData = bodyBlob,
            IsMajorVersion = true
        );
        insert file;
        System.debug('File written with ID: ' + file.Id);

        return file;
    }

    // Utility method to run sorting based on a file uploaded as ContentVersion
    public static ContentVersion runFromUploadedFile() {
        // Get the most recent file with the expected title
        ContentVersion version = [
            SELECT Id, Title, VersionData
            FROM ContentVersion
            WHERE Title = 'unsorted-names-list'
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];

        // Decode file content safely using a base64 roundtrip
        Blob body = version.VersionData;
        String base64 = EncodingUtil.base64Encode(body); // Ensures content is safely encoded
        Blob decoded = EncodingUtil.base64Decode(base64); // Ensures correct decoding
        String fileContent = decoded.toString(); // Convert Blob to String (UTF-8 safe)

        // Split the content by newline into individual names
        List<String> names = fileContent.split('\n');

        // Perform sort and output
        return sortAndOutput(names);

    }
}