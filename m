Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7B4A677ABF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 13:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v2SDS4D6019002; 
	Tue, 28 Mar 2017 14:28:46 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id k6tp_2vPZCw0; Tue, 28 Mar 2017 14:28:46 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2SDSi9n019100
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 28 Mar 2017 14:28:45 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1csrAy-0006Mq-CZ; Tue, 28 Mar 2017 14:28:44 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Mar 2017 14:28:43 +0100
Message-Id: <1490707723-24437-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] fetch2: Ensure we don't have file downloads overwriting each other
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
X-List-Received-Date: Tue, 28 Mar 2017 13:28:50 -0000

Imagine you have an sstate mirror accessed over http and an SSTATE_MIRRORS
which maps file:// urls to http:// urls.

File urls set donestampneeded = False, http urls don't. This can result in
races in the try_mirror_url() code since it will trigger new downloads after
aquiring the lockfile as verify_donestamp() doesn't look at origud and there
is no donestamp.

verify_donestamp() already has code to look at origud, we're just missing
some code at the start of the function to do this. Fix it to avoid
these races.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 464e66b..ea72025 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -625,7 +625,7 @@ def verify_donestamp(ud, d, origud=None):
     Returns True, if the donestamp exists and is valid, False otherwise. When
     returning False, any existing done stamps are removed.
     """
-    if not ud.needdonestamp:
+    if not ud.needdonestamp or (origud and not origud.needdonestamp):
         return True
 
     if not os.path.exists(ud.donestamp):
-- 
2.7.4


