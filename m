Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5BAEA74744
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 May 2018 03:31:59 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w4T3W02c020715
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 May 2018 20:32:00 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Mon, 28 May 2018 20:32:00 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 28 May 2018 20:26:58 -0700
Message-ID: <397f9de78131780edca5166f24afae425a376707.1527564213.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1527564213.git.David.Reyna@windriver.com>
References: <cover.1527564213.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 2/2] bitbake: Toaster: fix shutdown and extra threads
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
X-List-Received-Date: Tue, 29 May 2018 03:31:59 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Fix typo in shutdown code to kill threads when "kill -0" is not enough.
Use the '--noreload' flag for 'runserver' so that there are no extra
and unaccounted threads.

[YOCTO #12555]

(Bitbake rev: 256990943075e89cb9aee2bc6488344b6783e07b)

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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
1.9.1


