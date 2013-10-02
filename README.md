XUP
===

This bash script/program creates and manages an encrypted file stored in a local encFS stash. 
It decrypts the file and pops it open in kwrite or gedit for a specified period of time then it re-encrypts the file.


  XUP PROGRAM MENU
  
     1 - Create encrypted file - first time setup
     2 - Delete encrypted file - removes all data
     3 - Open encrypted file for 5 minutes - allows temporary access then automatically re-encrypts
     4 - Open encrypted file indefinitely - allows access for unspecified time period
     0 - Exit XUP - closes program and verifies data re-encryption
     
     
This program is tested on the following distributions:
- openSUSE 12.3
- Debian 7 (The user has to be added to the fuse group)
