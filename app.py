from flask import url_for,session,redirect,render_template,request,Flask,flash,logging,request
from flask_mysqldb import MySQL
from wtforms import Form, StringField,TextAreaField,PasswordField,validators
from passlib.hash import sha256_crypt
from functools import wraps
from sqlalchemy import create_engine
import pymysql
import pandas as pd
from leven import benzer

db_connection_str = 'mysql+pymysql://root:@localhost/chatbot'
db_connection = create_engine(db_connection_str)

df = pd.read_sql('SELECT * FROM soru_cevap', con=db_connection)

df = df.drop(["id"],axis=1)


# Kullanıcı giriş decoratorı

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "logged_in" in session:

            return f(*args, **kwargs)
        else:
            flash("Bu sayfayı görüntülemek için lütfen giriş yapınız","danger")
            return render_template("layout.html")
    return decorated_function

# kullanıcı kayıt sınıfı
class RegisterForm(Form):
    name = StringField("İsim Soyisim",validators=[validators.length(min=4,max=30),validators.DataRequired(message="İsim alanı boş bırakılamaz")])
    username = StringField("Kullanıcı Adı",validators=[validators.length(min=5,max=30),validators.DataRequired(message="Kullanıcı Adı alanı boş bırakılamaz")])
    email = StringField("Email Adresi",validators=[validators.Email(message="Geçerli bir email adresi griniz."),validators.DataRequired(message="İsim alanı boş bırakılamaz")])
    password = PasswordField("Parola:",validators=[
        validators.DataRequired(message="Lütfen bir parola belirleyiniz"),
        validators.EqualTo(fieldname= "confirm",message="Parolanız Uyuşmuyor")
    ])
    confirm = PasswordField("Parola Doğrula")

class loginForm(Form):
    username = StringField("Kullanıcı Adı:")
    password_entered = PasswordField("Parola:")

app = Flask(__name__)
app.secret_key = "chatbot"
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "" # veritabanı şifresi
app.config["MYSQL_DB"] = "chatbot"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"

mysql = MySQL(app)

# soru cevap chat alanı

@app.route("/ekle",methods =["GET","POST"])
@login_required
def ekle():
    if request.method == 'POST':
        mesaj = request.form.get('name')
        a = df["soru"]
        b = df["cevap"]

        if mesaj != "":

            for i in df.index:

                x = benzer(a.iloc[i].lower(),mesaj.lower(),ratio_calc=True)
                if x >= 0.70:


                    c = b.iloc[i]
              
                    return render_template("index.html",soru = mesaj,cevap = c)
                else:
                     
                    cursor = mysql.connection.cursor()

                    sorgu = "Insert into cevapsiz_sorular(cevapsiz_soru) VALUES(%s)"
                    cursor.execute(sorgu,(mesaj,))

                    mysql.connection.commit()
                    cursor.close()
                    c = "Bu sorunun cevabı size mail olarak bildirilecek"
                    return render_template("index.html",soru = mesaj,cevap = c)
        
        else:
            flash("Soru Alanı boş bırakılamaz...")

            x = "!!!!!!!! Soru alanı boş..."
            c = "Lütfen bir soru sorunuz soru alanı boş bırakılamaz... "
            render_template("index.html",soru =x,cevap = c)

            
                    

    return render_template("index.html")
#index 

@app.route("/index")
@login_required
def index():

    return render_template("index.html")

# kayıt ol işlemleri
@app.route("/register",methods =["GET","POST"])
def register():
    form = RegisterForm(request.form)
    if request.method == "POST" and form.validate():
        name =     form.name.data
        username = form.username.data
        email =    form.email.data
        password = sha256_crypt.encrypt(form.password.data)

        cursor = mysql.connection.cursor()

        sorgu = "Insert into users(name,email,username,password) VALUES(%s,%s,%s,%s)"
        cursor.execute(sorgu,(name,email,username,password))

        mysql.connection.commit()
        cursor.close()

        flash("Başarıyla Kayıt oldunuz..","success")
        
        return redirect(url_for("login"))

    else:
        
        return render_template("register.html",form = form)

#  Anasayfa
@app.route('/')
def layout():
    return render_template("layout.html")


# login işlemleri
@app.route('/login',methods = ["GET","POST"])
def login():
    form = loginForm(request.form)
    if request.method == "POST":
        username         = form.username.data
        password_entered = form.password_entered.data

        cursor = mysql.connection.cursor()

        sorgu = "Select * from users where username = %s"

        result = cursor.execute(sorgu,(username,))
        if result > 0 :
            data = cursor.fetchone()
            real_password = data["password"]
            if sha256_crypt.verify(password_entered,real_password):
                flash("Başarılı bir şekilde giriş yaptınız...","success")
                session["logged_in"] = True
                session["username"] = username
                return redirect(url_for("index"))
            else:
                flash("Parolanızı yanlış girdiniz..","danger")
                return redirect(url_for("login"))
        else:
            flash("Böyle bir kullanıcı bulunmuyor...","danger")
            return redirect(url_for("login"))

    return render_template("login.html",form = form)

# logout işlemi
@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("layout"))

# Admin girişi
@app.route("/admin",methods = ["GET","POST"])
def admin():

    form = loginForm(request.form)
    if request.method == "POST":

        username         = form.username.data
        password_entered = form.password_entered.data

        cursor = mysql.connection.cursor()

        sorgu = "Select * from admin where username = %s"

        result = cursor.execute(sorgu,(username,))
        if result > 0 :
            data = cursor.fetchone()
            real_password = data["password"]
            if sha256_crypt.verify(password_entered,real_password):
                flash("Başarılı bir şekilde giriş yaptınız...","success")
                session["logged_in"] = True
                session["username"] = username
                return redirect(url_for("dashboard"))
            else:
                flash("Parolanızı yanlış girdiniz..","danger")
                return redirect(url_for("admin"))
        else:
            flash("Böyle bir kullanıcı bulunmuyor...","danger")
            return redirect(url_for("admin"))

   
    return render_template("admin.html",form =form)

# Admin Paneli 

@app.route("/dashboard")
@login_required
def dashboard():

    return render_template("dashboard.html")

# soru cevap alanı dashboard
@app.route("/soru_cevap",methods = ["GET","POST"])
@login_required
def soru_cevap():
     cursor = mysql.connection.cursor()

     sorgu = "select * from soru_cevap"

     result = cursor.execute(sorgu)
     if result > 0:
         sorular = cursor.fetchall()
         return render_template("soru_cevap.html",sorular =sorular)

     else:
         return render_template("soru_cevap.hmtl")

     render_template("soru_cevap.html")

@app.route("/cevapsiz",methods = ["GET","POST"])
@login_required
def cevapsiz():
    cursor = mysql.connection.cursor()

    sorgu = "select * from cevapsiz_sorular"

    result = cursor.execute(sorgu)
    if result > 0:
        sorular = cursor.fetchall()
        return render_template("cevapsiz.html",sorular =sorular)

    else:
        return render_template("cevapsiz.hmtl")

    render_template("cevapsiz.html")

# admin ekleme 
@app.route("/admin_ekle",methods = ["GET","POST"])
@login_required
def admin_ekle():

    form = RegisterForm(request.form)
    if request.method == "POST" and form.validate():

        name =     form.name.data
        username = form.username.data
        email =    form.email.data
        password = sha256_crypt.encrypt(form.password.data)

        cursor = mysql.connection.cursor()

        sorgu = "Insert into admin(name,email,username,password) VALUES(%s,%s,%s,%s)"
        cursor.execute(sorgu,(name,email,username,password))

        mysql.connection.commit()
        cursor.close()

        flash("Kayıt Eklendi..","success")
        
        return redirect(url_for("dashboard"))

    else:
        
        return render_template("admin_ekle.html",form = form)

# soru cevap silme  sayfası

@app.route("/delete/<string:id>")
@login_required
def delete(id):
    cursor = mysql.connection.cursor()

    sorgu = "select * from soru_cevap where id =%s"

    result = cursor.execute(sorgu,(id,))
    if result > 0:
        sorgu2 = "Delete from soru_cevap where id =%s"
        cursor.execute(sorgu2,(id,))
        mysql.connection.commit()
        flash("Silme işlemi başarılı","success")
        return redirect(url_for("soru_cevap"))
    else:
        flash("Silme işlemi başarısız","danger")
        return render_template("soru_cevap.hmtl")

# Güncelleme işlemleri düzenle
@app.route("/cevap_yaz/<string:id>",methods = ["GET","POST"] )
@login_required
def cevap_yaz(id):
    if request.method == "GET":
        cursor = mysql.connection.cursor()
        sorgu = " Select * from cevapsiz_sorular where id = %s"
        cursor.execute(sorgu,(id,))
        form = CevapForm()
        deneme = cursor.fetchone()
        form.soru.data = deneme["cevapsiz_soru"]
        cevap = form.cevap.data
        return render_template("cevap_yaz.html",form = form)
          
    else:
        # post request
        cursor = mysql.connection.cursor()
        form = CevapForm(request.form)
        newsoru = form.soru.data
        newcevap = form.cevap.data
        sorgu2 = "Insert into soru_cevap(soru,cevap) VALUES(%s,%s) "
        cursor.execute(sorgu2,(newsoru,newcevap))
        sorgu3 = "Delete from cevapsiz_sorular where id =%s"
        cursor.execute(sorgu3,(id,))
        mysql.connection.commit()
        cursor.close()
        flash("Başarılı bir şekilde kayıt edildi","success")
        return redirect(url_for("soru_cevap"))

    return render_template("cevapsiz.html")

@app.route("/edit/<string:id>",methods = ["GET","POST"])
@login_required
def update(id):
    if request.method == "GET":
        cursor = mysql.connection.cursor()

        sorgu = "select *from soru_cevap where id = %s"
        result = cursor.execute(sorgu,(id,))

        if result == 0:

            flash("böyle bir soru yok ","danger")
            return render_template("soru_cevap.html")

        else:

           deneme = cursor.fetchone()
           form = CevapForm()

           form.soru.data = deneme["soru"]
           form.cevap.data = deneme["cevap"]
           return render_template("update.html",form = form)

    else:
        # post request

        form = CevapForm(request.form)

        newsoru = form.soru.data
        newcevap = form.cevap.data
        sorgu2 = "Update soru_cevap Set soru = %s, cevap = %s where id = %s "
        cursor = mysql.connection.cursor()
        cursor.execute(sorgu2,(newsoru,newcevap,id))
        mysql.connection.commit()
        
        flash("Güncellendi...","success")
        return redirect(url_for("soru_cevap"))

    return render_template("update.html")

class CevapForm(Form):
    soru = TextAreaField()
    cevap = TextAreaField()

# yeni soru cevap ekleme
@app.route("/yeni_soru",methods = ["GET","POST"])
@login_required
def yeni_soru():
    form = CevapForm(request.form)

    if request.method == "POST":
        cursor = mysql.connection.cursor()
       
        newsoru = form.soru.data
        newcevap = form.cevap.data
        sorgu2 = "Insert into soru_cevap(soru,cevap) VALUES(%s,%s) "
        cursor.execute(sorgu2,(newsoru,newcevap))
        mysql.connection.commit()
        cursor.close()

        flash("Başarılı bir şekilde eklendi....","success")
        return render_template("yeni_soru.html", form = form)
    return render_template("yeni_soru.html", form = form)
   
if __name__ == "__main__":
    app.run(debug=True)