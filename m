Return-Path: <stephano.cetola@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id B5C0B770B4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Aug 2016 17:41:33 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga104.fm.intel.com with ESMTP; 26 Aug 2016 10:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,581,1464678000"; 
   d="scan'208";a="1577672"
Received: from pequod.jf.intel.com ([10.7.201.50])
	by orsmga005.jf.intel.com with ESMTP; 26 Aug 2016 10:41:33 -0700
From: Stephano Cetola <stephano.cetola@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Aug 2016 10:41:43 -0700
Message-Id: <20160826174143.116764-1-stephano.cetola@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH] wget: allow basic http auth for SSTATE_MIRRORS
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
X-List-Received-Date: Fri, 26 Aug 2016 17:41:33 -0000

If http basic auth creds were added to sstate mirrors like so:

https://foo.com/sstate/PATH;user=foo:bar;downloadfilename=PATH

The sstate mirror check would silently fail with 401 unauthorized.
This patch allows both the check, and the wget download to succeed by
checking for user credentials and if present adding the correct
headers, or wget params as needed.

[ YOCTO #9815 ]

Signed-off-by: Stephano Cetola <stephano.cetola@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6b60d9b..ecb946a 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -108,6 +108,10 @@ class Wget(FetchMethod):
             bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.localfile))
             fetchcmd += " -O " + dldir + os.sep + ud.localfile
 
+        if ud.user:
+            up = ud.user.split(":")
+            fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (up[0],up[1])
+
         uri = ud.url.split(";")[0]
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
@@ -300,6 +304,13 @@ class Wget(FetchMethod):
             uri = ud.url.split(";")[0]
             r = urllib.request.Request(uri)
             r.get_method = lambda: "HEAD"
+
+            if ud.user:
+                import base64
+                encodeuser = base64.b64encode(ud.user.encode('utf-8')).decode("utf-8")
+                authheader =  "Basic %s" % encodeuser
+                r.add_header("Authorization", authheader)
+
             opener.open(r)
         except urllib.error.URLError as e:
             if try_again:
-- 
2.9.3


