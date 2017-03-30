Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B933477D05
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Mar 2017 10:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v2UAiwNL010634; 
	Thu, 30 Mar 2017 11:44:58 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qi9Nmu48RrJe; Thu, 30 Mar 2017 11:44:58 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2UAitp2010631
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Mar 2017 11:44:56 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1ctXZX-0006LS-CL; Thu, 30 Mar 2017 11:44:55 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Mar 2017 11:44:54 +0100
Message-Id: <1490870694-24350-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] wget: Fix handling of urls with user/password
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
X-List-Received-Date: Thu, 30 Mar 2017 10:44:59 -0000

URL decoding was improved in the core a while ago and this looks like
a leftover from those times which caused urls needing a user/password to
fail. Use the parameters from the core instead of the broken split
implementation.

[YOCTO #11262]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 0c61dfa..ae0ffa8 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -107,9 +107,8 @@ class Wget(FetchMethod):
             bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.localfile))
             fetchcmd += " -O " + dldir + os.sep + ud.localfile
 
-        if ud.user:
-            up = ud.user.split(":")
-            fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (up[0],up[1])
+        if ud.user and ud.pswd:
+            fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (ud.user, ud.pswd)
 
         uri = ud.url.split(";")[0]
         if os.path.exists(ud.localpath):
-- 
2.7.4


