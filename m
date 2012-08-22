Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T4GMm-0007cz-Dg for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 21:13:24 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MJ1IQ9005780
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:01:18 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05702-01 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:01:12 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MJ1AsB005774
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:01:11 +0100
Message-ID: <1345662072.3907.127.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Aug 2012 20:01:12 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] utils.py: Try harder to extract good traceback information by querying the datastore
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
X-List-Received-Date: Wed, 22 Aug 2012 19:13:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently as soon as execution passes outside the code fragment being
executed by better_exec, we don't get any good traceback information,
just a likely obscure reference to some function name which may
or may not be identifiable.

This patch adds code to query the datastore if present, allowing a more
meaningful back trace to be displayed in many cases.

[YOCTO #2981]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 44a42a0..e0ef63c 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -218,7 +218,7 @@ def better_compile(text, file, realfile, mode = "exec"):
 
         raise
 
-def better_exec(code, context, text = None, realfile = "<code>", data = None):
+def better_exec(code, context, text = None, realfile = "<code>"):
     """
     Similiar to better_compile, better_exec will
     print the lines that are responsible for the
@@ -256,16 +256,25 @@ def better_exec(code, context, text = None, realfile = "<code>", data = None):
 
         logger.error("The code that was being executed was:")
         _print_trace(textarray, linefailed)
-        logger.error("(file: '%s', lineno: %s, function: %s)", tbextract[0][0], tbextract[0][1], tbextract[0][2])
+        logger.error("[From file: '%s', lineno: %s, function: %s]", tbextract[0][0], tbextract[0][1], tbextract[0][2])
 
         # See if this is a function we constructed and has calls back into other functions in
         # "text". If so, try and improve the context of the error by diving down the trace
         level = 0
         nexttb = tb.tb_next
-        while nexttb is not None:
+        while nexttb is not None and (level+1) < len(tbextract):
             if tbextract[level][0] == tbextract[level+1][0] and tbextract[level+1][2] == tbextract[level][0]:
                 _print_trace(textarray, tbextract[level+1][1])
-                logger.error("(file: '%s', lineno: %s, function: %s)", tbextract[level+1][0], tbextract[level+1][1], tbextract[level+1][2])
+                logger.error("[From file: '%s', lineno: %s, function: %s]", tbextract[level+1][0], tbextract[level+1][1], tbextract[level+1][2])
+            elif "d" in context and tbextract[level+1][2]:
+                d = context["d"]
+                functionname = tbextract[level+1][2]
+                text = d.getVar(functionname, True)
+                if text:
+                    _print_trace(text.split('\n'), tbextract[level+1][1])
+                    logger.error("[From file: '%s', lineno: %s, function: %s]", tbextract[level+1][0], tbextract[level+1][1], tbextract[level+1][2])
+                else:
+                    break
             else:
                  break
             nexttb = tb.tb_next




