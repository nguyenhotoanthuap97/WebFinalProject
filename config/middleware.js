const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const session = require('express-session');
const cookieParser = require("cookie-parser");
const expressValidator = require("express-validator");
const flash = require('connect-flash');
const layout = require('../apps/models/products');
const q = require('q');

module.exports = function(app) {

    app.use(express.static("public"));

    app.use(bodyParser.urlencoded({
        extended: true
    }));
    app.use(bodyParser.json());
    app.use(cookieParser());

    //Express Session
    app.use(session({
        secret: 'secret',
        saveUninitialized: true,
        resave: true
    }))
    
    app.use(expressValidator({
        errorFormatter: function(param, msg, value) {
            var namespace = param.split('.'),
            root = namespace.shift(),
            formParam = root;

            while(namespace.length) {
                formParam += '[' + namespace.shift() + ']';
            }
            return {
                param: formParam,
                msg: msg,
                value: value
            }
        }
    }));

    app.use(flash());

    app.use(function(req, res, next) {
        res.locals.success_msg = req.flash('success_msg');
        res.locals.error_msg = req.flash('error_msg');
        res.locals.error = req.flash('error');
        
        q.all([layout.getBrands(),layout.getTypes()]).spread(function(temp1,temp2) {
            res.locals.brandsList = temp1;
            res.locals.typesList = temp2;
        })
        next();

    });

    // app.use(function(req, res, next) {
    //     categoryDB.getTypes().then(rows =>{
    //         res.locals.layoutVM = {
    //             brandsList: rows
    //         };
    //         next();
    //     });
    // });
    
}