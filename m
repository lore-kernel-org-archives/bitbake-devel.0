Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id CB09272F21
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 May 2017 21:30:24 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 May 2017 14:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.38,341,1491289200"; d="scan'208";a="101449482"
Received: from cdhirema-mobl1.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.142.50])
	by fmsmga005.fm.intel.com with ESMTP; 14 May 2017 14:30:25 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 May 2017 09:29:56 +1200
Message-Id: <b15eeb210fe3eaf0d599840231467a7e58da36c2.1494797368.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1494797368.git.paul.eggleton@linux.intel.com>
References: <cover.1494797368.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] lib/bb/fetch2: fix typo in conflicting revision message
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
X-List-Received-Date: Sun, 14 May 2017 21:30:25 -0000

spcify -> specify

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 136fc29..79a8906 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1130,7 +1130,7 @@ def srcrev_internal_helper(ud, d, name):
         if srcrev == "INVALID" or not srcrev:
             return parmrev
         if srcrev != parmrev:
-            raise FetchError("Conflicting revisions (%s from SRCREV and %s from the url) found, please spcify one valid value" % (srcrev, parmrev))
+            raise FetchError("Conflicting revisions (%s from SRCREV and %s from the url) found, please specify one valid value" % (srcrev, parmrev))
         return parmrev
 
     if srcrev == "INVALID" or not srcrev:
-- 
2.9.3


