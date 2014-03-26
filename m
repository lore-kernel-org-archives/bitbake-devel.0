Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id D4F086EC83
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 16:55:48 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2QGti89028934 for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 16:55:44 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dvn-r1vwwAbq for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 16:55:44 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2QGtf4Y028928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 16:55:43 GMT
Message-ID: <1395852935.24890.105.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 26 Mar 2014 16:55:35 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] msg: Add stdout/stderr filters
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
X-List-Received-Date: Wed, 26 Mar 2014 16:55:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Add logging filters which can be used to split output between stdout and
stderr, ERROR messages and above as passed by the Err filter, anything
below ERROR is passed by the Out filter. This is useful when trying to make
stderr more useful.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index 5976970..d79768d 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -126,7 +126,21 @@ class BBLogFilter(object):
             return True
         return False
 
+class BBLogFilterStdErr(BBLogFilter):
+    def filter(self, record):
+        if not BBLogFilter.filter(self, record):
+            return False
+        if record.levelno >= logging.ERROR:
+            return True
+        return False
 
+class BBLogFilterStdOut(BBLogFilter):
+    def filter(self, record):
+        if not BBLogFilter.filter(self, record):
+            return False
+        if record.levelno < logging.ERROR:
+            return True
+        return False
 
 # Message control functions
 #
@@ -164,10 +178,10 @@ def constructLogOptions():
         debug_domains["BitBake.%s" % domainarg] = logging.DEBUG - dlevel + 1
     return level, debug_domains
 
-def addDefaultlogFilter(handler):
+def addDefaultlogFilter(handler, cls = BBLogFilter):
     level, debug_domains = constructLogOptions()
 
-    BBLogFilter(handler, level, debug_domains)
+    cls(handler, level, debug_domains)
 
 #
 # Message handling functions



