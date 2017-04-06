Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id B71B177CFA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:52:57 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565864"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:52:57 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:05 +1200
Message-Id: <0f3380b6b9f4736b748fb4a39460c29e3f9e6cf0.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 05/11] lib/bb/siggen: show a diff when dumping changes to multi-line values
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
X-List-Received-Date: Thu, 06 Apr 2017 21:52:57 -0000

When dumping changes to signatures e.g. output of bitbake -s printdiff,
if for example a function has changed, it's much more readable to see a
unified diff of the changes rather than just printing the old function
followed by the new function, so use difflib to do that.

Note: I elected to keep to one item in the returned list per change,
rather than one line per line of output, so that the caller can still
look at changes individually if needed. Thus I've added some handling to
bitbake-diffsigs to split the change into lines so that each line is
displayed indented.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-diffsigs |  4 +++-
 lib/bb/siggen.py     | 12 +++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 5400e5b..4ca085f 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -67,7 +67,9 @@ def find_compare_task(bbhandler, pn, taskname):
                 recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash2))
             else:
                 out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb)
-                recout.extend(list('  ' + l for l in out2))
+                for change in out2:
+                    for line in change.splitlines():
+                        recout.append('  ' + line)
 
             return recout
 
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index f47af6d..f497fb9 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -5,6 +5,7 @@ import re
 import tempfile
 import pickle
 import bb.data
+import difflib
 from bb.checksum import FileChecksumCache
 
 logger = logging.getLogger('BitBake.SigGen')
@@ -462,7 +463,16 @@ def compare_sigfiles(a, b, recursecb = None):
     changed, added, removed = dict_diff(a_data['varvals'], b_data['varvals'])
     if changed:
         for dep in changed:
-            output.append("Variable %s value changed from '%s' to '%s'" % (dep, a_data['varvals'][dep], b_data['varvals'][dep]))
+            oldval = a_data['varvals'][dep]
+            newval = b_data['varvals'][dep]
+            if newval and oldval and ('\n' in oldval or '\n' in newval):
+                diff = difflib.unified_diff(oldval.splitlines(), newval.splitlines(), lineterm='')
+                # Cut off the first two lines, since we aren't interested in
+                # the old/new filename (they are blank anyway in this case)
+                difflines = list(diff)[2:]
+                output.append("Variable %s value changed:\n%s" % (dep, '\n'.join(difflines)))
+            else:
+                output.append("Variable %s value changed from '%s' to '%s'" % (dep, oldval, newval))
 
     if not 'file_checksum_values' in a_data:
          a_data['file_checksum_values'] = {}
-- 
2.9.3


