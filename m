Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 5C37F7258E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Dec 2014 11:14:55 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 29 Dec 2014 03:14:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,659,1413270000"; d="scan'208";a="630312991"
Received: from brvijay-mobl.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.0.132])
	by orsmga001.jf.intel.com with ESMTP; 29 Dec 2014 03:14:33 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Dec 2014 11:14:27 +0000
Message-Id: <c231b3780358cb93f93ac7ac9375ec605f794e04.1419851448.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1419851448.git.paul.eggleton@linux.intel.com>
References: <cover.1419851448.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1419851448.git.paul.eggleton@linux.intel.com>
References: <cover.1419851448.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] utils: make edit_metadata_file() handle VARIABLE +=
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
X-List-Received-Date: Mon, 29 Dec 2014 11:14:57 -0000

This is a little crude as the usage basically ignores that you're doing
an append operation, but for a lot of cases it will be sufficient.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ef8cd4d..90090b2 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -923,7 +923,7 @@ def edit_metadata_file(meta_file, variables, func):
     """
     var_res = {}
     for var in variables:
-        var_res[var] = re.compile(r'^%s[ \t]*[?=]+' % var)
+        var_res[var] = re.compile(r'^%s[ \t]*[?+]*=' % var)
 
     updated = False
     varset_start = ''
-- 
1.9.3


