# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2018-02-28 02:58
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('YSE_App', '0016_auto_20180213_0409'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='transienttag',
            name='transients',
        ),
        migrations.AddField(
            model_name='transient',
            name='tags',
            field=models.ManyToManyField(blank=True, to='YSE_App.TransientTag'),
        ),
    ]
