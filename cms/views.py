from django.shortcuts import render, redirect
from django import forms
from django.db import connection

class LoginForm(forms.Form):
    login_id = forms.CharField(label = 'ID', max_length = 64)
    login_pw = forms.CharField(label = 'PW', max_length = 64)

def login(request):
    if request.method == "GET":
        if request.session.has_key('login_id'):
            login_id = request.session['login_id']
            if login_id == 'admin':
                return render(request, 'cms/adminHome.html')
            else:
                return render(request, 'cms/agentHome.html')
        else:
            form = LoginForm()
            return render(request, 'cms/login.html', {'form': form})
    elif request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            login_id = form.cleaned_data['login_id']
            login_pw = form.cleaned_data['login_pw']
            with connection.cursor() as cursor:
                cursor.execute("SELECT * FROM AGENT WHERE ID = %s AND PW = %s", [login_id, login_pw])
                row = cursor.fetchall()
                if row:
                    request.session['login_id'] = login_id
                return redirect('/cms/login/')

def logout(request):
    try:
        del request.session['login_id']
    except:
        pass
    return redirect('/cms/login')

# 7번 view function & Form class
class SearchAgentForm(forms.Form):
    searchAgent_id = forms.CharField(label = 'ID', max_length = 64)
    searchAgent_pw = forms.CharField(label = 'ID', max_length = 64)
    searchAgent_name = forms.CharField(label = 'ID', max_length = 64)
    searchAgent_position = forms.CharField(label = 'ID', max_length = 64)
    searchAgent_phone = forms.CharField(label = 'ID', max_length = 64)
    searchAgent_cctv = forms.CharField(label = 'ID', max_length = 64)

def searchAgent(request):
