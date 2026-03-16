
Purpose:
This lesson explores an “Animal of the Week” website and demonstrates how Amazon S3 Versioning can be used to protect and recover website content. 
During the lab, changes are intentionally made to website objects to simulate accidental or intentional modifications and deletions. 
By enabling versioning, previous versions of the files can be restored, allowing the website to quickly recover from these issues and maintain availability.


Architecture / Key Components:

- Static website hosted using **Amazon Web Services Amazon S3

- S3 Versioning enabled to preserve multiple versions of objects

- Website files (HTML, images, etc.) stored as S3 objects

- Object updates and deletions create new versions rather than permanently removing data


Key Concepts Demonstrated:

- Protecting static website content with S3 Versioning

- Recovering previous object versions after accidental changes

- Restoring deleted objects using version history

- Understanding how object storage maintains historical versions


Implementation Steps:

- Start in S3
- Create a bucket with no blocked traffic
- Go into bucket→Properties→Static Website Hosting→ Set fields
- Then go to Permission in the bucket and create a bucket policy so that we have access to it

- Next we can populate the bucket
- Go to upload and upload the index.html / Error.html files and the IMG folder

 *** Refer to screenshot 1 ***
 
 
- Here is an example of uploading the same named file. With show versions you can see that there is an older version.
 
 *** Refer to screenshot 2 ***
 
- Voila! A Delete Marker after deleting the winkie.jpg file

 *** Refer to screenshot 3 ***
