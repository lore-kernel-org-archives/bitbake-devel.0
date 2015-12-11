Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 13AD46FFD3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Dec 2015 02:33:16 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 10 Dec 2015 18:33:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,411,1444719600"; d="scan'208";a="858518125"
Received: from exxie-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.172.26])
	by fmsmga001.fm.intel.com with ESMTP; 10 Dec 2015 18:33:15 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Dec 2015 15:32:55 +1300
Message-Id: <54699523ad090fb18b4bebd327ed0929acfe5063.1449801133.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1449801133.git.paul.eggleton@linux.intel.com>
References: <cover.1449801133.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1449801133.git.paul.eggleton@linux.intel.com>
References: <cover.1449801133.git.paul.eggleton@linux.intel.com>
Subject: [1.28][PATCH 1/2] lib/bb/utils: fix error in edit_metadata() when deleting first line
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
X-List-Received-Date: Fri, 11 Dec 2015 02:33:18 -0000

If you tried to delete the variable on the first line passed to
edit_metadata() this failed because the logic for trimming extra blank
lines didn't expect the list to be empty at that point - fix that bad
assumption.

(Bitbake master rev: 8bce6fefdc5c046b916588962a2b429c0f648133)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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
2.5.0


