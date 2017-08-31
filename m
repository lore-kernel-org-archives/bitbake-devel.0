Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5ADC07842A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 16:38:42 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7VGcfKh028720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 31 Aug 2017 17:38:42 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dnSUL-0003FQ-7e; Thu, 31 Aug 2017 17:38:41 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 17:38:33 +0100
Message-Id: <1504197520-12428-3-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 31 Aug 2017 17:38:42 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 03/10] cooker: Change to consistent prefile/postfile handling
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
X-List-Received-Date: Thu, 31 Aug 2017 16:38:46 -0000

Currently the original prefile and postfile passed when starting bitbake
server are 'sticky'. With the new memory resident model this doesn't make
sense as the server the system is started with isn't special.

This patch changes the code so the prefile/postfile are used if specified
on the commandline and not used otherwise. This makes the behaviour much
more predictable and expected and as an added bonus simplifies the code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         | 23 ++++++++++-------------
 lib/bb/cookerdata.py     |  2 --
 lib/bb/server/process.py |  6 ------
 3 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ad08c47..5ee1c0a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -416,19 +416,16 @@ class BBCooker:
         clean = True
         for o in options:
             if o in ['prefile', 'postfile']:
-                server_val = getattr(self.configuration, "%s_server" % o, None)
-                if not options[o] and server_val:
-                    # restore value provided on server start
-                    logger.debug(1, "Restoring server value for option '%s'" % o)
-                    setattr(self.configuration, o, server_val)
-                    clean = False
-                    continue
-                if getattr(self.configuration, o) == options[o]:
-                    # Value is the same, no need to mark dirty
-                    continue
-                else:
-                    logger.debug(1, "Marking as dirty due to '%s' option change to '%s'" % (o, options[o]))
-                    clean = False
+                # Only these options may require a reparse
+                try:
+                    if getattr(self.configuration, o) == options[o]:
+                        # Value is the same, no need to mark dirty
+                        continue
+                except AttributeError:
+                    pass
+                logger.debug(1, "Marking as dirty due to '%s' option change to '%s'" % (o, options[o]))
+                print("Marking as dirty due to '%s' option change to '%s'" % (o, options[o]))
+                clean = False
             setattr(self.configuration, o, options[o])
         for k in bb.utils.approved_variables():
             if k in environment and k not in self.configuration.env:
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 197db62..d105ab7 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -127,8 +127,6 @@ class CookerConfiguration(object):
         self.extra_assume_provided = []
         self.prefile = []
         self.postfile = []
-        self.prefile_server = []
-        self.postfile_server = []
         self.debug = 0
         self.cmd = None
         self.abort = True
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index fad8aac..5c7dfae 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -405,12 +405,6 @@ class BitBakeServer(object):
         server = ProcessServer(self.bitbake_lock, self.sock, self.sockname)
         self.configuration.setServerRegIdleCallback(server.register_idle_function)
 
-        # Copy prefile and postfile to _server variants
-        for param in ('prefile', 'postfile'):
-            value = getattr(self.configuration, param)
-            if value:
-                setattr(self.configuration, "%s_server" % param, value)
-
         self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset, self.readypipein)
         server.cooker = self.cooker
         server.server_timeout = self.configuration.server_timeout
-- 
2.7.4


