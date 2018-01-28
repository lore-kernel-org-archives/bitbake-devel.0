Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8A1EA786C4
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 28 Jan 2018 11:21:52 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w0SBLoRX025257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sun, 28 Jan 2018 11:21:51 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1efl1y-0002bN-Ae; Sun, 28 Jan 2018 11:21:50 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 28 Jan 2018 11:21:48 +0000
Message-Id: <1517138508-9957-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517138508-9957-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1517138508-9957-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/2] fetch/git: Add pack-refs command to mirror handling code
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
X-List-Received-Date: Sun, 28 Jan 2018 11:21:53 -0000

We've noticed issues on our infrastucture iterating over the many
tag/branch/head reference files that some git repositories may contain.

By issuing the pack-refs command, we move these all to a single file
which speeds up operations with the mirror repos in the downloads
directory in general.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5ef8cd6..d34ea1d 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -363,6 +363,7 @@ class Git(FetchMethod):
             progresshandler = GitProgressHandler(d)
             runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir)
             runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
+            runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdir=ud.clonedir)
             runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d, workdir=ud.clonedir)
             try:
                 os.unlink(ud.fullmirror)
-- 
2.7.4


