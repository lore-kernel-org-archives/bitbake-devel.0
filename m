Return-Path: <juro.bystricky@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 50F97605C3
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Jan 2017 19:17:28 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Jan 2017 11:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,235,1477983600"; d="scan'208";a="922837278"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.149])
	by orsmga003.jf.intel.com with ESMTP; 15 Jan 2017 11:17:28 -0800
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Jan 2017 11:13:36 -0800
Message-Id: <1484507616-24254-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: jurobystricky@hotmail.com
Subject: [PATCH] cooker.py: new multiconfig '*' syntax support
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
X-List-Received-Date: Sun, 15 Jan 2017 19:17:29 -0000

Currently you cannot build a target for all the configured multiconfigs without
specifying a list. The list can be quite long, requiring to type several lines
of text.

This enhancement is to support globbing so that you can do this,
e.g. instead of:

    $ bitbake multiconfig:A:bash multiconfig:B:bash bash

you can do:

    $ bitbake multiconfig:*:bash

There are real world use cases where it is desirable to use multiconfig with
two different tasks. For example:  SDKs with multiple toolchains but also
containing set of additional host tools, or multiconfig builds requiring one image for
the  main CPU(s) and a different co-image for a companion CPU.
For this reason, two variations of the new syntax are supported.

For example, the following:

    $ bitbake multiconfig:*:meta-toolhchain

would expand to:

    $ bitbake multiconfig:A:meta-toolchain multiconfig:B:meta-toolchain meta-toolchain

However the following:

    $ bitbake multiconfig:*:meta-toolhchain hosttools

would expand to:

    $ bitbake multiconfig:A:meta-toolchain multiconfig:B:meta-toolchain hosttools

In other words, if the user specified the "default" task explicitly, it replaces the implicit
"default" task.

[YOCTO#10680]

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
---
 bitbake/lib/bb/cooker.py | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f6bad36..094a871 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -666,7 +666,37 @@ class BBCooker:
         if not task.startswith("do_"):
             task = "do_%s" % task
 
-        fulltargetlist = self.checkPackages(pkgs_to_build, task)
+        targetlist = self.checkPackages(pkgs_to_build, task)
+        fulltargetlist = []
+        defaulttask_implicit = ''
+        defaulttask_explicit = False
+        wildcard = False
+
+        # Wild card expansion:
+        # Replace string such as "multiconfig:*:bash"
+        # into "multiconfig:A:bash multiconfig:B:bash bash"
+        for k in targetlist:
+            if k.startswith("multiconfig:"):
+                if wildcard:
+                    bb.fatal('multiconfig conflict')
+                if k.split(":")[1] == "*":
+                    wildcard = True
+                    for mc in self.multiconfigs:
+                        if mc:
+                            fulltargetlist.append(k.replace('*', mc))
+                        # implicit default task
+                        else:
+                            defaulttask_implicit = k.split(":")[2]
+                else:
+                    fulltargetlist.append(k)
+            else:
+                defaulttask_explicit = True
+                fulltargetlist.append(k)
+
+        if not defaulttask_explicit and defaulttask_implicit != '':
+            fulltargetlist.append(defaulttask_implicit)
+
+        bb.debug(1,"Target list: %s" % (str(fulltargetlist)))
         taskdata = {}
         localdata = {}
 
-- 
2.7.4


