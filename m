Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0E9126FFCD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Feb 2018 04:44:54 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w1G4itlj026998
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Feb 2018 20:44:55 -0800 (PST)
Received: from dreyna-Precision-T5600.corp.ad.wrs.com (147.11.200.210) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Thu, 15 Feb 2018 20:44:41 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 15 Feb 2018 20:26:02 -0800
Message-ID: <1db9c3b241a7371239ecb7a3bbf5a84868cdd7ef.1518754951.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1518754951.git.David.Reyna@windriver.com>
References: <cover.1518754951.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.200.210]
Subject: [PATCH 2/2] Toaster: fix shutdown and extra threads
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
X-List-Received-Date: Fri, 16 Feb 2018 04:44:55 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Fix typo in shutdown code to kill threads when "kill -0" is not enough.
Use the '--noreload' flag for 'runserver' so that there are no extra
and unaccounted threads.

[YOCTO #12555]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 bin/toaster | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 4036f0a..ed365ee 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -68,7 +68,7 @@ webserverKillAll()
         if [ -f ${pidfile} ]; then
             pid=`cat ${pidfile}`
             while kill -0 $pid 2>/dev/null; do
-                kill -SIGTERM -$pid 2>/dev/null
+                kill -SIGTERM $pid 2>/dev/null
                 sleep 1
             done
             rm  ${pidfile}
@@ -91,7 +91,7 @@ webserverStartAll()
 
     echo "Starting webserver..."
 
-    $MANAGE runserver "$ADDR_PORT" \
+    $MANAGE runserver --noreload "$ADDR_PORT" \
            </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 \
            & echo $! >${BUILDDIR}/.toastermain.pid
 
-- 
2.7.4


