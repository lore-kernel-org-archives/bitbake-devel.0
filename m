Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qp6fm-0007D4-1p
	for bitbake-devel@lists.openembedded.org;
	Fri, 05 Aug 2011 00:45:51 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 04 Aug 2011 15:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,320,1309762800"; d="scan'208";a="34615629"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga002.jf.intel.com with ESMTP; 04 Aug 2011 15:41:20 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  4 Aug 2011 15:46:01 -0700
Message-Id: <5cacdc4f1641eda1b5707c96f7c40924a9db6174.1312497858.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312497858.git.josh@linux.intel.com>
References: <cover.1312497858.git.josh@linux.intel.com>
In-Reply-To: <cover.1312497858.git.josh@linux.intel.com>
References: <cover.1312497858.git.josh@linux.intel.com>
Subject: [PATCH 2/2] bb/cooker: mark parsed conf files as potential cache invalidators
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 04 Aug 2011 22:45:51 -0000

The include parameter to _parse() tells the parser whether to include the
file in __base_depends, the contents of which have their mtime tested to
invalidate the cache when they have changed.

As I understand it we would want all of the configuration files that are
currently handled with the _parse() method to invalidate the cache to set the
default value of the include parameter to True.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 025dfe4..6022192 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1317,7 +1317,7 @@ def catch_parse_error(func):
     return wrapped
 
 @catch_parse_error
-def _parse(fn, data, include=False):
+def _parse(fn, data, include=True):
     return bb.parse.handle(fn, data, include)
 
 @catch_parse_error
-- 
1.7.6



