Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 3BB7673FC8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 15:08:46 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 18 May 2015 08:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,453,1427785200"; d="scan'208";a="696616665"
Received: from jmcmill1-mobl3.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.0.158])
	by orsmga001.jf.intel.com with ESMTP; 18 May 2015 08:08:45 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 May 2015 16:08:35 +0100
Message-Id: <5ba472960693ef4fb7f26c938d636bc9a426c07f.1431961693.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1431961693.git.paul.eggleton@linux.intel.com>
References: <cover.1431961693.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1431961693.git.paul.eggleton@linux.intel.com>
References: <cover.1431961693.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] lib/bb/utils: fix several bugs in edit_metadata_file()
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
X-List-Received-Date: Mon, 18 May 2015 15:08:49 -0000

* Fix unchanged assignments being dropped if other lines changed
* Fix not passing variable name from single-line assignments to the
  function
* Fix not trimming the trailing quote from values

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/utils.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 1681efd..0db7e56 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -974,6 +974,7 @@ def edit_metadata_file(meta_file, variables, func):
 
     updated = False
     varset_start = ''
+    varlines = []
     newlines = []
     in_var = None
     full_value = ''
@@ -1001,14 +1002,19 @@ def edit_metadata_file(meta_file, variables, func):
             else:
                 newlines.append('%s "%s"\n' % (varset_start, newvalue))
             return True
-        return False
+        else:
+            # Put the old lines back where they were
+            newlines.extend(varlines)
+            return False
 
     with open(meta_file, 'r') as f:
         for line in f:
             if in_var:
                 value = line.rstrip()
+                varlines.append(line)
                 full_value += value[:-1]
                 if value.endswith('"') or value.endswith("'"):
+                    full_value = full_value[:-1]
                     if handle_var_end():
                         updated = True
                     in_var = None
@@ -1022,11 +1028,13 @@ def edit_metadata_file(meta_file, variables, func):
                         if value.endswith('\\'):
                             value = value[:-1]
                         full_value = value
+                        varlines = [line]
+                        in_var = varname
                         if value.endswith('"') or value.endswith("'"):
+                            full_value = full_value[:-1]
                             if handle_var_end():
                                 updated = True
-                        else:
-                            in_var = varname
+                            in_var = None
                         matched = True
                         break
                 if not matched:
-- 
2.1.0


