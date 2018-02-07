Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0D0D260017
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Feb 2018 08:01:16 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w1781HgW015990
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 7 Feb 2018 00:01:17 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Wed, 7 Feb 2018 00:01:11 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 7 Feb 2018 16:01:59 +0800
Message-ID: <74b27cc930eecdc050e2da35135ba788e7f1f9b0.1517990305.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517990305.git.liezhi.yang@windriver.com>
References: <cover.1517990305.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] contrib/dump_cache.py: make it can dump everything
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
X-List-Received-Date: Wed, 07 Feb 2018 08:01:17 -0000
Content-Type: text/plain

Have a simple tool to dump bb_cache.dat is useful for investigating and
studying bitbake cache. The old contrib/dump_cache.py can dump pn, pv and
packages for it, now enhance it dump everything.

Here is the usage:
$ /path/to/dump_cache.py --help
usage: dump_cache.py [-h] [-r RECIPE] [-m MEMBERS] [-s] cachefile

bb_cache.dat's dumper

positional arguments:
  cachefile             specify bb_cache.dat

optional arguments:
  -h, --help            show this help message and exit
  -r RECIPE, --recipe RECIPE
                        specify the recipe, default: all recipes
  -m MEMBERS, --members MEMBERS
                        specify the member, use comma as separator for
                        multiple ones, default: all members
  -s, --skip            skip skipped recipes

Use dump_cache.py --help to get help

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/contrib/dump_cache.py | 85 ++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/bitbake/contrib/dump_cache.py b/bitbake/contrib/dump_cache.py
index f4d4c1b..8963ca4 100755
--- a/bitbake/contrib/dump_cache.py
+++ b/bitbake/contrib/dump_cache.py
@@ -2,7 +2,7 @@
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
-# Copyright (C) 2012 Wind River Systems, Inc.
+# Copyright (C) 2012, 2018 Wind River Systems, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -18,51 +18,68 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 #
-# This is used for dumping the bb_cache.dat, the output format is:
-# recipe_path PN PV PACKAGES
+# Used for dumping the bb_cache.dat
 #
 import os
 import sys
-import warnings
+import argparse
 
 # For importing bb.cache
 sys.path.insert(0, os.path.join(os.path.abspath(os.path.dirname(sys.argv[0])), '../lib'))
 from bb.cache import CoreRecipeInfo
 
-import pickle as pickle
+import pickle
 
-def main(argv=None):
-    """
-    Get the mapping for the target recipe.
-    """
-    if len(argv) != 1:
-        print("Error, need one argument!", file=sys.stderr)
-        return 2
+class DumpCache(object):
+    def __init__(self):
+        parser = argparse.ArgumentParser(
+            description="bb_cache.dat's dumper",
+            epilog="Use %(prog)s --help to get help")
+        parser.add_argument("-r", "--recipe",
+            help="specify the recipe, default: all recipes", action="store")
+        parser.add_argument("-m", "--members",
+            help = "specify the member, use comma as separator for multiple ones, default: all members", action="store", default="")
+        parser.add_argument("-s", "--skip",
+            help = "skip skipped recipes", action="store_true")
+        parser.add_argument("cachefile",
+            help = "specify bb_cache.dat", nargs = 1, action="store", default="")
 
-    cachefile = argv[0]
+        self.args = parser.parse_args()
 
-    with open(cachefile, "rb") as cachefile:
-        pickled = pickle.Unpickler(cachefile)
-        while cachefile:
-            try:
-                key = pickled.load()
-                val = pickled.load()
-            except Exception:
-                break
-            if isinstance(val, CoreRecipeInfo) and (not val.skipped):
-                pn = val.pn
-                # Filter out the native recipes.
-                if key.startswith('virtual:native:') or pn.endswith("-native"):
-                    continue
+    def main(self):
+        with open(self.args.cachefile[0], "rb") as cachefile:
+            pickled = pickle.Unpickler(cachefile)
+            while True:
+                try:
+                    key = pickled.load()
+                    val = pickled.load()
+                except Exception:
+                    break
+                if isinstance(val, CoreRecipeInfo):
+                    pn = val.pn
 
-                # 1.0 is the default version for a no PV recipe.
-                if "pv" in val.__dict__:
-                    pv = val.pv
-                else:
-                    pv = "1.0"
+                    if self.args.recipe and self.args.recipe != pn:
+                        continue
 
-                print("%s %s %s %s" % (key, pn, pv, ' '.join(val.packages)))
+                    if self.args.skip and val.skipped:
+                        continue
 
-if __name__ == "__main__":
-    sys.exit(main(sys.argv[1:]))
+                    if self.args.members:
+                        out = key
+                        for member in self.args.members.split(','):
+                            out += ": %s" % val.__dict__.get(member)
+                        print("%s" % out)
+                    else:
+                        print("%s: %s" % (key, val.__dict__))
+                elif not self.args.recipe:
+                    print("%s %s" % (key, val))
 
+if __name__ == "__main__":
+    try:
+        dump = DumpCache()
+        ret = dump.main()
+    except Exception as esc:
+        ret = 1
+        import traceback
+        traceback.print_exc()
+    sys.exit(ret)
-- 
2.7.4


