Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 0E3F662222
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 10:50:51 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 31 May 2013 03:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,778,1363158000"; d="scan'208";a="346203114"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by orsmga002.jf.intel.com with ESMTP; 31 May 2013 03:50:51 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id 884FF5607A1; Fri, 31 May 2013 11:50:51 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Fri, 31 May 2013 11:50:49 +0100
Message-Id: <1369997449-15349-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH] .gitignore: add vim tag and swp files
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
X-List-Received-Date: Fri, 31 May 2013 10:50:51 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Modify gitignore as to include popular editor's temporary
files, and lookup tags file.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 0359687..78aa674 100644
--- a/.gitignore
+++ b/.gitignore
@@ -5,3 +5,5 @@ pyshtables.py
 /doc/manual/html/
 /build/
 /bin/bitbakec
+*.swp
+tags
-- 
1.8.1.2


