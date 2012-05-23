Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SXAOd-0004ke-SR
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 14:10:32 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4N9e5fx027464
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 23 May 2012 02:40:05 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Wed, 23 May 2012 02:40:04 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 23 May 2012 17:40:19 +0800
Message-ID: <dac2367a09e77d0230e8c2e625484336533ea50e.1337764882.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1337764882.git.kai.kang@windriver.com>
References: <cover.1337764882.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] cooker.py: terminate the Parser processes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 23 May 2012 12:10:32 -0000
Content-Type: text/plain

[Yocto 2142]

Force to exit HOB when hob is parsing recipes, the bitbake doesn't stop.
It hangs on function BitBakeServerConnection::terminate in file
server/process.py:
    else:
        self.procserver.join()
It is waiting for the children process quit.

In stage of parse recipes BBCooker spawns Parser processes as many as
cpu numbers. When quit the Parser processes they make their internal
Queue to call cancel_join_thread() to avoid block but don't work at
this time.
So force to terminate the Parser processes.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/cooker.py |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index dea0aad..4a4dc38 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1175,7 +1175,7 @@ class BBCooker:
             return
 
         if self.state in (state.shutdown, state.stop):
-            self.parser.shutdown(clean=False)
+            self.parser.shutdown(clean=False, force = True)
             sys.exit(1)
 
         if self.state != state.parsing:
@@ -1608,10 +1608,13 @@ class CookerParser(object):
                 self.parser_quit.put(None)
 
             self.jobs.cancel_join_thread()
-            sys.exit(1)
 
         for process in self.processes:
-            process.join()
+            if force:
+                process.join(.1)
+                process.terminate()
+            else:
+                process.join()
         self.feeder.join()
 
         sync = threading.Thread(target=self.bb_cache.sync)
-- 
1.7.5.4



