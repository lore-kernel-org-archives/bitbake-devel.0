Return-Path: <olof.johansson@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8E7646E377
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 16:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 91FE613D22
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id B8qfHyITKTwE for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id 7C15F3F215F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 63F95B4A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 571D7937
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 55E053E06F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Thu, 12 Dec 2013
	17:48:59 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 2C82F9C075; 
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Dec 2013 17:48:58 +0100
Message-ID: <1386866938-5932-6-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
References: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [RFC 5/5] bb.fetch2.git: use the _gen_git_url() function
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
X-List-Received-Date: Thu, 12 Dec 2013 16:49:00 -0000
Content-Type: text/plain

Don't generate the url in several places.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/git.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index c01c82b..bc792e6 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -166,11 +166,6 @@ class Git(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
-        if ud.user:
-            username = ud.user + '@'
-        else:
-            username = ""
-
         ud.repochanged = not os.path.exists(ud.fullmirror)
 
         # If the checkout doesn't exist and the mirror tarball does, extract it
@@ -179,7 +174,7 @@ class Git(FetchMethod):
             os.chdir(ud.clonedir)
             runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
 
-        repourl = "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
+        repourl = self._gen_git_url(ud, d)
 
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
-- 
1.8.4.rc3


