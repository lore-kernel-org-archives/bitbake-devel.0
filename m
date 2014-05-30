Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 265BF6FA94
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 14:56:30 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4UEuPBO012336 for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:56:26 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MFwlAxa2Ebl3 for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:56:25 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4UEuJPk012309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:56:21 +0100
Message-ID: <1401461771.31309.53.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 30 May 2014 15:56:11 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] build/utils: Fix broken exception handling
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
X-List-Received-Date: Fri, 30 May 2014 14:56:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Checking for explicit exception names is bad, we also want to be able top
rely on inheritance. Fix these checks to be part of the real except clauses
so SkipPackage is recognised as being inherited from SkipRecipe.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 1a17547..6b70ce5 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -242,10 +242,9 @@ def exec_func_python(func, d, runfile, cwd=None):
     try:
         comp = utils.better_compile(code, func, bbfile)
         utils.better_exec(comp, {"d": d}, code, bbfile)
+    except (bb.parse.SkipRecipe, bb.build.FuncFailed):
+        raise
     except:
-        if sys.exc_info()[0] in (bb.parse.SkipRecipe, bb.build.FuncFailed):
-            raise
-
         raise FuncFailed(func, None)
     finally:
         bb.debug(2, "Python function %s finished" % func)
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index c179394..96d8218 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -354,16 +354,11 @@ def better_exec(code, context, text = None, realfile = "<code>"):
         code = better_compile(code, realfile, realfile)
     try:
         exec(code, get_context(), context)
-    except bb.BBHandledException:
-        # Error already shown so passthrough
-        raise
-    except bb.data_smart.ExpansionError:
+    except (bb.BBHandledException, bb.parse.SkipRecipe, bb.build.FuncFailed, bb.data_smart.ExpansionError):
+        # Error already shown so passthrough, no need for traceback
         raise
     except Exception as e:
         (t, value, tb) = sys.exc_info()
-
-        if t in [bb.parse.SkipRecipe, bb.build.FuncFailed]:
-            raise
         try:
             _print_exception(t, value, tb, realfile, text, context)
         except Exception as e:



