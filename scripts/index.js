import open, {openApp, apps} from 'open';
import axios from "axios";



const options = {
    method: 'GET',
    url: 'https://games.roblox.com/v1/games/1537690962/servers/Public',
    params: { cursor: '', sortOrder: 'Asc', excludeFullGames: 'false' },
    headers: {
        accept: 'application/json, text/plain, */*',
        'accept-language': 'en-US,en;q=0.9',
        'cache-control': 'no-cache',
        origin: 'https://www.roblox.com',
        pragma: 'no-cache',
        referer: 'https://www.roblox.com/',
    }
};

function selectServer(servers) {
    const randomServer = servers[Math.floor(Math.random() * servers.length)];
    return randomServer;
}

function main() {
    axios.request(options)
        .then(function (response) {
            const servers = response.data.data;

            const randomServer = selectServer(servers);

            console.log('Selected Server:', randomServer);

            const robloxUrl = `roblox://placeId=17723449397&launchData=1537690962/${randomServer.id}`;

            console.log('Opening Roblox URL:', robloxUrl);
            open(robloxUrl);
        })
        .catch(function (error) {
            console.error(error);
        });
}




main();