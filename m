Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id BDF597DDCC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2019 07:10:10 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x7M7ABuM010745
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2019 00:10:11 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Thu, 22 Aug 2019 00:10:10 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 22 Aug 2019 15:35:38 +0800
Message-ID: <3562c905fd50bb986aba8a40778245a026339c93.1566459309.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1566459309.git.liezhi.yang@windriver.com>
References: <cover.1566459309.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: cooker: Kill alive process before join it
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
X-List-Received-Date: Thu, 22 Aug 2019 07:10:10 -0000
Content-Type: text/plain

Fixed:
$ echo helloworld >> meta/recipes-extended/bash/bash_4.4.18.bb
$ while true; do kill-bb; rm -fr bitbake-cookerdaemon.log tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat* ; bitbake -p; done

It may hang in 10 mins, there are two problems:
* There might be deadlocks when call process.join() if the queue is not NULL,
  so we need cleanup the queue before join() it, but:
* The self.result_queue.get(timeout=0.25) may hang if the queue._wlock is hold
  by SomeOtherProcess, the queue has the following info when it hangs:
  '_wlock': <Lock(owner=SomeOtherProcess)>, so that we may can't clean up the
  queue.

We can kill alvie process before join it to fix the problems.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0607fcc..e42bcba 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -2082,19 +2082,15 @@ class CookerParser(object):
             for process in self.processes:
                 self.parser_quit.put(None)
 
-        # Cleanup the queue before call process.join(), otherwise there might be
-        # deadlocks.
-        while True:
-            try:
-               self.result_queue.get(timeout=0.25)
-            except queue.Empty:
-                break
-
         for process in self.processes:
             if force:
                 process.join(.1)
                 process.terminate()
             else:
+                # Kill the alive process firstly before join() it to avoid
+                # deadlocks
+                if process.is_alive():
+                    os.kill(process.pid, 9)
                 process.join()
 
         sync = threading.Thread(target=self.bb_cache.sync)
-- 
2.7.4


