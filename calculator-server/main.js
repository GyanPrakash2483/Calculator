const evaluate = require('./evaluate.js')
const express = require('express');
const app = express();
const dotenv = require('dotenv');
dotenv.config();



const PORT = process.env.PORT;

app.use(express.json());

app.post('/evaluate', (req, res) => {
    //console.log(req.body);
    if(!req.body.expression) {
        res.send({
            eval: 'Network Error'
        });
        return;
    }
    res.send({
        eval: evaluate.expression(req.body.expression)
    });
})

app.listen(PORT, () => {
    console.log('Server listening on port ' + PORT);
})