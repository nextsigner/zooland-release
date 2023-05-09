import QtQuick 2.0

Item{
    id: r
    QtObject{
        id: saveZoolParams
        function setData(data, isData){
            if(app.dev){
                log.lv('getUserAndSet:\n'+JSON.stringify(JSON.parse(data), null, 2))
            }
            if(isData){
                let j=JSON.parse(data)
                if(j.isRec){
                    if(app.dev){
                        log.lv('New remote params, id: '+j.params._id)
                    }
                    app.j.showMsgDialog('Zool Informa', 'Los datos se han guardado.', 'Una copia del archivo '+app.currentNom+' ha sido respaldado en el servidor de Zool.')
                }else{
                    app.j.showMsgDialog('Zool Informa Error!', 'Los datos no han sido guardados.', j.msg)
                }

            }else{
                //app.j.showMsgDialog('Zool Informa', 'Los datos no se han guardado en el servidor.', 'No se ha copia del archivo '+app.currentNom+'. No ha sido respaldado en el servidor de Zool.\nPosiblemente usted no esté conectado a internet o el servidor de Zool no se encuentra disponible en estos momentos.')
            }
        }
    }
    function save(j){
        let t=j.params.tipo
        let hsys=j.params.hsys
        let n=j.params.n.replace(/ /g, '%20')
        let d=j.params.d
        let m=j.params.m
        let a=j.params.a
        let h=j.params.h
        let min=j.params.min
        let gmt=j.params.gmt
        let lat=j.params.lat
        let lon=j.params.lon
        let alt=j.params.alt
        let ciudad=j.params.ciudad.replace(/ /g, '%20')
        let ms=j.params.ms
        let msReq=new Date(Date.now()).getTime()
        let url=apps.host
        url+='/zool/saveZoolParams'
        url+='?n='+n
        url+='&d='+d
        url+='&m='+m
        url+='&a='+a
        url+='&h='+h
        url+='&min='+min
        url+='&gmt='+gmt
        url+='&lat='+lat
        url+='&lon='+lon
        url+='&alt='+alt
        url+='&ciudad='+ciudad
        url+='&ms='+ms
        url+='&adminId='+apps.zoolUserId
        url+='&msReq='+msReq
        app.j.getRD(url, saveZoolParams)
    }
    QtObject{
        id: objGetZoolandData
        function setData(data, isData){
            if(isData){
                let j=JSON.parse(data)
                if(j.isData){
                    sweg.loadSweJson(JSON.stringify(j.data, null, 2))
                    //log.lv(JSON.stringify(j.data, null, 2))
                }else{
                    app.j.showMsgDialog('Zool Informa Error!', 'Los datos no han sido guardados.', j.error)
                }

            }else{
                app.j.showMsgDialog('Zool Informa', 'Los datos no se han cargado los datos del servidor Zool-Server.', 'El servidor no está encendido o está fallando la conexión a internet.')
            }
        }
    }
    function getZoolandData(j){
        sweg.load(j)
        app.fileData=JSON.stringify(j)
        let t=j.params.tipo
        let hsys=j.params.hsys
        let n=j.params.n.replace(/ /g, '%20')
        let d=j.params.d
        let m=j.params.m
        let a=j.params.a
        let h=j.params.h
        let min=j.params.min
        let gmt=j.params.gmt
        let lat=j.params.lat
        let lon=j.params.lon
        let alt=j.params.alt
        let ciudad=j.params.ciudad.replace(/ /g, '%20')
        let ms=j.params.ms
        let msReq=new Date(Date.now()).getTime()
        //let url=apps.host
        let url='http://zool.loca.lt'
        url+='/zool/getZoolData'
        url+='?n='+n
        url+='&d='+d
        url+='&m='+m
        url+='&a='+a
        url+='&h='+h
        url+='&min='+min
        url+='&gmt='+gmt
        url+='&lat='+lat
        url+='&lon='+lon
        url+='&alt='+alt
        url+='&ciudad='+ciudad
        url+='&ms='+ms
        url+='&adminId='+apps.zoolUserId
        url+='&msReq='+msReq
        app.j.getRD(url, objGetZoolandData)
    }

    Component.onCompleted: {
        let sj='{"params":{"tipo":"vn","ms":1633701422850,"n":"Ricardo","d":20,"m":6,"a":1975,"h":23,"min":4,"gmt":-3,"lat":-35.4752134,"lon":-69.585934,"ciudad":"Malargue Mendoza Argentina","msmod":1681568075071}}'
        let j=JSON.parse(sj)
        //getZoolandData(j)
    }
}

