import functions from 'firebase-functions'
import admin from 'firebase-admin'
import dotenv from 'dotenv'
import fetch from 'node-fetch'
import axios from 'axios'
dotenv.config()
admin.initializeApp()

dotenv.config()
let authToken = 'khbrj2nlxbqyg8ww2n5vhofmnfyvom'
const BASE_URL = 'https://api.igdb.com/v4'
async function generateAuthToken() {
    let data = await axios.post(
        `https://id.twitch.tv/oauth2/token?client_id=${process.env.CLIENT_ID}&client_secret=${process.env.CLIENT_SECRET}&grant_type=client_credentials`
    )
    authToken = data.access_token
}

async function pickGame() {
    let offset = Math.floor(Math.random() * 420)
    let response = await fetch(`${BASE_URL}/games`, {
        method: 'POST',
        headers: {
            'Client-ID': process.env.CLIENT_ID,
            Authorization: `Bearer ${authToken}`,
            'Content-Type': 'application/json'
        },
        body: `
            fields name, screenshots.url, alternative_names.name;
            where follows > 100;
            offset ${offset};
            limit 1;
        `
    })
    return await response.json()
}
export const regenerate_token = functions.https.onCall(async (req, res) => {
    await generateAuthToken()
    res.json({
        msg: 'token regenerated'
    })
})
export const game = functions.https.onCall(async (req, res) => {
    try {
        let game = await pickGame()
        while (game.length === 0 || game[0].screenshots.length === 0) {
            game = await pickGame()
        }
        game = game[0]
        if (game.alternative_names) {
            game.alternative_names = game.alternative_names.map(
                (alternative_name) => alternative_name.name
            )
        } else {
            game.alternative_names = ['']
        }
        if (game.screenshots) {
            game.screenshots = game.screenshots.map(
                (screenshot) =>
                    'https:' +
                    screenshot.url.replace('t_thumb', 't_screenshot_med')
            )
        }
        return game
    } catch (err) {
        throw new functions.https.HttpsError('internal', err)
    }
})
