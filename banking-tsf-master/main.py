from flask import Flask, render_template, redirect, request, flash, session
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin, login_manager, login_required, login_user, logout_user, LoginManager, current_user


local_server = True

app = Flask(__name__)
app.secret_key = "sohomneogi"

# app.config['SQL_ALCHEMY_DATABASE_URI']='mysql://username:password@localhost/databasename'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:sohomneogi@localhost/banking'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
# connection of app with the database
# <=====Login Manager====>


login_manager = LoginManager(app)

# this is for getting unique useraccess

login_manager.login_view = 'login'


@login_manager.user_loader
def load_user(user_id):
    return Admin.query.get(int(user_id))


class Test(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))


class Admin(UserMixin, db.Model):
    adminid = db.Column(db.Integer, primary_key=True)
    adminname = db.Column(db.String(100))
    adminpw = db.Column(db.String(100))


class Contact(UserMixin, db.Model):
    contactid = db.Column(db.String(100), primary_key=True)
    name = db.Column(db.String(100))
    email = db.Column(db.String(100))
    message = db.Column(db.String(200))


class Customer(UserMixin, db.Model):
    name = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(100))
    accno = db.Column(db.String(100))
    balance = db.Column(db.Integer)


class Money(UserMixin, db.Model):
    id = db.Column(db.String(100), primary_key=True)
    sender = db.Column(db.String(100))
    receiver = db.Column(db.String(100))
    amount = db.Column(db.String(100))
    status = db.Column(db.String(100))


@app.route('/')
def home():
    return render_template("index.html")


@app.route('/customer')
def customer():
    allcust = Customer.query.all()
    return render_template("allcust.html", allcust=allcust)


@app.route('/sendmoney', methods=['POST', 'GET'])
def sendmoney():
    if request.method == 'POST':
        sender = request.form.get('sender')
        receiver = request.form.get('receiver')
        amount = request.form.get('amount')

        send = Customer.query.filter_by(accno=sender).first()
        receiv = Customer.query.filter_by(accno=receiver).first()

        
        if send and receiv:
            bal = (send.balance)-int(amount)
            receivbal = receiv.balance + int(amount)
            print(bal)
            print(receivbal)
            if bal >= 0:
                new_user = db.engine.execute(
                f"INSERT INTO `money` (`sender`,`receiver`,`amount`,status) VALUES ('{sender}','{receiver}','{amount}','Success') ")
                db.engine.execute(
                f"UPDATE `customer` SET `name` ='{send.name}',`email`='{send.email}',`accno`='{send.accno}',`balance`='{bal}' WHERE `accno`='{sender}'")
                db.engine.execute(
                f"UPDATE `customer` SET `name` ='{receiv.name}',`email`='{receiv.email}',`accno`='{receiv.accno}',`balance`='{receivbal}' WHERE `accno`='{receiver}'")
                flash("Amount Transferred Successfully", "info")
                return redirect("/sendmoney")

            else:
                new_user = db.engine.execute(
                f"INSERT INTO `money` (`sender`,`receiver`,`amount`,status) VALUES ('{sender}','{receiver}','{amount}','Failed') ")
                flash("Transaction Failed", "danger")
                return redirect("/sendmoney")
        else:
            flash("Invalid Account Number", "warning")
            

    return render_template("sendmoney.html")


@app.route('/sendmoneyy/<string:accno>', methods=['POST', 'GET'])
def sendmoneyy(accno):
    cust=Customer.query.filter_by(accno=accno).first()
    

    return render_template("ssend.html",cust=cust)



@app.route('/checkbal',methods=['POST', 'GET'])
def checlbal():
    if request.method == 'POST':
        accno=request.form.get('accno')
        acc=Customer.query.filter_by(accno=accno).first()
        if acc:
            bal=acc.balance
            message= f"Account Balance is {bal}"
            flash(message,"success")
            return redirect("/checkbal")
        else:
            flash("Invaid Account Number","warning")
            return redirect("/checkbal")

    return render_template("checkbal.html",)

@app.route('/transaction')
def transaction():
    alltrans = Money.query.all()

    return render_template("trans.html", alltrans=alltrans)


@app.route('/contact')
def contact():
    return render_template("contact.html")


@app.route('/test')
def test():
    try:
        a = Test.query.all()
        print(a)
        return f'database is connected'

    except Exception as e:
        print(e)
        return f'My database is not connected {e}'


if __name__ == "__main__":
    app.run(debug=True)
