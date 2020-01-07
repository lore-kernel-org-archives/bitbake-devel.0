Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by mail.openembedded.org (Postfix) with ESMTP id E576C7FC9A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2020 22:09:00 +0000 (UTC)
IronPort-SDR: YcaT3fZdLIjKFOSOGopPe1jSxSD5GpMFgjAb4VMsvoUOa0wmxBb3rcDl8zctGv8jfQ9xxouwo3
	2pCgMqy4RveD1py3UiuPkPNVaFCFnVrnc5EM8lva53aoaLqoEsmsJf/nDpk5kRVx5spf7mlSWy
	L5U4F6T+lO6e9Or9inBgxfF3qIcMC0cm/IF3vIo2jguf2WUjJG2iIGAy0Hz7GIpCqw9IawrlZk
	4vMYhGkY9tAvy+TTqSvYuKH1eM65+mNUaerdGKIA2ND9v5VS3wX8p3eNTdd/mRb4UNTcdKwNE7
	RMI=
X-IronPort-AV: E=Sophos;i="5.69,407,1571695200"; 
   d="scan'208";a="4156466"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Jan 2020 23:08:58 +0100
Message-Id: <20200107220858.18057-2-pkj@axis.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200107220858.18057-1-pkj@axis.com>
References: <20200107220858.18057-1-pkj@axis.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: [master][zeus][warrior][PATCHv2 2/2] cooker: Ignore notifications for all .lock and .log files
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
X-List-Received-Date: Tue, 07 Jan 2020 22:09:02 -0000
Content-Transfer-Encoding: 8bit

Previously bitbake-cookerdaemon.log and bitbake.lock were ignored, but
this can be generalized to all .lock and .log files.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/cooker.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index b74affa7ec..a6c78990d0 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -267,8 +267,7 @@ class BBCooker:
             self.parsecache_valid = False
             bb.parse.clear_cache()
             return
-        if event.pathname.endswith("bitbake-cookerdaemon.log") \
-                or event.pathname.endswith("bitbake.lock"):
+        if event.pathname.endswith((".lock", ".log")):
             return
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
-- 
2.21.1


