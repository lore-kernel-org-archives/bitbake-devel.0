Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 757E76CAD5
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Feb 2014 22:11:00 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 06 Feb 2014 14:11:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,796,1384329600"; d="scan'208";a="477228684"
Received: from unknown (HELO peggleto-mobl5.ger.corp.intel.com)
	([10.252.123.122])
	by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2014 14:10:59 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Feb 2014 22:09:23 +0000
Message-Id: <1391724563-12684-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.5.3
Subject: [1.18][PATCH] bitbake: lib/bb/cache.py: Change debugging note to a debug message
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
X-List-Received-Date: Thu, 06 Feb 2014 22:11:00 -0000

From: Mark Hatle <mark.hatle@windriver.com>

Some apparently debugging was left in in a previous commit.  This caused
bitbake to return a list of bbappends when things changed from the cache.

Make this a proper debug message.

(Bitbake master rev: 1965e5cbdfede18d7b7cb0218e0a5147c3f1c884)

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 1c975b6..ebb6917 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -526,7 +526,7 @@ class Cache(object):
 
         if appends != info_array[0].appends:
             logger.debug(2, "Cache: appends for %s changed", fn)
-            bb.note("%s to %s" % (str(appends), str(info_array[0].appends)))
+            logger.debug(2, "%s to %s" % (str(appends), str(info_array[0].appends)))
             self.remove(fn)
             return False
 
-- 
1.8.5.3


