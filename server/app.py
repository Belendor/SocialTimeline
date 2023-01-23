from flask import Flask
from flask_smorest import Api

from routes.home import blp as HomeBlueprint

app = Flask(__name__)

app.config["API_TITLE"] = "Store REST API"
app.config["API_VERSION"] = "prod"
app.config['OPENAPI_VERSION'] = '3.0.3'

api = Api(app)
api.register_blueprint(HomeBlueprint)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)