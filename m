Return-Path: <stephano.cetola@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 046D0787DE
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Feb 2018 18:23:19 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Feb 2018 10:23:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,536,1511856000"; d="scan'208";a="31232678"
Received: from aalzate-mobl1.amr.corp.intel.com ([10.255.229.185])
	by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2018 10:23:21 -0800
From: Stephano Cetola <stephano.cetola@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Feb 2018 10:15:51 -0800
Message-Id: <20180219181551.87750-2-stephano.cetola@linux.intel.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180219181551.87750-1-stephano.cetola@linux.intel.com>
References: <20180219181551.87750-1-stephano.cetola@linux.intel.com>
Subject: [PATCH V2 1/1] utils.py: Add option for explode_dep_versions2 to return unsorted
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
X-List-Received-Date: Mon, 19 Feb 2018 18:23:20 -0000

From: Amanda Brindle <amanda.r.brindle@intel.com>

Before, explode_dep_versions2 would sort the OrderedDict before
returning. This function will still sort the OrderedDict by default, but
will now have the option to return the OrderedDict unsorted. This option will
allow us to check if the order of the package list has changed.

Signed-off-by: Amanda Brindle <amanda.r.brindle@intel.com>
Acked-by: Stephano Cetola <stephano.cetola@linux.intel.com>
---
 lib/bb/utils.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index c540b49c..7adb4690 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -187,7 +187,7 @@ def explode_deps(s):
             #r[-1] += ' ' + ' '.join(j)
     return r
 
-def explode_dep_versions2(s):
+def explode_dep_versions2(s, unsorted=False):
     """
     Take an RDEPENDS style string of format:
     "DEPEND1 (optional version) DEPEND2 (optional version) ..."
@@ -250,7 +250,8 @@ def explode_dep_versions2(s):
         if not (i in r and r[i]):
             r[lastdep] = []
 
-    r = collections.OrderedDict(sorted(r.items(), key=lambda x: x[0]))
+    if not unsorted:
+        r = collections.OrderedDict(sorted(r.items(), key=lambda x: x[0]))
     return r
 
 def explode_dep_versions(s):
-- 
2.16.0


