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
        priority: 'u=1, i',
        referer: 'https://www.roblox.com/',
        'sec-ch-ua': '"Google Chrome";v="125", "Chromium";v="125", "Not.A/Brand";v="24"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': '"Windows"',
        'sec-fetch-dest': 'empty',
        'sec-fetch-mode': 'cors',
        'sec-fetch-site': 'same-site',
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
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