from django.shortcuts import render, redirect
from django.http import HttpResponseRedirect
from django import forms
from django.db import connection

class LoginForm(forms.Form):
    agent_id = forms.CharField(label = 'Your ID', max_length = 64)
    agent_pw = forms.CharField(label = 'Your PW', max_length = 64)

def login(request):
    if request.method == "GET":
        if request.session.has_key('agent_id'):
            agent_id = request.session['agent_id']
            if agent_id == 'admin':
                return render(request, 'cms/adminHome.html')
            else:
                return render(request, 'cms/agentHome.html')
        else:
            form = LoginForm()
            return render(request, 'cms/login.html', {'form': form})
    elif request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            agent_id = form.cleaned_data['agent_id']
            agent_pw = form.cleaned_data['agent_pw']
            with connection.cursor() as cursor:
                cursor.execute("SELECT * FROM AGENT WHERE ID = %s AND PW = %s", [agent_id, agent_pw])
                row = cursor.fetchall()
                if row:
                    request.session['agent_id'] = agent_id
                return HttpResponseRedirect('/cms/login/')

def logout(request):
    try:
        del request.session['agent_id']
    except:
        pass
    return HttpResponseRedirect('/cms/login')
