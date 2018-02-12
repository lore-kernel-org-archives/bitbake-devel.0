Return-Path: <amanda.r.brindle@intel.com>
X-Greylist: delayed 571 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 12 Feb 2018 20:45:18 UTC
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by mail.openembedded.org (Postfix) with ESMTP id D253D7826C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Feb 2018 20:45:18 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 Feb 2018 12:35:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000"; d="scan'208";a="174292084"
Received: from arbrindl-dev.jf.intel.com ([10.7.199.57])
	by orsmga004.jf.intel.com with ESMTP; 12 Feb 2018 12:35:48 -0800
From: Amanda Brindle <amanda.r.brindle@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Feb 2018 12:32:18 -0800
Message-Id: <42094574d40ddef9dfb1e949311844b8eb0873f0.1518466860.git.amanda.r.brindle@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1518466860.git.amanda.r.brindle@intel.com>
References: <cover.1518466860.git.amanda.r.brindle@intel.com>
Cc: stephano.cetola@intel.com
Subject: [PATCH 1/1] bitbake: Add option for explode_dep_versions2 to return unsorted
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
X-List-Received-Date: Mon, 12 Feb 2018 20:45:19 -0000

Before, explode_dep_versions2 would sort the OrderedDict before
returning. This function will still sort the OrderedDict by default, but
will now have the option to return the OrderedDict unsorted. This option will
allow us to check if the order of the package list has changed.

Signed-off-by: Amanda Brindle <amanda.r.brindle@intel.com>
---
 bitbake/lib/bb/utils.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index c540b49..7adb469 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
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
2.7.4


