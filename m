Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 18BD272341
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 15:12:18 +0000 (UTC)
Received: by mail-wg0-f43.google.com with SMTP id l18so3918255wgh.16
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 07:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=GQ7OJnhqnNPiSLqlH1/yZGo0/h/ZcTvZWBT6ABb4REw=;
	b=Z4dW8HDyyTo1CdYlg9DtaiqMeKN1LZb7qE0ZSG9QtYC93oTF4B+IUSx7bQwy45GdvW
	mZofvpGhsTIxeTuHeS9pPPOc1bIptLKv1Cd1GWyyHsB7gGCLu2h/wkBVAdYtLQwLIdB9
	TaNyN4bLpp106Pq5lKPvikD/VbNQ4kAFeZCXrpT969fe6UUVdm203B7reITNYQd8Ttwv
	DqCK7fumBwPk7WjCTWaSg+fIK4SsxKTaelZTYi9itKkP4cHiAwXTwiZWj0psz5Ftioau
	eZL8YA2QW7JV1fqbC6rM7q3K6aeryUvXaxFLRTsQfLQISglnmFQMuuF0tQGQ0EzfNZe6
	QVGQ==
X-Gm-Message-State: ALoCoQkWi7ZPGqkQTHsSwAoez2Du52BXbOdIoXcJaMq/Nc3B6FVem971iEXEl02m6GtYJhpq04rk
X-Received: by 10.194.83.42 with SMTP id n10mr7172766wjy.133.1418224338861;
	Wed, 10 Dec 2014 07:12:18 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	dm10sm18278271wib.18.2014.12.10.07.12.17 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Dec 2014 07:12:17 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 6B6865646B9; Wed, 10 Dec 2014 15:12:17 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Dec 2014 15:12:10 +0000
Message-Id: <fd98d0bf2e915ae681bdde5a0de9579ea91da33c.1418224064.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
References: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418224064.git.alexandru.damian@intel.com>
References: <cover.1418224064.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 05/11] toasterui: add extra debug and development infos
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 10 Dec 2014 15:12:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We update and add logs throughout the code in order to help
with development. The extra logging is turned off by default,
but it can be enabled by using environment variables.

All logging happens through the Python logging facilities.

The toaster UI will save a log of all incoming events if the
TOASTER_EVENTLOG variable is set.

If TOASTER_SQLDEBUG is set all DB queries will be logged.

If TOASTER_DEVEL is set and the django-fresh module is available,
the module is enabled to allow auto-reload of pages when the
source is changed.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py                       | 12 ++++++++--
 lib/bb/ui/toasterui.py                             | 19 +++++++--------
 lib/toaster/bldcontrol/localhostbecontroller.py    | 27 ++++++++++++++--------
 .../management/commands/checksettings.py           |  2 +-
 .../bldcontrol/management/commands/runbuilds.py    | 13 +++++++----
 lib/toaster/toastermain/settings.py                | 27 ++++++++++++++++++++--
 lib/toaster/toastermain/urls.py                    | 10 +++++---
 7 files changed, 79 insertions(+), 31 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index e6ea7cd..85d7b28 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -33,6 +33,11 @@ from toaster.orm.models import Task_Dependency, Package_Dependency
 from toaster.orm.models import Recipe_Dependency
 from bb.msg import BBLogFormatter as format
 from django.db import models
+import logging
+
+
+logger = logging.getLogger("BitBake")
+
 
 class NotExisting(Exception):
     pass
@@ -115,7 +120,9 @@ class ORMWrapper(object):
                                     build_name=build_info['build_name'],
                                     bitbake_version=build_info['bitbake_version'])
 
+        logger.debug(1, "buildinfohelper: build is created %s" % build)
         if brbe is not None:
+            logger.debug(1, "buildinfohelper: brbe is %s" % brbe)
             from bldcontrol.models import BuildEnvironment, BuildRequest
             br, be = brbe.split(":")
 
@@ -604,6 +611,7 @@ class BuildInfoHelper(object):
         self.has_build_history = has_build_history
         self.tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
         self.brbe    = self.server.runCommand(["getVariable", "TOASTER_BRBE"])[0]
+        logger.debug(1, "buildinfohelper: Build info helper inited %s" % vars(self))
 
 
     def _configure_django(self):
@@ -1127,10 +1135,10 @@ class BuildInfoHelper(object):
         if 'build' in self.internal_state and 'backlog' in self.internal_state:
             if len(self.internal_state['backlog']):
                 tempevent = self.internal_state['backlog'].pop()
-                print "DEBUG: Saving stored event ", tempevent
+                logger.debug(1, "buildinfohelper: Saving stored event %s " % tempevent)
                 self.store_log_event(tempevent)
             else:
-                print "ERROR: Events not saved: \n", self.internal_state['backlog']
+                logger.error("buildinfohelper: Events not saved: %s" % self.internal_state['backlog'])
                 del self.internal_state['backlog']
 
         log_information = {}
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index d84b256..a85ad5a 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -62,15 +62,6 @@ def _log_settings_from_server(server):
 
 def main(server, eventHandler, params ):
 
-    includelogs, loglines = _log_settings_from_server(server)
-
-    # verify and warn
-    build_history_enabled = True
-    inheritlist, error = server.runCommand(["getVariable", "INHERIT"])
-    if not "buildhistory" in inheritlist.split(" "):
-        logger.warn("buildhistory is not enabled. Please enable INHERIT += \"buildhistory\" to see image details.")
-        build_history_enabled = False
-
     helper = uihelper.BBUIHelper()
 
     console = logging.StreamHandler(sys.stdout)
@@ -80,6 +71,16 @@ def main(server, eventHandler, params ):
     console.setFormatter(format)
     logger.addHandler(console)
 
+    includelogs, loglines = _log_settings_from_server(server)
+
+    # verify and warn
+    build_history_enabled = True
+    inheritlist, error = server.runCommand(["getVariable", "INHERIT"])
+
+    if not "buildhistory" in inheritlist.split(" "):
+        logger.warn("buildhistory is not enabled. Please enable INHERIT += \"buildhistory\" to see image details.")
+        build_history_enabled = False
+
     if not params.observe_only:
         logger.error("ToasterUI can only work in observer mode")
         return
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index ebf2b4f..22d31e3 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -32,6 +32,10 @@ from toastermain import settings
 
 from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, _getgitcheckoutdirectoryname
 
+import logging
+logger = logging.getLogger("toaster")
+
+
 class LocalhostBEController(BuildEnvironmentController):
     """ Implementation of the BuildEnvironmentController for the localhost;
         this controller manages the default build directory,
@@ -56,8 +60,10 @@ class LocalhostBEController(BuildEnvironmentController):
                 err = "command: %s \n%s" % (command, out)
             else:
                 err = "command: %s \n%s" % (command, err)
+            logger.debug("localhostbecontroller: shellcmd error %s" % err)
             raise ShellCmdException(err)
         else:
+            logger.debug("localhostbecontroller: shellcmd success")
             return out
 
     def _createdirpath(self, path):
@@ -90,7 +96,7 @@ class LocalhostBEController(BuildEnvironmentController):
         for i in self._shellcmd(cmd).split("\n"):
             if i.startswith("Bitbake server address"):
                 port = i.split(" ")[-1]
-                print "Found bitbake server port ", port
+                logger.debug("localhostbecontroller: Found bitbake server port %s" % port)
 
         def _toaster_ui_started(filepath):
             if not os.path.exists(filepath):
@@ -103,10 +109,10 @@ class LocalhostBEController(BuildEnvironmentController):
 
         while not _toaster_ui_started(os.path.join(self.be.builddir, "toaster_ui.log")):
             import time
-            print "DEBUG: Waiting server to start"
+            logger.debug("localhostbecontroller: Waiting bitbake server to start")
             time.sleep(0.5)
 
-        print("DEBUG: Started server")
+        logger.debug("localhostbecontroller: Started bitbake server")
         assert self.be.sourcedir and os.path.exists(self.be.builddir)
         self.be.bbaddress = "localhost"
         self.be.bbport = port
@@ -116,11 +122,11 @@ class LocalhostBEController(BuildEnvironmentController):
     def stopBBServer(self):
         assert self.pokydirname and os.path.exists(self.pokydirname)
         assert self.islayerset
-        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && %s source toaster stop\"" %
+        self._shellcmd("bash -c \"source %s/oe-init-build-env %s && %s source toaster stop\"" %
             (self.pokydirname, self.be.builddir, (lambda: "" if self.be.bbtoken is None else "BBTOKEN=%s" % self.be.bbtoken)()))
         self.be.bbstate = BuildEnvironment.SERVER_STOPPED
         self.be.save()
-        print "Stopped server"
+        logger.debug("localhostbecontroller: Stopped bitbake server")
 
     def setLayers(self, bitbakes, layers):
         """ a word of attention: by convention, the first layer for any build will be poky! """
@@ -149,12 +155,13 @@ class LocalhostBEController(BuildEnvironmentController):
                     raise BuildSetupException("More than one commit per git url, unsupported configuration: \n%s" % pprint.pformat(gitrepos))
 
 
+        logger.debug("localhostbecontroller, our git repos are %s" % gitrepos)
         layerlist = []
 
         # 2. checkout the repositories
         for giturl in gitrepos.keys():
             localdirname = os.path.join(self.be.sourcedir, _getgitcheckoutdirectoryname(giturl))
-            print "DEBUG: giturl ", giturl ,"checking out in current directory", localdirname
+            logger.debug("localhostbecontroller: giturl %s checking out in current directory %s" % (giturl, localdirname))
 
             # make sure our directory is a git repository
             if os.path.exists(localdirname):
@@ -167,17 +174,17 @@ class LocalhostBEController(BuildEnvironmentController):
 
             # branch magic name "HEAD" will inhibit checkout
             if commit != "HEAD":
-                print "DEBUG: checking out commit ", commit, "to", localdirname
+                logger.debug("localhostbecontroller: checking out commit %s to %s " % (commit, localdirname))
                 self._shellcmd("git fetch --all && git checkout \"%s\"" % commit , localdirname)
 
             # take the localdirname as poky dir if we can find the oe-init-build-env
             if self.pokydirname is None and os.path.exists(os.path.join(localdirname, "oe-init-build-env")):
-                print "DEBUG: selected poky dir name", localdirname
+                logger.debug("localhostbecontroller: selected poky dir name %s" % localdirname)
                 self.pokydirname = localdirname
 
                 # make sure we have a working bitbake
                 if not os.path.exists(os.path.join(self.pokydirname, 'bitbake')):
-                    print "DEBUG: checking bitbake into the poky dirname %s " % self.pokydirname
+                    logger.debug("localhostbecontroller: checking bitbake into the poky dirname %s " % self.pokydirname)
                     self._shellcmd("git clone -b \"%s\" \"%s\" \"%s\" " % (bitbakes[0].commit, bitbakes[0].giturl, os.path.join(self.pokydirname, 'bitbake')))
 
             # verify our repositories
@@ -189,7 +196,7 @@ class LocalhostBEController(BuildEnvironmentController):
                 if name != "bitbake":
                     layerlist.append(localdirpath.rstrip("/"))
 
-        print "DEBUG: current layer list ", layerlist
+        logger.debug("localhostbecontroller: current layer list %s " % layerlist)
 
         # 3. configure the build environment, so we have a conf/bblayers.conf
         assert self.pokydirname is not None
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 96d2d51..55f118c 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -1,7 +1,7 @@
 from django.core.management.base import NoArgsCommand, CommandError
 from django.db import transaction
 from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException
-from bldcontrol.models import BuildRequest, BuildEnvironment
+from bldcontrol.models import BuildRequest, BuildEnvironment, BRError
 from orm.models import ToasterSetting
 import os
 
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 5e253e0..56c989c 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -4,6 +4,9 @@ from orm.models import Build
 from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException, BuildSetupException
 from bldcontrol.models import BuildRequest, BuildEnvironment, BRError
 import os
+import logging
+
+logger = logging.getLogger("toaster")
 
 class Command(NoArgsCommand):
     args    = ""
@@ -32,6 +35,7 @@ class Command(NoArgsCommand):
                 # select the build environment and the request to build
                 br = self._selectBuildRequest()
             except IndexError as e:
+                # logger.debug("runbuilds: No build request")
                 return
             try:
                 bec = self._selectBuildEnvironment()
@@ -39,10 +43,10 @@ class Command(NoArgsCommand):
                 # we could not find a BEC; postpone the BR
                 br.state = BuildRequest.REQ_QUEUED
                 br.save()
-                print "No build env"
+                logger.debug("runbuilds: No build env")
                 return
 
-            print "Build %s, Environment %s" % (br, bec.be)
+            logger.debug("runbuilds: starting build %s, environment %s" % (br, bec.be))
             # let the build request know where it is being executed
             br.environment = bec.be
             br.save()
@@ -63,7 +67,7 @@ class Command(NoArgsCommand):
                 task = None
             bbctrl.build(list(map(lambda x:x.target, br.brtarget_set.all())), task)
 
-            print "Build launched, exiting"
+            logger.debug("runbuilds: Build launched, exiting")
             # disconnect from the server
             bbctrl.disconnect()
 
@@ -71,7 +75,7 @@ class Command(NoArgsCommand):
 
 
         except Exception as e:
-            print " EE Error executing shell command\n", e
+            logger.error("runbuilds: Error executing shell command %s" % e)
             traceback.print_exc(e)
             BRError.objects.create(req = br,
                 errtype = str(type(e)),
@@ -83,6 +87,7 @@ class Command(NoArgsCommand):
             bec.be.save()
 
 
+
     def cleanup(self):
         from django.utils import timezone
         from datetime import timedelta
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 0974b90..acc20cc 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -21,11 +21,15 @@
 
 # Django settings for Toaster project.
 
+import os, re
+
 DEBUG = True
 TEMPLATE_DEBUG = DEBUG
 
 # Set to True to see the SQL queries in console
 SQL_DEBUG = False
+if os.environ.get("TOASTER_SQLDEBUG", None) is not None:
+    SQL_DEBUG = True
 
 
 ADMINS = (
@@ -46,7 +50,6 @@ DATABASES = {
 }
 
 # Reinterpret database settings if we have DATABASE_URL environment variable defined
-import os, re
 
 if 'DATABASE_URL' in os.environ:
     dburl = os.environ['DATABASE_URL']
@@ -212,6 +215,9 @@ MIDDLEWARE_CLASSES = (
     # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
 )
 
+from os.path import dirname as DN
+SITE_ROOT=DN(DN(os.path.abspath(__file__)))
+
 ROOT_URLCONF = 'toastermain.urls'
 
 # Python dotted path to the WSGI application used by Django's runserver.
@@ -245,6 +251,19 @@ INSTALLED_APPS = (
     'south',
 )
 
+
+# Load django-fresh is TOASTER_DEVEL is set, and the module is available
+FRESH_ENABLED = False
+if os.environ.get('TOASTER_DEVEL', None) is not None:
+    try:
+        import fresh
+        MIDDLEWARE_CLASSES = MIDDLEWARE_CLASSES + ("fresh.middleware.FreshMiddleware",)
+        INSTALLED_APPS = INSTALLED_APPS + ('fresh',)
+        FRESH_ENABLED = True
+    except:
+        pass
+
+
 SOUTH_TESTS_MIGRATE = False
 
 # if we run in managed mode, we need user support
@@ -286,7 +305,7 @@ LOGGING = {
     },
     'formatters': {
         'datetime': {
-            'format': 'DB %(asctime)s %(message)s'
+            'format': '%(levelname)s %(asctime)s %(message)s'
         }
     },
     'handlers': {
@@ -302,6 +321,10 @@ LOGGING = {
         }
     },
     'loggers': {
+        'toaster' : {
+            'handlers': ['console'],
+            'level': 'DEBUG',
+        },
         'django.request': {
             'handlers': ['mail_admins'],
             'level': 'ERROR',
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 549fda1..a2916e2 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -44,11 +44,15 @@ urlpatterns = patterns('',
 )
 
 import toastermain.settings
+
+if toastermain.settings.FRESH_ENABLED:
+    urlpatterns.insert(1, url(r'', include('fresh.urls')))
+
 if toastermain.settings.MANAGED:
-    urlpatterns = urlpatterns + [
+    urlpatterns = [
         # Uncomment the next line to enable the admin:
         url(r'^admin/', include(admin.site.urls)),
-    ]
+    ] + urlpatterns
 # Automatically discover urls.py in various apps, beside our own
 # and map module directories to the patterns
 
@@ -61,4 +65,4 @@ for t in os.walk(os.path.dirname(currentdir)):
 
     if "urls.py" in t[2] and t[0] != currentdir:
         modulename = os.path.basename(t[0])
-        urlpatterns.append( url(r'^' + modulename + '/', include ( modulename + '.urls')))
+        urlpatterns.insert(0, url(r'^' + modulename + '/', include ( modulename + '.urls')))
-- 
1.9.1


