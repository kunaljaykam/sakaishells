# SakaiShells

SakaiShells is a collection of shell scripts designed to simplify the management and deployment of Sakai environments. These scripts automate various tasks such as deploying Sakai, managing databases, and handling server operations.

## Scripts Overview

Below is a list of the scripts included in this repository along with their descriptions:

### `config.sh`

- **Description**: Holds the configuration variables used by the other scripts. This includes paths to the Tomcat directory, Sakai home, and Sakai codebase.
- **Usage**: This script is sourced by other scripts and is not intended to be run directly.


### `deploy.sh`

- **Description**: Handles the deployment of Sakai using Maven. It checks for the required Java version and Maven before deploying.
- **Usage**: Execute with `bash deploy.sh`.

### `setup-db.sh`

- **Description**: Sets up and configures the database required for Sakai in MariaDB.
- **Usage**: Run `bash setup-db.sh` to set up the database.

### `clean-db.sh`

- **Description**: Cleans the Sakai database and specific directories, resetting the environment.
- **Usage**: Use `bash clean-db.sh` to clean up the database and directories.

### `start-tomcat.sh`

- **Description**: Starts the Tomcat server with JPDA enabled for debugging and can tail the Tomcat log file.
- **Usage**: Start Tomcat by running `bash start-tomcat.sh`.

### `dp.sh`

- **Description**: A deployment script intended to be run from the `sakai-codebase` directory.
- **Usage**: Navigate to the `sakai-codebase` and run `../../dp.sh` to deploy Sakai.

## Getting Started

1. Clone the repository to your local machine.
2. Navigate to the `sakaishells` directory.
4. Use the individual scripts as needed based on the above descriptions.

## Contributing

Contributions to SakaiShells are welcome. Please fork the repository and submit a pull request with your changes.


## Acknowledgments

- Thanks to the Sakai community for their continuous support and contributions.

