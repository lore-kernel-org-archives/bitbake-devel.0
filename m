Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 0E76A773FB
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 22:58:13 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga105.fm.intel.com with ESMTP; 05 Sep 2016 15:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,288,1470726000"; 
   d="scan'208";a="5310848"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.181.236])
	by orsmga004.jf.intel.com with ESMTP; 05 Sep 2016 15:58:12 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Sep 2016 10:57:33 +1200
Message-Id: <ef28c55f83a10858ae967e67d123497658b79516.1473116117.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 6/6] lib/bb/utils: edit_metadata() comment tweaks
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
X-List-Received-Date: Mon, 05 Sep 2016 22:58:13 -0000

No functional changes, just make a couple of minor tweaks to the
comments for edit_metadata():

* There are four elements to be returned by the callback function
* Add an example return statement for when you don't want to modify the
  value

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/utils.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index a855d58..729848a 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1081,7 +1081,7 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
                 newlines: list of lines up to this point. You can use
                     this to prepend lines before this variable setting
                     if you wish.
-            and should return a three-element tuple:
+            and should return a four-element tuple:
                 newvalue: new value to substitute in, or None to drop
                     the variable setting entirely. (If the removal
                     results in two consecutive blank lines, one of the
@@ -1095,6 +1095,8 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
                     multi-line value to continue on the same line as
                     the assignment, False to indent before the first
                     element.
+            To clarify, if you wish not to change the value, then you
+            would return like this: return origvalue, None, 0, True
         match_overrides: True to match items with _overrides on the end,
             False otherwise
     Returns a tuple:
-- 
2.5.5


