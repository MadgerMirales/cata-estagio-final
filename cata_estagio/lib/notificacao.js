const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

var msgData;

exports.notificacaoTrigger = functions.firestore
.document('Vagas/{vagasId}'
).onCreate((snap, context) => {
    msgData = snap.data();

    admin.firestore().collection('Tokens').get().then((snap) =>{
        var tokens = [];

        if(snap.empty){
            console.log('No Devices');
        }
        else{
            console.log('Tokens ok');

            for(var token of snap.docs){
                tokens.push(token.data().token);
            }
            var payload = {
                "notification": {
                    "title": "Vaga de " + msgData.vaga,
                    "body": "Função " + msgData.descricao,
                    "sound": "default"
                },
                "data":{
                    "sendername": msgData.vaga,
                    "message": msgData.descricao
                }
            }
            return admin.messaging().sendToDevice(tokens, payload).then((response) =>{
                console.log("Notificacao");
            }).catch((err) => {
                console.log(err);
            });
        }
    });
});