Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 166A779652
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Sep 2018 08:27:49 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8C8RUor020627
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Sep 2018 01:27:41 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Wed, 12 Sep 2018 01:27:19 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 12 Sep 2018 16:38:16 +0800
Message-ID: <7bb7a9d6566a2849e67073843a650800935f09db.1536741423.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1536741423.git.liezhi.yang@windriver.com>
References: <cover.1536741423.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] dump_cache.py: move it to oe-core/scripts
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
X-List-Received-Date: Wed, 12 Sep 2018 08:27:50 -0000
Content-Type: text/plain

Move it to oe-core can make it's easier to use, e.g., we don't need use
/path/to/bitbake/contrib/dump_cache.py to run it, just use dump_cache.py after
the build is initialized.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/contrib/dump_cache.py | 85 -------------------------------------------
 1 file changed, 85 deletions(-)
 delete mode 100755 bitbake/contrib/dump_cache.py

diff --git a/bitbake/contrib/dump_cache.py b/bitbake/contrib/dump_cache.py
deleted file mode 100755
index 8963ca4..0000000
--- a/bitbake/contrib/dump_cache.py
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/usr/bin/env python3
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
-# Copyright (C) 2012, 2018 Wind River Systems, Inc.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-#
-# Used for dumping the bb_cache.dat
-#
-import os
-import sys
-import argparse
-
-# For importing bb.cache
-sys.path.insert(0, os.path.join(os.path.abspath(os.path.dirname(sys.argv[0])), '../lib'))
-from bb.cache import CoreRecipeInfo
-
-import pickle
-
-class DumpCache(object):
-    def __init__(self):
-        parser = argparse.ArgumentParser(
-            description="bb_cache.dat's dumper",
-            epilog="Use %(prog)s --help to get help")
-        parser.add_argument("-r", "--recipe",
-            help="specify the recipe, default: all recipes", action="store")
-        parser.add_argument("-m", "--members",
-            help = "specify the member, use comma as separator for multiple ones, default: all members", action="store", default="")
-        parser.add_argument("-s", "--skip",
-            help = "skip skipped recipes", action="store_true")
-        parser.add_argument("cachefile",
-            help = "specify bb_cache.dat", nargs = 1, action="store", default="")
-
-        self.args = parser.parse_args()
-
-    def main(self):
-        with open(self.args.cachefile[0], "rb") as cachefile:
-            pickled = pickle.Unpickler(cachefile)
-            while True:
-                try:
-                    key = pickled.load()
-                    val = pickled.load()
-                except Exception:
-                    break
-                if isinstance(val, CoreRecipeInfo):
-                    pn = val.pn
-
-                    if self.args.recipe and self.args.recipe != pn:
-                        continue
-
-                    if self.args.skip and val.skipped:
-                        continue
-
-                    if self.args.members:
-                        out = key
-                        for member in self.args.members.split(','):
-                            out += ": %s" % val.__dict__.get(member)
-                        print("%s" % out)
-                    else:
-                        print("%s: %s" % (key, val.__dict__))
-                elif not self.args.recipe:
-                    print("%s %s" % (key, val))
-
-if __name__ == "__main__":
-    try:
-        dump = DumpCache()
-        ret = dump.main()
-    except Exception as esc:
-        ret = 1
-        import traceback
-        traceback.print_exc()
-    sys.exit(ret)
-- 
2.7.4


