Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 1E1FA71A86
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:08:37 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:08:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961398"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:22 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:00 +1300
Message-Id: <b30d1d4129080f68a511d8987206c552835247db.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 01/15] data_smart: fix resetting of reference on variablehistory
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
X-List-Received-Date: Tue, 13 Dec 2016 07:08:37 -0000

There is no "datasmart" member, only dataroot. This dates back to the
original implementation of variable history support - it's surprising we
haven't noticed the issue until now, but I guess it's rare to change a
copy of a datastore in a manner which using the old reference would
cause an issue.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index be43eb9..17768c8 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -844,7 +844,7 @@ class DataSmart(MutableMapping):
         data = DataSmart()
         data.dict["_data"] = self.dict
         data.varhistory = self.varhistory.copy()
-        data.varhistory.datasmart = data
+        data.varhistory.dataroot = data
         data.inchistory = self.inchistory.copy()
 
         data._tracking = self._tracking
-- 
2.5.5


