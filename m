Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8155174175
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 17:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4FGxitK024908 for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 18:01:02 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xUcuvBxfd9_U for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 18:01:02 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4FH0ngO024955
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 18:01:00 +0100
Message-ID: <1431709249.18723.23.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 15 May 2015 18:00:49 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Improve mirror building function error handling
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
X-List-Received-Date: Fri, 15 May 2015 17:01:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

First, when building mirror urls we don't do any fetching so we should never
be calling clean functions.

Currently, if a mirror url fails, we don't process it further to see
if there are any mirrors of the mirror.

We should do this even when the mirror url fails, else we may miss out
on valid/useful mappings, particularly in the case of file:// urls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 0e76408..73f73fd 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -901,7 +901,9 @@ def build_mirroruris(origud, mirrors, ld):
                 logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
                 logger.debug(1, str(e))
                 try:
-                    ud.method.clean(ud, ld)
+                    # setup_localpath of file:// urls may fail, we should still see 
+                    # if mirrors of the url exist
+                    adduri(newud, uris, uds)
                 except UnboundLocalError:
                     pass
                 continue   



