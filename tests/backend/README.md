<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Infisical, verified and packaged by Elestio

[Infisical](https://github.com/Infisical/infisical) is an Open-source, end-to-end encrypted secret management platform.

<img src="https://github.com/elestio-examples/infisical/raw/main/infisical.png" alt="infisical" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/infisical">fully managed infisical</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

[![deploy](https://github.com/elestio-examples/infisical/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/infisical)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/infisical.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

    mkdir -p ./mongo-data
    chown -R 1000:1000 ./mongo-data

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:6443`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3"

    services:
        nginx:
            image: nginx
            restart: always
            ports:
                - 172.17.0.1:6443:80
            volumes:
                - ./nginx/default.conf:/etc/nginx/conf.d/default.conf:ro
            depends_on:
                - frontend
                - backend

        backend:
            restart: always
            depends_on:
                - mongo
            image: elestio4test/infisical-backend:${SOFTWARE_VERSION_TAG}
            env_file: ./.env
            environment:
                - NODE_ENV=${NODE_ENV}

        frontend:
            restart: always
            depends_on:
                - backend
            image: elestio4test/infisical-frontend:${SOFTWARE_VERSION_TAG}
            env_file: ./.env
            environment:
                # - NEXT_PUBLIC_POSTHOG_API_KEY=${POSTHOG_PROJECT_API_KEY}
                - INFISICAL_TELEMETRY_ENABLED=${TELEMETRY_ENABLED}
                - NEXT_PUBLIC_STRIPE_PRODUCT_PRO=${STRIPE_PRODUCT_PRO}
                - NEXT_PUBLIC_STRIPE_PRODUCT_TEAM=${STRIPE_PRODUCT_TEAM}
                - NEXT_PUBLIC_STRIPE_PRODUCT_STARTER=${STRIPE_PRODUCT_STARTER}

        mongo:
            container_name: infisical-mongo
            image: mongo
            restart: always
            env_file: .env
            environment:
                - MONGO_INITDB_ROOT_USERNAME=${MONGO_USERNAME}
                - MONGO_INITDB_ROOT_PASSWORD=${MONGO_PASSWORD}
            volumes:
                - ./mongo-data:/data/db

### Environment variables

|       Variable       |          Value (example)          |
| :------------------: | :-------------------------------: |
| SOFTWARE_VERSION_TAG |              latest               |
|       NODE_ENV       |            production             |
|       TEST_URL       | http://yourdomain:4000/api/status |
|      SMTP_HOST       |          your.SMTP.host           |
|      SMTP_PORT       |                25                 |
|     SMTP_SECURE      |               false               |
|    SMTP_FROM_NAME    |             Infisical             |
|  SMTP_FROM_ADDRESS   |            SMTP-domain            |
|    ENCRYPTION_KEY    |             your-key              |
|  JWT_SIGNUP_SECRET   |         signup-secret-key         |
|  JWT_REFRESH_SECRET  |        refresh-secret-key         |
|   JWT_AUTH_SECRET    |          auth-secret-key          |
|  JWT_SERVICE_SECRET  |        service-secret-key         |
|      MONGO_URL       |        mongodb://mongo-url        |
|    MONGO_USERNAME    |          mongo-username           |
|    MONGO_PASSWORD    |          mongo-username           |
|       SITE_URL       |          https://domain           |
| ROOT_ENCRYPTION_KEY  |     your-root-encryption-key      |

# Maintenance

## Logging

The Elestio Infisical Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/Infisical/infisical">Infisical Github repository</a>

- <a target="_blank" href="https://infisical.com/docs/documentation/getting-started/introduction">Infisical documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/infisical">Elestio/Infisical Github repository</a>
