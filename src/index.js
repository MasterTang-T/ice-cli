#! /usr/bin/env node

const program = require('commander')
const {
    promisify
} = require('util')
const fs = require('fs')
const path = require('path')
const figlet = promisify(require('figlet'))
const clear = require('clear')
const chalk = require('chalk')
const ora = require('ora')
// 绿色字体打印
const logGreen = (content) => {
    console.log(chalk.green(content))
}
// 黄色字体打印
const logYellow = (content) => {
    console.log(chalk.yellow(content))
}
// 
const logRed = (content) => {
    console.log(chalk.redBright(content))
}

const WELCOME_MSG = `ICE-CLI`;
const NOT_FIND_FILE = 'NOT FIND FILE'
const BEGIN_READ_FILE = `reading  `
const READ_FINISH = `Read Finished`

program.version(require('../package.json').version)

program.command('init <iceFileName>')
    .action(async (name) => {
        clear()
        const welcomeMsg = await figlet(WELCOME_MSG)
        const filePath = path.resolve(__dirname, '..', name)
        const clientPath = filePath.replace('.ice', '.js')
        logGreen(welcomeMsg)
        if (fs.existsSync(filePath)) {
            const process_ora = ora(`${BEGIN_READ_FILE}${name}`)
            process_ora.start()
            const fileContent = fs.readFileSync(filePath, 'utf-8').toString();
            process_ora.succeed()
            logGreen(READ_FINISH)
            const fileDealData = fileDealFunc(fileContent)
            fs.writeFileSync(clientPath, fileDealData)
        } else {
            logRed(NOT_FIND_FILE)
        }
    })


program.parse(process.argv)

const fileDealFunc = (fileContent) => {
    let newFileContentArr = []
    newFileContentArr = fileContent.split('void')
    let str = ``;   
    let strArr = []
    for (let index = 1; index < newFileContentArr.length; index++) {
        const element = newFileContentArr[index]
        strArr.push(`${element.substring(1, element.indexOf('('))}`)
    }
    strArr = JSON.stringify(strArr,null,'\t')
    return strArr
}