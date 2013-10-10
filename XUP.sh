#! /bin/bash
# Name: XUP
# Author: runclimbhike
# Date: 9/11/13
# Program Description: This is a control program for access to an encrypted file using EncFS for encryption.
# Security Details: Make sure that your text editor is not creating unencrypted cache files. 
# 	Kwrite and other simple text editors do not do that. Most complex code editors like Kate create #cached files 
#	for backup and recovery. This may store your secure file in plain text.
# Dependencies: EncFS, fuse and a text editor
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
echo '***Licensed under General Public License 3 *** Copyleft only ***'
sleep 3
echo 'Initializing'
sleep 1
echo '.'
sleep 1
echo '.'
sleep 1
echo '.'
echo ''
selection=
until [ "$selection" = "0" ]; do
     echo ""
     echo "XUP PROGRAM MENU"
     echo "1 - Create encrypted file - first time setup"
     echo "2 - Delete encrypted file - removes all data"
     echo "3 - Open encrypted file for 5 minutes - allows temporary access then automatically re-encrypts"
     echo "4 - Open encrypted file indefinitely - allows access for unspecified time period"
     echo "0 - Exit XUP - closes program and verifies data re-encryption"
     echo ""
     echo -n "Enter Selection:"
     read selection
     echo ""
     case $selection in
# Begin creation of encfs stash. This should be a one time process.
         1 ) 
# check if encfs and fusermount is installed
			echo "Checking if software dependencies are installed"
			sleep 1
			 command -v encfs >/dev/null 2>&1 || { echo >&2 "XUP requires EncFS but it's not installed.  Aborting."; exit 1; }
			 command -v fusermount >/dev/null 2>&1 || { echo >&2 "XUP requires fusermount but it's not installed.  Aborting."; exit 1; }
# Setup a basic text editor to open the encrypted file
			
			if [ -a /usr/bin/kwrite ];
				then echo "Software dependencies have been satisfied. Beginning install."
					 EDITOR=kwrite
				elif [ -a /usr/bin/gedit ];
				then echo "Software dependencies have been satisfied. Beginning install."
					 EDITOR=gedit
				else echo "Please install either kwrite or gedit.Aborting."
				exit 0
				
			fi
			
					 
# create password, choose initial settings and initiate mount points.
			mkdir ~/.encrypted
			mkdir ~/.decrypted
			touch ~/.decrypted/data
			chmod 700 ~/.decrypted/data
			encfs ~/.encrypted ~/.decrypted
				
		;;
# Remove stash

		 2 ) 
			echo 'Are you sure you want to delete your encrypted file?  Type Y or N'
			read DELETE
			if [ $DELETE -eq 'Y' ]
				then 
				rm -rf ~/.decrypted
				rm -rf ~/.encrypted
				echo 'Your encrypted stash has been deleted. All data has been removed.'
			elif [ $DELETE -ne 'Y' ]
				then 
				echo 'Exiting program.Re-open get to Program Menu.'
				exit 0
			fi
			
			
			;;
# Open stash for 5 minutes.

		 3 ) 
         
			echo "Please enter your credentials."
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
			echo '.'
			sleep 1
			echo 'Your credentials have been verified successfully.'
			sleep 1
			echo 'XUP will now open a 5 minute session after which the file will re-encrypt.'
			sleep 1
			#spawn another terminal that opens the file in gedit

			$EDITOR ~/.decrypted/data & 

			# Allow 5 minute window access

			sleep 300

			#close the spawned gedit process after the 2 minute save has completed.

			pkill $EDITOR

			#encrypt the folder again

			fusermount -uq ~/.decrypted
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
			exit 0
			fi;;

# Open stash indefinitely

         4 ) 
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
		echo 'XUP will now open a session and close.'
		sleep 1
		#spawn another terminal that opens the file in gedit

		EDITOR ~/.decrypted/data & 

             
# Close the parent shell and leave the EDITOR open indefinitely.

		exit;;
		
		
		
         0 ) 
         
         fusermount -uq ~/.decrypted
			#verify that the data is no long decrypted
         
         exit;;
         
         * ) echo "Please enter 1,2,3,4 or 0"
         
     esac
     
done

