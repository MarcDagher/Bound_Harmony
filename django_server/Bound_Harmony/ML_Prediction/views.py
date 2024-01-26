from django.shortcuts import render
from django.http import HttpResponse, JsonResponse

def battikha(request):
    response_data = {
        'method': request.method,
        'path': request.path,
        'parameters': request.GET,
    }
    return JsonResponse(response_data)