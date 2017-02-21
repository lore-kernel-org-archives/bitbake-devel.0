Return-Path: <alexander.kanavin@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 171AB71E14
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 11:37:36 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Feb 2017 03:37:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,189,1484035200"; d="scan'208";a="227880407"
Received: from kanavin-desktop.fi.intel.com (HELO
	kanavin-desktop.fi.intel.comfi.intel.com) ([10.237.68.161])
	by fmsmga004.fm.intel.com with ESMTP; 21 Feb 2017 03:37:36 -0800
From: Alexander Kanavin <alexander.kanavin@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Feb 2017 13:36:42 +0200
Message-Id: <20170221113642.27744-1-alexander.kanavin@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] wget.py: match .lz tarballs as well when determining latest version
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
X-List-Received-Date: Tue, 21 Feb 2017 11:37:37 -0000

Signed-off-by: Alexander Kanavin <alexander.kanavin@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 737b98dd032..1cc445a4263 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -547,7 +547,7 @@ class Wget(FetchMethod):
 
         # src.rpm extension was added only for rpm package. Can be removed if the rpm
         # packaged will always be considered as having to be manually upgraded
-        psuffix_regex = "(tar\.gz|tgz|tar\.bz2|zip|xz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
+        psuffix_regex = "(tar\.gz|tgz|tar\.bz2|zip|xz|tar\.lz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
 
         # match name, version and archive type of a package
         package_regex_comp = re.compile("(?P<name>%s?\.?v?)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s$)"
-- 
2.11.0


