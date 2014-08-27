Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 6079671185
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:50 +0000 (UTC)
Received: by mail-wg0-f45.google.com with SMTP id x12so510467wgg.28
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=5J5Zgm7YhKh0+PW6q62p+yah3mZ7i1COnLAPXP9+kOY=;
	b=VQ6zZc/QTL23MoYbCbMIDq8QHeFSFTQ4h3hNtJUDxWxDkiOodWZ6QTIwH3MvkUwN8q
	IXK6iaqHl/IH7fmLJmYQfcEdaiHbz3hJFQUYuq83/Ej4XH8F3FpMJZu8RHoUvxak/u6h
	08s6EEGFZ7eXirLwKIAdqVvyE4ca8SYmHz6ospmi0UCkxgTJcTPEeTOfFLzPlyNFoCH7
	rFReVoCxkVh51fnr9CAnZ/8wZACI/7LamAPyO/M7TaJUfKx1XAZmzPkMzsrKWh6w0wnu
	KFwdbXJUjzEd2+Ns6O9qTkeQ4YIGnYLWmHgKXSL5sUyAK1h3pkc5q/NigTU5lwCeKFn2
	35ew==
X-Gm-Message-State: ALoCoQnA+TFCzx94cLeGP8wlMf+4A0kvzI8w2qq2JQ6mJEts88ilPG0M3PVpdmldu92jeDuVUiQf
X-Received: by 10.194.202.165 with SMTP id kj5mr12487380wjc.50.1409160228454; 
	Wed, 27 Aug 2014 10:23:48 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id w1sm25976066wib.1.2014.08.27.10.23.46
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:47 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 24C72560F4F; Wed, 27 Aug 2014 18:23:45 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:33 +0100
Message-Id: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1409159626.git.alexandru.damian@intel.com>
References: <cover.1409159626.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 01/11] toasterui: refactor log saving and save out-of-build errors
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
X-List-Received-Date: Wed, 27 Aug 2014 17:23:51 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We refactor log saving to go through only one code path.

All logs that happened outside the build (i.e. before build
starting) now will be logged to either toaster_ui.log if the
build command ran in interactive mode, or to the build request
errors if the command ran in managed mode.

This enables proper display of error logs in project page.
---
 lib/bb/ui/buildinfohelper.py | 79 ++++++++++++++++++++++++++------------------
 lib/bb/ui/toasterui.py       | 10 +++---
 2 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index f64423b..e1ef16d 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -480,6 +480,8 @@ class ORMWrapper(object):
                                 line_number = vh['line'],
                                 operation = vh['op'])
 
+class MockEvent: pass           # sometimes we mock an event, declare it here
+
 class BuildInfoHelper(object):
     """ This class gathers the build information from the server and sends it
         towards the ORM wrapper for storing in the database
@@ -487,6 +489,7 @@ class BuildInfoHelper(object):
         Keeps in memory all data that needs matching before writing it to the database
     """
 
+
     def __init__(self, server, has_build_history = False):
         self._configure_django()
         self.internal_state = {}
@@ -496,6 +499,8 @@ class BuildInfoHelper(object):
         self.orm_wrapper = ORMWrapper()
         self.has_build_history = has_build_history
         self.tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
+        self.brbe    = self.server.runCommand(["getVariable", "TOASTER_BRBE"])[0]
+
 
     def _configure_django(self):
         # Add toaster to sys path for importing modules
@@ -607,9 +612,7 @@ class BuildInfoHelper(object):
         assert '_pkgs' in vars(event)
         build_information = self._get_build_information()
 
-        brbe = self.server.runCommand(["getVariable", "TOASTER_BRBE"])[0]
-
-        build_obj = self.orm_wrapper.create_build_object(build_information, brbe)
+        build_obj = self.orm_wrapper.create_build_object(build_information, self.brbe)
 
         self.internal_state['build'] = build_obj
 
@@ -629,7 +632,8 @@ class BuildInfoHelper(object):
         # Save build configuration
         self.orm_wrapper.save_build_variables(build_obj, self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0])
 
-        return brbe
+        return self.brbe
+
 
 
     def update_target_image_file(self, event):
@@ -773,7 +777,6 @@ class BuildInfoHelper(object):
             identifier = fn + taskname + "_setscene"
             recipe_information = self._get_recipe_information_from_taskfile(fn)
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
-            class MockEvent: pass
             mevent = MockEvent()
             mevent.taskname = taskname
             mevent.taskhash = taskhash
@@ -792,7 +795,6 @@ class BuildInfoHelper(object):
             identifier = fn + taskname + "_setscene"
             recipe_information = self._get_recipe_information_from_taskfile(fn)
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
-            class MockEvent: pass
             mevent = MockEvent()
             mevent.taskname = taskname
             mevent.taskhash = taskhash
@@ -929,7 +931,8 @@ class BuildInfoHelper(object):
                             self.internal_state['recipes'],
                             )
 
-    def store_build_done(self, br_id, be_id):
+    def _store_build_done(self):
+        br_id, be_id = self.brbe.split(":")
         from bldcontrol.models import BuildEnvironment, BuildRequest
         be = BuildEnvironment.objects.get(pk = be_id)
         be.lock = BuildEnvironment.LOCK_LOCK
@@ -939,49 +942,61 @@ class BuildInfoHelper(object):
         br.build = self.internal_state['build']
         br.save()
 
-    def _store_log_information(self, level, text):
-        log_information = {}
-        log_information['build'] = self.internal_state['build']
-        log_information['level'] = level
-        log_information['message'] = text
-        self.orm_wrapper.create_logmessage(log_information)
-
-    def store_log_info(self, text):
-        self._store_log_information(LogMessage.INFO, text)
-
-    def store_log_warn(self, text):
-        self._store_log_information(LogMessage.WARNING, text)
 
     def store_log_error(self, text):
-        self._store_log_information(LogMessage.ERROR, text)
+        mockevent = MockEvent()
+        mockevent.levelno = format.ERROR
+        mockevent.msg = text
+        self.store_log_event(mockevent)
 
     def store_log_event(self, event):
+        if event.levelno < format.WARNING:
+            return
+
+        if 'args' in vars(event):
+            event.msg = event.msg % event.args
+
+        if not 'build' in self.internal_state:
+            if self.brbe is None:
+                if not 'backlog' in self.internal_state:
+                    self.internal_state['backlog'] = []
+                self.internal_state['backlog'].append(event)
+            else:   # we're under Toaster control, post the errors to the build request
+                from bldcontrol.models import BuildRequest, BRError
+                br, be = brbe.split(":")
+                buildrequest = BuildRequest.objects.get(pk = br)
+                brerror = BRError.objects.create(req = buildrequest, errtype="build", errmsg = event.msg)
+
+            return
+
         if 'build' in self.internal_state and 'backlog' in self.internal_state:
             if len(self.internal_state['backlog']):
                 tempevent = self.internal_state['backlog'].pop()
-                print "Saving stored event ", tempevent
+                print "    Saving stored event ", tempevent
                 self.store_log_event(tempevent)
             else:
                 del self.internal_state['backlog']
 
-        if event.levelno < format.WARNING:
-            return
-
-        if not 'build' in self.internal_state:
-            print "Save event for later"
-            if not 'backlog' in self.internal_state:
-                self.internal_state['backlog'] = []
-            self.internal_state['backlog'].append(event)
-
-            return
         log_information = {}
         log_information['build'] = self.internal_state['build']
         if event.levelno >= format.ERROR:
-            log_information['level'] = LogMessage.ERROR
+            log_information['level'] = event.levelno
         elif event.levelno == format.WARNING:
             log_information['level'] = LogMessage.WARNING
+        elif event.levelno == format.INFO:
+            log_information['level'] = LogMessage.INFO
+        else:
+            log_information['level'] = event.levelno
+
         log_information['message'] = event.msg
         log_information['pathname'] = event.pathname
         log_information['lineno'] = event.lineno
         self.orm_wrapper.create_logmessage(log_information)
 
+    def close(self):
+        if self.brbe is not None:
+            buildinfohelper._store_build_done()
+
+        if 'backlog' in self.internal_state:
+            for event in self.internal_state['backlog']:
+                   print "NOTE: Unsaved log: ", event.msg
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 2f628e9..d81b8a9 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -94,7 +94,6 @@ def main(server, eventHandler, params ):
     first = True
 
     buildinfohelper = BuildInfoHelper(server, build_history_enabled)
-    brbe = None
 
     while True:
         try:
@@ -111,7 +110,7 @@ def main(server, eventHandler, params ):
             helper.eventHandler(event)
 
             if isinstance(event, bb.event.BuildStarted):
-                brbe = buildinfohelper.store_started_build(event)
+                buildinfohelper.store_started_build(event)
 
             if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
@@ -222,19 +221,18 @@ def main(server, eventHandler, params ):
                                   bb.command.CommandExit)):
                 if (isinstance(event, bb.command.CommandFailed)):
                     event.levelno = format.ERROR
-                    event.msg = event.error
+                    event.msg = "Command Failed " + event.error
                     event.pathname = ""
                     event.lineno = 0
                     buildinfohelper.store_log_event(event)
                     errors += 1
 
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
+                buildinfohelper.close()
 
 
                 # we start a new build info
-                if brbe is not None:
-                    br_id, be_id = brbe.split(":")
-                    buildinfohelper.store_build_done(br_id, be_id)
+                if buildinfohelper.brbe is not None:
 
                     print "we are under BuildEnvironment management - after the build, we exit"
                     server.terminateServer()
-- 
1.9.1


