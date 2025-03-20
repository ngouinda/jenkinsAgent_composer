# Use the official Jenkins inbound agent image as the base image
# This image is pre-configured to work as a Jenkins agent
FROM jenkins/inbound-agent

# Switch to the root user to allow installation of additional packages
USER root

# Update the package list and install PHP
RUN apt update && apt install -y php

# Install additional PHP extensions required for various functionalities
RUN apt install -y php-curl php-xml zip unzip

# Install the PHP mbstring extension, which is required for handling multibyte strings
RUN apt install -y php-mbstring

# Download the Composer installer script
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" 
# Verify the integrity of the Composer installer using its SHA-384 hash
# If the hash matches, the installer is verified; otherwise, it is deleted
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"

# Run the Composer installer to generate the composer.phar file
RUN php composer-setup.php

# Remove the Composer installer script after installation
RUN php -r "unlink('composer-setup.php');"

# Move the Composer binary to a directory in the system PATH for global usage
RUN mv composer.phar /usr/local/bin/composer