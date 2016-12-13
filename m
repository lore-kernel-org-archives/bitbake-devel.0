Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id C5F8371C0C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:08:56 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:08:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961507"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:56 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:11 +1300
Message-Id: <6807f090d600a410cb46df405b85aa94c6f98c85.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 12/15] data_smart: support serialisation
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
X-List-Received-Date: Tue, 13 Dec 2016 07:08:57 -0000

The COW object used within VariableHistory can't be serialised itself,
but we can convert it to a dict when serializing and then back when
deserialising. This finally allows DataSmart objects to be serialized.
NOTE: "serialisation" here means pickling, not over XMLRPC or any other
transport.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/data_smart.py | 13 +++++++++++++
 lib/bb/tests/data.py | 23 +++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 4d0a771..79d591a 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -230,6 +230,19 @@ class VariableHistory(object):
         new.variables = self.variables.copy()
         return new
 
+    def __getstate__(self):
+        vardict = {}
+        for k, v in self.variables.iteritems():
+            vardict[k] = v
+        return {'dataroot': self.dataroot,
+                'variables': vardict}
+
+    def __setstate__(self, state):
+        self.dataroot = state['dataroot']
+        self.variables = COWDictBase.copy()
+        for k, v in state['variables'].items():
+            self.variables[k] = v
+
     def record(self, *kwonly, **loginfo):
         if not self.dataroot._tracking:
             return
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index a17245f..ba30d12 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -446,6 +446,29 @@ class Contains(unittest.TestCase):
         self.assertFalse(bb.utils.contains_any("SOMEFLAG", "x y z", True, False, self.d))
 
 
+class Serialize(unittest.TestCase):
+
+    def test_serialize(self):
+        import tempfile
+        import pickle
+        d = bb.data.init()
+        d.enableTracking()
+        d.setVar('HELLO', 'world')
+        d.setVarFlag('HELLO', 'other', 'planet')
+        with tempfile.NamedTemporaryFile(delete=False) as tmpfile:
+            tmpfilename = tmpfile.name
+            pickle.dump(d, tmpfile)
+
+        with open(tmpfilename, 'rb') as f:
+            newd = pickle.load(f)
+
+        os.remove(tmpfilename)
+
+        self.assertEqual(d, newd)
+        self.assertEqual(newd.getVar('HELLO', True), 'world')
+        self.assertEqual(newd.getVarFlag('HELLO', 'other'), 'planet')
+
+
 class Remote(unittest.TestCase):
     def test_remote(self):
         class TestConnector:
-- 
2.5.5


