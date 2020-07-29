from __future__ import unicode_literals
from django.db import models

class Profile(models.Model):
    name = models.CharField(max_length = 125)
    description = models.TextField(default = 'description default Text')

    def __unicode__(self):
        return self.name
