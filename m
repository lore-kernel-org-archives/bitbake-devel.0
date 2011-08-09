Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ke.yu@intel.com>) id 1QqiNb-0007on-JR
	for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 11:13:43 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 09 Aug 2011 02:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,342,1309762800"; d="scan'208";a="37232508"
Received: from kyu3-dev32.bj.intel.com (HELO localhost) ([10.238.153.157])
	by fmsmga002.fm.intel.com with ESMTP; 09 Aug 2011 02:09:13 -0700
From: Yu Ke <ke.yu@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Tue,  9 Aug 2011 17:17:00 +0800
Message-Id: <4c2fb51bccffc783352bb7f261a527caebcaed39.1312881309.git.ke.yu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1312881309.git.ke.yu@intel.com>
References: <cover.1312881309.git.ke.yu@intel.com>
In-Reply-To: <cover.1312881309.git.ke.yu@intel.com>
References: <cover.1312881309.git.ke.yu@intel.com>
Subject: [PATCH 1/1] fetcher2: show warning message when checksum is mismatch
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
X-List-Received-Date: Tue, 09 Aug 2011 09:13:43 -0000

Currently, if checksum mismatch, fetcher will try mirror,
and if mirror fetching fail, it will show error "Unable
to fetch URL xxx from from any source" which actually
hide the real reason and make user confuse.

so showing warning message will make it more clear.

Fix [YOCTO #1256]

Signed-off-by: Yu Ke <ke.yu@intel.com>
---
 lib/bb/fetch2/__init__.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9cfa3de..b691cbc 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -937,7 +937,7 @@ class Fetch(object):
                         raise
 
                     except BBFetchException as e:
-                        logger.debug(1, str(e))
+                        logger.warn(str(e))
                         # Remove any incomplete fetch
                         if os.path.isfile(ud.localpath):
                             bb.utils.remove(ud.localpath)
-- 
1.7.0.4



