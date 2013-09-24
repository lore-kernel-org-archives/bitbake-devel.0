Return-Path: <ddalex@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 535126CB6B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:13 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511899"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 2C4C95628CB; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:34 +0100
Message-Id: <00c5a198a429ef4fd8ee11b05c6f148f97744ef0.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 65/94] bitbake: webhob: improve search functionality
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

we improve the search functionality to allow for
multiple search terms separated by space.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/base.html | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/templates/base.html b/bitbake/lib/webhob/bldviewer/templates/base.html
index 45f8652..12b2f01 100644
--- a/bitbake/lib/webhob/bldviewer/templates/base.html
+++ b/bitbake/lib/webhob/bldviewer/templates/base.html
@@ -22,8 +22,11 @@ function showhideTableColumn(i, sh) {
 
 function filterTableRows(test) {
     if (test.length > 0) {
-        var r = new RegExp(test);
-        $('tr.data').map( function (i, el) { if (! r.test($(el).html())) {$(el).hide()} else $(el).show()});
+
+        var r = test.split(/[ ,]+/).map(function (e) { return new RegExp(e, 'i') });
+        $('tr.data').map( function (i, el) {
+            (! r.map(function (j) { return j.test($(el).html())}).reduce(function (c, p) { return c && p;} )) ? $(el).hide() : $(el).show();
+        });
     } else
     {
         $('tr.data').show();
-- 
1.8.1.2


