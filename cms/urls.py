from django.conf.urls import url
from cms import views

urlpatterns = [
    url(r'^login/$', views.login),                              #1, 3
    url(r'^logout/$',views.logout),                             #1, 3
    #url(r'^admin/addAgent/$', views.addAgent),                  #2
    #url(r'^admin/addCCTV/$', views.addCCTV),                    #4
    #url(r'^admin/allocateCCTV/$', views.allocateCCTV),          #5
    #url(r'^admin/searchCCTV/$', views.searchCCTV),              #6
    url(r'^admin/searchAgent/$', views.searchAgent),            #7
    #url(r'^admin/addAdjacentArea/$', views.addAdjacentArea),    #10, 12
    #url(r'^admin/addSequence/$', views.addSequence),            #11
    #url(r'^agent/changeInfo/$', views.changeInfo),              #3
    #url(r'^agent/manageCCTV/$', views.manageCCTV),              #8
    #url(r'^agent/uploadData/$', views.uploadData),              #9
]
