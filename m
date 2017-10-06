Return-Path: <mikko.ylinen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3C4986079F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Oct 2017 08:47:45 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Oct 2017 01:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,482,1500966000"; d="scan'208";a="1202912795"
Received: from summit.tm.intel.com ([10.237.55.126])
	by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2017 01:47:39 -0700
From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Oct 2017 11:47:35 +0300
Message-Id: <20171006084735.31536-1-mikko.ylinen@linux.intel.com>
X-Mailer: git-send-email 2.14.2
Subject: [PATCH] bitbake-user-manual: add more gitsm fetcher limitations
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
X-List-Received-Date: Fri, 06 Oct 2017 08:47:46 -0000

The submodule sources fetched by the gitsm fetcher are not automatically
tracked by the licensing and archiver infrastructures.

Add these limitations to the existing 'warnings' sections for
gitsm.

[YOCTO #11594]

Signed-off-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.xml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index d1ce43e2..c721e86e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -620,7 +620,9 @@
                         The Git Submodules fetcher is not a complete fetcher
                         implementation.
                         The fetcher has known issues where it does not use the
-                        normal source mirroring infrastructure properly.
+                        normal source mirroring infrastructure properly. Further,
+                        the submodule sources it fetches are not visible to the
+                        licensing and source archiving infrastructures.
                     </para>
                 </note>
             </para>
-- 
2.14.2


