Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TGW9U-0004Rk-MW
	for bitbake-devel@lists.openembedded.org;
	Tue, 25 Sep 2012 16:30:20 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 25 Sep 2012 07:17:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,483,1344236400"; d="scan'208";a="148844603"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.7])
	by AZSMGA002.ch.intel.com with ESMTP; 25 Sep 2012 07:17:29 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Sep 2012 15:17:17 +0100
Message-Id: <1348582637-31533-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] lib/bb/data.py: improve output for expansion errors
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
X-List-Received-Date: Tue, 25 Sep 2012 14:30:20 -0000

Instead of logging the function/variable separately as a NOTE when
failing to expand, re-raise ExpansionError with more contextual
information. This means that the full details are reported in Hob as
well as actually reporting the original error message in any UI where
we previously did not. For example, we used to get this with tab/space
indentation issues in a python function:

NOTE: Error expanding variable populate_packages
ERROR: Unable to parse /path/to/recipename.bb

Now, we will get this:

ERROR: ExpansionError during parsing /path/to/recipename.bb: Failure
 expanding variable populate_packages: IndentationError: unindent does
 not match any outer indentation level (<string>, line 4)

Fixes [YOCTO #3162].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/data.py       |    5 ++---
 bitbake/lib/bb/data_smart.py |    5 ++++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 5b7a092..9a32353 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -323,9 +323,8 @@ def build_dependencies(key, keys, shelldeps, vardepvals, d):
 
         deps |= set((vardeps or "").split())
         deps -= set((d.getVarFlag(key, "vardepsexclude", True) or "").split())
-    except:
-        bb.note("Error expanding variable %s" % key)
-        raise
+    except Exception as e:
+        raise bb.data_smart.ExpansionError(key, None, e)
     return deps, value
     #bb.note("Variable %s references %s and calls %s" % (key, str(deps), str(execs)))
     #d.setVarFlag(key, "vardeps", deps)
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index f5f3b13..ec3c04e 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -103,7 +103,10 @@ class ExpansionError(Exception):
         self.variablename = varname
         self.exception = exception
         if varname:
-            self.msg = "Failure expanding variable %s, expression was %s which triggered exception %s: %s" % (varname, expression, type(exception).__name__, exception)
+            if expression:
+                self.msg = "Failure expanding variable %s, expression was %s which triggered exception %s: %s" % (varname, expression, type(exception).__name__, exception)
+            else:
+                self.msg = "Failure expanding variable %s: %s: %s" % (varname, type(exception).__name__, exception)
         else:
             self.msg = "Failure expanding expression %s which triggered exception %s: %s" % (expression, type(exception).__name__, exception)
         Exception.__init__(self, self.msg)
-- 
1.7.9.5



