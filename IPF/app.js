/**
 * @author David Alexis <alexis06sc2@gmail.com>
 */
import dotenv from 'dotenv'
import express, { json } from 'express'
import { logger, loggerCon } from './app/utils/logger.js'
import RouteLoader from './routeLoader.js'
import cors from 'cors'
import http from 'http'
import os from 'node:os'
dotenv.config()

const app = express()
const routes = await RouteLoader('./app/routes/*.js')
const port = process.env.PORT || 3000
const name = process.env.APP || 'Planner'
const network = os.networkInterfaces().hasOwnProperty('Wi-Fi') ? os.networkInterfaces()['Wi-Fi'][1].address :
os.networkInterfaces().hasOwnProperty('Ethernet') ? os.networkInterfaces()['Ethernet'][1].address : process.env.HOSTNAME
const host = network || 'localhost'

// ✅ Recomendación del principio 'Need to know'
app.disable('x-powered-by')

// ✅ Intercambio de recursos de origen cruzado
app.use(cors())

// ✅ Parsea el cuerpo de las peticiones (JSON)
app.use(json())

// ✅ Front end
app.use(express.static('front-end'))

// ✅ REST API
app.use('/api', routes)

// ✅ Escucha del REST API
const server = http.createServer(app, (req, res) => {
    logger.warn(`404: Not Found: ${req.url}`)
    loggerCon.warn(`404: Not Found: ${req.url}`)
}).listen(port, host, () => {
    logger.info(`Server ${name} running and listening on http://${host}:${port}`)
    loggerCon.info(`Server ${name} running and listening on http://${host}:${port}`)
})

// ✅ Manejando señales
function signalHandler(signal) {
    server.close(() => {
        logger.warn(`Receive signal: ${signal}, Server Close`)
        loggerCon.warn(`Receive signal: ${signal}, Server Close`)
        process.exit(0)
    })
}

process.on('SIGINT', signalHandler)
process.on('SIGTERM', signalHandler)
process.on('SIGQUIT', signalHandler)
process.on('SIGBREAK', signalHandler)