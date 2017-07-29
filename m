Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 56C18785A3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 29 Jul 2017 00:22:45 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v6T0MkVq026742
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 17:22:47 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Fri, 28 Jul 2017 17:22:46 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Jul 2017 17:14:14 -0700
Message-ID: <5f1d922a5ab0ad617a5ae645a0c99500c5326087.1501286516.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1501286515.git.David.Reyna@windriver.com>
References: <cover.1501286515.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 2/2] toaster: move to new bitbake xmlrpc default
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
X-List-Received-Date: Sat, 29 Jul 2017 00:22:45 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The bitbake option "-t SERVERTYPE" was deprecated and can be
removed since the desired XMLRPC listener now the default.

The bitbake server port cannot be "-1" anymore and must be
explicitly passed.

There is a race condition for the bblock file to not only
be created but to actually be populated, so a delay test loop
is required (usually only one pass).

The 'xmlrpcclient' is now the class that allows Toaster to for
example kill builds.

The events for populating the recipe parsing now either show only
the final result or are skipped entiredly, so the progress
calculator needs to be changed to not block on the parsing phase.

[YOCTO #11851]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/bbcontroller.py          |  4 ++--
 lib/toaster/bldcontrol/localhostbecontroller.py | 19 +++++++++++++++----
 lib/toaster/orm/models.py                       |  2 +-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 912f67b..5195600 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -37,8 +37,8 @@ class BitbakeController(object):
     """
 
     def __init__(self, be):
-        import bb.server.xmlrpc
-        self.connection = bb.server.xmlrpc._create_server(be.bbaddress,
+        import bb.server.xmlrpcclient
+        self.connection = bb.server.xmlrpcclient._create_server(be.bbaddress,
                                                           int(be.bbport))[0]
 
     def _runCommand(self, command):
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 2916246..6142f7e 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -24,6 +24,7 @@ import os
 import sys
 import re
 import shutil
+import time
 from django.db import transaction
 from django.db.models import Q
 from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget, BRBitbake
@@ -331,12 +332,22 @@ class LocalhostBEController(BuildEnvironmentController):
         bitbake = os.path.join(self.pokydirname, 'bitbake', 'bin', 'bitbake')
         toasterlayers = os.path.join(builddir,"conf/toaster-bblayers.conf")
         self._shellcmd('bash -c \"source %s %s; BITBAKE_UI="knotty" %s --read %s --read %s '
-                       '--server-only -t xmlrpc -B 0.0.0.0:0\"' % (oe_init,
+                       '--server-only -B 0.0.0.0:0\"' % (oe_init,
                        builddir, bitbake, confpath, toasterlayers), self.be.sourcedir)
 
         # read port number from bitbake.lock
         self.be.bbport = ""
         bblock = os.path.join(builddir, 'bitbake.lock')
+        # allow 10 seconds for bb lock file to appear but also be populated
+        for lock_check in range(10):
+            if not os.path.exists(bblock):
+                logger.debug("localhostbecontroller: waiting for bblock file to appear")
+                time.sleep(1)
+                continue
+            if 10 < os.stat(bblock).st_size:
+                break
+            logger.debug("localhostbecontroller: waiting for bblock content to appear")
+            time.sleep(1)
         with open(bblock) as fplock:
             for line in fplock:
                 if ":" in line:
@@ -365,10 +376,10 @@ class LocalhostBEController(BuildEnvironmentController):
         log = os.path.join(builddir, 'toaster_ui.log')
         local_bitbake = os.path.join(os.path.dirname(os.getenv('BBBASEDIR')),
                                      'bitbake')
-        self._shellcmd(['bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:-1" '
+        self._shellcmd(['bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:%s" '
                         '%s %s -u toasterui --token="" >>%s 2>&1;'
-                        'BITBAKE_UI="knotty" BBSERVER=0.0.0.0:-1 %s -m)&\"' \
-                        % (brbe, local_bitbake, bbtargets, log, bitbake)],
+                        'BITBAKE_UI="knotty" BBSERVER=0.0.0.0:%s %s -m)&\"' \
+                        % (brbe, self.be.bbport, local_bitbake, bbtargets, log, self.be.bbport, bitbake)],
                         builddir, nowait=True)
 
         logger.debug('localhostbecontroller: Build launched, exiting. '
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 05cc5a8..7aaebed 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -451,7 +451,7 @@ class Build(models.Model):
     recipes_to_parse = models.IntegerField(default=1)
 
     # number of recipes parsed so far for this build
-    recipes_parsed = models.IntegerField(default=0)
+    recipes_parsed = models.IntegerField(default=1)
 
     # number of repos to clone for this build
     repos_to_clone = models.IntegerField(default=1)
-- 
1.9.1


