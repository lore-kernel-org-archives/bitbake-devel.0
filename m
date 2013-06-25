Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 50526605F3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jun 2013 13:01:34 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 25 Jun 2013 06:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,936,1363158000"; d="scan'208";a="335222994"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga001.jf.intel.com with ESMTP; 25 Jun 2013 06:01:33 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Jun 2013 16:03:25 +0300
Message-Id: <1372165405-25858-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake: adding a new comment should be placed on a new line
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 25 Jun 2013 13:01:35 -0000

In this case, the comment is appended to the end of the file.
Some text editors, do not place  a '\n' to the end of the file
after saving it.

[YOCTO #4636]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/cooker.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2245f8e..49e6345 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -234,7 +234,7 @@ class BBCooker:
                 total += c
 
             #add the variable on a single line, to be easy to replace the second time
-            total += "#added by bitbake"
+            total += "\n#added by bitbake"
             total += "\n%s = \"%s\"\n" % (var, val)
 
             with open(default_file, 'w') as f:
-- 
1.7.9.5


