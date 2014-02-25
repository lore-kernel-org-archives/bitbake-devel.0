Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 237566F30A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Feb 2014 13:22:44 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga102.ch.intel.com with ESMTP; 25 Feb 2014 05:22:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,540,1389772800"; d="scan'208";a="481450543"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.62])
	by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2014 05:22:20 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Feb 2014 15:30:12 +0200
Message-Id: <1393335012-26237-4-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1393335012-26237-1-git-send-email-cristiana.voicu@intel.com>
References: <y> <1393335012-26237-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 3/3] hob: append bbfiles to bblayers.conf instead of local.conf
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
X-List-Received-Date: Tue, 25 Feb 2014 13:22:44 -0000

[YOCTO #5118]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index cdf1eb5..46f36d8 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -505,7 +505,7 @@ class HobHandler(gobject.GObject):
         bbfiles = self.runCommand(["getVariable", "BBFILES", "False"]) or ""
         bbfiles = bbfiles.split()
         if val not in bbfiles:
-            self.append_var_in_file("BBFILES", val, "local.conf")
+            self.append_var_in_file("BBFILES", val, "bblayers.conf")
 
     def get_parameters(self):
         # retrieve the parameters from bitbake
-- 
1.7.9.5


