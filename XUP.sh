#! /bin/bash
# Name: XUP
# Author: runclimbhike
# Date: 9/11/13
# Program Description: This is a control program for access to an encrypted file using EncFS for encryption.
# Details: 
# Dependencies: EncFS, a lightweight text editor
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
echo 'Fully licensed under General Public License 3 *** Copyleft only *** You cant hate it if you made it***'


until [ "$selection" = "0"]; do
     echo ""
     echo "XUP PROGRAM MENU"
     echo "1 - Create encFS stash"
     echo "2 - Remove encFS stash"
     echo "3 - Open stash for 6 minutes"
     echo "4 - Open stash indefinitely"
     echo "5 - Open stash read-only"
     echo "0 - Exit program"
     echo ""
     echo -n "Enter Selection:"
     read selection
     echo ""
     case $selection in
         1 ) ls -f;;
         2 ) echo "This removes files"
             echo "Please type name of file to remove"
             read deletefiles  
             rm $deletefiles;;
         3 ) echo 'Please enter your credentials.'
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

		kwrite ~/.decrypted/data & 

		# Allow 2 minutes of access. gedit is set to save every minute.
		# Set EDITOR to save every minute.

		sleep 420

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

		Your secure file has been re-encrypted successfully.
		*****************************************************'
		sleep 5
		clear
		fi;;

         4 ) echo "This makes a Directory"
             echo "Please enter Directory name"
             read destination
             mkdir $destination;;
         0 ) exit;;
         
         * ) echo "Please enter 1,2,3,4 or 0"
         
     esac
     
done





















