Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0607F6011A
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Jan 2016 13:18:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u07DItAV025450
	for <bitbake-devel@lists.openembedded.org>; Thu, 7 Jan 2016 13:18:55 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2aZHFOVFOfkg for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Jan 2016 13:18:55 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u07DIqem025434
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 7 Jan 2016 13:18:53 GMT
Message-ID: <1452172732.7598.114.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 07 Jan 2016 13:18:52 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] fetch/git: Change to use clearer ssh url syntax for broken servers
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
X-List-Received-Date: Thu, 07 Jan 2016 13:18:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Some servers, e.g. bitbucket.org can't cope with ssh:// as part of
the git url syntax. git itself is happy enough with this but you
get server side errors when using it.

This changes the git fetcher to use the more common ssh url format
which also means we need a : before the path.

Seems a shame to have to do this due to broken servers however
it should be safe enough since this other form is the one most people
use on the commandline so it should be safe enough.

[YOCTO #8864]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 5ffab22..10ba1d3 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -330,6 +330,10 @@ class Git(FetchMethod):
             username = ud.user + '@'
         else:
             username = ""
+        if ud.proto == "ssh":
+            # Some servers, e.g. bitbucket.org can't cope with ssh://
+            # and removing that means we need a : before path.
+            return "%s%s:%s" % (username, ud.host, ud.path)
         return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
 
     def _revision_key(self, ud, d, name):



