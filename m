Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id B851873216
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Dec 2016 21:05:13 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 14 Dec 2016 13:05:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,348,1477983600"; d="scan'208";a="1072120313"
Received: from jlock-mobl1.ger.corp.intel.com ([10.252.22.2])
	by orsmga001.jf.intel.com with ESMTP; 14 Dec 2016 13:05:11 -0800
From: Joshua Lock <joshua.g.lock@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Dec 2016 21:05:01 +0000
Message-Id: <20161214210501.13650-1-joshua.g.lock@intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH] bitbake: remove True option to getVar calls (take 2)
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
X-List-Received-Date: Wed, 14 Dec 2016 21:05:13 -0000

getVar() now defaults to expanding by default, thus remove the True
option from getVar() calls with a regex search and replace.

Search made with the following regex: getVar ?\(( ?[^,()]*), True\)

(a follow on patch to fix up a few recent introductions)

Signed-off-by: Joshua Lock <joshua.g.lock@intel.com>
---
 lib/bb/server/process.py | 2 +-
 lib/bb/siggen.py         | 2 +-
 lib/bb/tests/data.py     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 1036366..c9dfb4f 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -103,7 +103,7 @@ class ProcessServer(Process, BaseImplServer):
             self.event_queue.put(event)
         self.event_handle.value = bb.event.register_UIHhandler(self, True)
 
-        heartbeat_event = self.cooker.data.getVar('BB_HEARTBEAT_EVENT', True)
+        heartbeat_event = self.cooker.data.getVar('BB_HEARTBEAT_EVENT')
         if heartbeat_event:
             try:
                 self.heartbeat_seconds = float(heartbeat_event)
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index b20b9cf..659d27d 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -101,7 +101,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
     def _build_data(self, fn, d):
 
-        ignore_mismatch = ((d.getVar("BB_HASH_IGNORE_MISMATCH", True) or '') == '1')
+        ignore_mismatch = ((d.getVar("BB_HASH_IGNORE_MISMATCH") or '') == '1')
         tasklist, gendeps, lookupcache = bb.data.generate_dependencies(d)
 
         taskdeps = {}
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index ba30d12..0903ba7 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -465,7 +465,7 @@ class Serialize(unittest.TestCase):
         os.remove(tmpfilename)
 
         self.assertEqual(d, newd)
-        self.assertEqual(newd.getVar('HELLO', True), 'world')
+        self.assertEqual(newd.getVar('HELLO'), 'world')
         self.assertEqual(newd.getVarFlag('HELLO', 'other'), 'planet')
 
 
-- 
2.9.3


