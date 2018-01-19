Return-Path: <amanda.r.brindle@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 02B5577FC9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jan 2018 20:55:35 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jan 2018 12:55:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,382,1511856000"; d="scan'208";a="27906207"
Received: from arbrindl-dev.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 19 Jan 2018 12:55:28 -0800
From: Amanda Brindle <amanda.r.brindle@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 19 Jan 2018 12:53:13 -0800
Message-Id: <57f40b8b016e6f9e4539d919d323dd6b6d75c31a.1516394932.git.amanda.r.brindle@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1516394932.git.amanda.r.brindle@intel.com>
References: <cover.1516394932.git.amanda.r.brindle@intel.com>
X-Mailman-Approved-At: Mon, 22 Jan 2018 22:09:11 +0000
Cc: paul.eggleton@linux.intel.com
Subject: [PATCH 1/1] tinfoil.py: Check if BUILDDIR exists
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
X-List-Received-Date: Fri, 19 Jan 2018 20:55:36 -0000

Check if BUILDDIR exists in order to deterimine if a tinfoil using
script is running without having called oe-init-build-env (or similar).
If not, instruct user to initialise the build environment, and then
error out immediately. Before, tinfoil would hang for 30s before
erroring out.

Fixes [YOCTO #12096]

Signed-off-by: Amanda Brindle <amanda.r.brindle@intel.com>
---
 bitbake/lib/bb/tinfoil.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index 368264f..e156b47 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -372,6 +372,11 @@ class Tinfoil:
         """
         self.quiet = quiet
 
+        basepath = os.environ.get('BUILDDIR')
+        if not basepath:
+            print("Tinfoil can only be run after initialising the build environment (e.g. by using oe-init-build-env)")
+            sys.exit(1)
+
         if self.tracking:
             extrafeatures = [bb.cooker.CookerFeatures.BASEDATASTORE_TRACKING]
         else:
-- 
2.7.4


