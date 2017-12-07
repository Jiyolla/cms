from django.db import models

# Create your models here.
class File(models.Model):
    VideoFile = models.FileField(upload_to='files', default='')
    LogFile = models.FileField(upload_to='files', default = '')
