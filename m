Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 1DCE660118
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Nov 2015 01:54:19 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 19 Nov 2015 17:54:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,320,1444719600"; d="scan'208";a="603692741"
Received: from ywong15-mobl2.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.131.114])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Nov 2015 17:52:56 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Nov 2015 14:52:29 +1300
Message-Id: <b3eb9a8c73162f83ad927fcd4302e1757e74fa41.1447984320.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1447984320.git.paul.eggleton@linux.intel.com>
References: <cover.1447984320.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1447984320.git.paul.eggleton@linux.intel.com>
References: <cover.1447984320.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] lib/bb/utils: fix error in edit_metadata() when deleting first line
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
X-List-Received-Date: Fri, 20 Nov 2015 01:54:19 -0000

If you tried to delete the variable on the first line passed to
edit_metadata() this failed because the logic for trimming extra blank
lines didn't expect the list to be empty at that point - fix that bad
assumption.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 7f82687..9b28952 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1177,7 +1177,7 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
             if not skip:
                 if checkspc:
                     checkspc = False
-                    if newlines[-1] == '\n' and line == '\n':
+                    if newlines and newlines[-1] == '\n' and line == '\n':
                         # Squash blank line if there are two consecutive blanks after a removal
                         continue
                 newlines.append(line)
-- 
2.1.0


