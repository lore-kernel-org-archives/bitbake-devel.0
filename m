Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4B84377DE7
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Aug 2017 22:48:57 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v79MmuYG031946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 9 Aug 2017 23:48:57 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dfZma-0007SM-10; Wed, 09 Aug 2017 23:48:56 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Aug 2017 23:48:55 +0100
Message-Id: <1502318935-28608-4-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1502318935-28608-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1502318935-28608-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Wed, 09 Aug 2017 23:48:57 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 4/4] cooker: Ignore common bitbake files for the parse cache invalidation
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
X-List-Received-Date: Wed, 09 Aug 2017 22:48:59 -0000

Writes to the cookerdaemon log and/or the lockfile were meaning the parser
cache was always being invalidated and reparsed. This is unnecessary so
spot accesses to these two common cases and ignore the files from a reparse
perspective.

This doesn't remove many sources of reparse but does improve several
common cases.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b3d6cd9..db034b9 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -263,6 +263,9 @@ class BBCooker:
             self.parsecache_valid = False
             bb.parse.clear_cache()
             return
+        if event.pathname.endswith("bitbake-cookerdaemon.log") \
+                or event.pathname.endswith("bitbake.lock"):
+            return
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
         self.parsecache_valid = False
-- 
2.7.4


