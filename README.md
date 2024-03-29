# GoCentral Docker
A Docker image for GoCentral, allowing you to deploy your own custom server.

## Issues
This image has only been tested on RPCS3, due to me not owning any real hardware. Rock Band 3 is the only game I've gotten to work so far.<br>
Rock Band 2 and The Beatles: Rock Band and Green Day: Rock Band connect to the server, but do not give out their username resulting in their login being refused and the connection being closed.<br>
Bridge networking doesn't work, you'll need to use the host driver.

## URLs to mask:
Rock Band 2 - rb2ps3live.hmxservices.com=`***`<br>
Rock Band 3 - rb3ps3live.hmxservices.com=`***`<br>
The Beatles: Rock Band - p9ps3live.hmxservices.com=`***`<br>
Green Day Rock Band - rpgps3live.hmxservices.com=`***`

## Building
Docker build tools should be automatically installed when installing Docker.<br>

Run `docker build -t gocentral ./` to build image.

## Running
### MongoDB
GoCentral stores its data using the GoLang MongoDB driver. You'll need to register/sign in to MongoDB and claim an (at minimum) free database.<br>
Grab its' generated Go driver connection string and set that as your MONGOCONNECTIONSTRING. If it gives an error, check if you've replaced the <password> part of the connection string with the pre-generated password given by MongoDB.

<br>
You can also selfhost the MongoDB instance you'd like to use. In my opinion it's much easier to use a cloud one for testing.

### Game Variables
Each game has been assigned a variable consisting of its' abbreviation and its' console's abbreviation. Here are all possible Game/Console combonations:<br>
GAMES:<br>
RB2 - Rock Band 2<br>
RB3 - Rock Band 3<br>
BRB - The Beatles : Rock Band<br>
GDRB - Green Day : Rock Band<br>
<br>CONSOLES:<br>
PS3 - Playstation 3<br>
WII - Wii<br>
X360 - Xbox 360<br>

You'll need to piece these together and set that as your GAME environment variable.<br>
ex. RB3:PS3

### docker run
`docker run -d --network=host -e MONGOCONNECTIONSTIRNG="*" -e LISTENINGIP="***" -e ADDRESS="***" -e GAME="***:***" gocentral`
# GoCentral
A Rock Band 3 master server re-implementation written in Golang using MongoDB as the database layer and my Quazal Rendez-vous-compatible forks of [nex-go](https://github.com/ihatecompvir/nex-go)/[nex-protocols-go](https://github.com/ihatecompvir/nex-protocols-go) as the underlying server layer. 

Note that this only aims to replicate what the game calls "Rock Central", support for the Music Store is _not_ here and will never be added. Just buy the songs through the Xbox Live Marketplace or PlayStation Store instead.

## Platform Compatibility
- PS3 (real hardware and RPCS3)
- Wii (real hardware and Dolphin)
- Xbox 360 (real hardware, requires RB3Enhanced)

## Setup and Usage
COMING SOON

## Features Implemented
- Message of the Day
- Online Matchmaking
- Leaderboards (WIP)
- Entity storage (characters, bands)
- Linked account spoofing to unlock the "Link Your Account to Rockband.com" goal/achievement

## Features Coming In the Future
- [Crossplay between PS3 and Wii](https://www.youtube.com/watch?v=KW5NrjDsv00) (requires RB3Enhanced)
- Battle of the Bands
- Setlist Challenges
- Setlist Sharing
- Global rank calculation
- Instaranks ("You are ranked #4 on the Guitar Leaderboard" on the post-song stats screen)
