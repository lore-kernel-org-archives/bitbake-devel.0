Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id C95216FC0E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 13:52:01 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id cc10so5711160wib.12
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 06:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=W8Igwi0Ma8zaHglLJWE8TGbwKv9P71ptRRY0owQYalc=;
	b=ASPwjPkjPDIttJlKO89pdhC9sVs1LqqvnO1M9bbwf6197VqQTviiivQpHk2u5rt2xi
	LDjbbNo640AFS3dYlsowDna1DfxTN9y0kUaGfGrzZ7DL2wHP6JdTZcyMLefCX7BmuWna
	mPssdeG0+ljALc2nRNyOqsVhJTHvzvfLe9JTXOTHtck1vpO4ECNm+cKO035gz62bldvI
	jowRFt7NbkinqtPyfSJ7ImqKprxBQ/x/HuYUjod/HMvT2GxVsqlDko2f5STxNI9PR3AN
	Fj8FFTO6vaWV5+tnZLyhNHgOxAIBlks91npp71wOASF0TNLLXk1PPV6v3sv4eYWgEZea
	EbEw==
X-Gm-Message-State: ALoCoQmWiwK0bdIp/KVEuC8XyatQJHtirXJeJ6KVuhGm719N9zKg9V/bJU1gP2/6lTQEsvZrCLnm
X-Received: by 10.194.142.205 with SMTP id ry13mr61263510wjb.69.1402581121774; 
	Thu, 12 Jun 2014 06:52:01 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id e11sm4195934wiw.19.2014.06.12.06.51.59
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Jun 2014 06:52:00 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id AE47C56115E; Thu, 12 Jun 2014 14:52:03 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Thu, 12 Jun 2014 14:52:02 +0100
Message-Id: <10988bd77c8c7cefad3b88744bc5d8a7e3c1f4cf.1402580802.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <08556b79b7b2af08aaeedf8733b1b8996f387c4e.1402580802.git.alexandru.damian@intel.com>
References: <08556b79b7b2af08aaeedf8733b1b8996f387c4e.1402580802.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1402580802.git.alexandru.damian@intel.com>
References: <cover.1402580802.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 6/6] toaster: build control functionality
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
X-List-Received-Date: Thu, 12 Jun 2014 13:52:02 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add the build control functionality to toaster.

* The bldcontrol application gains bbcontroller classes
that know how to manage a localhost build environment.

* The toaster UI now detects it is running under build
environment controller, and update the build controller
database and will shut down the bitbake server once
the build is complete.

* The toaster script can now run in standalone mode,
launching the build controller and the web interface instead
of just monitoring the build, as in the interactive mode.

* A fixture with the default build controller entry for
localhost is provided.

[YOCTO #5490]
[YOCTO #5491]
[YOCTO #5492]
[YOCTO #5493]
[YOCTO #5494]
[YOCTO #5537]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                        |   7 +-
 lib/bb/ui/buildinfohelper.py                       |  10 +
 lib/bb/ui/toasterui.py                             |   3 +
 lib/toaster/bldcontrol/bbcontroller.py             | 239 +++++++++++++++++++++
 lib/toaster/bldcontrol/fixtures/initial_data.json  |   2 +-
 lib/toaster/bldcontrol/management/__init__.py      |   0
 .../bldcontrol/management/commands/__init__.py     |   0
 .../bldcontrol/management/commands/runbuilds.py    |  85 ++++++++
 lib/toaster/bldcontrol/models.py                   |   2 +
 lib/toaster/bldcontrol/tests.py                    |  73 ++++++-
 10 files changed, 413 insertions(+), 8 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/bbcontroller.py
 create mode 100644 lib/toaster/bldcontrol/management/__init__.py
 create mode 100644 lib/toaster/bldcontrol/management/commands/__init__.py
 create mode 100644 lib/toaster/bldcontrol/management/commands/runbuilds.py

diff --git a/bin/toaster b/bin/toaster
index 80bda6d..01ffc7a 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -139,15 +139,16 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
         webserverKillAll
         RUNNING=0
     }
-    webserverStartAll || exit 1
+    webserverStartAll || (echo "Fail to start the web server, stopping" 1>&2 && exit 1)
     xdg-open http://0.0.0.0:8000/ >/dev/null 2>&1 &
     trap trap_ctrlc SIGINT
     echo "Running. Stop with Ctrl-C"
     while [ $RUNNING -gt 0 ]; do
-        wait;
+	python $BBBASEDIR/lib/toaster/manage.py runbuilds
+	sleep 1
     done
     echo "**** Exit"
-    exit 1
+    exit 0
 fi
 
 # We make sure we're running in the current shell and in a good environment
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 58df687..77be7c7 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -916,6 +916,16 @@ class BuildInfoHelper(object):
                             self.internal_state['recipes'],
                             )
 
+    def store_build_done(self, br_id, be_id):
+        from bldcontrol.models import BuildEnvironment, BuildRequest
+        be = BuildEnvironment.objects.get(pk = be_id)
+        be.lock = BuildEnvironment.LOCK_LOCK
+        be.save()
+        br = BuildRequest.objects.get(pk = br_id)
+        br.state = BuildRequest.REQ_COMPLETED
+        br.build = self.internal_state['build']
+        br.save()
+
     def _store_log_information(self, level, text):
         log_information = {}
         log_information['build'] = self.internal_state['build']
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index c1696b2..b1c80cc 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -228,8 +228,11 @@ def main(server, eventHandler, params ):
 
 
                 brbe = server.runCommand(["getVariable", "TOASTER_BRBE"])[0]
+                br_id, be_id = brbe.split(":")
                 # we start a new build info
                 if brbe is not None:
+                    buildinfohelper.store_build_done(br_id, be_id)
+
                     print "we are under BuildEnvironment management - after the build, we exit"
                     server.terminateServer()
                 else:
diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
new file mode 100644
index 0000000..d2b2a23
--- /dev/null
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -0,0 +1,239 @@
+#
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2014        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+
+import os
+import sys
+import re
+from django.db import transaction
+from django.db.models import Q
+from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget
+import subprocess
+
+from toastermain import settings
+
+
+# load Bitbake components
+path = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
+sys.path.insert(0, path)
+import bb.server.xmlrpc
+
+class BitbakeController(object):
+    """ This is the basic class that controlls a bitbake server.
+        It is outside the scope of this class on how the server is started and aquired
+    """
+
+    def __init__(self, connection):
+        self.connection = connection
+
+    def _runCommand(self, command):
+        result, error = self.connection.connection.runCommand(command)
+        if error:
+            raise Exception(error)
+        return result
+
+    def disconnect(self):
+        return self.connection.removeClient()
+
+    def setVariable(self, name, value):
+        return self._runCommand(["setVariable", name, value])
+
+    def build(self, targets, task = None):
+        if task is None:
+            task = "build"
+        return self._runCommand(["buildTargets", targets, task])
+
+
+
+def getBuildEnvironmentController(**kwargs):
+    """ Gets you a BuildEnvironmentController that encapsulates a build environment,
+        based on the query dictionary sent in.
+
+        This is used to retrieve, for example, the currently running BE from inside
+        the toaster UI, or find a new BE to start a new build in it.
+
+        The return object MUST always be a BuildEnvironmentController.
+    """
+    be = BuildEnvironment.objects.filter(Q(**kwargs))[0]
+    if be.betype == BuildEnvironment.TYPE_LOCAL:
+        return LocalhostBEController(be)
+    elif be.betype == BuildEnvironment.TYPE_SSH:
+        return SSHBEController(be)
+    else:
+        raise Exception("FIXME: Implement BEC for type %s" % str(be.betype))
+
+
+
+class BuildEnvironmentController(object):
+    """ BuildEnvironmentController (BEC) is the abstract class that defines the operations that MUST
+        or SHOULD be supported by a Build Environment. It is used to establish the framework, and must
+        not be instantiated directly by the user.
+
+        Use the "getBuildEnvironmentController()" function to get a working BEC for your remote.
+
+        How the BuildEnvironments are discovered is outside the scope of this class.
+
+        You must derive this class to teach Toaster how to operate in your own infrastructure.
+        We provide some specific BuildEnvironmentController classes that can be used either to
+        directly set-up Toaster infrastructure, or as a model for your own infrastructure set:
+
+            * Localhost controller will run the Toaster BE on the same account as the web server
+        (current user if you are using the the Django development web server)
+        on the local machine, with the "build/" directory under the "poky/" source checkout directory.
+        Bash is expected to be available.
+
+            * SSH controller will run the Toaster BE on a remote machine, where the current user
+        can connect without raise Exception("FIXME: implement")word (set up with either ssh-agent or raise Exception("FIXME: implement")phrase-less key authentication)
+
+    """
+    def __init__(self, be):
+        """ Takes a BuildEnvironment object as parameter that points to the settings of the BE.
+        """
+        self.be = be
+        self.connection = None
+
+    def startBBServer(self):
+        """ Starts a  BB server with Toaster toasterui set up to record the builds, an no controlling UI.
+            After this method executes, self.be bbaddress/bbport MUST point to a running and free server,
+            and the bbstate MUST be  updated to "started".
+        """
+        raise Exception("Must override in order to actually start the BB server")
+
+    def stopBBServer(self):
+        """ Stops the currently running BB server.
+            The bbstate MUST be updated to "stopped".
+            self.connection must be none.
+        """
+
+    def setLayers(self,ls):
+        """ Sets the layer variables in the config file, after validating local layer paths.
+            The layer paths must be in a list of BRLayer object
+        """
+        raise Exception("Must override setLayers")
+
+
+    def getBBController(self):
+        """ returns a BitbakeController to an already started server; this is the point where the server
+            starts if needed; or reconnects to the server if we can
+        """
+        if not self.connection:
+            self.startBBServer()
+            self.be.lock = BuildEnvironment.LOCK_RUNNING
+            self.be.save()
+
+        server = bb.server.xmlrpc.BitBakeXMLRPCClient()
+        server.initServer()
+        server.saveConnectionDetails("%s:%s" % (self.be.bbaddress, self.be.bbport))
+        self.connection = server.establishConnection([])
+
+        self.be.bbtoken = self.connection.transport.connection_token
+        self.be.save()
+
+        return BitbakeController(self.connection)
+
+    def getArtifact(path):
+        """ This call returns an artifact identified by the 'path'. How 'path' is interpreted as
+            up to the implementing BEC. The return MUST be a REST URL where a GET will actually return
+            the content of the artifact, e.g. for use as a "download link" in a web UI.
+        """
+        raise Exception("Must return the REST URL of the artifact")
+
+    def release(self):
+        """ This stops the server and releases any resources. After this point, all resources
+            are un-available for further reference
+        """
+        raise Exception("Must override BE release")
+
+class ShellCmdException(Exception):
+    pass
+
+class LocalhostBEController(BuildEnvironmentController):
+    """ Implementation of the BuildEnvironmentController for the localhost;
+        this controller manages the default build directory,
+        the server setup and system start and stop for the localhost-type build environment
+
+        The address field is used as working directory; if not set, the build/ directory
+        is created
+    """
+
+    def __init__(self, be):
+        super(LocalhostBEController, self).__init__(be)
+        from os.path import dirname as DN
+        self.cwd = DN(DN(DN(DN(DN(os.path.realpath(__file__))))))
+        if self.be.address is None or len(self.be.address) == 0:
+            self.be.address = "build"
+            self.be.save()
+        self.bwd = self.be.address
+        self.dburl = settings.getDATABASE_URL()
+
+        # transform relative paths to absolute ones
+        if not self.bwd.startswith("/"):
+            self.bwd = os.path.join(self.cwd, self.bwd)
+        self._createBE()
+
+    def _shellcmd(self, command):
+        p = subprocess.Popen(command, cwd=self.cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+        (out,err) = p.communicate()
+        if p.returncode:
+            if len(err) == 0:
+                err = "command: %s" % command
+            else:
+                err = "command: %s \n%s" % (command, err)
+            raise ShellCmdException(err)
+        else:
+            return out
+
+    def _createBE(self):
+        assert self.cwd and os.path.exists(self.cwd)
+        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.cwd, self.bwd))
+
+    def startBBServer(self):
+        assert self.cwd and os.path.exists(self.cwd)
+        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && DATABASE_URL=%s source toaster start noweb && sleep 1\"" % (self.cwd, self.bwd, self.dburl))
+        # FIXME unfortunate sleep 1 - we need to make sure that bbserver is started and the toaster ui is connected
+        # but since they start async without any return, we just wait a bit
+        print "Started server"
+        assert self.cwd and os.path.exists(self.bwd)
+        self.be.bbaddress = "localhost"
+        self.be.bbport = "8200"
+        self.be.bbstate = BuildEnvironment.SERVER_STARTED
+        self.be.save()
+
+    def stopBBServer(self):
+        assert self.cwd
+        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && %s source toaster stop\"" %
+            (self.cwd, self.bwd, (lambda: "" if self.be.bbtoken is None else "BBTOKEN=%s" % self.be.bbtoken)()))
+        self.be.bbstate = BuildEnvironment.SERVER_STOPPED
+        self.be.save()
+        print "Stopped server"
+
+    def setLayers(self, layers):
+        assert self.cwd is not None
+        layerconf = os.path.join(self.bwd, "conf/bblayers.conf")
+        if not os.path.exists(layerconf):
+            raise Exception("BE is not consistent: bblayers.conf file missing at ", layerconf)
+        return True
+
+    def release(self):
+        assert self.cwd and os.path.exists(self.bwd)
+        import shutil
+        shutil.rmtree(os.path.join(self.cwd, "build"))
+        assert not os.path.exists(self.bwd)
diff --git a/lib/toaster/bldcontrol/fixtures/initial_data.json b/lib/toaster/bldcontrol/fixtures/initial_data.json
index 21883ab..b2f12b3 100644
--- a/lib/toaster/bldcontrol/fixtures/initial_data.json
+++ b/lib/toaster/bldcontrol/fixtures/initial_data.json
@@ -1 +1 @@
-[{"pk": 1, "model": "bldcontrol.buildenvironment", "fields": {"updated": "2014-05-20T12:17:30Z", "created": "2014-05-20T12:17:30Z", "lock": 0, "bbstate": 0, "bbaddress": "", "betype": 0, "bbtoken": "", "address": "localhost", "bbport": -1}}]
+[{"pk": 1, "model": "bldcontrol.buildenvironment", "fields": {"updated": "2014-05-20T12:17:30Z", "created": "2014-05-20T12:17:30Z", "lock": 0, "bbstate": 0, "bbaddress": "", "betype": 0, "bbtoken": "", "address": "", "bbport": -1}}]
diff --git a/lib/toaster/bldcontrol/management/__init__.py b/lib/toaster/bldcontrol/management/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/bldcontrol/management/commands/__init__.py b/lib/toaster/bldcontrol/management/commands/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
new file mode 100644
index 0000000..dd8f84b
--- /dev/null
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -0,0 +1,85 @@
+from django.core.management.base import NoArgsCommand, CommandError
+from django.db import transaction
+from orm.models import Build
+from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException
+from bldcontrol.models import BuildRequest, BuildEnvironment
+import os
+
+class Command(NoArgsCommand):
+    args    = ""
+    help    = "Schedules and executes build requests as possible. Does not return (interrupt with Ctrl-C)"
+
+
+    @transaction.commit_on_success
+    def _selectBuildEnvironment(self):
+        bec = getBuildEnvironmentController(lock = BuildEnvironment.LOCK_FREE)
+        bec.be.lock = BuildEnvironment.LOCK_LOCK
+        bec.be.save()
+        return bec
+
+    @transaction.commit_on_success
+    def _selectBuildRequest(self):
+        br = BuildRequest.objects.filter(state = BuildRequest.REQ_QUEUED).order_by('pk')[0]
+        br.state = BuildRequest.REQ_INPROGRESS
+        br.save()
+        return br
+
+    def schedule(self):
+        try:
+            br = None
+            try:
+                # select the build environment and the request to build
+                br = self._selectBuildRequest()
+            except IndexError as e:
+                return
+            try:
+                bec = self._selectBuildEnvironment()
+            except IndexError as e:
+                # we could not find a BEC; postpone the BR
+                br.state = BuildRequest.REQ_QUEUED
+                br.save()
+                return
+
+            # set up the buid environment with the needed layers
+            print "Build %s, Environment %s" % (br, bec.be)
+            bec.setLayers(br.brlayer_set.all())
+
+            # get the bb server running
+            bbctrl = bec.getBBController()
+
+            # let toasterui that this is a managed build
+            bbctrl.setVariable("TOASTER_BRBE", "%d:%d" % (br.pk, bec.be.pk))
+
+            # set the build configuration
+            for variable in br.brvariable_set.all():
+                bbctrl.setVariable(variable.name, variable.value)
+
+            # trigger the build command
+            bbctrl.build(list(map(lambda x:x.target, br.brtarget_set.all())))
+
+            print "Build launched, exiting"
+            # disconnect from the server
+            bbctrl.disconnect()
+
+            # cleanup to be performed by toaster when the deed is done
+
+        except ShellCmdException as e:
+            import traceback
+            print " EE Error executing shell command\n", e
+            traceback.format_exc(e)
+
+        except Exception as e:
+            import traceback
+            traceback.print_exc()
+            raise e
+
+    def cleanup(self):
+        from django.utils import timezone
+        from datetime import timedelta
+        # environments locked for more than 30 seconds - they should be unlocked
+        BuildEnvironment.objects.filter(lock=BuildEnvironment.LOCK_LOCK).filter(updated__lt = timezone.now() - timedelta(seconds = 30)).update(lock = BuildEnvironment.LOCK_FREE)
+
+
+    def handle_noargs(self, **options):
+        self.cleanup()
+        self.schedule()
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index 11f487c..158874f 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -20,9 +20,11 @@ class BuildEnvironment(models.Model):
 
     LOCK_FREE = 0
     LOCK_LOCK = 1
+    LOCK_RUNNING = 2
     LOCK_STATE = (
         (LOCK_FREE, "free"),
         (LOCK_LOCK, "lock"),
+        (LOCK_RUNNING, "running"),
     )
 
     address     = models.CharField(max_length = 254)
diff --git a/lib/toaster/bldcontrol/tests.py b/lib/toaster/bldcontrol/tests.py
index 501deb7..ebe477d 100644
--- a/lib/toaster/bldcontrol/tests.py
+++ b/lib/toaster/bldcontrol/tests.py
@@ -7,10 +7,75 @@ Replace this with more appropriate tests for your application.
 
 from django.test import TestCase
 
+from bldcontrol.bbcontroller import LocalhostBEController, BitbakeController
+from bldcontrol.models import BuildEnvironment, BuildRequest
+from bldcontrol.management.commands.runbuilds import Command
 
-class SimpleTest(TestCase):
-    def test_basic_addition(self):
+import socket
+import subprocess
+
+class LocalhostBEControllerTests(TestCase):
+    def test_StartAndStopServer(self):
+        obe = BuildEnvironment.objects.create(lock = BuildEnvironment.LOCK_FREE, betype = BuildEnvironment.TYPE_LOCAL)
+        lbc = LocalhostBEController(obe)
+
+        # test start server and stop
+        self.assertTrue(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex(('localhost', 8200)), "Port already occupied")
+        lbc.startBBServer()
+        self.assertFalse(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex(('localhost', 8200)), "Server not answering")
+
+        lbc.stopBBServer()
+        self.assertTrue(socket.socket(socket.AF_INET, socket.SOCK_STREAM).connect_ex(('localhost', 8200)), "Server not stopped")
+
+        # clean up
+        import subprocess
+        out, err = subprocess.Popen("netstat  -tapn 2>/dev/null | grep 8200 | awk '{print $7}' | sort -fu | cut -d \"/\" -f 1 | grep -v -- - | tee /dev/fd/2 | xargs -r kill", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()
+
+        self.assertTrue(err == '', "bitbake server pid %s not stopped" % err)
+
+        obe = BuildEnvironment.objects.create(lock = BuildEnvironment.LOCK_FREE, betype = BuildEnvironment.TYPE_LOCAL)
+        lbc = LocalhostBEController(obe)
+
+        bbc = lbc.getBBController()
+        self.assertTrue(isinstance(bbc, BitbakeController))
+        # test set variable
+        try:
+            bbc.setVariable
+        except Exception as e :
+            self.fail("setVariable raised %s", e)
+
+        lbc.stopBBServer()
+        out, err = subprocess.Popen("netstat  -tapn 2>/dev/null | grep 8200 | awk '{print $7}' | sort -fu | cut -d \"/\" -f 1 | grep -v -- - | tee /dev/fd/2 | xargs -r kill", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()
+        self.assertTrue(err == '', "bitbake server pid %s not stopped" % err)
+
+
+class RunBuildsCommandTests(TestCase):
+    def test_bec_select(self):
         """
-        Tests that 1 + 1 always equals 2.
+        Tests that we can find and lock a build environment
         """
-        self.assertEqual(1 + 1, 2)
+
+        obe = BuildEnvironment.objects.create(lock = BuildEnvironment.LOCK_FREE, betype = BuildEnvironment.TYPE_LOCAL)
+        command = Command()
+        bec = command._selectBuildEnvironment()
+
+        # make sure we select the object we've just built
+        self.assertTrue(bec.be.id == obe.id, "Environment is not properly selected")
+        # we have a locked environment
+        self.assertTrue(bec.be.lock == BuildEnvironment.LOCK_LOCK, "Environment is not locked")
+        # no more selections possible here
+        self.assertRaises(IndexError, command._selectBuildEnvironment)
+
+    def test_br_select(self):
+        from orm.models import Project
+        p, created = Project.objects.get_or_create(pk=1)
+        obr = BuildRequest.objects.create(state = BuildRequest.REQ_QUEUED, project = p)
+        command = Command()
+        br = command._selectBuildRequest()
+
+        # make sure we select the object we've just built
+        self.assertTrue(obr.id == br.id, "Request is not properly selected")
+        # we have a locked environment
+        self.assertTrue(br.state == BuildRequest.REQ_INPROGRESS, "Request is not updated")
+        # no more selections possible here
+        self.assertRaises(IndexError, command._selectBuildRequest)
-- 
1.9.1


