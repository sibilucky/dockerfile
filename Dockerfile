# Use official HTTPD image
FROM httpd:2.4

# Copy a custom HTML file to the web server's document root
COPY ./index.html /usr/local/apache2/htdocs/

# Expose port 70 for the web server
EXPOSE 70

# Run the HTTPD service
CMD ["httpd-foreground"]
