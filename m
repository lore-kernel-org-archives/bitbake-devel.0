Return-Path: <anibal.limon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 25B80757F4
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jul 2015 20:38:22 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 03 Jul 2015 13:38:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,402,1432623600"; d="scan'208";a="755652965"
Received: from mctremel-mobl1.amr.corp.intel.com (HELO
	alimon-ThinkPad-W540.amr.corp.intel.com) ([10.254.180.106])
	by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2015 13:38:22 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jul 2015 15:40:26 -0500
Message-Id: <1435956027-26996-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH 1/2] cooker.py: Close lock file and watcher fds when end.
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
X-List-Received-Date: Fri, 03 Jul 2015 20:38:24 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When run cooker inside loop it reaches OS max fd's causing
an exception.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/cooker.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f31bca6..abe8a52 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1432,6 +1432,9 @@ class BBCooker:
         if self.state in (state.shutdown, state.forceshutdown, state.error):
             if hasattr(self.parser, 'shutdown'):
                 self.parser.shutdown(clean=False, force = True)
+            self.configwatcher.close()
+            self.watcher.close()
+            self.lock.close()
             raise bb.BBHandledException()
 
         if self.state != state.parsing:
-- 
1.9.1


