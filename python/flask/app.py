from flask import Flask

from routes import views

app = Flask(__name__)
app = Flask(__name__,
            static_url_path='/assets',
            static_folder='./assets')

app.register_blueprint(views.app)

if __name__ == "__main__":
    print(app.url_map)
    app.run(host='0.0.0.0', port=8630)

