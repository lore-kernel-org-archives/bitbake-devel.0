Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Ua8Fr-0001Xf-Ik for bitbake-devel@lists.openembedded.org;
	Wed, 08 May 2013 19:34:16 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r48HIYRc009942 for <bitbake-devel@lists.openembedded.org>;
	Wed, 8 May 2013 18:18:35 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dUvUGMikueWc for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 May 2013 18:18:34 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r48HIUtb009936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Wed, 8 May 2013 18:18:32 +0100
Message-ID: <1368033360.27116.93.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 08 May 2013 18:16:00 +0100
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Subject: utils: Improve better_compile error message
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 08 May 2013 17:34:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Similarly to the better_exec improvements, improve the compile failure
messages to be more user readable.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 9d7a32f..462eb68 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -255,18 +255,20 @@ def better_compile(text, file, realfile, mode = "exec"):
     try:
         return compile(text, file, mode)
     except Exception as e:
+        error = []
         # split the text into lines again
         body = text.split('\n')
-        logger.error("Error in compiling python function in %s", realfile)
-        logger.error(str(e))
+        error.append("Error in compiling python function in %s:\n" % realfile)
         if e.lineno:
-            logger.error("The lines leading to this error were:")
-            logger.error("\t%d:%s:'%s'", e.lineno, e.__class__.__name__, body[e.lineno-1])
-            logger.error("\n".join(_print_trace(body, e.lineno)))
+            error.append("The code lines resulting in this error were:")
+            error.extend(_print_trace(body, e.lineno))
         else:
-            logger.error("The function causing this error was:")
+            error.append("The function causing this error was:")
             for line in body:
-                logger.error(line)
+                error.append(line)
+        error.append("%s: %s" % (e.__class__.__name__, str(e)))
+
+        logger.error("\n".join(error))
 
         e = bb.BBHandledException(e)
         raise e




