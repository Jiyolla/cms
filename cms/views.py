from django.shortcuts import render, redirect, reverse
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

class ChangeInfoForm(forms.Form):
    PW = forms.CharField(label = 'Agent PW', max_length = 64, required = False)
    Name = forms.CharField(label = 'Agent Name', max_length = 64, required = False)
    Position = forms.CharField(label = 'Agent Position', max_length = 64, required = False)
    Phone = forms.CharField(label = 'Agent Phone', max_length = 64, required = False)

class AddCCTVForm(forms.Form):
    ID = forms.CharField(label = 'CCTV ID', max_length = 64)
    Model = forms.CharField(label = 'CCTV Model', max_length = 64, required = False)
    InstallationDate = forms.DateField(label = 'CCTV Installation Date', required = False)
    AGENT_ID = forms.CharField(label = 'Agent ID', max_length = 64, required = False)

class AllocateCCTVForm(forms.Form):
    ID = forms.CharField(label = 'CCTV ID', max_length = 64)
    AGENT_ID = forms.CharField(label = 'Agent ID', max_length = 64)

class SearchCCTVForm(forms.Form):
    ID = forms.CharField(label = 'CCTV ID', max_length = 64, required = False)
    Model = forms.CharField(label = 'CCTV Model', max_length = 64, required = False)
    InstallationDate = forms.DateField(label = 'CCTV Installation Date', required = False)
    AGENT_ID = forms.CharField(label = 'Agent ID', max_length = 64, required = False)

class SearchAgentForm(forms.Form):
    ID = forms.CharField(label = 'Agent ID', max_length = 64, required = False)
    Name = forms.CharField(label = 'Agent Name', max_length = 64, required = False)
    Position = forms.CharField(label = 'Agent Position', max_length = 64, required = False)
    Phone = forms.CharField(label = 'Agent Phone', max_length = 64, required = False)
    CCTV_ID = forms.CharField(label = 'CCTV ID', max_length = 64, required = False)


def dictfetchall(cursor):
    columns = [col[0] for col in cursor.description]
    return [
        dict(zip(columns, row))
        for row in cursor.fetchall()
    ]

def login(request):
    if request.method == 'GET':
        if request.session.has_key('login_id'):
            login_id = request.session['login_id']
            if login_id == 'admin':
                return redirect('/cms/admin/')
            else:
                return redirect('/cms/agent/')
        else:
            form = LoginForm()
            return render(request, 'cms/login.html', {'form': form})
    elif request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            login_id = form.cleaned_data['login_id']
            login_pw = form.cleaned_data['login_pw']
            try:
                cursor = connection.cursor()
                cursor.execute('SELECT * FROM AGENT WHERE ID = %s AND PW = %s', [login_id, login_pw])
                row = cursor.fetchall()
            except:
                messages.info(request, 'DB OPERATION DENIED')
            if row:
                request.session['login_id'] = login_id
        return redirect('/cms/login/')

def logout(request):
    try:
        del request.session['login_id']
    except:
        pass
    return redirect('/cms/login/')

def admin(request, action):
    if request.session.has_key('login_id'):
        if request.session['login_id'] == 'admin':
            if action == 'addAgent/':
                return addAgent(request)
            elif action == 'addCCTV/':
                return addCCTV(request)
            elif action == 'allocateCCTV/':
                return allocateCCTV(request)
            elif action == 'searchCCTV/':
                return searchCCTV(request)
            elif action == 'searchAgent/':
                return searchAgent(request)
            else:
                return render(request, 'cms/adminHome.html')
    return redirect('/cms/login/')

def addAgent(request):
    if request.method == 'GET':
        try:
            rows = []
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM AGENT')
            rows.append('AGENT TABLE')
            rows += dictfetchall(cursor)
        except:
            messages.info(request, 'DB OPERATION DENIED')
        form = AddAgentForm()
        return render(request, 'cms/addAgent.html', {'rows': rows, 'form': form})
    elif request.method == 'POST':
        form = AddAgentForm(request.POST)
        if request.POST['action'] == 'Add Agent':
            if form.is_valid():
                addAgent_id = form.cleaned_data['ID']
                addAgent_pw = form.cleaned_data['PW']
                addAgent_name = form.cleaned_data['Name']
                addAgent_position = form.cleaned_data['Position']
                addAgent_phone = form.cleaned_data['Phone']
                try:
                    cursor = connection.cursor()
                    cursor.execute('INSERT INTO AGENT VALUES(%s, %s, %s, %s, %s)', [addAgent_id, addAgent_pw, addAgent_name, addAgent_position, addAgent_phone])
                except:
                    messages.info(request, 'DB OPERATION DENIED')
        elif request.POST['action'] == 'Remove Agent':
            if form.is_valid():
                removeAgent_id = form.cleaned_data['ID']
                try:
                    cursor = connection.cursor()
                    cursor.execute('DELETE FROM AGENT WHERE ID = %s', [removeAgent_id])
                except:
                    messages.info(request, 'DB OPERATION DENIED')
        return redirect('/cms/admin/addAgent/')

def addCCTV(request):
    if request.method == 'GET':
        try:
            rows = []
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM CCTV')
            rows.append('CCTV TABLE')
            rows += dictfetchall(cursor)
        except:
            messages.info(request, 'DB OPERATION DENIED')
        form = AddCCTVForm()
        return render(request, 'cms/addCCTV.html', {'rows': rows, 'form': form})
    elif request.method == 'POST':
        form = AddCCTVForm(request.POST)
        if request.POST['action'] == 'Add CCTV':
            if form.is_valid():
                addCCTV_id = form.cleaned_data['ID']
                addCCTV_model = form.cleaned_data['Model']
                addCCTV_installation_date = form.cleaned_data['InstallationDate']
                addCCTV_agent_id = form.cleaned_data['AGENT_ID']
                addCCTV_agent_id = 'admin' if addCCTV_agent_id == '' else addCCTV_agent_id
                try:
                    cursor = connection.cursor()
                    cursor.execute('INSERT INTO CCTV VALUES(%s, %s, %s, %s)', [addCCTV_id, addCCTV_model, addCCTV_installation_date, addCCTV_agent_id])
                except:
                    messages.info(request, 'DB OPERATION DENIED')
        elif request.POST['action'] == 'Remove CCTV':
            if form.is_valid():
                removeCCTV_id = form.cleaned_data['ID']
                try:
                    cursor = connection.cursor()
                    cursor.execute('DELETE FROM CCTV WHERE ID = %s', [removeCCTV_id])
                except:
                    messages.info(request, 'DB OPERATION DENIED')
        return redirect('/cms/admin/addCCTV/')

def allocateCCTV(request):
    if request.method == 'GET':
        try:
            rows = []
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM CCTV')
            rows.append('CCTV TABLE')
            rows += dictfetchall(cursor)
            cursor.execute('SELECT * FROM AGENT')
            rows.append('AGENT TABLE')
            rows += dictfetchall(cursor)
        except:
            messages.info(request, 'DB OPERATION DENIED')
        form = AllocateCCTVForm()
        return render(request, 'cms/allocateCCTV.html', {'rows': rows, 'form': form})
    elif request.method == 'POST':
        form = AllocateCCTVForm(request.POST)
        if request.POST['action'] == 'Allocate CCTV':
            if form.is_valid():
                allocateCCTV_id = form.cleaned_data['ID']
                allocateCCTV_agent_id = form.cleaned_data['AGENT_ID']
                try:
                    cursor = connection.cursor()
                    cursor.execute('UPDATE CCTV SET AGENT_ID = %s WHERE ID = %s', [allocateCCTV_agent_id, allocateCCTV_id])
                except:
                    messages.info(request, 'DB OPERATION DENIED')
        elif request.POST['action'] == 'Deallocate CCTV':
            if form.is_valid():
                deallocateCCTV_id = form.cleaned_data['ID']
                deallocateCCTV_agent_id = form.cleaned_data['AGENT_ID']
                try:
                    cursor = connection.cursor()
                    cursor.execute('UPDATE CCTV SET AGENT_ID = \'admin\' WHERE ID = %s', [deallocateCCTV_id])
                except:
                    messages.info(request, 'DB OPERATION DENIED')
        return redirect('/cms/admin/allocateCCTV/')

def searchCCTV(request):
    if request.method == 'GET':
        try:
            rows = []
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM CCTV')
            rows.append('CCTV TABLE')
            rows += dictfetchall(cursor)
        except:
            messages.info(request, 'DB OPERATION DENIED')
        form = SearchCCTVForm()
        return render(request, 'cms/searchCCTV.html', {'rows': rows, 'form': form})
    elif request.method == 'POST':
        form = SearchCCTVForm(request.POST)
        if request.POST['action'] == 'Search CCTV':
            if form.is_valid():
                searchCCTV_id = form.cleaned_data['ID']
                searchCCTV_id = 'TRUE' if searchCCTV_id == '' else 'ID = \'{}\''.format(searchCCTV_id)
                searchCCTV_model = form.cleaned_data['Model']
                searchCCTV_model = 'TRUE' if searchCCTV_model == '' else 'Model = \'{}\''.format(searchCCTV_model)
                searchCCTV_installation_date = form.cleaned_data['InstallationDate']
                searchCCTV_installation_date = 'TRUE' if not searchCCTV_installation_date else 'InstallationDate = \'{}\''.format(searchCCTV_installation_date)
                searchCCTV_agent_id = form.cleaned_data['AGENT_ID']
                searchCCTV_agent_id = 'TRUE' if searchCCTV_agent_id == '' else 'AGENT_ID = \'{}\''.format(searchCCTV_agent_id)
                try:
                    cursor = connection.cursor()
                    cursor.execute('SELECT * FROM CCTV WHERE {} AND {} AND {} AND {}'.format(searchCCTV_id, searchCCTV_model, searchCCTV_installation_date, searchCCTV_agent_id))
                    rows = dictfetchall(cursor)
                    for row in rows:
                        messages.info(request, row)
                except:
                    messages.info(request, 'DB OPERATION DENIED')
        return redirect('/cms/admin/searchCCTV/')

def searchAgent(request):
    if request.method == 'GET':
        try:
            rows = []
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM AGENT')
            rows.append('AGENT TABLE')
            rows += dictfetchall(cursor)
            cursor.execute('SELECT * FROM CCTV')
            rows.append('CCTV TABLE')
            rows += dictfetchall(cursor)
        except:
            messages.info(request, 'DB OPERATION DENIED')
        form = SearchAgentForm()
        return render(request, 'cms/searchAgent.html', {'rows': rows, 'form': form})
    elif request.method == 'POST':
        form = SearchAgentForm(request.POST)
        if request.POST['action'] == 'Search Agent':
            if form.is_valid():
                searchAgent_id = form.cleaned_data['ID']
                searchAgent_id = 'TRUE' if searchAgent_id == '' else 'E.ID = \'{}\''.format(searchAgent_id)
                searchAgent_name = form.cleaned_data['Name']
                searchAgent_name = 'TRUE' if searchAgent_name == '' else 'Name = \'{}\''.format(searchAgent_name)
                searchAgent_position = form.cleaned_data['Position']
                searchAgent_position = 'TRUE' if searchAgent_position == '' else 'Position = \'{}\''.format(searchAgent_position)
                searchAgent_phone = form.cleaned_data['Phone']
                searchAgent_phone = 'TRUE' if searchAgent_phone == '' else 'Phone = \'{}\''.format(searchAgent_phone)
                searchAgent_cctv_id = form.cleaned_data['CCTV_ID']
                searchAgent_cctv_id = 'TRUE' if searchAgent_cctv_id == '' else 'E.ID = C.AGENT_ID AND C.ID = \'{}\''.format(searchAgent_cctv_id)
                print('SELECT E.* FROM AGENT E, CCTV C WHERE {} AND {} AND {} AND {} AND {}'.format(searchAgent_id, searchAgent_name, searchAgent_position, searchAgent_phone, searchAgent_cctv_id))
                try:
                    cursor = connection.cursor()
                    cursor.execute('SELECT DISTINCT E.* FROM AGENT E, CCTV C WHERE {} AND {} AND {} AND {} AND {}'.format(searchAgent_id, searchAgent_name, searchAgent_position, searchAgent_phone, searchAgent_cctv_id))
                    rows = dictfetchall(cursor)
                    for row in rows:
                        messages.info(request, row)
                except:
                    messages.info(request, 'DB OPERATION DENIED')
        return redirect('/cms/admin/searchAgent/')


def agent(request, action):
    if request.session.has_key('login_id'):
        if action == 'changeInfo/':
            return changeInfo(request)
        elif action == 'manageCCTV/':
            return manageCCTV(request)
        elif action == 'uploadData/':
            return uploadData(request)
        else:
            return render(request, 'cms/agentHome.html')
    return redirect('/cms/login/')

def changeInfo(request):
    changeInfo_id = '\'{}\''.format(request.session['login_id'])
    if request.method == 'GET':
        try:
            rows = []
            cursor = connection.cursor()
            cursor.execute('SELECT * FROM AGENT WHERE ID = {}'.format(changeInfo_id))
            rows.append('AGENT INFO')
            rows += dictfetchall(cursor)
        except:
            messages.info(request, 'DB OPERATION DENIED')
        form = ChangeInfoForm()
        return render(request, 'cms/changeInfo.html', {'rows': rows, 'form': form})
    elif request.method == 'POST':
        form = ChangeInfoForm(request.POST)
        if request.POST['action'] == 'Change Info':
            if form.is_valid():
                changeInfo_pw = form.cleaned_data['PW']
                changeInfo_pw = 'PW' if changeInfo_pw == '' else '\'{}\''.format(changeInfo_pw)
                changeInfo_name = form.cleaned_data['Name']
                changeInfo_name = 'Name' if changeInfo_name == '' else '\'{}\''.format(changeInfo_name)
                changeInfo_position = form.cleaned_data['Position']
                changeInfo_position = 'Position' if changeInfo_position == '' else '\'{}\''.format(changeInfo_position)
                changeInfo_phone = form.cleaned_data['Phone']
                changeInfo_phone = 'Phone' if changeInfo_phone == '' else '\'{}\''.format(changeInfo_phone)
                try:
                    cursor = connection.cursor()
                    cursor.execute('UPDATE AGENT SET PW = {}, Name = {}, Position = {}, Phone = {} WHERE ID = {}'.format(changeInfo_pw, changeInfo_name, changeInfo_position, changeInfo_phone, changeInfo_id))
                except:
                    messages.info(request, 'DB OPERATION DENIED')
        return redirect('/cms/agent/changeInfo/')
