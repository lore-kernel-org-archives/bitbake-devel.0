Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 3D6F265E99
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Apr 2014 16:35:55 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 10 Apr 2014 09:35:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,835,1389772800"; d="scan'208";a="518446359"
Received: from pbrannig-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.121.73])
	by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2014 09:35:55 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Apr 2014 17:35:40 +0100
Message-Id: <4fbfa1880e3a5f791d98f54710323f2db9463358.1397147607.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1397147607.git.paul.eggleton@linux.intel.com>
References: <cover.1397147607.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1397147607.git.paul.eggleton@linux.intel.com>
References: <cover.1397147607.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] cache: don't trigger reparse on recipes with wildcards in SRC_URI
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
X-List-Received-Date: Thu, 10 Apr 2014 16:35:55 -0000

Since we now get wildcards in the file checksum list in the cache, we
need to ignore them when checking to see if they still exist. This
fixes connman-gnome reparsing on every bitbake execution in OE-Core.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 318781b..431fc07 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -527,7 +527,7 @@ class Cache(object):
         if hasattr(info_array[0], 'file_checksums'):
             for _, fl in info_array[0].file_checksums.items():
                 for f in fl.split():
-                    if not os.path.exists(f):
+                    if not ('*' in f or os.path.exists(f)):
                         logger.debug(2, "Cache: %s's file checksum list file %s was removed",
                                         fn, f)
                         self.remove(fn)
-- 
1.9.0


