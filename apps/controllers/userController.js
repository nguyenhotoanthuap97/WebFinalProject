const userDB = require('../models/user');
const q = require('q');
const helper = require('../helper/bcrypt_password');

let userController = {
    registerPage: function (req, res) {
        res.render("_user/register", {
            layout: "index",
            user: req.session.user
        });
    },
    loginPage: function (req, res) {
        res.render("_user/login", {
            layout: "index"
        });
    },
    changePasswordPage: function (req, res) {
        res.render("_user/changePassword", {
            layout: "index"
        })
    }
    ,
    userRegister: function (req, res) {
        let username = req.body.username;
        let firstname = req.body.firstname;
        let lastname = req.body.lastname;
        let password = req.body.password;
        let password2 = req.body.password2;
        let email = req.body.email;
        let phone = req.body.phone;

        req.checkBody('username', 'Username đang trống').notEmpty();
        req.checkBody('firstname', 'Họ đang trống').notEmpty();
        req.checkBody('lastname', 'Tên đang trống').notEmpty();
        req.checkBody('password', 'Password không hợp lệ').notEmpty();
        req.checkBody('password2', 'Password không tương xứng').equals(password);
        req.checkBody('email', 'Email sai định dạng').isEmail();
        req.checkBody('phone', 'Số điện thoại sai định dạng').isMobilePhone('vi-VN');

        var errors = req.validationErrors();
        if (errors) {
            res.render('_user/register', {
                errors: errors,
                layout: "index"
            })
        }
        else {
            let hashPassword = helper.encryptPassword(password)
            let obj = {
                username,
                password: hashPassword,
                name: firstname + ' ' + lastname,
                email,
                phone
            }
            let p1 = userDB.insertUser(obj)
                .then(success => {
                    req.flash('success_msg', 'Bạn đã đăng kí thành công và có thể đăng nhập');
                    res.redirect("/login");
                })

                .fail(err => {
                    req.flash('error_msg', 'Bạn không đăng kí thành công');
                    res.redirect("/register");
                })

                .catch(err => {
                    req.flash('error', 'Hệ thống bị lỗi')
                    console.log(err);
                });

            let p2 = userDB.insertInfo(obj).catch(err => {
                console.log(err);
            })
            q.all([p1, p2]).spread(err => {
                console.log(err);
            })
        }
    }
    ,
    userLogin: function (req, res) {
        let username = req.body.username;
        let password = req.body.password;

        req.checkBody('username', 'Username đang trống').notEmpty();
        req.checkBody('password', 'Password đang trống').notEmpty();

        var errors = req.validationErrors();
        if (errors) {
            res.render('_user/login', {
                errors: errors,
                layout: "index"
            })
        }
        else {
            userDB.findByUsername(username)
                .then(rows => {
                    if (rows.length > 0) {
                        let type = rows[0].type;
                        let passwordSQL = rows[0].password;
                        //Tạo object để truyền session
                        let user = {
                            username,
                            passwordSQL,
                            type,
                            status: true
                        }

                        if (type < 0) {
                            req.flash('error_msg', 'Tài khoản bị khóa');
                            req.redirect('/login');
                        }
                        else {
                            var checkPass = helper.validPassword(password, passwordSQL);
                            if (checkPass === true) {
                                req.session.user = user;
                                if (user.type == 0)
                                    res.redirect("/");
                                else
                                    res.redirect("/admin");
                            }
                            else {
                                req.flash("error_msg", "Mật khẩu không đúng");
                                res.redirect('/login');
                            }
                        }
                    }
                    else {
                        req.flash('error_msg', 'Username không tồn tại');
                        res.redirect('/login');
                    }
                })
                .catch(err => {
                    console.log(err);
                })
                .fail(err => {
                    req.flash("error_msg", "Đăng nhập thất bại");
                    res.redirect('/login');
                })

                ;
        }

    }
    ,
    userLogout: function (req, res) {
        req.session.destroy();
        res.redirect('/');
    }
    ,
    userChangePassword: function (req, res) {
        let email = req.body.email;
        let password = req.body.password;
        let password_confirmation = req.body.password_confirmation;

        req.checkBody('email', 'Email sai định dạng').isEmail();
        req.checkBody('password', 'Password đang trống').notEmpty();
        req.checkBody('password_confirmation', 'Password không tương xứng').equals(password);

        var errors = req.validationErrors();
        if (errors) {
            res.render('_user/changepassword', {
                errors: errors,
                layout: "index"
            })
        }
        else {
            userDB.findByEmail(email)
                .then(rows => {
                    if (rows.length > 0) {
                        let username = rows[0].username;
                        let hashPassword = helper.encryptPassword(password);

                        //Tạo object để truyền session
                        let user = {
                            username,
                            password: hashPassword,
                            type: 0,
                            status: true
                        }

                        req.session.user = user;
                        userDB.updatePassword(user)
                            .then((success) => {
                                req.flash('success_msg', 'Bạn tạo mật khẩu mới thành công');
                                res.redirect('/login');
                            })
                            /*
                            .fail((error) => {
                                res.flash('error_msg', 'Tạo mật khẩu thất bại');
                                res.redirect('/changepassword');
                            });*/
                            .catch(err => {
                                console.log(err);
                            })
                    }
                    else {
                        req.flash('error_msg', 'Email không tồn tại');
                        res.redirect('/changePassword');
                    }
                })
                .catch(err => {
                    console.log(err);
                })
                .fail(err => {
                    req.flash("error_msg", "Đăng nhập thất bại");
                    res.redirect('/login');
                });
        }
    }

}

module.exports = userController;