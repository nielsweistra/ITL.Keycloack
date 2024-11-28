# Base image
FROM quay.io/keycloak/keycloak:26.0.6

# Set environment variables for development mode
ENV KEYCLOAK_ADMIN=admin \
    KEYCLOAK_ADMIN_PASSWORD=admin \
    KC_PROXY=edge

# Optional: Copy custom configuration files (e.g., themes or providers)
# COPY ./themes /opt/keycloak/themes
# COPY ./providers /opt/keycloak/providers

# Expose Keycloak port
EXPOSE 8080

# Default command to start Keycloak in development mode
CMD ["start-dev"]
