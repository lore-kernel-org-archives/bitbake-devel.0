Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 6D3CD77D28
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  2 Apr 2017 23:19:29 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 02 Apr 2017 16:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,266,1486454400"; d="scan'208";a="243248000"
Received: from rbek-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.164.56])
	by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2017 16:19:29 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Apr 2017 11:19:06 +1200
Message-Id: <0eef14785fb932ab17923f0a7496dd6f7669b275.1491175014.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491175014.git.paul.eggleton@linux.intel.com>
References: <cover.1491175014.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/4] codeparser: add some comments
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
X-List-Received-Date: Sun, 02 Apr 2017 23:19:29 -0000

Add a few comments at the top of the file explaining what it's for, and
a comment pointing out that you need to increment the cache version when
changing any code that changes the output.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/codeparser.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index f76b478..530f44e 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -1,3 +1,22 @@
+"""
+BitBake code parser
+
+Parses actual code (i.e. python and shell) for functions and in-line
+expressions. Used mainly to determine dependencies on other functions
+and variables within the BitBake metadata. Also provides a cache for
+this information in order to speed up processing.
+
+(Not to be confused with the code that parses the metadata itself,
+see lib/bb/parse/ for that).
+
+NOTE: if you change how the parsers gather information you will almost
+certainly need to increment CodeParserCache.CACHE_VERSION below so that
+any existing codeparser cache gets invalidated. Additionally you'll need
+to increment __cache_version__ in cache.py in order to ensure that old
+recipe caches don't trigger "Taskhash mismatch" errors.
+
+"""
+
 import ast
 import sys
 import codegen
@@ -117,6 +136,10 @@ class shellCacheLine(object):
 
 class CodeParserCache(MultiProcessCache):
     cache_file_name = "bb_codeparser.dat"
+    # NOTE: you must increment this if you change how the parsers gather information,
+    # so that an existing cache gets invalidated. Additionally you'll need
+    # to increment __cache_version__ in cache.py in order to ensure that old
+    # recipe caches don't trigger "Taskhash mismatch" errors.
     CACHE_VERSION = 9
 
     def __init__(self):
-- 
2.9.3


