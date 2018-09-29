from flask import Blueprint, render_template, jsonify

app = Blueprint('views', __name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/heartbeat', methods=['GET'])
def test():
    return jsonify({'status': 'ok'})
