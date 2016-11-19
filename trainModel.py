import os
from clarifai import rest
from clarifai.rest import ClarifaiApp as clarifai_api
import sys

# Put this in ~/.clarifai/config
# [clarifai]
# CLARIFAI_APP_ID: ANLt2_JVkxCVtTLmiLwZiXdTJnB166J8Rb6O018i
# CLARIFAI_APP_SECRET: zJRFpCpRPycMNl0jd4-2GVdb1pfiB3-iyIpfA1dh

_CLASS = 'wink'
_DIR = 'training_data/regular/'

clarifai = clarifai_api()

if sys.argv[1] == "0":
    for fn in os.listdir(_DIR):
        if fn != ".DS_Store":
            clarifai.inputs.create_image_from_filename(_DIR + fn, not_concepts=[_CLASS])
else:
    model = clarifai.models.get('gestures')
    model.train()
