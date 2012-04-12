Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1SIGZN-0001zQ-Km
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Apr 2012 11:44:01 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 12 Apr 2012 02:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="140804403"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.110])
	by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2012 02:34:14 -0700
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 17:28:01 +0800
Message-Id: <00fda8f184223f4e189786da33d2c7d6b9c617fe.1334222502.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1334222502.git.lianhao.lu@intel.com>
References: <cover.1334222502.git.lianhao.lu@intel.com>
Subject: [PATCH 1/1] bb.utils: Modifed vercmp() to meet Debian rules.
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
X-List-Received-Date: Thu, 12 Apr 2012 09:44:01 -0000

The version compare function vercmp() was not exatcly conforming to
Debian rules, e.g. it reported 'r1' > 'r1.1' but the Debian rules says
'r1' < 'r1.1'; it didn't support the "~" either.

Modified the vercmp() to meet Debian rules, so that it's compatible to
the rules used in opkg.

This part of the buf fixing of [YOCTO #2233].

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
---
 lib/bb/utils.py |   40 ++++++++++++++++------------------------
 1 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 21d3a81..1d98bca 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -31,9 +31,6 @@ from contextlib import contextmanager
 
 logger = logging.getLogger("BitBake.Util")
 
-# Version comparison
-separators = ".-"
-
 # Context used in better_exec, eval
 _context = {
     "os": os,
@@ -48,15 +45,18 @@ def explode_version(s):
     while (s != ''):
         if s[0] in string.digits:
             m = numeric_regexp.match(s)
-            r.append(int(m.group(1)))
+            r.append((0, int(m.group(1))))
             s = m.group(2)
             continue
         if s[0] in string.letters:
             m = alpha_regexp.match(s)
-            r.append(m.group(1))
+            r.append((1, m.group(1)))
             s = m.group(2)
             continue
-        r.append(s[0])
+        if s[0] == '~':
+            r.append((-1, s[0]))
+        else:
+            r.append((2, s[0]))
         s = s[1:]
     return r
 
@@ -77,33 +77,25 @@ def split_version(s):
 def vercmp_part(a, b):
     va = explode_version(a)
     vb = explode_version(b)
-    sa = False
-    sb = False
     while True:
         if va == []:
-            ca = None
+            (oa, ca) = (0, None)
         else:
-            ca = va.pop(0)
+            (oa, ca) = va.pop(0)
         if vb == []:
-            cb = None
+            (ob, cb) = (0, None)
         else:
-            cb = vb.pop(0)
-        if ca == None and cb == None:
+            (ob, cb) = vb.pop(0)
+        if (oa, ca) == (0, None) and (ob, cb) == (0, None):
             return 0
-
-        if isinstance(ca, basestring):
-            sa = ca in separators
-        if isinstance(cb, basestring):
-            sb = cb in separators
-        if sa and not sb:
+        if oa < ob:
             return -1
-        if not sa and sb:
+        elif oa > ob:
             return 1
-
-        if ca > cb:
-            return 1
-        if ca < cb:
+        elif ca < cb:
             return -1
+        elif ca > cb:
+            return 1
 
 def vercmp(ta, tb):
     (ea, va, ra) = ta
-- 
1.7.0.4



