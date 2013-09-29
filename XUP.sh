#! /bin/bash
# Name: XUP
# Author: runclimbhike
# Date: 9/11/13
# Program Description: This program controls access to an encrypted file using EncFS for encryption and gedit for data management.
# Details: This program assumes that the EncFS file has been created already. It also assumes that Gedit has been configured to save every minute.# 
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
echo '.'
sleep 1
echo 'Created by runclimbhike'
sleep 1
echo 'XUP is a registered trademark of NIXNOW'
sleep 1
echo 'Fully licensed under General Public License 3. *** Use in-kind. *** Copyleft only *** You cant hate it if you made it'
sleep 1
echo '
XUP is establishing connection.'
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
	echo '.'
else 
	echo 'Your credentials could not be verified. XUP will now close.'
	sleep 4
	clear

	exit 0
fi
sleep 1
echo '.'
sleep 1
echo 'Your credentials have been verified successfully.'
sleep 1
echo 'XUP will now open a 5 minute session after which the file will re-encrypt.'
sleep 1
#spawn another terminal that opens the file in gedit

kate ~/.decrypted/data & 

# Allow 2 minutes of access. gedit is set to save every minute.
# Set gedit to save every minute.

sleep 420

#close the spawned gedit process after the 2 minute save has completed.

pkill kate

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



