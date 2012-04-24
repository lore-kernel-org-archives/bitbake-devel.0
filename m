Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SMb7M-00059p-3w
	for bitbake-devel@lists.openembedded.org;
	Tue, 24 Apr 2012 10:29:00 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 24 Apr 2012 01:19:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="136007840"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 24 Apr 2012 01:19:24 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Apr 2012 16:16:11 +0800
Message-Id: <b8807cba5faa15207e893e54ed9f2b92f680ceb6.1335254750.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1335254750.git.dongxiao.xu@intel.com>
References: <cover.1335254750.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1335254750.git.dongxiao.xu@intel.com>
References: <cover.1335254750.git.dongxiao.xu@intel.com>
Subject: [PATCH 2/3] Hob: Add proxy setting into setting's md5
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
X-List-Received-Date: Tue, 24 Apr 2012 08:29:00 -0000

If user changed the proxy setting, we will reparse configuration because
it may need sanity check.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hig.py |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 93a4fbc..4baf960 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -356,6 +356,15 @@ class AdvancedSettingDialog (CrumbsDialog):
         data += ("SDK_MACHINE: "          + self._get_sorted_value(self.configuration.curr_sdk_machine))
         data += ("TOOLCHAIN_BUILD: "      + self._get_sorted_value(self.configuration.toolchain_build))
         data += ("IMAGE_FSTYPES: "        + self._get_sorted_value(self.configuration.image_fstypes))
+        if self.enable_proxy:
+            data += ("ALL_PROXY: "            + self._get_sorted_value(self.configuration.all_proxy))
+            data += ("HTTP_PROXY: "           + self._get_sorted_value(self.configuration.http_proxy))
+            data += ("HTTPS_PROXY: "          + self._get_sorted_value(self.configuration.https_proxy))
+            data += ("FTP_PROXY: "            + self._get_sorted_value(self.configuration.ftp_proxy))
+            data += ("GIT_PROXY_HOST: "       + self._get_sorted_value(self.configuration.git_proxy_host))
+            data += ("GIT_PROXY_PORT: "       + self._get_sorted_value(self.configuration.git_proxy_port))
+            data += ("CVS_PROXY_HOST: "       + self._get_sorted_value(self.configuration.cvs_proxy_host))
+            data += ("CVS_PROXY_PORT: "       + self._get_sorted_value(self.configuration.cvs_proxy_port))
         for key in self.configuration.extra_setting.keys():
             data += (key + ": " + self._get_sorted_value(self.configuration.extra_setting[key]))
         return hashlib.md5(data).hexdigest()
-- 
1.7.4.1



