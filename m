Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 64D2960E97
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 14:48:59 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 20 Dec 2013 06:49:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,521,1384329600"; d="scan'208";a="453335471"
Received: from dsgunati-mobl.gar.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.122.40])
	by fmsmga002.fm.intel.com with ESMTP; 20 Dec 2013 06:48:59 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Dec 2013 14:48:44 +0000
Message-Id: <18b297060236ed036009c19114cc90725e50b680.1387550848.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1387550848.git.paul.eggleton@linux.intel.com>
References: <cover.1387550848.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1387550848.git.paul.eggleton@linux.intel.com>
References: <cover.1387550848.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] fetch2: fail checksum validation if SRC_URI checksums set to ""
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
X-List-Received-Date: Fri, 20 Dec 2013 14:49:00 -0000

We were checking SRC_URI md5sum/sha256sum values against None here, so
if they were set to "" then no error was produced. Since the value is
still effectively unset in this case, this is not the right behaviour;
just check if the value doesn't evaluate to False instead.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 199cdca..6c6915c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -526,19 +526,19 @@ def verify_checksum(ud, d):
     if ud.method.recommends_checksum(ud):
         # If strict checking enabled and neither sum defined, raise error
         strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
-        if (strict and ud.md5_expected == None and ud.sha256_expected == None):
+        if strict and not (ud.md5_expected or ud.sha256_expected):
             raise NoChecksumError('No checksum specified for %s, please add at least one to the recipe:\n'
                              'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
                              (ud.localpath, ud.md5_name, md5data,
                               ud.sha256_name, sha256data), ud.url)
 
         # Log missing sums so user can more easily add them
-        if ud.md5_expected == None:
+        if not ud.md5_expected:
             logger.warn('Missing md5 SRC_URI checksum for %s, consider adding to the recipe:\n'
                         'SRC_URI[%s] = "%s"',
                         ud.localpath, ud.md5_name, md5data)
 
-        if ud.sha256_expected == None:
+        if not ud.sha256_expected:
             logger.warn('Missing sha256 SRC_URI checksum for %s, consider adding to the recipe:\n'
                         'SRC_URI[%s] = "%s"',
                         ud.localpath, ud.sha256_name, sha256data)
-- 
1.8.1.2


