Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id D56847319D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 16:49:05 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 17 Dec 2015 08:49:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,441,1444719600"; d="scan'208";a="15002678"
Received: from agusev-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.27.121])
	by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2015 08:49:04 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Dec 2015 16:48:49 +0000
Message-Id: <91c6596e0afb371fafce32530cc32964a16180f4.1450370782.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
References: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
In-Reply-To: <cover.1450370782.git.elliot.smith@intel.com>
References: <cover.1450370782.git.elliot.smith@intel.com>
Subject: [PATCH 04/11] toaster: remove unused variable
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
X-List-Received-Date: Thu, 17 Dec 2015 16:49:06 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed unused variable RUNNING from the toaster script.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index a849559..ccbfdb3 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -185,7 +185,6 @@ fi
 
 BBBASEDIR=`dirname $TOASTER`/..
 OEROOT=`dirname $TOASTER`/../..
-RUNNING=0
 NOTOASTERUI=0
 WEBSERVER=1
 TOASTER_BRBE=""
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


