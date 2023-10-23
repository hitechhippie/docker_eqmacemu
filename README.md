# docker_eqmacemu
docker-compose based instance of a takp clone server

## installation
1. Clone this repository to a machine with docker installed.

2. `cd` to the `takp` subfolder.

3. Copy the example environment file and tailor for your environment; in particuliar, it's best to choose a user and group id of the same user/group that you operate docker-compose with.  You may also change several other options including database/server names, auto account creation, etc.

 * `cp .env_example .env`
 * edit the `.env` file

4. Build the server binaries and base container image with:

 * `docker-compose build`

5. Launch the stack with:
 * `docker-compose up -d`

## logging in
1. Obtain a TAKP client and set the `eqhost.txt` file settings to point to your docker host with port `6000`.

2. Login to the system with the default GM-enabled account, `dockeradmin`: password `dockeradmin`.

