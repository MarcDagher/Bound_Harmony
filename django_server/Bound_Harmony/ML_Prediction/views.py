from django.shortcuts import render
from django.http import HttpResponse

def battikha(request):
  try:
    age = request.GET['name']
    if (age):
      return HttpResponse(age)
  except KeyError:
    return HttpResponse("Hi.")