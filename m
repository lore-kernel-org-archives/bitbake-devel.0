Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 6738072FDD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Feb 2017 10:13:21 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP; 23 Feb 2017 02:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,197,1484035200"; d="scan'208";a="51723648"
Received: from mburny-mobl.ger.corp.intel.com (HELO
	mqz-osx-suse64.fi.intel.com) ([10.252.22.38])
	by orsmga002.jf.intel.com with ESMTP; 23 Feb 2017 02:13:21 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2017 12:13:19 +0200
Message-Id: <1487844799-23976-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH] lib/oe/gpg_sign: sign rpm packages in chunks of 100
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
X-List-Received-Date: Thu, 23 Feb 2017 10:13:21 -0000

Split the file list into chunks in order to avoid
"OSError: [Errno 7] Argument list too long"

This would happend when a package has huge amount of subpackages, e.g.
glibc-locale.

[YOCTO #11069]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 meta/lib/oe/gpg_sign.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/meta/lib/oe/gpg_sign.py b/meta/lib/oe/gpg_sign.py
index dcd1990..bf36226 100644
--- a/meta/lib/oe/gpg_sign.py
+++ b/meta/lib/oe/gpg_sign.py
@@ -35,11 +35,12 @@ class LocalSigner(object):
             cmd += "--define '%%__gpg %s' " % self.gpg_bin
         if self.gpg_path:
             cmd += "--define '_gpg_path %s' " % self.gpg_path
-        cmd += ' '.join(files)
 
-        status, output = oe.utils.getstatusoutput(cmd)
-        if status:
-            raise bb.build.FuncFailed("Failed to sign RPM packages: %s" % output)
+        # Sign in chunks of 100 packages
+        for i in range(0, len(files), 100):
+            status, output = oe.utils.getstatusoutput(cmd + ' '.join(files[i:i+100]))
+            if status:
+                raise bb.build.FuncFailed("Failed to sign RPM packages: %s" % output)
 
     def detach_sign(self, input_file, keyid, passphrase_file, passphrase=None, armor=True):
         """Create a detached signature of a file"""
-- 
2.6.6


