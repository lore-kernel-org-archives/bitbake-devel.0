Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id B3A3A773FB
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 22:58:10 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga105.fm.intel.com with ESMTP; 05 Sep 2016 15:58:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,288,1470726000"; 
   d="scan'208";a="5310840"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.181.236])
	by orsmga004.jf.intel.com with ESMTP; 05 Sep 2016 15:58:09 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Sep 2016 10:57:32 +1200
Message-Id: <72efb64409b1f31009a029482f539dd400a42f2f.1473116117.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 5/6] fetch2/npm: clarify comment
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
X-List-Received-Date: Mon, 05 Sep 2016 22:58:11 -0000

The correct name of the parameter is "version" not "ver" so ensure we
aren't misleading the user by giving the latter in an example.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 08d6876..43929ce 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -13,7 +13,7 @@ Usage in the recipe:
     - name
     - version
 
-    npm://registry.npmjs.org/${PN}/-/${PN}-${PV}.tgz  would become npm://registry.npmjs.org;name=${PN};ver=${PV}
+    npm://registry.npmjs.org/${PN}/-/${PN}-${PV}.tgz  would become npm://registry.npmjs.org;name=${PN};version=${PV}
     The fetcher all triggers off the existence of ud.localpath. If that exists and has the ".done" stamp, its assumed the fetch is good/done
 
 """
-- 
2.5.5


