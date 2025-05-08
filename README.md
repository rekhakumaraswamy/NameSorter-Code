# NameSorter - Practical Documentation

## Purpose

The 'NameSorter' Apex class is designed to:

- Sort a list of full names alphabetically by last name (and then given names).
- Print the sorted names to the debug log.
- Output the sorted list into a downloadable '.txt' file saved in Salesforce Files.

---

## Usage

There are two main ways to use this utility:

### 1. Direct Sorting in Apex

- **Method**: 'NameSorter.sortAndOutput(List<String> unsortedNames)'
- **Input**: A list of full names (e.g., '['Janet Parsons', 'Leo Gardner']')
- **Output**: A file named 'sorted-names-list.txt' in Salesforce Files

### 2. Sorting from an Uploaded File

- **Method**: `NameSorter.runFromUploadedFile()'
- **Input**: A file named 'unsorted-names-list.txt` uploaded to Salesforce Files
- **Output**: A new file named 'sorted-names-list.txt' with sorted names

---

## Uploading the Input File

Apex cannot access local files directly. You must upload the file in Salesforce first.

Steps:

1. Go to **App Launcher → Files → Upload Files**
2. Upload your file named 'unsorted-names-list.txt'
3. Ensure the file contains **one full name per line** (e.g., 'Janet Parsons')

---

## Running the Sort Logic

To execute the sort and generate the output file:

1. Open **Developer Console → Anonymous Window**
2. Paste and run the following line:
   NameSorter.runFromUploadedFile();
3. This will generate and save a new file named sorted-names-list.txt to Salesforce Files

---

## Output Verification

After execution, the output file can be found here:

1.	Navigate to **App Launcher → Files.**
2.	Look for a file named **sorted-names-list.txt.**
3.	Download and open it — the file should contain:
    - Sorted names alphabetically.
    - One name per line.

---

## Test Coverage Summary

Unit tests are provided to:
-	Verify correct sorting logic.
-	Ensure file creation and output.
-	Simulate file upload using ContentVersion.

### Test class: NameSorterTest
-	Coverage: 89%
-	Validates both sortAndOutput() and runFromUploadedFile()
-	Asserts output file existence and content correctness


---


