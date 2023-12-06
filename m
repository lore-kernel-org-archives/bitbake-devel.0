Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03523C10F09
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 22:43:32 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.51254.1701902602198322300
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 14:43:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=NWNJv54u;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 837179C3632;
	Wed,  6 Dec 2023 17:43:21 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id LoDAsyVO1zQR; Wed,  6 Dec 2023 17:43:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 129989C2CEF;
	Wed,  6 Dec 2023 17:43:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 129989C2CEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701902600; bh=hUpStVXYsY61plPujuhH6hRXr2iCI7OV6eXxuIo0bwI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=NWNJv54u5fB2PpjcrL1fduLVuSS0dFv+S3FGrOEi/P79++nO4JEyQSw1BRAnzErtm
	 NFG4mmCwAgjmVvOYNebkgTzVFWBhqXlHGKrH6yk81bPY0IqcxkfUuaQjx6jC7BJ226
	 GnxeJAjtg8X7QgOAfpgXubDD2xnbQJE54E4fToP+ZUKOYGkUnGWpkCzGKbX5ERk5VD
	 edjiPgrB5tLA7Qr/9AwwS9R+2vnLegjrojJry/UPVJIB6K2fNLLdN8Cpfz8nSq5rNU
	 ywBWjHp9uD+J0BmhIos9CUGnscMIvEywAE44PHDZEefdeeR/dpkg1TtOsuxW3OAHnC
	 irKWvyseZAgyQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fAPKOm1cM70f; Wed,  6 Dec 2023 17:43:20 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id DC47D9C33CC;
	Wed,  6 Dec 2023 17:43:19 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [toaster][PATCHv3 1/3] toaster: Added feat to import eventlogs files as builds in toaster
Date: Wed,  6 Dec 2023 17:43:03 -0500
Message-Id: <20231206224305.34686-2-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206224305.34686-1-marlon.rodriguez-garcia@savoirfairelinux.com>
References: <20231206224305.34686-1-marlon.rodriguez-garcia@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 22:43:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15624

New feature added to recreate command line builds that are made when toas=
ter is off.
The feature contains a new button on the base template to access a new te=
mplate.
A new model was added to register the information on the builds and gener=
ate access links
A new form was added to include the option to load specific files
This feature uses the value from the variable BB_DEFAULT_EVENTLOG to read=
 the files created by bitbake

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 lib/bb/ui/toasterui.py                        |   2 +-
 .../orm/migrations/0021_eventlogsimports.py   |  22 ++
 lib/toaster/orm/models.py                     |   9 +
 lib/toaster/toastergui/forms.py               |  13 ++
 lib/toaster/toastergui/templates/base.html    |   3 +-
 .../templates/command_line_builds.html        | 171 ++++++++++++++++
 lib/toaster/toastergui/urls.py                |   1 +
 lib/toaster/toastergui/views.py               | 188 +++++++++++++++++-
 8 files changed, 405 insertions(+), 4 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0021_eventlogsimports.py
 create mode 100644 lib/toaster/toastergui/forms.py
 create mode 100644 lib/toaster/toastergui/templates/command_line_builds.=
html

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index ec5bd4f1..6bd21f18 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -385,7 +385,7 @@ def main(server, eventHandler, params):
                     main.shutdown =3D 1
=20
                 logger.info("ToasterUI build done, brbe: %s", brbe)
-                continue
+                break
=20
             if isinstance(event, (bb.command.CommandCompleted,
                                   bb.command.CommandFailed,
diff --git a/lib/toaster/orm/migrations/0021_eventlogsimports.py b/lib/to=
aster/orm/migrations/0021_eventlogsimports.py
new file mode 100644
index 00000000..328eb575
--- /dev/null
+++ b/lib/toaster/orm/migrations/0021_eventlogsimports.py
@@ -0,0 +1,22 @@
+# Generated by Django 4.2.5 on 2023-11-23 18:44
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies =3D [
+        ('orm', '0020_models_bigautofield'),
+    ]
+
+    operations =3D [
+        migrations.CreateModel(
+            name=3D'EventLogsImports',
+            fields=3D[
+                ('id', models.BigAutoField(auto_created=3DTrue, primary_=
key=3DTrue, serialize=3DFalse, verbose_name=3D'ID')),
+                ('name', models.CharField(max_length=3D255)),
+                ('imported', models.BooleanField(default=3DFalse)),
+                ('build_id', models.IntegerField(blank=3DTrue, null=3DTr=
ue)),
+            ],
+        ),
+    ]
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 1098ad3f..19c96862 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1868,6 +1868,15 @@ class Distro(models.Model):
     def __unicode__(self):
         return "Distro " + self.name + "(" + self.description + ")"
=20
+class EventLogsImports(models.Model):
+    name =3D models.CharField(max_length=3D255)
+    imported =3D models.BooleanField(default=3DFalse)
+    build_id =3D models.IntegerField(blank=3DTrue, null=3DTrue)
+
+    def __str__(self):
+        return self.name
+
+
 django.db.models.signals.post_save.connect(invalidate_cache)
 django.db.models.signals.post_delete.connect(invalidate_cache)
 django.db.models.signals.m2m_changed.connect(invalidate_cache)
diff --git a/lib/toaster/toastergui/forms.py b/lib/toaster/toastergui/for=
ms.py
new file mode 100644
index 00000000..a87e5391
--- /dev/null
+++ b/lib/toaster/toastergui/forms.py
@@ -0,0 +1,13 @@
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+from django import forms
+from django.core.validators import FileExtensionValidator
+ =20
+class LoadFileForm(forms.Form):
+    eventlog_file =3D forms.FileField(widget=3Dforms.FileInput(attrs=3D{=
'accept': '.json'}))
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toa=
stergui/templates/base.html
index 041448d1..e90be696 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -132,7 +132,8 @@
             {% if project_enable %}
             <a class=3D"btn btn-default navbar-btn navbar-right" id=3D"n=
ew-project-button" href=3D"{% url 'newproject' %}">New project</a>
             {% endif %}
-          </div>
+            <a class=3D"btn btn-default navbar-btn navbar-right" id=3D"i=
mport_page" style=3D"margin-right: 5px !important" id=3D"import-cmdline-b=
utton" href=3D"{% url 'cmdlines' %}">Import command line builds</a>
+            </div>
       </div>
     </nav>
=20
diff --git a/lib/toaster/toastergui/templates/command_line_builds.html b/=
lib/toaster/toastergui/templates/command_line_builds.html
new file mode 100644
index 00000000..5b085e33
--- /dev/null
+++ b/lib/toaster/toastergui/templates/command_line_builds.html
@@ -0,0 +1,171 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block title %} Import Builds from eventlogs - Toaster {% endblock %}
+
+{% block pagecontent %}
+
+<div class=3D"container-fluid">
+    <div class=3D"row">
+        <div class=3D"col-md-12">
+            <div class=3D"page-header">
+                <div class=3D"row">
+                    <div class=3D"col-md-6">
+                        <h1>Import command line builds</h1>
+                    </div>
+                    {% if import_all %}
+                    <div class=3D"col-md-6">
+                        <button id=3D"import_all" type=3D"button" class=3D=
"btn btn-primary navbar-btn navbar-right">
+                            <span class=3D"glyphicon glyphicon-upload" s=
tyle=3D"vertical-align: top;"></span> Import All
+                        </button>
+                    </div>=20
+                    {% endif %}   =20
+                </div>
+            </div>
+            {% if messages %}
+            <div class=3D"row-fluid" id=3D"empty-state-{{table_name}}">
+                {% for message in messages %}
+                <div class=3D"alert alert-danger">{{message}}</div>
+                {%endfor%}
+            </div>
+            {% endif %}
+            <div class=3D"row">
+                <h4 style=3D"margin-left: 15px;"><strong>Import eventlog=
 file</strong></h4>
+                <form method=3D"POST" enctype=3D"multipart/form-data" ac=
tion=3D"{% url 'cmdlines' %}">=20
+                    {% csrf_token %}=20
+                    <div class=3D"col-md-6" style=3D"padding-left: 20px;=
">
+                        <div class=3D"row">
+                            <input type=3D"hidden" value=3D"{{dir}}" nam=
e=3D"dir">
+                            <div class=3D"col-md-3"> {{ form.eventlog_fi=
le}}  </div>                           =20
+                        </div>
+                        <div class=3D"row" style=3D"padding-top: 10px;">
+                            <div class=3D"col-md-6">=20
+                                <button id=3D"file_import" type=3D"submi=
t" disabled=3D"disabled" class=3D"btn btn-default navbar-btn" >
+                                    <span class=3D"glyphicon glyphicon-u=
pload" style=3D"vertical-align: top;"></span> Import
+                                </button>
+                            </div>
+                        </div>
+                    </div>
+                </form>
+            </div>
+
+            <div class=3D"row" style=3D"padding-top: 20px;">
+                <div class=3D"col-md-6 ">
+                    <h4><strong>Import eventlog files from directory</st=
rong>
+                        <a href=3D"#" data-toggle=3D"tooltip" title=3D"{=
{dir}}">
+                            <svg xmlns=3D"http://www.w3.org/2000/svg" wi=
dth=3D"16" height=3D"16" fill=3D"currentColor" class=3D"bi bi-info-circle=
" viewBox=3D"0 0 16 16" data-toggle=3D"tooltip">
+                                <path d=3D"M8 15A7 7 0 1 1 8 1a7 7 0 0 1=
 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
+                                <path d=3D"m8.93 6.588-2.29.287-.082.38.=
45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.=
545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.3=
75-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
+                            </svg>
+                        </a>
+                    </h4>
+                    {% if files %}
+                    <div class=3D"table-responsive">
+                        <table class=3D"table col-md-4 table-bordered ta=
ble-hover">
+                            <thead>
+                            <tr class=3D"row">
+                                <th scope=3D"col">Name</th>
+                                <th scope=3D"col">Action</th>
+                            </tr>
+                            </thead>
+                            <tbody>
+                                {% for file in files %}
+                                <tr class=3D"row" style=3D"height: 48px;=
">
+                                    <th scope=3D"row" class=3D"col-md-6"=
 style=3D"vertical-align: middle;">
+                                        <input type=3D"hidden" value=3D"=
{{file.name}}" name=3D"{{file.name}}">{{file.name}}
+                                    </th>
+                                    <td class=3D"col-md-6 align-middle" =
style=3D"vertical-align: middle;">
+                                        {% if file.imported =3D=3D True =
and file.build_id is not None %}
+                                            <a href=3D"{% url 'builddash=
board' file.build_id %}">Build Details</a>
+                                        {%else %}
+                                            <a onclick=3D"_ajax_update('=
{{file.name}}', false, '{{dir}}')" data-toggle=3D"tooltip" title=3D"Impor=
t File">
+                                                <span class=3D"glyphicon=
 glyphicon-upload" style=3D"font-size: 18px;"></span>
+                                            </a>
+                                        {%endif%}
+                                    </td>
+                                </tr>
+                                {% endfor%}
+                            </tbody>
+                        </table>
+                    </div>
+                    {% else %}
+                    <div class=3D"row-fluid" id=3D"empty-state-{{table_n=
ame}}">
+                        <div class=3D"alert alert-info">Sorry - no files=
 found</div>
+                    </div>
+                    {%endif%}
+                </div>
+            </div>
+        </div>
+    </div>
+</div>
+
+<script>
+
+function _ajax_update(file, all, dir){
+    function getCookie(name) {
+        var cookieValue =3D null;
+        if (document.cookie && document.cookie !=3D=3D '') {
+            var cookies =3D document.cookie.split(';');
+            for (var i =3D 0; i < cookies.length; i++) {
+                var cookie =3D jQuery.trim(cookies[i]);
+                // Does this cookie string begin with the name we want?
+                if (cookie.substring(0, name.length + 1) =3D=3D=3D (name=
 + '=3D')) {
+                    cookieValue =3D decodeURIComponent(cookie.substring(=
name.length + 1));
+                    break;
+                }
+            }
+        }
+    return cookieValue;
+    }
+    var csrftoken =3D getCookie('csrftoken');
+
+    function csrfSafeMethod(method) {
+        // these HTTP methods do not require CSRF protection
+        return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
+    }
+    $.ajaxSetup({
+        beforeSend: function (xhr, settings) {
+            if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
+                xhr.setRequestHeader("X-CSRFToken", csrftoken);
+            }
+        }
+    });
+
+    $.ajax({
+        url:'/toastergui/cmdline/',
+        type: "POST",
+        data: {file: file, all: all, dir: dir},
+        success:function(data){
+            window.location =3D '/toastergui/builds/'
+        },
+        complete:function(data){      =20
+        },
+        error:function (xhr, textStatus, thrownError){
+            console.log('fail');
+        }
+    });
+}
+
+$('#import_all').on('click', function(){
+    _ajax_update("{{files | safe}}", true, "{{dir | safe}}");
+});
+
+
+$('#import_page').hide();
+
+$(function () {
+  $('[data-toggle=3D"tooltip"]').tooltip()
+})
+
+
+$("#id_eventlog_file").change(function(){
+    console.log($('#file_import'))
+    $('#file_import').prop("disabled", false);
+    $('#file_import').addClass('btn-primary')
+    $('#file_import').removeClass('btn-default')
+})
+
+</script>
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls=
.py
index bc3b0c79..62629494 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -95,6 +95,7 @@ urlpatterns =3D [
         # project URLs
         url(r'^newproject/$', views.newproject, name=3D'newproject'),
=20
+        url(r'^cmdline/$', views.CommandLineBuilds.as_view(), name=3D'cm=
dlines'),
         url(r'^projects/$',
             tables.ProjectsTable.as_view(template_name=3D"projects-toast=
ertable.html"),
             name=3D'all-projects'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/vie=
ws.py
index cc8517ba..a75fba47 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -6,24 +6,36 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import ast
 import re
+import pickle
+import codecs
+import subprocess
+
+import bb.cooker
+from bb.ui import toasterui
=20
 from django.db.models import F, Q, Sum
 from django.db import IntegrityError
-from django.shortcuts import render, redirect, get_object_or_404
+from django.shortcuts import render, redirect, get_object_or_404, HttpRe=
sponseRedirect
 from django.utils.http import urlencode
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe
 from orm.models import LogMessage, Variable, Package_Dependency, Package
 from orm.models import Task_Dependency, Package_File
 from orm.models import Target_Installed_Package, Target_File
 from orm.models import TargetKernelFile, TargetSDKFile, Target_Image_Fil=
e
-from orm.models import BitbakeVersion, CustomImageRecipe
+from orm.models import BitbakeVersion, CustomImageRecipe, EventLogsImpor=
ts
=20
 from django.urls import reverse, resolve
+from django.contrib import messages
+
 from django.core.exceptions import ObjectDoesNotExist
+from django.core.files.storage import FileSystemStorage
+from django.core.files.uploadedfile import InMemoryUploadedFile, Tempora=
ryUploadedFile
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseNotFound, JsonResponse
 from django.utils import timezone
+from django.views.generic import TemplateView
 from datetime import timedelta, datetime
 from toastergui.templatetags.projecttags import json as jsonfilter
 from decimal import Decimal
@@ -32,6 +44,10 @@ import os
 from os.path import dirname
 import mimetypes
=20
+from toastergui.forms import LoadFileForm
+
+from collections import namedtuple
+
 import logging
=20
 from toastermain.logs import log_view_mixin
@@ -41,6 +57,7 @@ logger =3D logging.getLogger("toaster")
 # Project creation and managed build enable
 project_enable =3D ('1' =3D=3D os.environ.get('TOASTER_BUILDSERVER'))
 is_project_specific =3D ('1' =3D=3D os.environ.get('TOASTER_PROJECTSPECI=
FIC'))
+import_page =3D False
=20
 class MimeTypeFinder(object):
     # setting this to False enables additional non-standard mimetypes
@@ -1940,3 +1957,170 @@ if True:
         except (ObjectDoesNotExist, IOError):
             return toaster_render(request, "unavailable_artifact.html")
=20
+class EventPlayer:
+    """Emulate a connection to a bitbake server."""
+
+    def __init__(self, eventfile, variables):
+        self.eventfile =3D eventfile
+        self.variables =3D variables
+        self.eventmask =3D []
+
+    def waitEvent(self, _timeout):
+        """Read event from the file."""
+        line =3D self.eventfile.readline().strip()
+        if not line:
+            return
+        try:
+            event_str =3D json.loads(line)['vars'].encode('utf-8')
+            event =3D pickle.loads(codecs.decode(event_str, 'base64'))
+            event_name =3D "%s.%s" % (event.__module__, event.__class__.=
__name__)
+            if event_name not in self.eventmask:
+                return
+            return event
+        except ValueError as err:
+            print("Failed loading ", line)
+            raise err
+
+    def runCommand(self, command_line):
+        """Emulate running a command on the server."""
+        name =3D command_line[0]
+
+        if name =3D=3D "getVariable":
+            var_name =3D command_line[1]
+            variable =3D self.variables.get(var_name)
+            if variable:
+                return variable['v'], None
+            return None, "Missing variable %s" % var_name
+
+        elif name =3D=3D "getAllKeysWithFlags":
+            dump =3D {}
+            flaglist =3D command_line[1]
+            for key, val in self.variables.items():
+                try:
+                    if not key.startswith("__"):
+                        dump[key] =3D {
+                            'v': val['v'],
+                            'history' : val['history'],
+                        }
+                        for flag in flaglist:
+                            dump[key][flag] =3D val[flag]
+                except Exception as err:
+                    print(err)
+            return (dump, None)
+
+        elif name =3D=3D 'setEventMask':
+            self.eventmask =3D command_line[-1]
+            return True, None
+
+        else:
+            raise Exception("Command %s not implemented" % command_line[=
0])
+
+    def getEventHandle(self):
+        """
+        This method is called by toasterui.
+        The return value is passed to self.runCommand but not used there=
.
+        """
+        pass
+
+
+class CommandLineBuilds(TemplateView):
+    model =3D EventLogsImports
+    template_name =3D 'command_line_builds.html'
+
+    def get_context_data(self, **kwargs):
+        context =3D super(CommandLineBuilds, self).get_context_data(**kw=
args)
+        #get value from BB_DEFAULT_EVENTLOG defined in bitbake.conf
+        eventlog =3D subprocess.check_output(['bitbake-getvar', 'BB_DEFA=
ULT_EVENTLOG', '--value'])
+        if eventlog:
+            logs_dir =3D os.path.dirname(eventlog.decode().strip('\n'))
+            files =3D os.listdir(logs_dir)
+            imported_files =3D EventLogsImports.objects.all()
+            files_list =3D []
+
+            # Filter files that end with ".json"
+            event_files =3D [file for file in files if file.endswith(".j=
son")]
+
+            #build dict for template using db data
+            for event_file in event_files:
+                if imported_files.filter(name=3Devent_file):
+                    files_list.append({
+                        'name': event_file,
+                        'imported': True,
+                        'build_id': imported_files.filter(name=3Devent_f=
ile)[0].build_id
+                    })
+                else:
+                    files_list.append({
+                        'name': event_file,
+                        'imported': False,
+                        'build_id': None
+                    })
+                    context['import_all'] =3D True
+
+            context['files'] =3D files_list
+            context['dir'] =3D logs_dir
+        else:
+            context['files'] =3D []
+            context['dir'] =3D ''
+
+        context['form'] =3D LoadFileForm()
+        context['project_enable'] =3D project_enable
+        return context
+
+    def post(self, request, **kwargs):
+        logs_dir =3D request.POST.get('dir')
+        all_files =3D  request.POST.get('all')
+
+        imported_files =3D EventLogsImports.objects.all()
+        try:
+            if all_files =3D=3D 'true':
+                files =3D ast.literal_eval(request.POST.get('file'))
+                for file in files:
+                    if imported_files.filter(name=3Dfile.get('name')).ex=
ists():
+                        imported_files.filter(name=3Dfile.get('name'))[0=
].imported =3D True
+                    else:
+                        with open("{}/{}".format(logs_dir, file.get('nam=
e'))) as eventfile:
+                            # load variables from the first line
+                            variables =3D json.loads(eventfile.readline(=
).strip())['allvariables']
+
+                            params =3D namedtuple('ConfigParams', ['obse=
rve_only'])(True)
+                            player =3D EventPlayer(eventfile, variables)
+
+                            toasterui.main(player, player, params)
+                        event_log_import =3D EventLogsImports.objects.cr=
eate(name=3Dfile.get('name'), imported=3DTrue)
+                        event_log_import.build_id =3D Build.objects.last=
().id
+                        event_log_import.save()
+            else:
+                if self.request.FILES.get('eventlog_file'):
+                    file =3D self.request.FILES['eventlog_file']
+                else:
+                    file =3D request.POST.get('file')
+
+                if imported_files.filter(name=3Dfile).exists():
+                    imported_files.filter(name=3Dfile)[0].imported =3D T=
rue
+                else:=20
+                    if isinstance(file, InMemoryUploadedFile) or isinsta=
nce(file, TemporaryUploadedFile):
+                        variables =3D json.loads(file.readline().strip()=
)['allvariables']
+                        params =3D namedtuple('ConfigParams', ['observe_=
only'])(True)
+                        player =3D EventPlayer(file, variables)
+                        if not os.path.exists('{}/{}'.format(logs_dir, f=
ile.name)):
+                            fs =3D FileSystemStorage(location=3Dlogs_dir=
)
+                            fs.save(file.name, file)
+                        toasterui.main(player, player, params)
+                    else:
+                        with open("{}/{}".format(logs_dir, file)) as eve=
ntfile:
+                            # load variables from the first line
+                            variables =3D json.loads(eventfile.readline(=
).strip())['allvariables']
+                            params =3D namedtuple('ConfigParams', ['obse=
rve_only'])(True)
+                            player =3D EventPlayer(eventfile, variables)
+                            toasterui.main(player, player, params)
+                    event_log_import =3D EventLogsImports.objects.create=
(name=3Dfile, imported=3DTrue)
+                    event_log_import.build_id =3D Build.objects.last().i=
d
+                    event_log_import.save()
+        except json.decoder.JSONDecodeError:
+            messages.add_message(
+                self.request,
+                messages.SUCCESS,
+                "The file content is not in the correct format. Update f=
ile content or upload a different file."
+            )
+            return HttpResponseRedirect("/toastergui/cmdline/")
+        return HttpResponseRedirect('/toastergui/builds/')
--=20
2.34.1


