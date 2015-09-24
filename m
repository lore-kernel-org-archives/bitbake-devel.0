Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 78D71756C5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Sep 2015 10:31:39 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2015 03:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,580,1437462000"; d="scan'208";a="811939737"
Received: from rdouetx-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.2.3])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2015 03:31:39 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Sep 2015 11:31:31 +0100
Message-Id: <638d33d78fcd25fdd6f808458592f553d325e1a3.1443090607.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <92bef2c338fd79ad607f25b8062e8c71eef2a31e.1443090607.git.elliot.smith@intel.com>
References: <92bef2c338fd79ad607f25b8062e8c71eef2a31e.1443090607.git.elliot.smith@intel.com>
In-Reply-To: <cover.1443090607.git.elliot.smith@intel.com>
References: <cover.1443090607.git.elliot.smith@intel.com>
Subject: [PATCH 2/2] toaster: change requirements.txt to get the latest 1.6 django version
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
X-List-Received-Date: Thu, 24 Sep 2015 10:31:39 -0000

From: brian avery <avery.brian@gmail.com>

getting the latest 1.6 available gives us the most bug fixes

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 toaster-requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index c4a2221..358e662 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,4 +1,4 @@
-Django==1.6
+Django<1.7
 South==0.8.4
 argparse==1.2.1
 wsgiref==0.1.2
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


