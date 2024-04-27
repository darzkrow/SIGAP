
from django.urls import path
from django.contrib.auth import views as auth_views


from . import views


urlpatterns = [

    path('accounts/logout/', views.logout_view, name='logout'),
    path('accounts/login/', auth_views.LoginView.as_view(), name='login'),

]
