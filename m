Return-Path: <maxin.john@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id ACF9260721
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jul 2016 08:24:11 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 29 Jul 2016 01:24:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,438,1464678000"; d="scan'208";a="1031368505"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga002.fm.intel.com with ESMTP; 29 Jul 2016 01:24:12 -0700
Received: from mbabyjoh-desk.fi.intel.com (mbabyjoh-desk.fi.intel.com
	[10.237.72.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id 1A3026A4080
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jul 2016 01:23:59 -0700 (PDT)
From: "Maxin B. John" <maxin.john@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 29 Jul 2016 11:23:35 +0300
Message-Id: <1469780615-1657-1-git-send-email-maxin.john@intel.com>
X-Mailer: git-send-email 2.4.0
Subject: [RFC][PATCH] bitbake: fetch2: fix warning while switching from master to krogoth
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
X-List-Received-Date: Fri, 29 Jul 2016 08:24:13 -0000

While switching from master to krogoth build with a common download directory,
got a large number of warnings like the one listed below:

WARNING: freetype-2.6.3-r0 do_fetch: Couldn't load checksums from
donestamp /home/maxin/downloads/freetype-2.6.3.tar.bz2.done: ValueError
(msg: unsupported pickle protocol: 4)

These warnings are caused by the difference in pickle module
implementation in python3(master) and python2(krogoth). Python2 supports
3 different protocols (0, 1, 2) and pickle.HIGHEST_PROTOCOL is 2 where as
Python3 supports 5 different protocols (0, 1, 2, 3, 4) and
pickle.HIGHEST_PROTOCOL is obviously 4.

My suggestion is to use 2 since it is backward compatible with python2
(all the supported distros for krogoth provides python2 which supports
pickle protocol version 2)

Signed-off-by: Maxin B. John <maxin.john@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 3eabba1..9054b2e 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -664,7 +664,7 @@ def verify_donestamp(ud, d, origud=None):
         # as an upgrade path from the previous done stamp file format.
         if checksums != precomputed_checksums:
             with open(ud.donestamp, "wb") as cachefile:
-                p = pickle.Pickler(cachefile, pickle.HIGHEST_PROTOCOL)
+                p = pickle.Pickler(cachefile, 2)
                 p.dump(checksums)
         return True
     except ChecksumError as e:
@@ -698,7 +698,7 @@ def update_stamp(ud, d):
             checksums = verify_checksum(ud, d)
             # Store the checksums for later re-verification against the recipe
             with open(ud.donestamp, "wb") as cachefile:
-                p = pickle.Pickler(cachefile, pickle.HIGHEST_PROTOCOL)
+                p = pickle.Pickler(cachefile, 2)
                 p.dump(checksums)
         except ChecksumError as e:
             # Checksums failed to verify, trigger re-download and remove the
-- 
2.4.0


