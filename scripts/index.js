import open, { openApp, apps } from 'open';
import axios from 'axios';

const options = {
    method: 'GET',
    url: 'https://games.roblox.com/v1/games/1537690962/servers/Public',
    params: { cursor: '', sortOrder: 'Asc', excludeFullGames: 'false' },
    headers: {
        accept: 'application/json, text/plain, */*',
    }
};

function selectServer(servers) {
    const randomServer = servers[Math.floor(Math.random() * servers.length)];
    return randomServer;
}

async function fetchServers(cursor = '', requests = 5) {
    let allServers = [];
    let currentCursor = cursor;

    while (requests > 0) {
        try {
            const response = await axios.request({
                ...options,
                params: { ...options.params, cursor: currentCursor }
            });

            const servers = response.data.data;
            allServers = allServers.concat(servers);

            currentCursor = response.data.nextPageCursor;
            if (!currentCursor) break;
            ``
            requests--;
        } catch (error) {
            console.error('Error fetching servers:', error);
            break;
        }
    }
    return allServers;
}

async function main() {
    const allServers = await fetchServers();

    if (allServers.length > 0) {
        let randomServer = selectServer(allServers);

        while (randomServer.ping > 600) {
            randomServer = selectServer(allServers);
        }

        const robloxUrl = `roblox://placeId=17723449397&launchData=1537690962/${randomServer.id}`;

        // console.log('Selected Server:', randomServer);
        // console.log('Opening Roblox URL:', robloxUrl);
        open(robloxUrl);
    } else {
        console.log('No servers found.');
    }
}


main();
