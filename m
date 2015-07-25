Return-Path: <juro.bystricky@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 9DE7075BD3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 25 Jul 2015 18:36:40 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 25 Jul 2015 11:36:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,542,1432623600"; d="scan'208";a="735450700"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.145])
	by orsmga001.jf.intel.com with ESMTP; 25 Jul 2015 11:36:42 -0700
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 25 Jul 2015 11:32:43 -0700
Message-Id: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: richard.purdie@intel.com
Subject: [PATCH] wget.py: support for semi-colons in URL
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
X-List-Received-Date: Sat, 25 Jul 2015 18:36:44 -0000

Some URLs contain semi-colons. For example, some GIT repositories
support downloading snapshots using URL such as:

"http://abc123.com/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47"

Currently there is no way to construct SRC_URI with such URLs.
Bitbake uses semi-colons in SRC_URI as delimiters for various parameters.

This patch allows using of semi-colons in URLs: ';;' (double semi-colon)
in SRC_URI is processed  as a single semi-colon that is a part of a URL name.
For example, the above URL would become:

SRC_URI = "http://abc123.com/git/?p=gcc/gcc.git;;a=snapshot;;h=a5dd47"

Note that it is not possible to determine the name of the downloaded file
from URL alone. The onus to specify the proper name is on the user,
via the parameter 'downloadfilename':

SRC_URI = "http://abc123.com/git/?p=gcc/gcc.git;;a=snapshot;;h=a5dd47;downloadfilename=myfile.tar.gz"

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 425b6b9..a623b83 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -80,7 +80,21 @@ class Wget(FetchMethod):
             bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.localfile))
             fetchcmd += " -O " + dldir + os.sep + ud.localfile
 
-        uri = ud.url.split(";")[0]
+        # Process any ";;" in SRC_URI, these are escape sequences for ";" in URL
+        if ';;' in ud.url:
+           # If URL contains ';' the name of the downloaded file cannot be derived reliably
+           # (or derived at all) using URL string alone.
+           # Therefore we insist the file name is specified explicitly by the user.
+           if not 'downloadfilename' in ud.parm:
+               raise FetchError("Could not determine the name of the downloaded file. Please specify explicitly by using SRC_URI option 'downloadfilename'")
+
+           # Convert ";;" into something unique (not containing ';')
+           uri = ud.url.replace(";;","%3B%3B");
+           uri = uri.split(";")[0]
+           uri = uri.replace("%3B%3B",";");
+        else:
+           uri = ud.url.split(";")[0]
+
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
             fetchcmd += d.expand(" -c -P ${DL_DIR} '%s'" % uri)
-- 
1.9.1


