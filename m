Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B3DC10DC1
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 22:43:31 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.51545.1701902602068878457
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 14:43:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=YRMz/UoS;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1B6019C3645;
	Wed,  6 Dec 2023 17:43:21 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id hEYQ4h7n1KAv; Wed,  6 Dec 2023 17:43:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4658F9C406A;
	Wed,  6 Dec 2023 17:43:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 4658F9C406A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701902600; bh=44DQ/ovLoq9/yvERhR2Ke//3Tlv6K3kjOSHAKtvpNNc=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=YRMz/UoSA++dg8Ii55NscNFPZ/Yu/U1lEBvEzNfoJpH3FUcFwZSL7DzvgPg9ur9lW
	 mGqgT11xuxgImf1P0SrfpaGWiAhnUomvSSvPvJoPyeGHHwq8RKeMYEaqW7UMSeKerB
	 /z0E7yWIkW4+jHEHhgGfNUdrXTfCEEufmDoASVHLd3XKV0xUN++WlDV5JnEeBxY3wS
	 mcyhitlWb/OYa/GAzpWyncgBkf9dWnnjBXPJMfYo3PacO9hw7l5YNyfZYUjw1tWZ8i
	 KPBaCvc9gAqPIGAyMLvHgBpaPbzMsXyZjPykIfaeu3aKF+b5MUHAq+Y9Fqf3DoKmOq
	 w3bqxJ9oAwn4w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xDusbt5C26sX; Wed,  6 Dec 2023 17:43:20 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2425B9C3552;
	Wed,  6 Dec 2023 17:43:20 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [toaster][PATCHv3 3/3] toaster: Update eventreplay functionality for new eventlog file structure
Date: Wed,  6 Dec 2023 17:43:05 -0500
Message-Id: <20231206224305.34686-4-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206224305.34686-1-marlon.rodriguez-garcia@savoirfairelinux.com>
References: <20231206224305.34686-1-marlon.rodriguez-garcia@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 22:43:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15622

Added class EventPlayer to list of libraries under bitbake/bb/ui/
Update file read functionality to match new eventlog format

Exclude listing of files that don't contain the allvariables definitions =
used to replay builds
This part of the feature should be revisited. Over a long period of time,=
 the BB_DEFAULT_EVENTLOG
will exponentially increase the size of the log file and cause bottleneck=
s when importing.

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 lib/bb/ui/eventreplay.py        |  85 +++++++++++++++++++++
 lib/toaster/toastergui/views.py | 131 ++++++++++++--------------------
 2 files changed, 132 insertions(+), 84 deletions(-)
 create mode 100644 lib/bb/ui/eventreplay.py

diff --git a/lib/bb/ui/eventreplay.py b/lib/bb/ui/eventreplay.py
new file mode 100644
index 00000000..b5999a1b
--- /dev/null
+++ b/lib/bb/ui/eventreplay.py
@@ -0,0 +1,85 @@
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
\ No newline at end of file
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/vie=
ws.py
index 2e34c8a2..cac72d36 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -8,12 +8,12 @@
=20
 import ast
 import re
-import pickle
-import codecs
 import subprocess
+import sys
=20
 import bb.cooker
 from bb.ui import toasterui
+from bb.ui import eventreplay
=20
 from django.db.models import F, Q, Sum
 from django.db import IntegrityError
@@ -1957,71 +1957,6 @@ if True:
         except (ObjectDoesNotExist, IOError):
             return toaster_render(request, "unavailable_artifact.html")
=20
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
-            event_str =3D json.loads(line)['vars'].encode('utf-8')
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
-
=20
 class CommandLineBuilds(TemplateView):
     model =3D EventLogsImports
@@ -2038,7 +1973,14 @@ class CommandLineBuilds(TemplateView):
             files_list =3D []
=20
             # Filter files that end with ".json"
-            event_files =3D [file for file in files if file.endswith(".j=
son")]
+            event_files =3D []
+            for file in files:
+                if file.endswith(".json"):
+                    # because BB_DEFAULT_EVENTLOG is a directory, we nee=
d to check if the file is a valid eventlog
+                    with open("{}/{}".format(logs_dir, file)) as efile:
+                        content =3D efile.read()
+                        if 'allvariables' in content:
+                            event_files.append(file)
=20
             #build dict for template using db data
             for event_file in event_files:
@@ -2077,7 +2019,6 @@ class CommandLineBuilds(TemplateView):
         imported_files =3D EventLogsImports.objects.all()
         try:
             if all_files =3D=3D 'true':
-
                 # use of session variable to deactivate icon for builds =
in progress
                 request.session['all_builds'] =3D True
                 request.session.modified =3D True
@@ -2090,10 +2031,17 @@ class CommandLineBuilds(TemplateView):
                     else:
                         with open("{}/{}".format(logs_dir, file.get('nam=
e'))) as eventfile:
                             # load variables from the first line
-                            variables =3D json.loads(eventfile.readline(=
).strip())['allvariables']
-
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
                             params =3D namedtuple('ConfigParams', ['obse=
rve_only'])(True)
-                            player =3D EventPlayer(eventfile, variables)
+                            player =3D eventreplay.EventPlayer(eventfile=
, variables)
=20
                             toasterui.main(player, player, params)
                         event_log_import =3D EventLogsImports.objects.cr=
eate(name=3Dfile.get('name'), imported=3DTrue)
@@ -2104,20 +2052,27 @@ class CommandLineBuilds(TemplateView):
                     file =3D self.request.FILES['eventlog_file']
                 else:
                     file =3D request.POST.get('file')
-
-                # use of session variable to deactivate icon for build i=
n progress=20
-                request.session['file'] =3D file
-                request.session['all_builds'] =3D False
-                request.session.modified =3D True
-                request.session.save()
+                    # use of session variable to deactivate icon for bui=
ld in progress=20
+                    request.session['file'] =3D file
+                    request.session['all_builds'] =3D False
+                    request.session.modified =3D True
+                    request.session.save()
=20
                 if imported_files.filter(name=3Dfile).exists():
                     imported_files.filter(name=3Dfile)[0].imported =3D T=
rue
                 else:=20
                     if isinstance(file, InMemoryUploadedFile) or isinsta=
nce(file, TemporaryUploadedFile):
-                        variables =3D json.loads(file.readline().strip()=
)['allvariables']
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
                         params =3D namedtuple('ConfigParams', ['observe_=
only'])(True)
-                        player =3D EventPlayer(file, variables)
+                        player =3D eventreplay.EventPlayer(file, variabl=
es)
                         if not os.path.exists('{}/{}'.format(logs_dir, f=
ile.name)):
                             fs =3D FileSystemStorage(location=3Dlogs_dir=
)
                             fs.save(file.name, file)
@@ -2125,18 +2080,26 @@ class CommandLineBuilds(TemplateView):
                     else:
                         with open("{}/{}".format(logs_dir, file)) as eve=
ntfile:
                             # load variables from the first line
-                            variables =3D json.loads(eventfile.readline(=
).strip())['allvariables']
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
                             params =3D namedtuple('ConfigParams', ['obse=
rve_only'])(True)
-                            player =3D EventPlayer(eventfile, variables)
+                            player =3D eventreplay.EventPlayer(eventfile=
, variables)
                             toasterui.main(player, player, params)
                     event_log_import =3D EventLogsImports.objects.create=
(name=3Dfile, imported=3DTrue)
                     event_log_import.build_id =3D Build.objects.last().i=
d
                     event_log_import.save()
                     request.session['file'] =3D ""
-        except json.decoder.JSONDecodeError:
+        except Exception:
             messages.add_message(
                 self.request,
-                messages.SUCCESS,
+                messages.ERROR,
                 "The file content is not in the correct format. Update f=
ile content or upload a different file."
             )
             return HttpResponseRedirect("/toastergui/cmdline/")
--=20
2.34.1


