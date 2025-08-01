import sys
import os
from os import path

sys.path.append(path.abspath('./'))

commands = {
    "-all": "robot -d ./logs src/test",
    "-login": "robot -d ./logs src/test/login.robot",
    "-products": "robot -d ./logs src/test/products.robot",
    "-users": "robot -d ./logs src/test/users.robot",
    "-examples": "robot -d ./logs src/test/examples.robot",
    "-reqres": "robot -d ./logs src/test/reqres.robot",
}

for param in sys.argv[1:]:
    if param in commands:
        command = commands[param]
    else :
        print(f"Parâmetro inválido ou inexistente: {param}")

os.system(command)