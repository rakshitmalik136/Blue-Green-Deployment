# Base Image
FROM nginx:alpine

# Remove nginx default config file
RUN rm /etc/nginx/conf.d/default.conf

# Copy manually made config file
COPY /conf/nginx.conf /etc/nginx/conf.d/nginx.conf

# Expose port
EXPOSE 80

# Command
CMD ["nginx", "-g", "daemon off;"]
