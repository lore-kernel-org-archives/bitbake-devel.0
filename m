Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 59C3B77299
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb48H007485; Wed, 1 Jun 2016 13:37:04 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Rld6CYmDHtzO; Wed,  1 Jun 2016 13:37:04 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxkR007452
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000o2-Ao; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:29 +0100
Message-Id: <1464784607-2985-10-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 10/28] toaster: use force_text instead of force_bytes
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:07 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Usage of force_bytes in BuildRequest.__str__ method caused
python 3 to throw "__str__ returned non-string (type bytes)"
error.

Replaced force_bytes with force_text to make the code working
on both python 2 and python 3.

[YOCTO #9584]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 4 ++--
 lib/toaster/bldcontrol/models.py                        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index e3145e8..80782ef 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -54,8 +54,8 @@ class Command(NoArgsCommand):
                 logger.debug("runbuilds: No build env")
                 return
 
-            logger.debug("runbuilds: starting build %s, environment %s" % \
-                         (str(br).decode('utf-8'), bec.be))
+            logger.info("runbuilds: starting build %s, environment %s" % \
+                        (br, bec.be))
 
             # let the build request know where it is being executed
             br.environment = bec.be
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index e09ad20..f06c562 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -1,7 +1,7 @@
 from __future__ import unicode_literals
 from django.db import models
 from django.core.validators import MaxValueValidator, MinValueValidator
-from django.utils.encoding import force_bytes
+from django.utils.encoding import force_text
 from orm.models import Project, ProjectLayer, ProjectVariable, ProjectTarget, Build, Layer_Version
 
 import logging
@@ -121,7 +121,7 @@ class BuildRequest(models.Model):
         return self.brvariable_set.get(name="MACHINE").value
 
     def __str__(self):
-        return force_bytes('%s %s' % (self.project, self.get_state_display()))
+        return force_text('%s %s' % (self.project, self.get_state_display()))
 
 # These tables specify the settings for running an actual build.
 # They MUST be kept in sync with the tables in orm.models.Project*
-- 
2.5.0


