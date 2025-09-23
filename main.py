from flask import Flask, render_template, request, redirect, url_for, flash, session
import mysql.connector
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.secret_key = "votre_clef_secrete"  # change par une clé sécurisée

# Connexion à MySQL
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="",        # ton mot de passe MySQL
        database="exercice1"
    )

# Page d'accueil : login et inscription
@app.route("/", methods=["GET", "POST"])
def home():
    if request.method == "POST":
        form_type = request.form.get("form_type")  # distingue login / register

        # Connexion
        if form_type == "login":
            username = request.form["username"]
            password = request.form["password"]

            conn = get_db_connection()
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM users WHERE user_login = %s", (username,))
            user = cursor.fetchone()
            cursor.close()
            conn.close()

            if user and check_password_hash(user["user_password"], password):
                session["user_id"] = user["user_id"]
                session["username"] = user["user_login"]
                flash("Connexion réussie ✅", "success")
                return redirect(url_for("dashboard"))
            else:
                flash("Nom d'utilisateur ou mot de passe incorrect ❌", "danger")

        # Inscription
        elif form_type == "register":
            username = request.form["username"]
            email = request.form["email"]
            password = request.form["password"]
            confirm_password = request.form["confirm_password"]

            if password != confirm_password:
                flash("Les mots de passe ne correspondent pas ❌", "danger")
            else:
                hashed_password = generate_password_hash(password)

                conn = get_db_connection()
                cursor = conn.cursor()
                cursor.execute(
                    "INSERT INTO users (user_login, user_password, user_mail, user_date_new) VALUES (%s, %s, %s, NOW())",
                    (username, hashed_password, email)
                )
                conn.commit()
                cursor.close()
                conn.close()

                flash("Inscription réussie ✅ Vous pouvez maintenant vous connecter.", "success")
                return redirect(url_for("home"))

    return render_template("index.html")

# Dashboard après connexion
@app.route("/dashboard")
def dashboard():
    if "user_id" in session:
        return render_template("dashboard.html", username=session["username"])
    else:
        return redirect(url_for("home"))

# Déconnexion
@app.route("/logout")
def logout():
    session.clear()
    flash("Déconnexion réussie ✅", "info")
    return redirect(url_for("home"))

if __name__ == "__main__":
    app.run(debug=True)
