Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 92FA2782A4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 19:30:28 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga105.fm.intel.com with ESMTP; 14 Jun 2017 12:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,341,1493708400"; d="scan'208";a="1141318018"
Received: from jlock-mobl1.ger.corp.intel.com ([10.252.8.228])
	by orsmga001.jf.intel.com with ESMTP; 14 Jun 2017 12:30:28 -0700
From: Joshua Lock <joshua.g.lock@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Jun 2017 20:30:22 +0100
Message-Id: <20170614193022.7163-1-joshua.g.lock@intel.com>
X-Mailer: git-send-email 2.9.4
Subject: [PATCH] fetch: fix handling of files with incorrect checksums from a premirror
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
X-List-Received-Date: Wed, 14 Jun 2017 19:30:29 -0000

Ensure that when an item fetched from a premirror has an invalid checksum the
fetcher falls back to the usual logic of trying the upstream and any configured
mirrors.

Signed-off-by: Joshua Lock <joshua.g.lock@intel.com>
---
 lib/bb/fetch2/__init__.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1f63a04..ec65216 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1621,6 +1621,15 @@ class Fetch(object):
                     logger.debug(1, "Trying PREMIRRORS")
                     mirrors = mirror_from_string(self.d.getVar('PREMIRRORS'))
                     localpath = try_mirrors(self, self.d, ud, mirrors, False)
+                    if localpath:
+                        try:
+                            # early checksum verification so that if the checksum of the premirror
+                            # contents mismatch the fetcher can still try upstream and mirrors
+                            update_stamp(ud, self.d)
+                        except ChecksumError as e:
+                            logger.warning("Checksum failure encountered with premirror download of %s - will attempt other sources." % u)
+                            logger.debug(1, str(e))
+                            localpath = ""
 
                 if premirroronly:
                     self.d.setVar("BB_NO_NETWORK", "1")
-- 
2.9.4


