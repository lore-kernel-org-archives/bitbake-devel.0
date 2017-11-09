Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 270E5782DC
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Nov 2017 11:56:10 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	vA9BuAAb007699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 9 Nov 2017 11:56:11 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1eClRK-00031u-Ha; Thu, 09 Nov 2017 11:56:10 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Nov 2017 11:56:08 +0000
Message-Id: <1510228568-11602-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1510228568-11602-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1510228568-11602-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/2] tinfoil: Ensure we clean up loggers
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
X-List-Received-Date: Thu, 09 Nov 2017 11:56:11 -0000

This is primarily paranoid but ensure we remove any loggers we setup
either directly or indirectly so the initial state is restored after
we exit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tinfoil.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index fb2ee4a..fa95f63 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -322,14 +322,14 @@ class Tinfoil:
         self.server_connection = None
         self.recipes_parsed = False
         self.quiet = 0
+        self.oldhandlers = self.logger.handlers[:]
         if setup_logging:
             # This is the *client-side* logger, nothing to do with
             # logging messages from the server
-            oldhandlers = self.logger.handlers[:]
             bb.msg.logger_create('BitBake', output)
             self.localhandlers = []
             for handler in self.logger.handlers:
-                if handler not in oldhandlers:
+                if handler not in self.oldhandlers:
                     self.localhandlers.append(handler)
 
     def __enter__(self):
@@ -835,6 +835,12 @@ class Tinfoil:
             self.server_connection.terminate()
             self.server_connection = None
 
+        # Restore logging handlers to how it looked when we started
+        if self.oldhandlers:
+            for handler in self.logger.handlers:
+                if handler not in self.oldhandlers:
+                    self.logger.handlers.remove(handler)
+
     def _reconvert_type(self, obj, origtypename):
         """
         Convert an object back to the right type, in the case
-- 
2.7.4


