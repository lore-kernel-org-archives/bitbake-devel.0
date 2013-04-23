Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1UUdkH-0000VQ-3B
	for bitbake-devel@lists.openembedded.org;
	Tue, 23 Apr 2013 15:58:57 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 Apr 2013 06:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,533,1363158000"; d="scan'208";a="322997781"
Received: from bogdanm.rb.intel.com ([10.237.105.166])
	by orsmga002.jf.intel.com with ESMTP; 23 Apr 2013 06:40:09 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Apr 2013 16:43:45 +0300
Message-Id: <1366724625-6815-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] bitbake: remove stack trace depth limitation
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 23 Apr 2013 13:58:59 -0000

In case of an error in bitbake, the stack trace is limited to 5
items. This is an endless source of confusion and it makes bugs
reports impractical, since a full stack trace can't be included
in the bug report. This patch simply removes the depth limit.

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/bin/bitbake |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 96d613e..e8064ec 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -276,6 +276,6 @@ if __name__ == "__main__":
     except Exception:
         ret = 1
         import traceback
-        traceback.print_exc(5)
+        traceback.print_exc()
     sys.exit(ret)
 
-- 
1.7.10.4



