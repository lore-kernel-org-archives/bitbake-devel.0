Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7555177299
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb3B7007479; Wed, 1 Jun 2016 13:37:05 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mHNfE_0XgM2J; Wed,  1 Jun 2016 13:37:05 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxOx007457
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000oT-DT; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:34 +0100
Message-Id: <1464784607-2985-15-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 15/28] toaster: use decode('utf-8') for binary data
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:08 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Decoded binary data to utf-8 to fix the following
error when runnign on python 3:
TypeError: Type str doesn't support the buffer API

[YOCTO #9584]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/bldcontrol/localhostbecontroller.py        | 2 +-
 lib/toaster/bldcontrol/management/commands/loadconf.py | 2 +-
 lib/toaster/orm/models.py                              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index b4e4196..3da8be4 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -70,7 +70,7 @@ class LocalhostBEController(BuildEnvironmentController):
             raise ShellCmdException(err)
         else:
             logger.debug("localhostbecontroller: shellcmd success")
-            return out
+            return out.decode('utf-8')
 
     def getGitCloneDirectory(self, url, branch):
         """Construct unique clone directory name out of url and branch."""
diff --git a/lib/toaster/bldcontrol/management/commands/loadconf.py b/lib/toaster/bldcontrol/management/commands/loadconf.py
index 6d25df9..173e3ce 100644
--- a/lib/toaster/bldcontrol/management/commands/loadconf.py
+++ b/lib/toaster/bldcontrol/management/commands/loadconf.py
@@ -54,7 +54,7 @@ class Command(BaseCommand):
             (out,err) = cmd.communicate()
             if cmd.returncode != 0:
                 logging.warning("Error while importing layer vcs_url: git error: %s" % err)
-            for line in out.split("\n"):
+            for line in out.decode('utf-8').split("\n"):
                 try:
                     (name, path) = line.split("\t", 1)
                     if name == remote_name:
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 9183b0c..58dc753 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1169,7 +1169,7 @@ class LayerIndexLayerSource(LayerSource):
             except URLError as e:
                 raise Exception("Failed to read %s: %s" % (path, e.reason))
 
-            return json.loads(res.read())
+            return json.loads(res.read().decode('utf-8'))
 
         # verify we can get the basic api
         try:
-- 
2.5.0


