from clarifai import rest
from clarifai.rest import ClarifaiApp as clarifai_api

# Put this in ~/.clarifai/config
# [clarifai]
# CLARIFAI_APP_ID: ANLt2_JVkxCVtTLmiLwZiXdTJnB166J8Rb6O018i
# CLARIFAI_APP_SECRET: zJRFpCpRPycMNl0jd4-2GVdb1pfiB3-iyIpfA1dh

clarifai = clarifai_api()

model = clarifai.models.get('gestures')
model.update(concepts_mutually_exclusive=False)
