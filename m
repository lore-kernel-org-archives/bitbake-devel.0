Return-Path: <valentin.popa@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 469AA6F558
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Mar 2014 15:53:56 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 17 Mar 2014 08:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,670,1389772800"; d="scan'208";a="501625784"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.76])
	by orsmga002.jf.intel.com with ESMTP; 17 Mar 2014 08:53:48 -0700
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Mar 2014 17:53:38 +0200
Message-Id: <1395071618-24702-1-git-send-email-valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.3.2
Subject: [PATCH] hob: sync after image deploy
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
X-List-Received-Date: Mon, 17 Mar 2014 15:53:57 -0000

Showing "Deploy image successful" after 'dd' returns
may determine the user to disconnect the usb stick even
though the writing operations are not finished.
This patch makes sure that the entire image is deployed
on the usb stick before the user is informed about any result.

[YOCTO #5892]

Signed-off-by: Valentin Popa <valentin.popa@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py
index f64fbd6..a13fff9 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py
@@ -167,7 +167,7 @@ class DeployImageDialog (CrumbsDialog):
                 if cmdline:
                     tmpfile = tempfile.NamedTemporaryFile()
                     cmdline += "\"sudo dd if=" + self.image_path + \
-                                " of=" + combo_item + "; echo $? > " + tmpfile.name + "\""
+                                " of=" + combo_item + " && sync; echo $? > " + tmpfile.name + "\""
                     subprocess.call(shlex.split(cmdline))
 
                     if int(tmpfile.readline().strip()) == 0:
-- 
1.8.3.2


