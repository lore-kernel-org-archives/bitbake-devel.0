Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristian.iorga@intel.com>) id 1TaSJo-0003Hz-Jq
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Nov 2012 15:27:25 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 19 Nov 2012 06:13:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,279,1352102400"; d="scan'208";a="219688147"
Received: from sentry (HELO localhost.localdomain) ([10.237.105.157])
	by azsmga001.ch.intel.com with ESMTP; 19 Nov 2012 06:12:58 -0800
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Nov 2012 16:13:12 +0200
Message-Id: <1353334392-7949-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] bitbake: Network test timeouts reduced
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
X-List-Received-Date: Mon, 19 Nov 2012 14:27:25 -0000

Network timeouts affecting wget
connectivity test are reduced,
so that Hob network test will fail faster.

Fixes [YOCTO #3248]

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 bitbake/lib/bb/fetch2/wget.py |    2 +-
 meta/conf/bitbake.conf        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index ea99198..1b5bce0 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -63,7 +63,7 @@ class Wget(FetchMethod):
     def download(self, uri, ud, d, checkonly = False):
         """Fetch urls"""
 
-        basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
+        basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 5 -nv --passive-ftp --no-check-certificate"
 
         if 'downloadfilename' in ud.parm:
             basecmd += " -O ${DL_DIR}/" + ud.localfile
diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index cf779a4..b5dd2d8 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -588,7 +588,7 @@ XORG_MIRROR = "http://xorg.freedesktop.org/releases"
 
 FETCHCMD_svn = "/usr/bin/env svn --non-interactive --trust-server-cert"
 FETCHCMD_cvs = "/usr/bin/env cvs"
-FETCHCMD_wget = "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
+FETCHCMD_wget = "/usr/bin/env wget -t 2 -T 5 -nv --passive-ftp --no-check-certificate"
 FETCHCMD_bzr = "/usr/bin/env bzr"
 FETCHCMD_hg = "/usr/bin/env hg"
 
-- 
1.7.10.4



