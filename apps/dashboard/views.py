from django.shortcuts import render, redirect
from django.contrib.auth import views as auth_views
from .forms import CreateUserForms
from django.contrib.auth.forms import UserCreationForm

from django.urls import reverse_lazy
def logout_view(request):
    return auth_views.LogoutView.as_view()(request)


def UserRegister(request):
    content ={
        'form': CreateUserForms()
    }
    return render(request, 'registration/register.html ', content)



