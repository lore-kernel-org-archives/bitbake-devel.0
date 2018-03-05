Return-Path: <amanda.r.brindle@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 2BFBB789A9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Mar 2018 19:16:28 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Mar 2018 11:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800"; d="scan'208";a="22225703"
Received: from arbrindl-dev.jf.intel.com ([10.7.199.57])
	by orsmga007.jf.intel.com with ESMTP; 05 Mar 2018 11:16:28 -0800
From: Amanda Brindle <amanda.r.brindle@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Mar 2018 11:11:52 -0800
Message-Id: <94fc0e5fdc169763b00bbd42d528ef51e78b44c2.1520274722.git.amanda.r.brindle@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520274722.git.amanda.r.brindle@intel.com>
References: <cover.1520274722.git.amanda.r.brindle@intel.com>
Cc: stephano.cetola@intel.com
Subject: [PATCH V3 1/1] utils.py: Add option for explode_dep_versions2 to return unsorted
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
X-List-Received-Date: Mon, 05 Mar 2018 19:16:29 -0000

Before, explode_dep_versions2 would sort the OrderedDict before
returning. This function will still sort the OrderedDict by default, but
will now have the option to return the OrderedDict unsorted. This option will
allow us to check if the order of the package list has changed.

Signed-off-by: Amanda Brindle <amanda.r.brindle@intel.com>
---
 lib/bb/utils.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index c540b49..0275f05 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -187,7 +187,7 @@ def explode_deps(s):
             #r[-1] += ' ' + ' '.join(j)
     return r
 
-def explode_dep_versions2(s):
+def explode_dep_versions2(s, *, sort = True):
     """
     Take an RDEPENDS style string of format:
     "DEPEND1 (optional version) DEPEND2 (optional version) ..."
@@ -250,7 +250,8 @@ def explode_dep_versions2(s):
         if not (i in r and r[i]):
             r[lastdep] = []
 
-    r = collections.OrderedDict(sorted(r.items(), key=lambda x: x[0]))
+    if sort:
+        r = collections.OrderedDict(sorted(r.items(), key=lambda x: x[0]))
     return r
 
 def explode_dep_versions(s):
-- 
2.7.4


