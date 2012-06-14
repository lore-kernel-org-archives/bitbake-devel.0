Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1Sf0bf-0006Ce-2t
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 05:20:23 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5E39jUE018438
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jun 2012 20:09:46 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 13 Jun 2012 20:09:45 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 13 Jun 2012 22:09:39 -0500
Message-ID: <1339643381-23026-3-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339643381-23026-1-git-send-email-jason.wessel@windriver.com>
References: <1339643381-23026-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/4] fetch2: Fix URI encode / decode regression
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
X-List-Received-Date: Thu, 14 Jun 2012 03:20:23 -0000
Content-Type: text/plain

The commit 420eb112a4f (fetch2: quote/unquote url paths) caused a
regression on Ubuntu 11.10's default python.

The problem is a result of the uri_replace() returning an encoded uri
and the local.py's localpath() routine not decoding the uri before
executing the local checks.

The problem was found using an updated version of the screen patches where there is a local copy of the download.  Example:

| DEBUG: For url ftp://ftp.debian.org/debian/pool/main/s/screen/screen_4.0.3-11+lenny1.diff.gz;name=patch returning file:///opt/dl/downloads/screen_4.0.3-11%2Blenny1.diff.gz;name=patch

The %2B was not getting decoded by the localpath() routine.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/fetch2/local.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index a0ed444..fdbd9fc 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -43,10 +43,12 @@ class Local(FetchMethod):
         ud.basename = os.path.basename(ud.url.split("://")[1].split(";")[0])
         return
 
-    def localpath(self, url, urldata, d):
+    def localpath(self, tryurl, urldata, d):
         """
         Return the local filename of a given url assuming a successful fetch.
         """
+        import urllib;
+        url = urllib.unquote(tryurl)
         path = url.split("://")[1]
         path = path.split(";")[0]
         newpath = path
-- 
1.7.10



