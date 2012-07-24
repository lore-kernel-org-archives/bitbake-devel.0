Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1StZLU-00063i-TU
	for bitbake-devel@lists.openembedded.org;
	Tue, 24 Jul 2012 09:15:53 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q6O74Mtl026538
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 24 Jul 2012 00:04:22 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Tue, 24 Jul 2012 00:04:22 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Tue, 24 Jul 2012 15:04:14 +0800
Message-ID: <cb139de49946bb1ae88ccffa25d78996ce7d0184.1343113295.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1343113295.git.kai.kang@windriver.com>
References: <cover.1343113295.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/2] monitordisk: update return value
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
X-List-Received-Date: Tue, 24 Jul 2012 07:15:53 -0000
Content-Type: text/plain

update function check()'s return value of class diskMonitor. When
runqueue is terminated by disk monitor, cooker has a chance to deal this
situation accordingly.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/monitordisk.py |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index 9469193..ac6f9be 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
@@ -200,7 +200,11 @@ class diskMonitor:
 
     def check(self, rq):
 
-        """ Take action for the monitor """
+        """
+        Take action for the monitor.
+        Return True to tell cooker that runqueue is terminated by disk monitor.
+        This return value is useful for UIs such as Hob.
+        """
 
         if self.enableMonitor:
             for dev in self.devDict:
@@ -219,10 +223,12 @@ class diskMonitor:
                         logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(False)
+                        return True
                     elif self.devDict[dev][0] == "ABORT" and not self.checked[dev]:
                         logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(True)
+                        return True
 
                 # The free inodes, float point number
                 freeInode = st.f_favail
@@ -237,8 +243,10 @@ class diskMonitor:
                         logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(False)
+                        return True
                     elif self.devDict[dev][0]  == "ABORT" and not self.checked[dev]:
                         logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(True)
-        return
+                        return True
+        return False
-- 
1.7.5.4



