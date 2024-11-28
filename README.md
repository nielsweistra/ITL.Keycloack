# Keycloak with PostgreSQL

This project sets up **Keycloak** for authentication and authorization, backed by **PostgreSQL**, using two different deployment strategies:

1. **Docker Compose**: For local testing and development.
2. **Helm**: For production-ready deployments on Kubernetes.

## Structure ##
```
│   docker-compose.yml  # Defines the multi-container Docker services for local testing.
│   Dockerfile          # Contains instructions for building the Docker image for Keycloak.
│
└───chart               # Contains the Helm chart for deploying the application in Kubernetes.
    │   values.yaml     # Default values for the Helm chart, such as configurations for Keycloak and PostgreSQL.
    │
    └───templates       # Contains Kubernetes YAML templates for various resources in the Helm chart.
        deployment.yaml # Defines the Kubernetes Deployment resource for Keycloak and PostgreSQL.
        pgcluster.yaml  # Configuration for the PostgreSQL cluster, using a PostgreSQL operator.
        service.yaml     # Defines Kubernetes Service resources for Keycloak and PostgreSQL.
        _helpers.tpl     # Contains helper templates for generating common values and names used across the chart.
```

### Local Testing with Docker Compose

This setup uses Docker Compose to run **Keycloak** and **PostgreSQL** as containers for local development and testing. The configuration exposes **Keycloak** on `localhost:8080` and **PostgreSQL** on `localhost:5432`.

#### Docker Compose Setup

1. **Keycloak**:
   - Runs on port `8080` for local testing.
   - Uses PostgreSQL as its database backend.
   - Configured in development mode (`start-dev`).

2. **PostgreSQL**:
   - Runs on port `5432` for local testing.
   - Stores Keycloak's data (users, realms, etc.).
   - Configured with default credentials.

#### Getting Started with Docker Compose

1. Clone the repository:

    ```bash
    git clone https://github.com/nielsweistra/ITL.Keycloack.git
    cd ITL.Keycloack
    ```

2. Build and start the services:

    ```bash
    docker-compose up --build
    ```

3. **Access Keycloak**:
   - Open your browser and navigate to `http://localhost:8080`.
   - Log in with the default admin credentials:
     - **Username**: `admin`
     - **Password**: `admin`

4. **Access PostgreSQL**:
   - PostgreSQL is running on `localhost:5432`.
   - You can connect to it with the following credentials:
     - **Username**: `keycloak`
     - **Password**: `keycloak_password`
     - **Database**: `keycloak`

5. To check if Keycloak is successfully connected to PostgreSQL, view the logs:

    ```bash
    docker logs keycloak
    ```

   You should see a message indicating that Keycloak has connected to the PostgreSQL database.

---

### Production-Ready Deployment with Helm

For production deployments on Kubernetes, use the Helm chart provided in the `chart` directory. This chart deploys **Keycloak** and **PostgreSQL** in a Kubernetes environment, using Kubernetes-native resources for scalability, high availability, and management.

#### Helm Chart Structure:

- **deployment.yaml**: Defines Kubernetes deployments for Keycloak and PostgreSQL.
- **pgcluster.yaml**: Configures the PostgreSQL cluster using the `PostgresqlCNPG` operator for PostgreSQL management in Kubernetes.
- **service.yaml**: Configures the services for both Keycloak and PostgreSQL, ensuring they are accessible within the Kubernetes cluster.
- **_helpers.tpl**: Contains helper templates for generating common resource names and labels.

#### Customizing the Helm Chart

1. Navigate to the `chart` directory:

    ```bash
    cd chart
    ```

2. Modify the `values.yaml` file for custom configurations, such as:
   - Keycloak admin credentials (`KC_BOOTSTRAP_ADMIN_USERNAME`, `KC_BOOTSTRAP_ADMIN_PASSWORD`).
   - PostgreSQL credentials (`POSTGRES_USER`, `POSTGRES_PASSWORD`).
   - Replicas for both Keycloak and PostgreSQL, resource requests/limits, etc.

3. Install the Helm chart:

    ```bash
    helm install keycloak-release .
    ```

    This will deploy Keycloak and PostgreSQL on your Kubernetes cluster.

4. **Access Keycloak**:
   - Port-forward to expose Keycloak locally (if desired for testing):

    ```bash
    kubectl port-forward svc/keycloak 8080:8080
    ```

   - Access Keycloak at `http://localhost:8080`.
   - Log in with the admin credentials you set in the `values.yaml` file.

5. **Access PostgreSQL**:
   - You can port-forward to PostgreSQL if needed:

    ```bash
    kubectl port-forward svc/postgresql 5432:5432
    ```

   - Connect to PostgreSQL using the credentials set in `values.yaml`.

---

### Customization

- **Keycloak Admin Credentials**: To modify the admin credentials, update the `KC_BOOTSTRAP_ADMIN_USERNAME` and `KC_BOOTSTRAP_ADMIN_PASSWORD` environment variables in the `docker-compose.yml` file (for local testing) or in the `values.yaml` file (for Helm/production).
  
- **PostgreSQL Configuration**: You can change the default PostgreSQL credentials and database name by modifying the `POSTGRES_USER`, `POSTGRES_PASSWORD`, and `POSTGRES_DB` environment variables in the `docker-compose.yml` or `pgcluster.yaml` for Helm.

- **Helm Chart Configuration**: The `values.yaml` file in the Helm chart provides an easy way to adjust configurations, including:
   - Number of replicas for Keycloak and PostgreSQL.
   - Resource requests/limits.
   - Persistent storage for PostgreSQL.
