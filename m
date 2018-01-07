Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A42787884F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  7 Jan 2018 12:06:04 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w07C61Tg014494
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sun, 7 Jan 2018 12:06:02 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1eY9iD-000776-3J; Sun, 07 Jan 2018 12:06:01 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  7 Jan 2018 12:05:58 +0000
Message-Id: <1515326759-27305-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/2] tests/fetch: Allow bit/bitbake-selftest to function correctly
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
X-List-Received-Date: Sun, 07 Jan 2018 12:06:06 -0000

Without this the paths to git-make-shallow are incorrect and cause test
failures if bitbake isn't executed from cwd or PATH.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 7d7c5d7..11698f2 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -874,7 +874,7 @@ class FetchCheckStatusTest(FetcherTest):
 
 
 class GitMakeShallowTest(FetcherTest):
-    bitbake_dir = os.path.join(os.path.dirname(os.path.join(__file__)), '..', '..', '..')
+    bitbake_dir = os.path.join(os.path.dirname(os.path.join(os.path.abspath(__file__))), '..', '..', '..')
     make_shallow_path = os.path.join(bitbake_dir, 'bin', 'git-make-shallow')
 
     def setUp(self):
-- 
2.7.4


