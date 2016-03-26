from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    try:
       	flask_ver = Flask.__version__
    except AttributeError:
    	import pkg_resources
    	flask_ver = pkg_resources.get_distribution('Flask').version
    finally:
    	return 'Flask version ' + flask_ver + ' Docker container!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
