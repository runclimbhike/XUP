#! /bin/bash
# Name: XUP
# Author: runclimbhike
# Date: 9/11/13
# Program Description: This program controls access to an encrypted file using EncFS for encryption.
# Details: This program assumes that the EncFS file has been created already. 
#
#
#begin splash and program information.
echo '

       X     8     * ~~~~~ 8
        X   X *    *       |
         X X  *    *_______|
          X   *    *
         X X  *    *
        X   X *    *
       X     8 ~~~~~
'
echo 'Initializing'
sleep 1
echo 'Fully licensed under General Public License 3. *** Copyleft only *** You cant hate it if you made it***'
sleep 1
echo 'Please enter your credentials.'
sleep 1
#begin actual program
#use enfs to mount the encrypted folder to decrypted
encfs ~/.encrypted ~/.decrypted
#user will enter the password
if [ -a ~/.decrypted/data ];
then
	echo 'Verifying...'
else 
	echo 'Your credentials could not be verified. XUP will now close.'
	sleep 4
	clear

	exit 0
fi
sleep 1
echo 'Your credentials have been verified successfully.'
sleep 1
echo 'XUP will now open a 5 minute session after which the file will re-encrypt.'
sleep 1
#spawn another terminal that opens the file in EDITOR

kwrite ~/.decrypted/data & 

# Allow 6 minutes of access. gedit is set to save every minute.
# Set gedit to save every minute.

sleep 360

#close the spawned gedit process after the 2 minute save has completed.

pkill kwrite

#encrypt the folder again

fusermount -u ~/.decrypted
#verify that the data is no long decrypted
if [ -a ~/.decrypted/data ];
then 
	clear
	echo 'Folder has not been encrypted correctly. Please see admin.'
else	
	clear
	echo '
*****************************************************
Session complete. 

There are no records of any activity performed on 
the file during this time period.
 
Your secure file has been re-encrypted successfully.
*****************************************************'
	sleep 5
	clear
fi



