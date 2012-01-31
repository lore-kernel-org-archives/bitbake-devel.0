Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1Rs7BJ-0003kH-He
	for bitbake-devel@lists.openembedded.org;
	Tue, 31 Jan 2012 07:27:06 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 30 Jan 2012 22:19:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112304556"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.146])
	by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2012 22:19:12 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Jan 2012 14:18:04 +0800
Message-Id: <fe0512a8af642c0b23a9fbbb6aa82953b9e17313.1327990542.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1327990542.git.lianhao.lu@intel.com>
References: <cover.1327990542.git.lianhao.lu@intel.com>
Subject: [PATCH 1/1] prserv: Do not ping PRService if not required
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
X-List-Received-Date: Tue, 31 Jan 2012 06:27:06 -0000

[YOCTO #1942]
Ping the PRService only if PRSERV_HOST and PRSERV_PORT are set.

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
---
 bitbake/lib/prserv/serv.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index fa437f9..5567c6f 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -268,7 +268,7 @@ def is_local_special(host, port):
 
 def auto_start(d):
     global singleton
-    if d.getVar('USE_PR_SERV', True) == '0':
+    if (not d.getVar('PRSERV_HOST', True)) or (not d.getVar('PRSERV_PORT', True)):
         return True
 
     if is_local_special(d.getVar('PRSERV_HOST', True), int(d.getVar('PRSERV_PORT', True))) and not singleton:
-- 
1.7.0.4



