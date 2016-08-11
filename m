Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id D8F26771C4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Aug 2016 03:37:39 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 10 Aug 2016 20:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,503,1464678000"; d="scan'208";a="863452271"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.171.53])
	by orsmga003.jf.intel.com with ESMTP; 10 Aug 2016 20:37:38 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Aug 2016 15:37:00 +1200
Message-Id: <3c460ccdf61654f7d74713e10c305476c5db1aee.1470886482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1470886482.git.paul.eggleton@linux.intel.com>
References: <cover.1470886482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1470886482.git.paul.eggleton@linux.intel.com>
References: <cover.1470886482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/4] siggen: properly close files rather than opening them inline
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
X-List-Received-Date: Thu, 11 Aug 2016 03:37:40 -0000

If you don't do this, with Python 3 you get a warning on exit under some
circumstances.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/siggen.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 5d8a253..9b2f658 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -363,10 +363,12 @@ def clean_basepaths_list(a):
 def compare_sigfiles(a, b, recursecb = None):
     output = []
 
-    p1 = pickle.Unpickler(open(a, "rb"))
-    a_data = p1.load()
-    p2 = pickle.Unpickler(open(b, "rb"))
-    b_data = p2.load()
+    with open(a, 'rb') as f:
+        p1 = pickle.Unpickler(ff)
+        a_data = p1.load()
+    with open(b, 'rb') as f:
+        p2 = pickle.Unpickler(f)
+        b_data = p2.load()
 
     def dict_diff(a, b, whitelist=set()):
         sa = set(a.keys())
@@ -563,8 +565,9 @@ def calc_taskhash(sigdata):
 def dump_sigfile(a):
     output = []
 
-    p1 = pickle.Unpickler(open(a, "rb"))
-    a_data = p1.load()
+    with open(a, 'rb') as f:
+        p1 = pickle.Unpickler(f)
+        a_data = p1.load()
 
     output.append("basewhitelist: %s" % (a_data['basewhitelist']))
 
-- 
2.5.5


