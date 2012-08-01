Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SwTHw-0002fB-8R
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Aug 2012 09:24:17 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q717CUxv001079
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 1 Aug 2012 00:12:30 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.124) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.309.2; Wed, 1 Aug 2012 00:12:31 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 1 Aug 2012 15:18:18 +0800
Message-ID: <7b73c5634e48091d4e76acc9c94005d0243d5abd.1343804786.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <cover.1343804786.git.liezhi.yang@windriver.com>
References: <cover.1343804786.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] contrib/dump_cache.py: dump recipe -> packages mapping from bb_cache.dat
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
X-List-Received-Date: Wed, 01 Aug 2012 07:24:17 -0000
Content-Type: text/plain

Add the dump_cache.py to dump the "recipe -> packages" mapping for
target recipes form bb_cache.dat:

* Usage:
  dump_cache.py bb_cache.dat

* The format is:
    recipe_path pn pv packages
  For example:
    /path/to/gzip_1.5.bb gzip 1.5 gzip-dbg gzip-staticdev gzip-dev gzip-doc gzip-locale gzip

* Only save the mapping for the target recipe

* We can extend this to dump other informations when needed.

* Put this script to bitbake/contrib/ (not to oe-core) is because it
  needs the bb.cache.

[YOCTO #2741]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/contrib/dump_cache.py |   68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100755 bitbake/contrib/dump_cache.py

diff --git a/bitbake/contrib/dump_cache.py b/bitbake/contrib/dump_cache.py
new file mode 100755
index 0000000..e1f2309
--- /dev/null
+++ b/bitbake/contrib/dump_cache.py
@@ -0,0 +1,68 @@
+#!/usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# Copyright (C) 2012 Wind River Systems, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+#
+# This is used for dumping the bb_cache.dat, the output format is:
+# recipe_path PN PV PACKAGES
+#
+import os
+import sys
+import warnings
+
+# For importing bb.cache
+sys.path.insert(0, os.path.join(os.path.abspath(os.path.dirname(sys.argv[0])), '../lib'))
+from bb.cache import CoreRecipeInfo
+
+import cPickle as pickle
+
+def main(argv=None):
+    """
+    Get the mapping for the target recipe.
+    """
+    if len(argv) != 1:
+        print >>sys.stderr, "Error, need one argument!"
+        return 2
+
+    cachefile = argv[0]
+
+    with open(cachefile, "rb") as cachefile:
+        pickled = pickle.Unpickler(cachefile)
+        while cachefile:
+            try:
+                key = pickled.load()
+                val = pickled.load()
+            except Exception:
+                break
+            if isinstance(val, CoreRecipeInfo) and (not val.skipped):
+                pn = val.pn
+                # Filter out the native recipes.
+                if key.startswith('virtual:native:') or pn.endswith("-native"):
+                    continue
+
+                # 1.0 is the default version for a no PV recipe.
+                if val.__dict__.has_key("pv"):
+                    pv = val.pv
+                else:
+                    pv = "1.0"
+
+                print("%s %s %s %s" % (key, pn, pv, ' '.join(val.packages)))
+
+if __name__ == "__main__":
+    sys.exit(main(sys.argv[1:]))
+
-- 
1.7.10.4



