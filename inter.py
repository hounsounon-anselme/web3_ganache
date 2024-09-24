from web3 import Web3
import json

from eth_account import Account


# Se connecter à Ganache local
ganache_url = "http://127.0.0.1:7545"
web3 = Web3(Web3.HTTPProvider(ganache_url))

# Vérifier la connexion
if web3.is_connected():
    print("Connecté à Ganache")
else:
    print("Problème de connexion à Ganache")




# Définir l'adresse du compte qui va interagir avec le contrat
accounts = "0x8d43A2C6992A0b2D7A4530D01C10066D518A9Ae4"
print("Comptes disponibles :", accounts)


# Adresse du contrat déployé (remplacez par l'adresse réelle du contrat déployé)
contract_address = "0xf911Efd5A647f77F01892EEfbBD01a62DB08A527"

# ABI du contrat (obtenez-le après la compilation)
#Charger l'ABI depuis un fichier
with open('/home/anselme/MCS/artifacts/contracts/NoisyCoordinates.sol/NoisyCoordinates.json') as f:
    contract_json = json.load(f)
    contract_abi = contract_json['abi']

# Charger le contrat
contract = web3.eth.contract(address=contract_address, abi=contract_abi)

# Charger le contrat


def send_noisy_coordinates(latitude, longitude):
    tx_hash = contract.functions.submitNoisyCoordinates(latitude, longitude).transact({'from': accounts})
    web3.eth.wait_for_transaction_receipt(tx_hash)
    print(f"Transaction envoyée pour {latitude}, {longitude}")


# Exemples de coordonnées bruitées à envoyer
noisy_coordinates = [
    (1223456, 324567),
    (2234567, 456789),
    (2345678, 567890),
]

# Envoyer les coordonnées une par une
for lat, lon in noisy_coordinates:
    send_noisy_coordinates(lat, lon)

# Récupérer les coordonnées envoyées par l'utilisateur
def get_user_coordinates(user):
    return contract.functions.getCoordinates(user).call()

user_coords = get_user_coordinates(accounts)
print(f"Coordonnées pour l'utilisateur {accounts}: {user_coords}")
