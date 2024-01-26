from django.db import models

class Prediction(models.Model):
  result = models.CharField(max_length=50)


