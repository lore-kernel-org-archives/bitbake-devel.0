Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA51C46CA3
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 16:47:29 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.583.1702313244772648984
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Dec 2023 08:47:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=VTDRUYDN;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 28F3E9C284E;
	Mon, 11 Dec 2023 11:47:24 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id w9RFCbyEe9IR; Mon, 11 Dec 2023 11:47:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C1EE69C3679;
	Mon, 11 Dec 2023 11:47:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C1EE69C3679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702313238; bh=9D0lARxUCAt19PcRkMKwojs70ROw5nGxVNpK4PSB4dc=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=VTDRUYDNJwkYjBmifpt69TGQQtq3e+pKE+DOda398luqByAoojIi6ovMMzgrP2YCs
	 yW89vGAp//quGuqolozitDF8J8O77/SLyodIplzQJkql7mEZmleF0u1+BUCJHKMxBI
	 dA3GkzWfpohPDknGnkQX98UvA6594N4+8g6RCsxtAVKd01NJLj+NU2iYkRmc7GJxaU
	 1m/zGHHD4D8bSOSV1FN3sRqyDURCtdLF24+57t+xEu8kQYzi7+xxDO1+Pmrg8eRyQ/
	 ckhHiTOvHufu3lZdv+5TrTAViEbynOq499c9AqC6zpBrENqbXA2Fn2pV48UhDY8e2n
	 lr/hZf34ia2aQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id uzJLIEVOb-sD; Mon, 11 Dec 2023 11:47:18 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 8A4749C3502;
	Mon, 11 Dec 2023 11:47:18 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [toaster][PATCHv6 1/1] toaster: Added new feature to import eventlogs from command line into toaster using replay functionality
Date: Mon, 11 Dec 2023 11:47:05 -0500
Message-Id: <20231211164705.34450-2-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211164705.34450-1-marlon.rodriguez-garcia@savoirfairelinux.com>
References: <20231211164705.34450-1-marlon.rodriguez-garcia@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Dec 2023 16:47:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15649

Added a new button on the base template to access a new template.
Added a model register the information on the builds and generate access =
links
Added a form to include the option to load specific files
Added jquery and ajax functions to block screen and redirect to build pag=
e when import eventlogs is trigger
Added a new button on landing page linked to import build page, and set m=
in-height of buttons in landing page for uniformity
Removed test assertion to check command line build in content, because ne=
w button contains text
Updated toaster_eventreplay to use library
Fix test in test_layerdetails_page
Rebased from master

This feature uses the value from the variable BB_DEFAULT_EVENTLOG to read=
 the files created by bitbake
Exclude listing of files that don't contain the allvariables definitions =
used to replay builds
This part of the feature should be revisited. Over a long period of time,=
 the BB_DEFAULT_EVENTLOG
will exponentially increase the size of the log file and cause bottleneck=
s when importing.

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 bin/toaster-eventreplay                       |  74 +------
 lib/bb/ui/eventreplay.py                      |  86 ++++++++
 lib/bb/ui/toasterui.py                        |   2 +-
 .../orm/migrations/0021_eventlogsimports.py   |  22 ++
 lib/toaster/orm/models.py                     |   9 +
 .../tests/browser/test_landing_page.py        |   2 -
 .../tests/browser/test_layerdetails_page.py   |   2 +-
 lib/toaster/toastergui/forms.py               |  14 ++
 lib/toaster/toastergui/static/css/default.css |  28 +++
 lib/toaster/toastergui/templates/base.html    |   3 +-
 .../templates/command_line_builds.html        | 198 ++++++++++++++++++
 lib/toaster/toastergui/templates/landing.html |  10 +-
 lib/toaster/toastergui/urls.py                |   1 +
 lib/toaster/toastergui/views.py               | 173 ++++++++++++++-
 14 files changed, 543 insertions(+), 81 deletions(-)
 create mode 100644 lib/bb/ui/eventreplay.py
 create mode 100644 lib/toaster/orm/migrations/0021_eventlogsimports.py
 create mode 100644 lib/toaster/toastergui/forms.py
 create mode 100644 lib/toaster/toastergui/templates/command_line_builds.=
html

diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index f137c71d..74a31932 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -30,77 +30,7 @@ sys.path.insert(0, join(dirname(dirname(abspath(__file=
__))), 'lib'))
=20
 import bb.cooker
 from bb.ui import toasterui
-
-class EventPlayer:
-    """Emulate a connection to a bitbake server."""
-
-    def __init__(self, eventfile, variables):
-        self.eventfile =3D eventfile
-        self.variables =3D variables
-        self.eventmask =3D []
-
-    def waitEvent(self, _timeout):
-        """Read event from the file."""
-        line =3D self.eventfile.readline().strip()
-        if not line:
-            return
-        try:
-            decodedline =3D json.loads(line)
-            if 'allvariables' in decodedline:
-                self.variables =3D decodedline['allvariables']
-                return
-            if not 'vars' in decodedline:
-                raise ValueError
-            event_str =3D decodedline['vars'].encode('utf-8')
-            event =3D pickle.loads(codecs.decode(event_str, 'base64'))
-            event_name =3D "%s.%s" % (event.__module__, event.__class__.=
__name__)
-            if event_name not in self.eventmask:
-                return
-            return event
-        except ValueError as err:
-            print("Failed loading ", line)
-            raise err
-
-    def runCommand(self, command_line):
-        """Emulate running a command on the server."""
-        name =3D command_line[0]
-
-        if name =3D=3D "getVariable":
-            var_name =3D command_line[1]
-            variable =3D self.variables.get(var_name)
-            if variable:
-                return variable['v'], None
-            return None, "Missing variable %s" % var_name
-
-        elif name =3D=3D "getAllKeysWithFlags":
-            dump =3D {}
-            flaglist =3D command_line[1]
-            for key, val in self.variables.items():
-                try:
-                    if not key.startswith("__"):
-                        dump[key] =3D {
-                            'v': val['v'],
-                            'history' : val['history'],
-                        }
-                        for flag in flaglist:
-                            dump[key][flag] =3D val[flag]
-                except Exception as err:
-                    print(err)
-            return (dump, None)
-
-        elif name =3D=3D 'setEventMask':
-            self.eventmask =3D command_line[-1]
-            return True, None
-
-        else:
-            raise Exception("Command %s not implemented" % command_line[=
0])
-
-    def getEventHandle(self):
-        """
-        This method is called by toasterui.
-        The return value is passed to self.runCommand but not used there=
.
-        """
-        pass
+from bb.ui import eventreplay
=20
 def main(argv):
     with open(argv[-1]) as eventfile:
@@ -116,7 +46,7 @@ def main(argv):
             sys.exit("Cannot find allvariables entry in event log file %=
s" % argv[-1])
         eventfile.seek(0)
         params =3D namedtuple('ConfigParams', ['observe_only'])(True)
-        player =3D EventPlayer(eventfile, variables)
+        player =3D eventreplay.EventPlayer(eventfile, variables)
=20
         return toasterui.main(player, player, params)
=20
diff --git a/lib/bb/ui/eventreplay.py b/lib/bb/ui/eventreplay.py
new file mode 100644
index 00000000..d62ecbfa
--- /dev/null
+++ b/lib/bb/ui/eventreplay.py
@@ -0,0 +1,86 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# This file re-uses code spread throughout other Bitbake source files.
+# As such, all other copyrights belong to their own right holders.
+#
+
+
+import os
+import sys
+import json
+import pickle
+import codecs
+
+
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
+            decodedline =3D json.loads(line)
+            if 'allvariables' in decodedline:
+                self.variables =3D decodedline['allvariables']
+                return
+            if not 'vars' in decodedline:
+                raise ValueError
+            event_str =3D decodedline['vars'].encode('utf-8')
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
diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
index f6649a3d..8fe5fea4 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -219,5 +219,3 @@ class TestLandingPage(SeleniumTestCase):
         content =3D self.get_page_source()
         self.assertTrue(self.PROJECT_NAME in content,
                         'should show builds for project %s' % self.PROJE=
CT_NAME)
-        self.assertFalse(self.CLI_BUILDS_PROJECT_NAME in content,
-                         'should not show builds for cli project')
diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/to=
aster/tests/browser/test_layerdetails_page.py
index 367c6179..05ee88b0 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -108,7 +108,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
=20
         self.wait_until_visible("#save-changes-for-switch", poll=3D3)
         btn_save_chg_for_switch =3D self.find("#save-changes-for-switch"=
)
-        btn_save_chg_for_switch.click()
+        self.driver.execute_script("arguments[0].click();", btn_save_chg=
_for_switch)
         self.wait_until_visible("#edit-layer-source")
=20
         # Refresh the page to see if the new values are returned
diff --git a/lib/toaster/toastergui/forms.py b/lib/toaster/toastergui/for=
ms.py
new file mode 100644
index 00000000..10c7ac40
--- /dev/null
+++ b/lib/toaster/toastergui/forms.py
@@ -0,0 +1,14 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+# BitBake Toaster UI tests implementation
+#
+# Copyright (C) 2023 Savoir-faire Linux
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
diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/=
toastergui/static/css/default.css
index 5cd7e211..284355e7 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -367,3 +367,31 @@ h2.panel-title { font-size: 30px; }
   }
 }
 /* End copied in from newer version of Font-Awesome 4.3.0 */
+
+
+#overlay {
+  display: flex;
+  position: fixed;
+  top: 0;
+  left: 0;
+  width: 100%;
+  height: 100%;
+  background-color: rgba(0, 0, 0, 0.7);
+  align-items: center;
+  justify-content: center;
+  z-index: 999;
+}
+
+.spinner {
+  border: 6px solid rgba(255, 255, 255, 0.3);
+  border-radius: 50%;
+  border-top: 6px solid #3498db;
+  width: 50px;
+  height: 50px;
+  animation: spin 1s linear infinite;
+}
+
+@keyframes spin {
+  0% { transform: rotate(0deg); }
+  100% { transform: rotate(360deg); }
+}
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
index 00000000..95944c74
--- /dev/null
+++ b/lib/toaster/toastergui/templates/command_line_builds.html
@@ -0,0 +1,198 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block title %} Import Builds from eventlogs - Toaster {% endblock %}
+
+{% block pagecontent %}
+
+<div class=3D"container-fluid">
+    <div id=3D"overlay" class=3D"hide">
+        <div class=3D"spinner">
+            <div class=3D"fa-spin">
+            </div>
+        </div>
+    </div>
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
tion=3D"{% url 'cmdlines' %}" id=3D"form_file">=20
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
+                <div class=3D"col-md-8 ">
+                    <h4><strong>Eventlogs from existing build directory:=
 </strong>
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
+                        <table class=3D"table col-md-6 table-bordered ta=
ble-hover">
+                            <thead>
+                            <tr class=3D"row">
+                                <th scope=3D"col">Name</th>
+                                <th scope=3D"col">Size</th>
+                                <th scope=3D"col">Action</th>
+                            </tr>
+                            </thead>
+                            <tbody>
+                                {% for file in files %}
+                                <tr class=3D"row" style=3D"height: 48px;=
">
+                                    <th scope=3D"row" class=3D"col-md-4"=
 style=3D"vertical-align: middle;">
+                                        <input type=3D"hidden" value=3D"=
{{file.name}}" name=3D"{{file.name}}">{{file.name}}
+                                    </th>
+                                    <td class=3D"col-md-4 align-middle" =
style=3D"vertical-align: middle;">{{file.size|filesizeformat}}</td>
+                                    <td class=3D"col-md-4 align-middle" =
style=3D"vertical-align: middle;">
+                                        {% if file.imported =3D=3D True =
and file.build_id is not None %}
+                                            <a href=3D"{% url 'builddash=
board' file.build_id %}">Build Details</a>
+                                        {% elif request.session.file =3D=
=3D file.name or request.session.all_builds %}
+                                            <a data-toggle=3D"tooltip" t=
itle=3D"Build in progress">
+                                                <span class=3D"glyphicon=
 glyphicon-upload" style=3D"font-size: 18px; color:grey"></span>
+                                            </a>
+                                        {%else%}
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
+    $('#file_import').prop("disabled", false);
+    $('#file_import').addClass('btn-primary')
+    $('#file_import').removeClass('btn-default')
+})
+
+$(document).ajaxStart(function(){
+    $('#overlay').removeClass('hide');
+    window.setTimeout( =20
+        function() { =20
+            window.location =3D '/toastergui/builds/'
+        }, 10000)
+});
+
+$( "#form_file").on( "submit", function( event ) {
+    $('#overlay').removeClass('hide');
+    window.setTimeout( =20
+        function() { =20
+            window.location =3D '/toastergui/builds/'
+        }, 10000)
+});
+
+</script>
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/=
toastergui/templates/landing.html
index 22bbed69..589ee226 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -15,7 +15,7 @@
               <p>A web interface to <a href=3D"https://www.openembedded.=
org">OpenEmbedded</a> and <a href=3D"https://docs.yoctoproject.org/bitbak=
e.html">BitBake</a>, the <a href=3D"https://www.yoctoproject.org">Yocto P=
roject</a> build system.</p>
=20
 		          <p class=3D"top-air">
-		            <a class=3D"btn btn-info btn-lg" href=3D"http://docs.yocto=
project.org/toaster-manual/setup-and-use.html#setting-up-and-using-toaste=
r">
+		            <a class=3D"btn btn-info btn-lg" href=3D"http://docs.yocto=
project.org/toaster-manual/setup-and-use.html#setting-up-and-using-toaste=
r" style=3D"min-width: 460px;">
 			            Toaster is ready to capture your command line builds
 		            </a>
 		          </p>
@@ -23,7 +23,7 @@
 		          {% if lvs_nos %}
                     {% if project_enable %}
 		            <p class=3D"top-air">
-		              <a class=3D"btn btn-primary btn-lg" href=3D"{% url 'newp=
roject' %}">
+		              <a class=3D"btn btn-primary btn-lg" href=3D"{% url 'newp=
roject' %}" style=3D"min-width: 460px;">
 			              Create your first Toaster project to run manage builds
 		              </a>
 		            </p>
@@ -42,6 +42,12 @@
                 </div>
               {% endif %}
=20
+              <p class=3D"top-air">
+		            <a class=3D"btn btn-info btn-lg" href=3D"{% url 'cmdlines'=
 %}" style=3D"min-width: 460px;">
+			            Import command line event logs from build directory
+		            </a>
+		          </p>
+
               <ul class=3D"list-unstyled lead">
                 <li>
                   <a href=3D"http://docs.yoctoproject.org/toaster-manual=
/index.html#toaster-user-manual">
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls=
.py
index 2c138d3d..7f8489d3 100644
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
index 735d304a..039d3665 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -6,24 +6,36 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import ast
 import re
+import subprocess
+import sys
+
+import bb.cooker
+from bb.ui import toasterui
+from bb.ui import eventreplay
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
@@ -1940,3 +1957,155 @@ if True:
         except (ObjectDoesNotExist, IOError):
             return toaster_render(request, "unavailable_artifact.html")
=20
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
+            event_files =3D []
+            for file in files:
+                if file.endswith(".json"):
+                    # because BB_DEFAULT_EVENTLOG is a directory, we nee=
d to check if the file is a valid eventlog
+                    with open("{}/{}".format(logs_dir, file)) as efile:
+                        content =3D efile.read()
+                        if 'allvariables' in content:
+                            event_files.append(file)
+
+            #build dict for template using db data
+            for event_file in event_files:
+                if imported_files.filter(name=3Devent_file):
+                    files_list.append({
+                        'name': event_file,
+                        'imported': True,
+                        'build_id': imported_files.filter(name=3Devent_f=
ile)[0].build_id,
+                        'size': os.path.getsize("{}/{}".format(logs_dir,=
 event_file))
+                    })
+                else:
+                    files_list.append({
+                        'name': event_file,
+                        'imported': False,
+                        'build_id': None,
+                        'size': os.path.getsize("{}/{}".format(logs_dir,=
 event_file))
+                    })
+                    context['import_all'] =3D True
+
+            context['files'] =3D files_list
+            context['dir'] =3D logs_dir
+        else:
+            context['files'] =3D []
+            context['dir'] =3D ''
+       =20
+        # enable session variable
+        if not self.request.session.get('file'):
+            self.request.session['file'] =3D ""
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
+                # use of session variable to deactivate icon for builds =
in progress
+                request.session['all_builds'] =3D True
+                request.session.modified =3D True
+                request.session.save()
+
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
+                            variables =3D None
+                            while line :=3D eventfile.readline().strip()=
:
+                                try:
+                                    variables =3D json.loads(line)['allv=
ariables']
+                                    break
+                                except (KeyError, json.JSONDecodeError):
+                                    continue
+                            if not variables:
+                                raise Exception("File content missing  b=
uild variables")
+                            eventfile.seek(0)
+                            params =3D namedtuple('ConfigParams', ['obse=
rve_only'])(True)
+                            player =3D eventreplay.EventPlayer(eventfile=
, variables)
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
+                    # use of session variable to deactivate icon for bui=
ld in progress=20
+                    request.session['file'] =3D file
+                    request.session['all_builds'] =3D False
+                    request.session.modified =3D True
+                    request.session.save()
+
+                if imported_files.filter(name=3Dfile).exists():
+                    imported_files.filter(name=3Dfile)[0].imported =3D T=
rue
+                else:=20
+                    if isinstance(file, InMemoryUploadedFile) or isinsta=
nce(file, TemporaryUploadedFile):
+                        variables =3D None
+                        while line :=3D file.readline().strip():
+                            try:
+                                variables =3D json.loads(line)['allvaria=
bles']
+                                break
+                            except (KeyError, json.JSONDecodeError):
+                                continue
+                        if not variables:
+                            raise Exception("File content missing  build=
 variables")
+                        file.seek(0)
+                        params =3D namedtuple('ConfigParams', ['observe_=
only'])(True)
+                        player =3D eventreplay.EventPlayer(file, variabl=
es)
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
+                            variables =3D None
+                            while line :=3D eventfile.readline().strip()=
:
+                                try:
+                                    variables =3D json.loads(line)['allv=
ariables']
+                                    break
+                                except (KeyError, json.JSONDecodeError):
+                                    continue
+                            if not variables:
+                                raise Exception("File content missing  b=
uild variables")
+                            eventfile.seek(0)
+                            params =3D namedtuple('ConfigParams', ['obse=
rve_only'])(True)
+                            player =3D eventreplay.EventPlayer(eventfile=
, variables)
+                            toasterui.main(player, player, params)
+                    event_log_import =3D EventLogsImports.objects.create=
(name=3Dfile, imported=3DTrue)
+                    event_log_import.build_id =3D Build.objects.last().i=
d
+                    event_log_import.save()
+                    request.session['file'] =3D ""
+        except Exception:
+            messages.add_message(
+                self.request,
+                messages.ERROR,
+                "The file content is not in the correct format. Update f=
ile content or upload a different file."
+            )
+            return HttpResponseRedirect("/toastergui/cmdline/")
+        return HttpResponseRedirect('/toastergui/builds/')
--=20
2.34.1


