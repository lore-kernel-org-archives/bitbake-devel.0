Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <nitin.a.kamble@intel.com>) id 1Ss1S2-0005hU-2b
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jul 2012 02:52:14 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 19 Jul 2012 17:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="168720807"
Received: from yocto-hm1.jf.intel.com ([10.23.232.32])
	by orsmga001.jf.intel.com with ESMTP; 19 Jul 2012 17:39:46 -0700
From: nitin.a.kamble@intel.com
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Jul 2012 17:39:18 -0700
Message-Id: <6af334f77b2e8bdbcc536fe777c57e4ac646f71b.1342635547.git.nitin.a.kamble@intel.com>
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1342635547.git.nitin.a.kamble@intel.com>
References: <cover.1342635547.git.nitin.a.kamble@intel.com>
X-Mailman-Approved-At: Fri, 20 Jul 2012 11:07:59 +0200
Subject: [PATCH 1/1] bitbake wget fetcher: add parameter: downloadfilename
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
X-List-Received-Date: Fri, 20 Jul 2012 00:52:14 -0000

From: Nitin A Kamble <nitin.a.kamble@intel.com>

this allows wget fetcher to store the downloaded file in a specified custom filename in ${DL_DIR}

Exmaple:
SRC_URI = "https://edc.intel.com/Download.aspx?id=6190;downloadfilename=LIN_IEMGD_1_14_GOLD_2443.tgz"

This fixes bug:
[YOCTO #2570]

Signed-off-by: Nitin A Kamble <nitin.a.kamble@intel.com>
---
 bitbake/lib/bb/fetch2/wget.py |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index b784afb..9affa0d 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -50,7 +50,11 @@ class Wget(FetchMethod):
 
     def urldata_init(self, ud, d):
 
-        ud.basename = os.path.basename(ud.path)
+        if 'downloadfilename' in ud.parm:
+            ud.basename = ud.parm['downloadfilename']
+        else:
+            ud.basename = os.path.basename(ud.path)
+
         ud.localfile = data.expand(urllib.unquote(ud.basename), d)
 
     def download(self, uri, ud, d, checkonly = False):
@@ -58,6 +62,9 @@ class Wget(FetchMethod):
 
         basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
 
+        if 'downloadfilename' in ud.parm:
+            basecmd += " -O ${DL_DIR}/" + ud.localfile
+
         if checkonly:
             fetchcmd = d.getVar("CHECKCOMMAND_wget", True) or d.expand(basecmd + " -c -P ${DL_DIR} '${URI}'")
         elif os.path.exists(ud.localpath):
-- 
1.7.3.4



