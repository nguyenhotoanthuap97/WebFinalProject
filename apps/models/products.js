const db = require("./database.js");
const q = require('q');

let products = {
    getProducts: function() {
        let d = q.defer();
        let sql = "select name, price, picture from product";
        db.query(sql, (error, results) => {
            if (error) {
                d.reject(error);
            }
            d.resolve(results);       
        });
        return d.promise;
    },
    getBrands: function() {
        let d = q.defer();
        let sql = "select id, name from brand";
        db.query(sql, (error, results) => {
            if (error) {
                d.reject(error);
            }
            d.resolve(results);       
        });
        return d.promise;
    },

    lookProductBrand: function(brand) {
        let d = q.defer();
        let sql = "select name, price, picture from product where brand = ?";
        db.query(sql,[brand], (error, results) => {
            if (error) {
                d.reject(error);
            }
            d.resolve(results);       
        });
        return d.promise;
    },
    lookProductType: function(type) {
        let d = q.defer();
        let sql = "select name, price, picture from product where type = ? ";
        db.query(sql,[type],(error, results) => {
            if (error) {
                d.reject(error);
            }
            d.resolve(results);       
        });
        return d.promise;
    }
}

module.exports = products;