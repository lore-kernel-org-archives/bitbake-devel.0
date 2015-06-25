Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 3422673F9E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:00 +0000 (UTC)
Received: by wgbhy7 with SMTP id hy7so58661905wgb.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Yt77biQpycCf/lmZ6GzBJBPHjwIMhGom398MD27XiyQ=;
	b=hOoKPemFwcfOodl/TpkpPAcrvQR1IuY3Oj8gKlZEPXFQoGupzeuPCLRYjkrWtaHXvg
	Cw8x3Z1LHQGlMCGzKfOSxaM9rFXba6FAaezEgcJOR/pIPCdmjYyOEZjKx39imFb2qSL6
	QTHF3rZA/3n9vUGdz56bh54TdmDnzV2Bc94nq8LVveVnAS3iKqyb/gsaN1isAwOL/+TN
	21XwJX0xPCL9b2i4GY35MpOMVFMtEzUhVOTqDGxoZoair7kl8q+BNPMYOJF4/glzTl2u
	Og4grpo5txL3PJcZLMSo1t17sR20lYdhG4JJdzH/btVdb/NXrVuNh9spt4B5oAmKwXY+
	ClNA==
X-Gm-Message-State: ALoCoQkJVToko7NcYEwaoNSag/1SCYGMFY7G7+3hdvBbysr1ulbWVa79LuWI6MyQ42ZaQ6BCTyZm
X-Received: by 10.194.93.226 with SMTP id cx2mr18577950wjb.28.1435228440876;
	Thu, 25 Jun 2015 03:34:00 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id di7sm6906557wib.23.2015.06.25.03.33.59
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:33:59 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B8AA4561CC7; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:39 +0100
Message-Id: <7ee0f1da0a8fcac37419ffdddbe35a9268a1ded4.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 02/23] toaster: improve the buildenvironment API
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:01 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We improve the buildenvironment API by reducing it to a single
command: triggerBuild.

This command is specifically implemented in each BE controller
type, so the runbuilds management command is only concerned
with scheduling the next build, and not with the details
of how a build is actually started.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py             |  3 +++
 lib/toaster/bldcontrol/localhostbecontroller.py    | 22 ++++++++++++++++
 .../bldcontrol/management/commands/runbuilds.py    | 30 +++++-----------------
 lib/toaster/bldcontrol/sshbecontroller.py          | 21 +++++++++++++++
 4 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 42675d3..9dd01e0 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -190,6 +190,9 @@ class BuildEnvironmentController(object):
         """
         raise Exception("Must override BE release")
 
+    def triggerBuild(self, bitbake, layers, variables, targets):
+        raise Exception("Must override BE release")
+
 class ShellCmdException(Exception):
     pass
 
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index bc3566a..d0f8632 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -317,3 +317,25 @@ class LocalhostBEController(BuildEnvironmentController):
         import shutil
         shutil.rmtree(os.path.join(self.be.sourcedir, "build"))
         assert not os.path.exists(self.be.builddir)
+
+
+    def triggerBuild(self, bitbake, layers, variables, targets):
+        # set up the buid environment with the needed layers
+        self.setLayers(bitbake, layers)
+        self.writeConfFile("conf/toaster-pre.conf", )
+        self.writeConfFile("conf/toaster.conf", raw = "INHERIT+=\"toaster buildhistory\"")
+
+        # get the bb server running with the build req id and build env id
+        bbctrl = self.getBBController()
+
+        # trigger the build command
+        task = reduce(lambda x, y: x if len(y)== 0 else y, map(lambda y: y.task, targets))
+        if len(task) == 0:
+            task = None
+
+        bbctrl.build(list(map(lambda x:x.target, targets)), task)
+
+        logger.debug("localhostbecontroller: Build launched, exiting. Follow build logs at %s/toaster_ui.log" % self.be.builddir)
+
+        # disconnect from the server
+        bbctrl.disconnect()
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 808318f..920d9ef 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -50,33 +50,16 @@ class Command(NoArgsCommand):
 
             # write the build identification variable
             BRVariable.objects.create(req = br, name="TOASTER_BRBE", value="%d:%d" % (br.pk, bec.be.pk))
+
             # let the build request know where it is being executed
             br.environment = bec.be
             br.save()
 
-            # set up the buid environment with the needed layers
-            bec.setLayers(br.brbitbake_set.all(), br.brlayer_set.all())
-            bec.writeConfFile("conf/toaster-pre.conf", br.brvariable_set.all())
-            bec.writeConfFile("conf/toaster.conf", raw = "INHERIT+=\"toaster buildhistory\"")
-
-            # get the bb server running with the build req id and build env id
-            bbctrl = bec.getBBController()
-
-            # trigger the build command
-            task = reduce(lambda x, y: x if len(y)== 0 else y, map(lambda y: y.task, br.brtarget_set.all()))
-            if len(task) == 0:
-                task = None
-            bbctrl.build(list(map(lambda x:x.target, br.brtarget_set.all())), task)
-
-            logger.debug("runbuilds: Build launched, exiting. Follow build logs at %s/toaster_ui.log" % bec.be.builddir)
-            # disconnect from the server
-            bbctrl.disconnect()
-
-            # cleanup to be performed by toaster when the deed is done
-
+            # this triggers an async build
+            bec.triggerBuild(br.brbitbake_set.all(), br.brlayer_set.all(), br.brvariable_set.all(), br.brtarget_set.all())
 
         except Exception as e:
-            logger.error("runbuilds: Error executing shell command %s" % e)
+            logger.error("runbuilds: Error launching build %s" % e)
             traceback.print_exc(e)
             if "[Errno 111] Connection refused" in str(e):
                 # Connection refused, read toaster_server.out
@@ -124,8 +107,9 @@ class Command(NoArgsCommand):
     def cleanup(self):
         from django.utils import timezone
         from datetime import timedelta
-        # environments locked for more than 30 seconds - they should be unlocked
-        BuildEnvironment.objects.filter(lock=BuildEnvironment.LOCK_LOCK).filter(updated__lt = timezone.now() - timedelta(seconds = 30)).update(lock = BuildEnvironment.LOCK_FREE)
+        # DISABLED environments locked for more than 30 seconds - they should be unlocked
+        #BuildEnvironment.objects.filter(lock=BuildEnvironment.LOCK_LOCK).filter(updated__lt = timezone.now() - timedelta(seconds = 30)).update(lock = BuildEnvironment.LOCK_FREE)
+        pass
 
 
     def handle_noargs(self, **options):
diff --git a/lib/toaster/bldcontrol/sshbecontroller.py b/lib/toaster/bldcontrol/sshbecontroller.py
index 29ed0a7..8ef434b 100644
--- a/lib/toaster/bldcontrol/sshbecontroller.py
+++ b/lib/toaster/bldcontrol/sshbecontroller.py
@@ -156,3 +156,24 @@ class SSHBEController(BuildEnvironmentController):
         import shutil
         shutil.rmtree(os.path.join(self.be.sourcedir, "build"))
         assert not self._pathexists(self.be.builddir)
+
+    def triggerBuild(self, bitbake, layers, variables, targets):
+        # set up the buid environment with the needed layers
+        self.setLayers(bitbake, layers)
+        self.writeConfFile("conf/toaster-pre.conf", )
+        self.writeConfFile("conf/toaster.conf", raw = "INHERIT+=\"toaster buildhistory\"")
+
+        # get the bb server running with the build req id and build env id
+        bbctrl = self.getBBController()
+
+        # trigger the build command
+        task = reduce(lambda x, y: x if len(y)== 0 else y, map(lambda y: y.task, targets))
+        if len(task) == 0:
+            task = None
+
+        bbctrl.build(list(map(lambda x:x.target, targets)), task)
+
+        logger.debug("localhostbecontroller: Build launched, exiting. Follow build logs at %s/toaster_ui.log" % self.be.builddir)
+
+        # disconnect from the server
+        bbctrl.disconnect()
-- 
1.9.1


