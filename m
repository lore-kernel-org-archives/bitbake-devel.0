Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A54D471D9E
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 May 2017 21:30:22 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 May 2017 14:30:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.38,341,1491289200"; d="scan'208";a="101449474"
Received: from cdhirema-mobl1.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.142.50])
	by fmsmga005.fm.intel.com with ESMTP; 14 May 2017 14:30:22 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 May 2017 09:29:55 +1200
Message-Id: <94014121fdc8336dd52bac1876da0cdc6804092c.1494797368.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1494797368.git.paul.eggleton@linux.intel.com>
References: <cover.1494797368.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] lib/bb/COW.py: fix typo in Tim Ansell's name
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
X-List-Received-Date: Sun, 14 May 2017 21:30:22 -0000

See AUTHORS for reference.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/COW.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index 36ebbd9..bec6208 100644
--- a/lib/bb/COW.py
+++ b/lib/bb/COW.py
@@ -3,7 +3,7 @@
 #
 # This is a copy on write dictionary and set which abuses classes to try and be nice and fast.
 #
-# Copyright (C) 2006 Tim Amsell
+# Copyright (C) 2006 Tim Ansell
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
-- 
2.9.3


