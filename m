Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id A25B061486
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Feb 2015 12:14:01 +0000 (UTC)
Received: by mail-wg0-f43.google.com with SMTP id y19so38380546wgg.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 02 Feb 2015 04:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=8METslhMFA7sOcgh78SRmIEOxNMG9XbTJhMpwVrIqu4=;
	b=AwUblPYAfNOeYA7Ry34bnDn+j0138asLBEiZlzTjAoBEgUB5rjmsC/OkyGGxK0Hgjd
	/EfbPjJ+7Kpu7/dNOk+Hf47OYMYU9ZA9PGCf/z5XJD5EGBJ22vGnArDj45AS4TG6/nwI
	2HU71xpMNx+z5GXKXyATVZWqW3jfhNalYXw99iItLl16dJLwLyhvhURwgPpVJj98F64a
	UsUh3pK2pY571YcyqA/HN1f4g12fduBpnaFamqYUiJwOsFCxONTJRfsbwOZOa044TMp2
	8NyrvxxAq3BpcxE8hIi64SRULHDvpXshKb6kgfOk+fVFKcHiy7RdDSJwJahzxVQ4SIex
	oQkg==
X-Gm-Message-State: ALoCoQndp0bdWAkpcJpCBbsKHveW2BqTAG9o4P5v1JjFHvY8WeHUvz9Eu2OE59NFkCYAGVdZaOds
X-Received: by 10.194.60.205 with SMTP id j13mr42911609wjr.42.1422879242203;
	Mon, 02 Feb 2015 04:14:02 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id 18sm27611249wjr.46.2015.02.02.04.14.00
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 02 Feb 2015 04:14:01 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0214A561796; Mon,  2 Feb 2015 12:13:59 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Feb 2015 12:13:58 +0000
Message-Id: <1422879238-20984-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/1] toaster: proper setup for build configuration
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
X-List-Received-Date: Mon, 02 Feb 2015 12:14:02 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch makes sure that all the toaster conf files are actually
written from the build enviroment controllers.

Additionally, toaster checks that the 'daemon' program, which is used
to start the build system, is available (currently for localhost).

[YOCTO #7171]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                             |  5 +++++
 lib/toaster/bldcontrol/bbcontroller.py                  | 16 ++++++++--------
 lib/toaster/bldcontrol/localhostbecontroller.py         | 11 +++++++++++
 lib/toaster/bldcontrol/management/commands/runbuilds.py |  3 ++-
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 4f25293..85a2575 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -175,6 +175,11 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
         exit 1;
     fi
 
+    if [ "x`which daemon`" == "x" ]; then
+        echo -e "Failed dependency; toaster needs the 'daemon' program in order to be able to start builds'. Please install the 'daemon' program." 1>&2;
+	exit 1;
+    fi
+
     # Define a fake builddir where only the pid files are actually created. No real builds will take place here.
     BUILDDIR=/tmp
     RUNNING=1
diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index dbfb2f3..cf3f1fd 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -140,25 +140,25 @@ class BuildEnvironmentController(object):
         bblayerconffile.write("# line added by toaster build control\nBBLAYERS = \"" + " ".join(layerlist) + "\"")
         bblayerconffile.close()
 
-    def writePreConfFile(self, variable_list):
-        prefilepath = os.path.join(self.be.builddir, "conf/toaster-pre.conf")
-        with open(prefilepath, "w") as prefile:
-            for i in variable_list:
-                prefile.write("%s=\"%s\"\n" % (i.name, i.value))
 
+    def writeConfFile(self, variable_list = None, raw = None):
+        """ Writes a configuration file in the build directory. Override with buildenv-specific implementation. """
+        raise Exception("FIXME: Must override to actually write a configuration file")
 
-    def startBBServer(self, brbe):
+
+    def startBBServer(self):
         """ Starts a  BB server with Toaster toasterui set up to record the builds, an no controlling UI.
             After this method executes, self.be bbaddress/bbport MUST point to a running and free server,
             and the bbstate MUST be  updated to "started".
         """
-        raise Exception("Must override in order to actually start the BB server")
+        raise Exception("FIXME: Must override in order to actually start the BB server")
 
     def stopBBServer(self):
         """ Stops the currently running BB server.
             The bbstate MUST be updated to "stopped".
             self.connection must be none.
         """
+        raise Exception("FIXME: Must override stoBBServer")
 
     def setLayers(self, bbs, ls):
         """ Checks-out bitbake executor and layers from git repositories.
@@ -168,7 +168,7 @@ class BuildEnvironmentController(object):
 
             a word of attention: by convention, the first layer for any build will be poky!
         """
-        raise Exception("Must override setLayers")
+        raise Exception("FIXME: Must override setLayers")
 
 
     def getBBController(self):
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 980751f..47708d1 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -82,6 +82,17 @@ class LocalhostBEController(BuildEnvironmentController):
         self._createdirpath(self.be.builddir)
         self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.pokydirname, self.be.builddir))
 
+
+    def writeConfFile(self, file_name, variable_list = None, raw = None):
+        filepath = os.path.join(self.be.builddir, file_name)
+        with open(filepath, "w") as conffile:
+            if variable_list is not None:
+                for i in variable_list:
+                    conffile.write("%s=\"%s\"\n" % (i.name, i.value))
+            if raw is not None:
+                conffile.write(raw)
+
+
     def startBBServer(self):
         assert self.pokydirname and os.path.exists(self.pokydirname)
         assert self.islayerset
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 23ee855..3b539b5 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -56,7 +56,8 @@ class Command(NoArgsCommand):
 
             # set up the buid environment with the needed layers
             bec.setLayers(br.brbitbake_set.all(), br.brlayer_set.all())
-            bec.writePreConfFile(br.brvariable_set.all())
+            bec.writeConfFile("conf/toaster-pre.conf", br.brvariable_set.all())
+            bec.writeConfFile("conf/toaster.conf", raw = "INHERIT+=\"toaster buildhistory\"")
 
             # get the bb server running with the build req id and build env id
             bbctrl = bec.getBBController()
-- 
1.9.1


