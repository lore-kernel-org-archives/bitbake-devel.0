Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S0ckV-0001sM-CV
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 18:46:35 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 Feb 2012 09:38:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="114093554"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.61])
	by orsmga002.jf.intel.com with ESMTP; 23 Feb 2012 09:38:12 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2012 17:38:08 +0000
Message-Id: <31cd0a49d9e0acaf2a9eb9c903711a06b1d2914d.1330018579.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1330018579.git.paul.eggleton@linux.intel.com>
References: <cover.1330018579.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1330018579.git.paul.eggleton@linux.intel.com>
References: <cover.1330018579.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] bitbake: add file and line number to ParseError
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
X-List-Received-Date: Thu, 23 Feb 2012 17:46:36 -0000

Ensure that a file and line number are reported for ParseError where
possible. This helps particularly in the case of inherit and require
which previously did not report either of these upon failure.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py                     |    2 +-
 bitbake/lib/bb/parse/__init__.py             |   15 +++++++++++++--
 bitbake/lib/bb/parse/ast.py                  |    8 ++++----
 bitbake/lib/bb/parse/parse_py/BBHandler.py   |    6 ++----
 bitbake/lib/bb/parse/parse_py/ConfHandler.py |   11 ++++++-----
 5 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 308805a..bf25a83 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1398,7 +1398,7 @@ def _parse(fn, data, include=True):
 
 @catch_parse_error
 def _inherit(bbclass, data):
-    bb.parse.BBHandler.inherit([bbclass], data)
+    bb.parse.BBHandler.inherit([bbclass], "configuration INHERITs", 0, data)
     return data
 
 class ParsingFailure(Exception):
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index c5005ae..8b7ec73 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -37,6 +37,17 @@ logger = logging.getLogger("BitBake.Parsing")
 
 class ParseError(Exception):
     """Exception raised when parsing fails"""
+    def __init__(self, msg, filename, lineno=0):
+        self.msg = msg
+        self.filename = filename
+        self.lineno = lineno
+        Exception.__init__(self, msg, filename, lineno)
+
+    def __str__(self):
+        if self.lineno:
+            return "ParseError at %s:%d: %s" % (self.filename, self.lineno, self.msg)
+        else:
+            return "ParseError in %s: %s" % (self.filename, self.msg)
 
 class SkipPackage(Exception):
     """Exception raised to skip this package"""
@@ -78,7 +89,7 @@ def handle(fn, data, include = 0):
     for h in handlers:
         if h['supports'](fn, data):
             return h['handle'](fn, data, include)
-    raise ParseError("%s is not a BitBake file" % fn)
+    raise ParseError("not a BitBake file", fn)
 
 def init(fn, data):
     for h in handlers:
@@ -111,7 +122,7 @@ def vars_from_file(mypkg, d):
     parts = myfile[0].split('_')
     __pkgsplit_cache__[mypkg] = parts
     if len(parts) > 3:
-        raise ParseError("Unable to generate default variables from the filename: %s (too many underscores)" % mypkg)
+        raise ParseError("Unable to generate default variables from filename (too many underscores)", mypkg)
     exp = 3 - len(parts)
     tmplist = []
     while exp != 0:
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 31c930d..94fa175 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -59,9 +59,9 @@ class IncludeNode(AstNode):
 
         # TODO: Cache those includes... maybe not here though
         if self.force:
-            bb.parse.ConfHandler.include(self.filename, s, data, "include required")
+            bb.parse.ConfHandler.include(self.filename, s, self.lineno, data, "include required")
         else:
-            bb.parse.ConfHandler.include(self.filename, s, data, False)
+            bb.parse.ConfHandler.include(self.filename, s, self.lineno, data, False)
 
 class ExportNode(AstNode):
     def __init__(self, filename, lineno, var):
@@ -267,7 +267,7 @@ class InheritNode(AstNode):
         self.classes = classes
 
     def eval(self, data):
-        bb.parse.BBHandler.inherit(self.classes, data)
+        bb.parse.BBHandler.inherit(self.classes, self.filename, self.lineno, data)
 
 def handleInclude(statements, filename, lineno, m, force):
     statements.append(IncludeNode(filename, lineno, m.group(1), force))
@@ -450,7 +450,7 @@ def multi_finalize(fn, d):
                 d.setVar("BBEXTENDVARIANT", variantmap[name])
             else:
                 d.setVar("PN", "%s-%s" % (pn, name))
-            bb.parse.BBHandler.inherit([extendedmap[name]], d)
+            bb.parse.BBHandler.inherit([extendedmap[name]], fn, 0, d)
 
         safe_d.setVar("BBCLASSEXTEND", extended)
         _create_variants(datastores, extendedmap.keys(), extendfunc)
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 2d6e331..125f458 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -68,10 +68,8 @@ def supports(fn, d):
     """Return True if fn has a supported extension"""
     return os.path.splitext(fn)[-1] in [".bb", ".bbclass", ".inc"]
 
-def inherit(files, d):
+def inherit(files, fn, lineno, d):
     __inherit_cache = data.getVar('__inherit_cache', d) or []
-    fn = ""
-    lineno = 0
     for file in files:
         file = data.expand(file, d)
         if not os.path.isabs(file) and not file.endswith(".bbclass"):
@@ -81,7 +79,7 @@ def inherit(files, d):
             logger.log(logging.DEBUG -1, "BB %s:%d: inheriting %s", fn, lineno, file)
             __inherit_cache.append( file )
             data.setVar('__inherit_cache', __inherit_cache, d)
-            include(fn, file, d, "inherit")
+            include(fn, file, lineno, d, "inherit")
             __inherit_cache = data.getVar('__inherit_cache', d) or []
 
 def get_statements(filename, absolute_filename, base_name):
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 6ae9d97..9242632 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -44,10 +44,11 @@ def init(data):
 def supports(fn, d):
     return fn[-5:] == ".conf"
 
-def include(oldfn, fn, data, error_out):
+def include(oldfn, fn, lineno, data, error_out):
     """
-    error_out If True a ParseError will be raised if the to be included
-    config-files could not be included.
+    error_out: A string indicating the verb (e.g. "include", "inherit") to be
+    used in a ParseError that will be raised if the file to be included could
+    not be included. Specify False to avoid raising an error in this case.
     """
     if oldfn == fn: # prevent infinite recursion
         return None
@@ -68,7 +69,7 @@ def include(oldfn, fn, data, error_out):
         ret = handle(fn, data, True)
     except IOError:
         if error_out:
-            raise ParseError("Could not %(error_out)s file %(fn)s" % vars() )
+            raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
         logger.debug(2, "CONF file '%s' not found", fn)
 
 def handle(fn, data, include):
@@ -131,7 +132,7 @@ def feeder(lineno, s, fn, statements):
         ast.handleExport(statements, fn, lineno, m)
         return
 
-    raise ParseError("%s:%d: unparsed line: '%s'" % (fn, lineno, s));
+    raise ParseError("unparsed line: '%s'" % s, fn, lineno);
 
 # Add us to the handlers list
 from bb.parse import handlers
-- 
1.7.5.4



