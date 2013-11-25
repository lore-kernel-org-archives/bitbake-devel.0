Return-Path: <jason.wessel@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5B50F6D2F8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 21:21:35 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rAPLLY8p013095
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 13:21:34 -0800 (PST)
Received: from ord-jrw.corp.ad.wrs.com (172.25.32.36) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.2.347.0; Mon, 25 Nov 2013 13:21:35 -0800
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Nov 2013 15:21:28 -0600
Message-ID: <1385414489-2901-5-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1385414489-2901-1-git-send-email-jason.wessel@windriver.com>
References: <1385414489-2901-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 4/5] oe-init-build-env: Allow startup with and without memres
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
X-List-Received-Date: Mon, 25 Nov 2013 21:21:35 -0000
Content-Type: text/plain

Use the bitbake --status-only and the fact that bitbake.lock will
contain the host name and port to determine when to activate or
shutdown the stay resident bitbake server.

This allows a end developer to cleanly switch between the two ways to
use bitbake as well as enter the memres bitbake server from multiple
shells without starting the server if it is already running.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 oe-init-build-env        |    9 +++++++++
 oe-init-build-env-memres |   21 ++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/oe-init-build-env b/oe-init-build-env
index de9692f..8ef32f3 100755
--- a/oe-init-build-env
+++ b/oe-init-build-env
@@ -47,3 +47,12 @@ else
    unset BBPATH
 fi
 
+# Shutdown any bitbake server if the BBSERVER variable is not set
+if [ -z "$BBSERVER" ] && [ -f bitbake.lock ] ; then
+    grep ":" bitbake.lock > /dev/null && BBSERVER=`cat bitbake.lock` bitbake --status-only
+    if [ $? = 0 ] ; then
+	echo "Shutting down bitbake memory resident server with bitbake -m"
+	BBSERVER=`cat bitbake.lock` bitbake -m
+    fi
+fi
+
diff --git a/oe-init-build-env-memres b/oe-init-build-env-memres
index 79b91b7..687d5e1 100755
--- a/oe-init-build-env-memres
+++ b/oe-init-build-env-memres
@@ -54,6 +54,21 @@ else
    unset OEROOT
    unset BBPATH
 fi
-bitbake --server-only -t xmlrpc -B localhost:$port
-export BBSERVER=localhost:$port
-echo "Bitbake server started on port $port, use bitbake -m to shut it down"
+res=1
+if [ -e bitbake.lock ] && grep : bitbake.lock > /dev/null ; then
+    BBSERVER=`cat bitbake.lock` bitbake --status-only
+    res=$?
+fi
+
+if [ $res != 0 ] ; then
+    bitbake --server-only -t xmlrpc -B localhost:$port
+fi
+
+export BBSERVER=`cat bitbake.lock`
+
+if [ $res = 0 ] ; then
+    echo "Using existing bitbake server at: $BBSERVER, use bitbake -m to shut it down"
+else
+    echo "Bitbake server started at: $BBSERVER, use bitbake -m to shut it down"
+fi
+unset res
-- 
1.7.9.5


