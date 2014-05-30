Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E93AC6FA94
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 14:55:56 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4UEtqGU012288 for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:55:52 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OM52JqWnxvbO for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:55:52 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4UEtjM4012275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:55:47 +0100
Message-ID: <1401461737.31309.52.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 30 May 2014 15:55:37 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] event: Add SkipRecipe event to replace SkipPackage
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
X-List-Received-Date: Fri, 30 May 2014 14:55:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

In the depths of time we were rather confused about naming. bb files
are recipes, the event to skip parsing them should be SkipRecipe,
not SkipPackage. This changes bitbake to use the better name but
leaves the other around for now. We can therefore start removing
references to it from the metadata.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index d1ed30a..1a17547 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -243,7 +243,7 @@ def exec_func_python(func, d, runfile, cwd=None):
         comp = utils.better_compile(code, func, bbfile)
         utils.better_exec(comp, {"d": d}, code, bbfile)
     except:
-        if sys.exc_info()[0] in (bb.parse.SkipPackage, bb.build.FuncFailed):
+        if sys.exc_info()[0] in (bb.parse.SkipRecipe, bb.build.FuncFailed):
             raise
 
         raise FuncFailed(func, None)
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 431fc07..38e9148 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -692,7 +692,7 @@ def init(cooker):
 
     * Its mtime
     * The mtimes of all its dependencies
-    * Whether it caused a parse.SkipPackage exception
+    * Whether it caused a parse.SkipRecipe exception
 
     Files causing parsing errors are evicted from the cache.
 
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index db0f8e6..7b2032a 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -340,7 +340,7 @@ class DataSmart(MutableMapping):
                     break
             except ExpansionError:
                 raise
-            except bb.parse.SkipPackage:
+            except bb.parse.SkipRecipe:
                 raise
             except Exception as exc:
                 raise ExpansionError(varname, s, exc)
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 05ff543..8b47ae5 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -72,7 +72,7 @@ def execute_handler(name, handler, event, d):
     event.data = d
     try:
         ret = handler(event)
-    except (bb.parse.SkipPackage, bb.BBHandledException):
+    except (bb.parse.SkipRecipe, bb.BBHandledException):
         raise
     except Exception:
         etype, value, tb = sys.exc_info()
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index bf5ed05..2303f15 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -49,8 +49,11 @@ class ParseError(Exception):
         else:
             return "ParseError in %s: %s" % (self.filename, self.msg)
 
-class SkipPackage(Exception):
-    """Exception raised to skip this package"""
+class SkipRecipe(Exception):
+    """Exception raised to skip this recipe"""
+
+class SkipPackage(SkipRecipe):
+    """Exception raised to skip this recipe (use SkipRecipe in new code)"""
 
 __mtime_cache = {}
 def cached_mtime(f):
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 30380a4..4e5a06e 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -386,7 +386,7 @@ def multi_finalize(fn, d):
     d = bb.data.createCopy(safe_d)
     try:
         finalize(fn, d)
-    except bb.parse.SkipPackage as e:
+    except bb.parse.SkipRecipe as e:
         d.setVar("__SKIPPED", e.args[0])
     datastores = {"": safe_d}
 
@@ -429,7 +429,7 @@ def multi_finalize(fn, d):
             verfunc(pv, d, safe_d)
             try:
                 finalize(fn, d)
-            except bb.parse.SkipPackage as e:
+            except bb.parse.SkipRecipe as e:
                 d.setVar("__SKIPPED", e.args[0])
 
         _create_variants(datastores, versions, verfunc, onlyfinalise)
@@ -469,7 +469,7 @@ def multi_finalize(fn, d):
             try:
                 if not onlyfinalise or variant in onlyfinalise:
                     finalize(fn, variant_d, variant)
-            except bb.parse.SkipPackage as e:
+            except bb.parse.SkipRecipe as e:
                 variant_d.setVar("__SKIPPED", e.args[0])
 
     if len(datastores) > 1:
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index a8627e9..9633340 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -154,7 +154,7 @@ def handle(fn, d, include):
 
     try:
         statements.eval(d)
-    except bb.parse.SkipPackage:
+    except bb.parse.SkipRecipe:
         bb.data.setVar("__SKIPPED", True, d)
         if include == 0:
             return { "" : d }
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index ead5f36..c179394 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -362,7 +362,7 @@ def better_exec(code, context, text = None, realfile = "<code>"):
     except Exception as e:
         (t, value, tb) = sys.exc_info()
 
-        if t in [bb.parse.SkipPackage, bb.build.FuncFailed]:
+        if t in [bb.parse.SkipRecipe, bb.build.FuncFailed]:
             raise
         try:
             _print_exception(t, value, tb, realfile, text, context)



