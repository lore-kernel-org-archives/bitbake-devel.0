Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 06B7778227
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Oct 2017 15:11:07 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Oct 2017 08:10:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,484,1500966000"; d="scan'208";a="1203024177"
Received: from yctb05.ostc.intel.com ([10.54.69.59])
	by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2017 08:10:47 -0700
From: leonardo.sandoval.gonzalez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Oct 2017 08:10:42 -0700
Message-Id: <20171006151043.55075-2-leonardo.sandoval.gonzalez@linux.intel.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20171006151043.55075-1-leonardo.sandoval.gonzalez@linux.intel.com>
References: <20171006151043.55075-1-leonardo.sandoval.gonzalez@linux.intel.com>
Subject: [PATCH v2 2/3] bitbake-user-manual-metadata: include a space on a append example
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
X-List-Received-Date: Fri, 06 Oct 2017 15:11:08 -0000

From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>

By definition, the override operator "_append" does not include a space,
so include it.

Signed-off-by: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index b37da10a..0cfa53d0 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -669,7 +669,7 @@
                         <literallayout class='monospaced'>
      DEPENDS = "glibc ncurses"
      OVERRIDES = "machine:local"
-     DEPENDS_append_machine = "libmad"
+     DEPENDS_append_machine = " libmad"
                         </literallayout>
                         In this example, <filename>DEPENDS</filename> becomes
                         "glibc ncurses libmad".
-- 
2.12.3


