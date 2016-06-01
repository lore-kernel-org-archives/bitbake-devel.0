Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E94F8773D7
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb48R007485; Wed, 1 Jun 2016 13:37:08 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6SblXuawexxz; Wed,  1 Jun 2016 13:37:08 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxJQ007455
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000oH-CN; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:32 +0100
Message-Id: <1464784607-2985-13-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 13/28] toaster: fix local imports
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:14 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Replaced local imports with absolute imports.
Used .module for local imports.

This should make the code to work on python 2 and python 3.

[YOCTO #9584]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/bldcontrol/bbcontroller.py                      | 2 +-
 lib/toaster/bldcontrol/localhostbecontroller.py             | 2 +-
 lib/toaster/bldcontrol/management/commands/checksettings.py | 2 +-
 lib/toaster/bldcontrol/management/commands/loadconf.py      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index d09ac17..9bddadb 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -79,7 +79,7 @@ def getBuildEnvironmentController(**kwargs):
         The return object MUST always be a BuildEnvironmentController.
     """
 
-    from localhostbecontroller import LocalhostBEController
+    from bldcontrol.localhostbecontroller import LocalhostBEController
 
     be = BuildEnvironment.objects.filter(Q(**kwargs))[0]
     if be.betype == BuildEnvironment.TYPE_LOCAL:
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 7b2f126..b4e4196 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -32,7 +32,7 @@ import subprocess
 
 from toastermain import settings
 
-from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, BitbakeController
+from bldcontrol.bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException, BitbakeController
 
 import logging
 logger = logging.getLogger("toaster")
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 6b1da1b..2407e1b 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -105,7 +105,7 @@ class Command(NoArgsCommand):
                     try:
                         config_file = os.environ.get('TOASTER_CONF')
                         print("\nImporting file: %s" % config_file)
-                        from loadconf import Command as LoadConfigCommand
+                        from .loadconf import Command as LoadConfigCommand
 
                         LoadConfigCommand()._import_layer_config(config_file)
                         # we run lsupdates after config update
diff --git a/lib/toaster/bldcontrol/management/commands/loadconf.py b/lib/toaster/bldcontrol/management/commands/loadconf.py
index 5022b59..6d25df9 100644
--- a/lib/toaster/bldcontrol/management/commands/loadconf.py
+++ b/lib/toaster/bldcontrol/management/commands/loadconf.py
@@ -4,7 +4,7 @@ from orm.models import BitbakeVersion, Release, ReleaseDefaultLayer, ReleaseLaye
 from django.db import IntegrityError
 import os
 
-from checksettings import DN
+from .checksettings import DN
 
 import logging
 logger = logging.getLogger("toaster")
-- 
2.5.0


