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
const ora = require('ora') // 进度条

const handlebars = require('handlebars') // 模板

// 绿色字体打印
const logGreen = (content) => {
    console.log(chalk.green(content))
}
// 黄色字体打印
const logYellow = (content) => {
    console.log(chalk.yellow(content))
}
// 红色字体打印
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
        const filePath = path.resolve(__dirname, '../input', name)
        let clientPath = path.resolve(__dirname, '../output', name)
        clientPath = clientPath.replace('.ice', '.json')
        logGreen(welcomeMsg)
        if (fs.existsSync(filePath)) {
            const process_ora = ora(`${BEGIN_READ_FILE}${name}`)
            process_ora.start()
            const fileContent = fs.readFileSync(filePath, 'utf-8').toString();
            process_ora.succeed()
            logGreen(READ_FINISH)
            const fileDealData = fileDealFunc(fileContent)
            fs.writeFileSync(clientPath, fileDealData)
            renderClientJS(clientPath)
            renderIceJS(clientPath)
        } else {
            logRed(NOT_FIND_FILE)
        }
    })
program.parse(process.argv)
// 处理读取到的ice文件内容
const fileDealFunc = (fileContent) => {
    let newFileContentArr = []
    newFileContentArr = fileContent.split('void')
    let str = ``;
    let strArr = []
    for (let index = 1; index < newFileContentArr.length; index++) {
        const element = newFileContentArr[index]
        strArr.push(`${element.substring(1, element.indexOf('('))}`)
    }
    strArr = JSON.stringify(strArr, null, '\t')
    return strArr
}
// 渲染client.js 模板
const renderClientJS = (clientPath) => {
    const fileData = fs.readFileSync(clientPath).toString();
    const CLIENT_TEMPLATE = path.resolve(__dirname, '../input/template/Client.js.hbs')
    compile({
        methodsArr: fileData
    }, clientPath, CLIENT_TEMPLATE)
}
// 渲染 ice对应的js模板
const renderIceJS = (iceJsonPath) => {
    const fileData = JSON.parse(fs.readFileSync(iceJsonPath).toString());
    const ICE_JS_PATH = iceJsonPath.replace('.json','.js')
    // 处理参数数组文件，写入对应的js模板中
    const ICE_JS_TEMPLATE = path.resolve(__dirname, '../input/template/IceBusiness.js.hbs')
    if (fs.existsSync(ICE_JS_TEMPLATE)) {
        const content = fs.readFileSync(ICE_JS_TEMPLATE).toString()
        let methodsObj = {}
        const paramArr = [, , , , , , [[7]], [[7]], , , ]
        if(fileData instanceof Array){
            for (let index = 0; index < fileData.length; index++) {
                const element = fileData[index];
                methodsObj[element] =  paramArr
            }
        }
        const result = handlebars.compile(content)({
            methodsObj:JSON.stringify(methodsObj,null,'\t')
        })
        fs.writeFileSync(ICE_JS_PATH, result);
    }
}
// 编译client.js
/**
 * @param {Object}  meta-数据定义
 * @param {String}  filePath-目标文件路径
 * @param {String}  templatePath-模板文件路径
 * @return {void}
 */
const compile = (meta, filePath, templatePath) => {
    const filename = splitPath(filePath);
    const templateName = splitPath(templatePath);
    let FILEPATH = filePath.replace(filename, templateName)
    FILEPATH = FILEPATH.replace('.json', '.js')
    if (fs.existsSync(templatePath)) {
        const content = fs.readFileSync(templatePath).toString()
        const result = handlebars.compile(content)(meta)
        fs.writeFileSync(FILEPATH, result);
    }
}
// 分割路径
splitPath = (path) => {
    const a =path.indexOf('.js') == -1? path.split('.json')[0]:path.split('.js')[0];
    const b = a.indexOf("/") !== -1 ? a.split('/') : a.split("\\");
    const c = b[b.length - 1];
    return c
}