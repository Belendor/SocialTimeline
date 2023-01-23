from flask.views import MethodView
from flask_smorest import Blueprint, abort

blp = Blueprint("home", __name__, description = "Home page")

@blp.route("/")
class Item(MethodView):
    @blp.response(200)
    def get(self):
        return "It is a Home page."