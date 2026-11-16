from flask import Flask, jsonify, request
app = Flask(__name__)
@app.get('/health')
def health(): return jsonify(status='ok', service='orders')
@app.post('/api/orders')
def orders():
    data = request.get_json(silent=True) or {}
    try:
        product_id = int(data.get('product_id', 0))
        quantity = int(data.get('quantity', 1))
    except (TypeError, ValueError):
        return jsonify(error='Invalid product or quantity'), 400
    if product_id not in (1, 2, 3) or not 1 <= quantity <= 10:
        return jsonify(error='Choose a valid product and quantity between 1 and 10'), 400
    # Training demo only: no database or payment; order is not persisted.
    return jsonify(message='Demo order accepted', product_id=product_id, quantity=quantity, persisted=False), 201
if __name__ == '__main__': app.run(host='0.0.0.0', port=5000)