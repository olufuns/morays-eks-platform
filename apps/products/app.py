from flask import Flask, jsonify
app = Flask(__name__)
PRODUCTS = [
    {"id": 1, "name": "Cloud Starter", "price": 29, "description": "Learn cloud basics"},
    {"id": 2, "name": "DevOps Essentials", "price": 49, "description": "Build a deployment pipeline"},
    {"id": 3, "name": "Kubernetes Pro", "price": 79, "description": "Manage microservices on EKS"},
]
@app.get('/health')
def health(): return jsonify(status='ok', service='products')
@app.get('/api/products')
def products(): return jsonify(PRODUCTS)
if __name__ == '__main__': app.run(host='0.0.0.0', port=5000)
