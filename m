Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 8596D77ABD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Mar 2017 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1489766099; x=1521302099; h=from:to:subject:date:message-id;
	bh=r1f7c7gMB9VRXFsXwc3tQv9VlAkQkDsYpdMdm1x34Hw=;
	b=Di7KSvjbxEQLb/6upaglsORSnom0WA50M+W1HRdZYNmiSad4N5HSpo5D
	CFauYtiNRvLOnE+7uqBO8PoG+I0EEQ==;
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Mar 2017 08:54:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,177,1486454400"; d="scan'208";a="1109586459"
Received: from jlock-mobl1.ger.corp.intel.com ([10.252.34.237])
	by orsmga001.jf.intel.com with ESMTP; 17 Mar 2017 08:54:47 -0700
From: Joshua Lock <joshua.g.lock@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Mar 2017 15:54:39 +0000
Message-Id: <20170317155439.4770-1-joshua.g.lock@intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH] lib/bb/tests/codeparser: update expand syntax in comment
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
X-List-Received-Date: Fri, 17 Mar 2017 15:54:56 -0000

bb.data.expand(x, d) is deprecated API

Signed-off-by: Joshua Lock <joshua.g.lock@intel.com>
---
 lib/bb/tests/codeparser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index a681841..a45a582 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -285,8 +285,8 @@ def a():
 
 test(d)
 
-bb.data.expand(d.getVar("something", False), d)
-bb.data.expand("${inexpand} somethingelse", d)
+d.expand(d.getVar("something", False))
+d.expand("${inexpand} somethingelse")
 d.getVar(a(), False)
 """
 
-- 
2.9.3


