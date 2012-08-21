Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T3rUt-0000mL-Dd for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 18:40:07 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7LGS4uL014920
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Aug 2012 17:28:04 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14609-02 for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Aug 2012 17:27:59 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7LGRujq014914
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Aug 2012 17:27:58 +0100
Message-ID: <1345566476.3907.95.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 21 Aug 2012 17:27:56 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] event/ast: Use better_exec instead of simple_exec
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
X-List-Received-Date: Tue, 21 Aug 2012 16:40:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This improves the stack traces dumped by bitbake when for example anonymous
python functions fail.

Also default to passing code strings to better_exec to match the behaviour of
simple_exec to aid the transition.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 20923b5..fa179d8 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -175,7 +175,7 @@ def register(name, handler):
                 _handlers[name] = noop
                 return
             env = {}
-            bb.utils.simple_exec(code, env)
+            bb.utils.better_exec(code, env)
             func = bb.utils.better_eval(name, env)
             _handlers[name] = func
         else:
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 86f9463..b88d5f5 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -320,7 +320,7 @@ def finalize(fn, d, variant = None):
     code = []
     for funcname in d.getVar("__BBANONFUNCS") or []:
         code.append("%s(d)" % funcname)
-    bb.utils.simple_exec("\n".join(code), {"d": d})
+    bb.utils.better_exec("\n".join(code), {"d": d})
     bb.data.update_data(d)
 
     tasklist = d.getVar('__BBTASKS') or []
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index ee4ef73..da12b14 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -218,7 +218,7 @@ def better_compile(text, file, realfile, mode = "exec"):
 
         raise
 
-def better_exec(code, context, text, realfile = "<code>"):
+def better_exec(code, context, text = code, realfile = "<code>"):
     """
     Similiar to better_compile, better_exec will
     print the lines that are responsible for the




