# Base Image
FROM nginx:alpine

# Remove nginx default config file
RUN rm /etc/nginx/conf.d/default.conf

# Copy manually made config file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80

# Command
CMD ["nginx", "-g", "daemon off;"]
