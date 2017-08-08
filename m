Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id EEE7171996
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Aug 2017 09:12:15 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v789CHVr024755
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Aug 2017 02:12:17 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.361.1;
	Tue, 8 Aug 2017 02:12:16 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 8 Aug 2017 02:12:09 -0700
Message-ID: <53074458ae150fc7544b02f5c3e37ff49257cb27.1502183410.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1502183410.git.liezhi.yang@windriver.com>
References: <cover.1502183410.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [WIP][RFC PATCH 5/5] bitbake: main: make observe-only work without --bind
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
X-List-Received-Date: Tue, 08 Aug 2017 09:12:16 -0000
Content-Type: text/plain

The bitbake --server-only can work without --bind, so --observe-only should also
can work without --bind or --remote-server.

And also allow the connection all the time, otherwise --observe-only doesn't
work.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/main.py           | 4 ----
 bitbake/lib/bb/server/process.py | 8 ++------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 57b4d7688d9..4477d9c5998 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -357,10 +357,6 @@ def bitbake_main(configParams, configuration):
                                   ("the BBSERVER environment variable" if "BBSERVER" in os.environ \
                                    else "the '--remote-server' option"))
 
-    if configParams.observe_only and not (configParams.remote_server or configParams.bind):
-        raise BBMainException("FATAL: '--observe-only' can only be used by UI clients "
-                              "connecting to a server.\n")
-
     if "BBDEBUG" in os.environ:
         level = int(os.environ["BBDEBUG"])
         if level > configuration.debug:
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 338c44835e1..7f81996246e 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -137,12 +137,8 @@ class ProcessServer(multiprocessing.Process):
         while not self.quit:
             if self.sock in ready:
                 self.controllersock, address = self.sock.accept()
-                if self.haveui:
-                    print("Dropping connection attempt as we have a UI %s" % (str(ready)))
-                    self.controllersock.close()
-                else:
-                    print("Accepting %s" % (str(ready)))
-                    fds.append(self.controllersock)
+                print("Accepting %s" % (str(ready)))
+                fds.append(self.controllersock)
             if self.controllersock in ready:
                 try:
                     print("Connecting Client")
-- 
2.11.0


