Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1T1oqs-0005sm-Fb
	for bitbake-devel@lists.openembedded.org;
	Thu, 16 Aug 2012 03:26:22 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7G1EORK022936
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 18:14:24 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 15 Aug 2012 18:14:25 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 Aug 2012 20:14:22 -0500
Message-ID: <2e26350de4ff2c38348031f65acac2f29d8656b9.1345079338.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1345079338.git.peter.seebach@windriver.com>
References: <cover.1345079338.git.peter.seebach@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] data_smart.py: implement _remove as a keyword like _append.
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
X-List-Received-Date: Thu, 16 Aug 2012 01:26:23 -0000
Content-Type: text/plain

There has historically been no way to remove a single word
from a list, but many lists (such as DISTRO_FEATURES) are
assembled from many sources all over the place. The _remove
keyword offers a clean(er) way to do this.

Implementation: _remove is added to the keyword list next
to _append and _prepend. During finalize(), the list of
removes for a given variable is subjected to the usual
filtering for overrides. However, the winning entries are
not removed; they are added to a list stored in the new
variable flag _remove_later.

At expansion time, after a variable has been expanded,
removes for it (if any) are processed. We use the same
_special_values magic here that we use elsewhere. Currently
there's no caching; perhaps there should be.

Additionally, "-=" and "=-" are accepted as synonyms for
_remove.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
---
 lib/bb/data_smart.py                 |   45 +++++++++++++++++++++++++++++----
 lib/bb/parse/ast.py                  |    6 ++++
 lib/bb/parse/parse_py/ConfHandler.py |    2 +-
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index a128914..d59f8ab 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -40,8 +40,8 @@ from bb.COW  import COWDictBase
 
 logger = logging.getLogger("BitBake.Data")
 
-__setvar_keyword__ = ["_append", "_prepend"]
-__setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend)(_(?P<add>.*))?$')
+__setvar_keyword__ = ["_append", "_prepend", "_remove"]
+__setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>.*))?$')
 __expand_var_regexp__ = re.compile(r"\${[^{}]+}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
 
@@ -219,7 +219,10 @@ class DataSmart(MutableMapping):
 
         #
         # First we apply all overrides
-        # Then  we will handle _append and _prepend
+        # Then we will handle _append and _prepend and store the _remove
+        # information for later. (_remove has to be processed during
+        # expansion, but there's no reason to duplicate the override-checking
+        # logic.)
         #
 
         for o in overrides:
@@ -243,12 +246,16 @@ class DataSmart(MutableMapping):
                 except Exception, e:
                     logger.info("Untracked delVar %s: %s" % (var, e))
 
-        # now on to the appends and prepends
+        # now on to the appends and prepends, and stashing the removes
+        # for processing during expansion
         for op in __setvar_keyword__:
             if op in self._special_values:
                 appends = self._special_values[op] or []
                 for append in appends:
                     keep = []
+                    # Anything we already have tagged for removal should be
+                    # added to.
+                    remove_later = self.getVarFlag(append, '_remove_later') or []
                     for (a, o) in self.getVarFlag(append, op) or []:
                         match = True
                         if o:
@@ -266,6 +273,19 @@ class DataSmart(MutableMapping):
                         elif op == "_prepend":
                             sval = a + (self.getVar(append, False) or "")
                             self.setVar(append, sval, 'Ignore')
+                        elif op == "_remove":
+                            # stash for later processing
+                            remove_later.append(a)
+
+                    if remove_later:
+                        # We build a list of applicable _remove values,
+                        # which can then be used after expansion.
+                        self.setVarFlag(append, '_remove_later', remove_later, 'Ignore')
+                        try:
+                            self._special_values['_remove_later'].add(append)
+                        except KeyError:
+                            self._special_values['_remove_later'] = set()
+                            self._special_values['_remove_later'].add(append)
 
                     # We save overrides that may be applied at some later stage
                     # ... but we don't need to report on this.
@@ -356,10 +376,23 @@ class DataSmart(MutableMapping):
 
     def getVar(self, var, expand=False, noweakdefault=False):
         value = self.getVarFlag(var, "content", False, noweakdefault)
+        removes = None
+        try:
+            # See whether any _remove values made it through overrides
+            if var in self._special_values['_remove_later']:
+                removes = self.getVarFlag(var, '_remove_later', True)
+        except KeyError:
+            pass
 
         # Call expand() separately to make use of the expand cache
         if expand and value:
-            return self.expand(value, var)
+            value = self.expand(value, var)
+        if removes:
+            list = value.split(' ')
+            for r in removes:
+                if r in list:
+                    list.remove(r)
+            value = " ".join(list)
         return value
 
     def renameVar(self, key, newkey, filename = None, lineno = None):
@@ -371,7 +404,7 @@ class DataSmart(MutableMapping):
         if val is not None:
             self.setVar(newkey, val, filename, lineno, 'rename-create')
 
-        for i in ('_append', '_prepend'):
+        for i in (__setvar_keyword__):
             src = self.getVarFlag(key, i)
             if src is None:
                 continue
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index dbc2237..b2e038b 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -113,6 +113,12 @@ class DataNode(AstNode):
             val = "%s %s" % (groupd["value"], (self.getFunc(key, data) or ""))
             op = 'prepend'
             details = groupd["value"]
+        elif (("preminus" in groupd and groupd["preminus"] != None) or
+              ("postminus" in groupd and groupd["postminus"] != None)):
+            # There's no correct value to set in this case; it has to
+            # convert into a flag.
+            key = key + "_remove"
+            val = "%s" % groupd["value"]
         elif "postdot" in groupd and groupd["postdot"] != None:
             val = "%s%s" % ((self.getFunc(key, data) or ""), groupd["value"])
             op = 'postdot'
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 4a1012e..a5a25fc 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -29,7 +29,7 @@ import logging
 import bb.utils
 from bb.parse import ParseError, resolve_file, ast, logger
 
-__config_regexp__  = re.compile( r"(?P<exp>export\s*)?(?P<var>[a-zA-Z0-9\-_+.${}/]+)(\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?\s*((?P<colon>:=)|(?P<lazyques>\?\?=)|(?P<ques>\?=)|(?P<append>\+=)|(?P<prepend>=\+)|(?P<predot>=\.)|(?P<postdot>\.=)|=)\s*(?P<apo>['\"])(?P<value>.*)(?P=apo)$")
+__config_regexp__  = re.compile( r"(?P<exp>export\s*)?(?P<var>[a-zA-Z0-9\-_+.${}/]+)(\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?\s*((?P<colon>:=)|(?P<lazyques>\?\?=)|(?P<ques>\?=)|(?P<append>\+=)|(?P<prepend>=\+)|(?P<preminus>=-)|(?P<postminus>-=)|(?P<predot>=\.)|(?P<postdot>\.=)|=)\s*(?P<apo>['\"])(?P<value>.*)(?P=apo)$")
 __include_regexp__ = re.compile( r"include\s+(.+)" )
 __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/]+)$" )
-- 
1.7.0.4



