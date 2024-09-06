#!/bin/bash
#
# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person or application name, and a generic password. The user will be forced to change the password on the first login.
# The username, password, and host for the account will be displayed at the end.
# The script can not be executed without superuser privileges.

if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.'
   exit 1
fi

# Get the username (login).
read -p 'Enter the username: ' USER_NAME

# Validate username
if [[ -z "${USER_NAME}" ]]
then
   echo 'Username cannot be empty.'
   exit 1
fi

# Get the real name (contents for the description field).
read -p 'Enter the name of the person or application that will be using this account: ' COMMENT

# Get the password. Password will be changed on first login.
read -p 'Enter the password to use for the account: ' PASSWORD

# Validate password
if [[ -z "${PASSWORD}" ]]
then
   echo 'Password cannot be empty.'
   exit 1
fi

# Create the account.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Verify account creation.
if [[ "${?}" -ne 0 ]]
then
  echo 'The account could not be created.'
  exit 1
fi

# Set the password.
echo "${USER_NAME}:${PASSWORD}" | chpasswd

# Check to see if the chpasswd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'The password for the account could not be set.'
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo 'password:'
echo "${PASSWORD}"
echo 'host:'
echo "${HOSTNAME}"
exit 0
