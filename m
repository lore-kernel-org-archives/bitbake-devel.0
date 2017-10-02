Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4573377527
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Oct 2017 15:38:54 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Oct 2017 08:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,470,1500966000"; d="scan'208";a="1226094807"
Received: from yctb05.ostc.intel.com ([10.54.69.59])
	by fmsmga002.fm.intel.com with ESMTP; 02 Oct 2017 08:38:54 -0700
From: leonardo.sandoval.gonzalez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Oct 2017 08:38:48 -0700
Message-Id: <20171002153849.24922-2-leonardo.sandoval.gonzalez@linux.intel.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20171002153849.24922-1-leonardo.sandoval.gonzalez@linux.intel.com>
References: <20171002153849.24922-1-leonardo.sandoval.gonzalez@linux.intel.com>
Subject: [PATCH 2/3] bitbake-user-manual-metadata: include a space on a append example
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
X-List-Received-Date: Mon, 02 Oct 2017 15:38:54 -0000

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


