from django.shortcuts import render, redirect
from django import forms
from django.db import connection
from django.contrib import messages

class LoginForm(forms.Form):
    login_id = forms.CharField(label = 'ID', max_length = 64)
    login_pw = forms.CharField(label = 'PW', max_length = 64)

class AddAgentForm(forms.Form):
    ID = forms.CharField(label = 'Agent ID', max_length = 64)
    PW = forms.CharField(label = 'Agent PW', max_length = 64, required = False)
    Name = forms.CharField(label = 'Agent Name', max_length = 64, required = False)
    Position = forms.CharField(label = 'Agent Position', max_length = 64, required = False)
    Phone = forms.CharField(label = 'Agent Phone', max_length = 64, required = False)

def dictfetchall(cursor):
    columns = [col[0] for col in cursor.description]
    return [
        dict(zip(columns, row))
        for row in cursor.fetchall()
    ]

def login(request):
    if request.method == "GET":
        if request.session.has_key('login_id'):
            login_id = request.session['login_id']
            if login_id == 'admin':
                return redirect('/cms/admin/')
            else:
                return redirect('/cms/agent/')
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
    return redirect('/cms/login/')

def admin(request):
    return render(request, 'cms/adminHome.html')

def addAgent(request):
    if request.method == "GET":
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM AGENT")
            rows = dictfetchall(cursor)
        form = AddAgentForm()
        return render(request, 'cms/addAgent.html', {'rows': rows, 'form': form})
    elif request.method == "POST":
        form = AddAgentForm(request.POST)
        if request.POST['action'] == 'Add Agent':
            if form.is_valid():
                addAgent_id = form.cleaned_data['ID']
                addAgent_pw = form.cleaned_data['PW']
                addAgent_name = form.cleaned_data['Name']
                addAgent_position = form.cleaned_data['Position']
                addAgent_phone = form.cleaned_data['Phone']
                with connection.cursor() as cursor:
                    cursor.execute("SELECT * FROM AGENT WHERE ID = %s", [addAgent_id])
                    row = cursor.fetchall()
                    if not row:
                        cursor.execute('INSERT INTO AGENT VALUES(%s, %s, %s, %s, %s)', [addAgent_id, addAgent_pw, addAgent_name, addAgent_position, addAgent_phone])
                    else:
                        messages.info(request, 'Agent already Exist')
        elif request.POST['action'] == 'Remove Agent':
            if form.is_valid():
                removeAgent_id = form.cleaned_data['ID']
                with connection.cursor() as cursor:
                    cursor.execute('DELETE FROM AGENT WHERE ID = %s', [removeAgent_id])
    return redirect('/cms/admin/addAgent/')

def agent(request):
    return render(request, 'cms/agentHome.html')
