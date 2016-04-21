Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8BF9C731BB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Apr 2016 13:22:24 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 21 Apr 2016 06:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,512,1455004800"; d="scan'208";a="949956279"
Received: from santhige-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.8.209])
	by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2016 06:22:24 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Apr 2016 14:22:06 +0100
Message-Id: <1461244926-20236-3-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1461244926-20236-1-git-send-email-elliot.smith@intel.com>
References: <1461244926-20236-1-git-send-email-elliot.smith@intel.com>
Subject: [PATCH 3/3] toaster: bin/toaster Fix noweb command
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
X-List-Received-Date: Thu, 21 Apr 2016 13:22:24 -0000

From: Michael Wood <michael.g.wood@intel.com>

For the noweb command we don't need to check if a socket is in use or
not as we're not starting the django development server. We're just
setting up the environment and running the runbuilds scheduler.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/bin/toaster | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 9540fc9..987d53c1 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -255,7 +255,9 @@ case $CMD in
     start )
         # check if addr:port is not in use
         if [ "$CMD" == 'start' ]; then
-             $MANAGE checksocket "$ADDR_PORT" || return 1
+            if [ $WEBSERVER -gt 0 ]; then
+                $MANAGE checksocket "$ADDR_PORT" || return 1
+            fi
         fi
 
         # kill Toaster web server if it's alive
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


