Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T4GOE-0007fh-L4 for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 21:14:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MJ2kx8005798
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:02:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05702-02 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:02:41 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MJ2bxn005792
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:02:38 +0100
Message-ID: <1345662159.3907.129.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Aug 2012 20:02:39 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] utils.py: Once we've printed errors messages, suppress the backtrace
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
X-List-Received-Date: Wed, 22 Aug 2012 19:14:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Adding a generic backtrace to better_compile and better_exec is pointless,
therefore reraise the exception as a bb.BBHandledException so the
generic code doesn't confuse the user even more.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index e0ef63c..82dab6b 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -216,7 +216,8 @@ def better_compile(text, file, realfile, mode = "exec"):
             for line in body:
                 logger.error(line)
 
-        raise
+        e = bb.BBHandledException(e)
+        raise e
 
 def better_exec(code, context, text = None, realfile = "<code>"):
     """
@@ -231,7 +232,7 @@ def better_exec(code, context, text = None, realfile = "<code>"):
         code = better_compile(code, realfile, realfile)
     try:
         exec(code, _context, context)
-    except Exception:
+    except Exception as e:
         (t, value, tb) = sys.exc_info()
 
         if t in [bb.parse.SkipPackage, bb.build.FuncFailed]:
@@ -280,7 +281,8 @@ def better_exec(code, context, text = None, realfile = "<code>"):
             nexttb = tb.tb_next
             level = level + 1
 
-        raise
+        e = bb.BBHandledException(e)
+        raise e
 
 def simple_exec(code, context):
     exec(code, _context, context)




