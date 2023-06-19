import QtQuick 2.0

Item{
    id: r
    property string host

    QtObject{
        id: saveZoolParams
        function setData(data, isData){
            if(app.dev){
                //log.lv('getUserAndSet:\n'+JSON.stringify(JSON.parse(data), null, 2))
            }
            if(isData){
                let j=JSON.parse(data)
                if(j.isRec){
                    if(app.dev){
                        //log.lv('New remote params, id: '+j.params._id)
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
        let url=r.host+':8100'
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
        const encoded = encodeURI(url);
        console.log('Url saveZoolParams: '+encoded)
        app.j.getRD(""+encoded+"", saveZoolParams)
    }


    //--> Get Zooland Data
    QtObject{
        id: objGetZoolandData
        property var promesaParams
        function setData(data, isData){
            if(vars.dev){
                //zpn.addNot('objGetZoolandData.setData.data: '+data, true, 1000)
            }
            if(isData){
                let j=JSON.parse(data)
                if(j.isData){
                    sweg.loadSweJson(JSON.stringify(j.data, null, 2), objGetZoolandData.promesaParams)
                }else{
                    vars.j.showMsgDialog('Zool Informa Error!', 'Los datos no han sido guardados.', j.error)
                }

            }else{
                vars.j.showMsgDialog('Zool Informa', 'Los datos no se han cargado los datos del servidor Zool-Server.\nHost: '+r.host, 'El servidor no está encendido o está fallando la conexión a internet.')
            }
        }
    }
    function getZoolandData(j){
        objGetZoolandData.promesaParams=j
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
        let url=r.host+':8100'
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
        const encoded = encodeURI(url);
        vars.j.getRD(""+url+"", objGetZoolandData)
        if(vars.dev){
            zpn.addNot('Url objGetZoolandData: '+url, true, 1000)
        }
        console.log('Url: '+url)
    }
    //<-- Get Zooland Data

    //--> Get Zooland Data Back
    QtObject{
        id: objGetZoolandDataBack
        property var promesaParams
        function setData(data, isData){
            if(isData){
                let j=JSON.parse(data)
                if(j.isData){
                    sweg.loadSweJsonBack(JSON.stringify(j.data, null, 2), objGetZoolandDataBack.promesaParams)
                }else{
                    app.j.showMsgDialog('Zool Informa Error!', 'Los datos no han sido guardados.', j.error)
                }

            }else{
                vars.j.showMsgDialog('Zool Informa', 'Los datos no se han cargado los datos del servidor Zool-Server.\nHost: '+r.host, 'El servidor no está encendido o está fallando la conexión a internet.')
            }
        }
    }
    function getZoolandDataBack(j){
        objGetZoolandDataBack.promesaParams=j
        vars.cParamsBack=JSON.stringify(j)
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
        let url=r.host+':8100'
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
        const encoded = encodeURI(url);
        console.log('Url objGetZoolandDataBack: '+encoded)
        vars.j.getRD(""+url+"", objGetZoolandDataBack)
        if(vars.dev){
            zpn.addNot('Url objGetZoolandDataBack: '+url, true, 5000)
        }
        console.log('Url Back: '+url)
    }
    //<-- Get Zooland Data Back


    //--> Get Data Params List
    QtObject{
        id: setZoolandParamsList
        function setData(data, isData){
            if(isData){
                let j=JSON.parse(data)
                //log.lv('setZoolandParamsLis(): '+JSON.stringify(j))
                //zpn.addNot('sdadsa3333', false, 0)
                zsm.getPanel('ZoolRemoteParamsList').load(j)
            }
        }
    }
    function getZoolandParamsList(){
        let msReq=new Date(Date.now()).getTime()
        let url=r.host+':8100'
        url+='/zool/getZoolandParamsList'
        url+='?adminId='+apps.zoolUser+'&r='+msReq
        const encoded = encodeURI(url);
        console.log('Url getZoolandParamsList: '+encoded)
        //zpn.addNot('Url: '+url, false, 0)
        vars.j.getRD(""+url+"", setZoolandParamsList)
    }
    //<-- Get Data Params List



    Component.onCompleted: {
        let fp=unik.getPath(4)+'/host'
        let h=unik.getFile(fp)//.replace(/ /g, '').replace(/\n/g, '')
        if(h==='' || h.lenght < 3){
            h='http://zool.loca.lt'
        }
        if(!vars.dev){
            r.host=h
        }else{
            r.host=h
            //r.host='http://localhost'
        }

        let sj='{"params":{"tipo":"vn","ms":1633701422850,"n":"Ricardo","d":20,"m":6,"a":1975,"h":23,"min":4,"gmt":-3,"lat":-35.4752134,"lon":-69.585934, "alt": 0, "ciudad":"Malargue Mendoza Argentina","msmod":1681568075071}}'
        loadParamsFromString(sj)
    }
    function loadParamsFromString(s){        {
            getZoolandData(JSON.parse(s))
        }
    }
}

