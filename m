Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id 46DBB602D9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 05:20:40 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id 184so713656pff.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 21:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=68ZwyfR2vckmM6dpFxNFRNcQWpSmpDSNCujbG/igyU8=;
	b=HnU8gu7l+fhFEmfa7MTXNNbwBPPs6Z84ZeIqI0037T40ZT2Gw6mNdVCPukqUF1Nz7O
	Spp5aNpA5uYaStfTJXb6yknO6qXygoKV3FdLwgLc48KhXo3sv9O2QDrCGuRDQRzk1dZL
	dJseNp1YJKu/YbSb5G1AmeT3LBBuXF/7xGmYWJVTlUFQYhYdw+YN5MxoW1NQzlIBgaUz
	71r90awQ/bZM/rappenbAUsw5Vm3lOQJJGVPf2JqmKl5WKc4QWOf4fnEm7nmvdUARpng
	Gfs5tMC9sG3ZWxA6IGSqPTJ+6uq+iImEc0BDJ9/T90D0WW2qiAsxelGyzecnLsK2v9bG
	7lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=68ZwyfR2vckmM6dpFxNFRNcQWpSmpDSNCujbG/igyU8=;
	b=dJgLz6mgP/cHPJPwFhuFS1Z/20kjSiX3eaSkoXoT5nKzkU7t/SpOeDOXbkaSSWbS4R
	dFEAmK/NUrycMkhx2MsKMEjpqGBCyC0H15Y9Ty5BKHRyXemMCPeSGrtAB4URJDF2d2Jp
	rD+HjqAzoAZ/KT9nfxmsUOlnUfEnPHfEibBbE16QeSVzyZ+7Q++X1NnaMkUiGC4By62r
	zX3ubDvFM6SB35/u20DCccgd+Upz0IGNeoBHMLMzyTgK/8p18bvgiH1DnHJZZFQagWbH
	yDaCOKPDMVSnKp0mGSvjTtdI87vqJXkKgjHjyQG1okg0BdidE4NW86rKVgQ+JJZAsgWy
	4LZA==
X-Gm-Message-State: AD7BkJJaqulOLo2fYlrXpB4Vn2nC2A+TXo449etFFmtXQPXYNU3oXQuC3rgByk2nZhHOMQ==
X-Received: by 10.98.68.73 with SMTP id r70mr1079871pfa.136.1456982441754;
	Wed, 02 Mar 2016 21:20:41 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	z5sm25544986par.21.2016.03.02.21.20.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 21:20:41 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 21:26:54 -0800
Message-Id: <df618a1a82ca72c39f9334c7b6ce1104553cf7da.1456982682.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1456982682.git.avery.brian@gmail.com>
References: <cover.1456982682.git.avery.brian@gmail.com>
Subject: [PATCH 1/3] toaster: raise NotImplementedError
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
X-List-Received-Date: Thu, 03 Mar 2016 05:20:41 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Raised NotImplementedError instead of Exception to be
able to catch it.

This is a preparation for removing sshbecontroller module.
It has to be done as code in bldcontrol/tests.py imports custom
NotImplementedException from sshbecontroller.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/bbcontroller.py | 10 +++++-----
 lib/toaster/bldcontrol/models.py       |  8 ++++++--
 lib/toaster/bldcontrol/tests.py        |  6 ++----
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 1387bda..f228d37 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -138,7 +138,7 @@ class BuildEnvironmentController(object):
             After this method executes, self.be bbaddress/bbport MUST point to a running and free server,
             and the bbstate MUST be  updated to "started".
         """
-        raise Exception("FIXME: Must override in order to actually start the BB server")
+        raise NotImplementedError("FIXME: Must override in order to actually start the BB server")
 
 
     def setLayers(self, bitbake, ls):
@@ -149,7 +149,7 @@ class BuildEnvironmentController(object):
 
             a word of attention: by convention, the first layer for any build will be poky!
         """
-        raise Exception("FIXME: Must override setLayers")
+        raise NotImplementedError("FIXME: Must override setLayers")
 
 
     def getBBController(self):
@@ -176,16 +176,16 @@ class BuildEnvironmentController(object):
             up to the implementing BEC. The return MUST be a REST URL where a GET will actually return
             the content of the artifact, e.g. for use as a "download link" in a web UI.
         """
-        raise Exception("Must return the REST URL of the artifact")
+        raise NotImplementedError("Must return the REST URL of the artifact")
 
     def release(self):
         """ This stops the server and releases any resources. After this point, all resources
             are un-available for further reference
         """
-        raise Exception("Must override BE release")
+        raise NotImplementedError("Must override BE release")
 
     def triggerBuild(self, bitbake, layers, variables, targets):
-        raise Exception("Must override BE release")
+        raise NotImplementedError("Must override BE release")
 
 class ShellCmdException(Exception):
     pass
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index a3a49ce..bb613c6 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -42,13 +42,17 @@ class BuildEnvironment(models.Model):
     def get_artifact(self, path):
         if self.betype == BuildEnvironment.TYPE_LOCAL:
             return open(path, "r")
-        raise Exception("FIXME: artifact download not implemented for build environment type %s" % self.get_betype_display())
+        raise NotImplementedError("FIXME: artifact download not implemented "\
+                                  "for build environment type %s" % \
+                                  self.get_betype_display())
 
     def has_artifact(self, path):
         import os
         if self.betype == BuildEnvironment.TYPE_LOCAL:
             return os.path.exists(path)
-        raise Exception("FIXME: has artifact not implemented for build environment type %s" % self.get_betype_display())
+        raise NotImplementedError("FIXME: has artifact not implemented for "\
+                                  "build environment type %s" % \
+                                  self.get_betype_display())
 
 # a BuildRequest is a request that the scheduler will build using a BuildEnvironment
 # the build request queue is the table itself, ordered by state
diff --git a/lib/toaster/bldcontrol/tests.py b/lib/toaster/bldcontrol/tests.py
index 141b42a..e808991 100644
--- a/lib/toaster/bldcontrol/tests.py
+++ b/lib/toaster/bldcontrol/tests.py
@@ -48,13 +48,12 @@ class BEControllerTests(object):
         self.assertTrue(err == '', "bitbake server pid %s not stopped" % err)
 
     def test_serverStartAndStop(self):
-        from bldcontrol.sshbecontroller import NotImplementedException
         obe =  self._getBuildEnvironment()
         bc = self._getBEController(obe)
         try:
             # setting layers, skip any layer info
             bc.setLayers(BITBAKE_LAYER, POKY_LAYERS)
-        except NotImplementedException,  e:
+        except NotImplementedError:
             print "Test skipped due to command not implemented yet"
             return True
         # We are ok with the exception as we're handling the git already exists
@@ -74,14 +73,13 @@ class BEControllerTests(object):
         self._serverForceStop(bc)
 
     def test_getBBController(self):
-        from bldcontrol.sshbecontroller import NotImplementedException
         obe = self._getBuildEnvironment()
         bc = self._getBEController(obe)
         layerSet = False
         try:
             # setting layers, skip any layer info
             layerSet = bc.setLayers(BITBAKE_LAYER, POKY_LAYERS)
-        except NotImplementedException:
+        except NotImplementedError:
             print "Test skipped due to command not implemented yet"
             return True
         # We are ok with the exception as we're handling the git already exists
-- 
1.9.1


