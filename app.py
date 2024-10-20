from flask import Flask, request, send_file
import subprocess

app = Flask(__name__)

@app.route('/generate', methods=['POST'])
def generate_image():
    prompt = request.json.get('prompt', '')
    if prompt:
        subprocess.run(['python3', 'tiny_optimizedSD/tiny_txt2img.py', '--prompt', prompt])
        return send_file('output_image.png', mimetype='image/png')
    return 'Invalid request', 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
    
