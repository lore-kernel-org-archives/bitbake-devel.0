Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id BA4BC7F475
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Aug 2019 09:25:52 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x779PMPB010335
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 7 Aug 2019 02:25:44 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Wed, 7 Aug 2019 02:25:32 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 7 Aug 2019 17:50:48 +0800
Message-ID: <f630d2cf1fd22078ff18498ef2670e18af4ae217.1565171270.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1565171270.git.liezhi.yang@windriver.com>
References: <cover.1565171270.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] cooker: Cleanup the queue before call process.join()
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
X-List-Received-Date: Wed, 07 Aug 2019 09:25:53 -0000
Content-Type: text/plain

Fixed:
$ rm -fr tmp-glibc/cache/default-glibc/qemux86/x86_64/bb_cache.dat* ; bitbake -p
Press *one* Ctrl-C when the parsing process is at about 50%, then the processes
are not exited:

Keyboard Interrupt, closing down...

Timeout while waiting for a reply from the bitbake server

It hangs at process.join(), according to:

https://docs.python.org/3.7/library/multiprocessing.html

Cleanup the queue before call process.join() can fix the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 6e1d59b..ec1b35d 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -2077,6 +2077,14 @@ class CookerParser(object):
             for process in self.processes:
                 self.parser_quit.put(None)
 
+        # Cleanup the queue before call process.join(), otherwise there might be
+        # deadlocks.
+        while True:
+            try:
+               self.result_queue.get(timeout=0.25)
+            except queue.Empty:
+                break
+
         for process in self.processes:
             if force:
                 process.join(.1)
-- 
2.7.4


