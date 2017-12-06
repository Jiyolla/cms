from django.shortcuts import render, redirect
from django import forms
from django.db import connection

class LoginForm(forms.Form):
    login_id = forms.CharField(label = 'ID', max_length = 64)
    login_pw = forms.CharField(label = 'PW', max_length = 64)

class AddAgentForm(forms.Form):
    addAgent_id = forms.CharField(label = 'Agent ID', max_length = 64)
    addAgent_pw = forms.CharField(label = 'Agent PW', max_length = 64)
    addAgent_name = forms.CharField(label = 'Agent Name', max_length = 64)
    addAgent_position = forms.CharField(label = 'Agent Position', max_length = 64)
    addAgent_phone = forms.CharField(label = 'Agent Phone', max_length = 64)

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
            return redirect('/cms/login')

def logout(request):
    try:
        del request.session['login_id']
    except:
        pass
    return redirect('/cms/login')

def addAgent(request):
    if request.method = "GET":
        fdjk
    elif request.method = "POST":
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM AGENT")
        row = cursor.fetchall()
    form = AddAgentForm(row)
    return render(request, 'cms/addAgent.html', {'form': form})
