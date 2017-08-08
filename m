Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4E46871A0F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Aug 2017 09:12:14 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v789CGw4002045
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Aug 2017 02:12:16 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.361.1;
	Tue, 8 Aug 2017 02:12:15 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 8 Aug 2017 02:12:08 -0700
Message-ID: <432506cd871d7e8f1703121b2f96f7f03ffae673.1502183410.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1502183410.git.liezhi.yang@windriver.com>
References: <cover.1502183410.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [WIP][RFC PATCH 4/5] bitbake: main: handle BB_SERVER_TIMEOUT = -1
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
X-List-Received-Date: Tue, 08 Aug 2017 09:12:15 -0000
Content-Type: text/plain

Make BB_SERVER_TIMEOUT = -1 mean no unload forever.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/main.py           | 6 ++++--
 bitbake/lib/bb/server/process.py | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index fb082e7e0f3..57b4d7688d9 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -259,8 +259,10 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           help="The name/address for the bitbake xmlrpc server to bind to.")
 
         parser.add_option("-T", "--idle-timeout", type=float, dest="server_timeout",
-                          default=os.environ.get("BB_SERVER_TIMEOUT", 0) or None,
-                          help="Set timeout to unload bitbake server due to inactivity")
+                          default=os.getenv("BB_SERVER_TIMEOUT"),
+                          help="Set timeout to unload bitbake server due to inactivity, "
+                                "set to -1 means no unload, "
+                                "default: Environment variable BB_SERVER_TIMEOUT.")
 
         parser.add_option("", "--no-setscene", action="store_true",
                           dest="nosetscene", default=False,
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 5b8a549f94e..338c44835e1 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -180,7 +180,8 @@ class ProcessServer(multiprocessing.Process):
                     if self.timeout is None:
                         print("No timeout, exiting.")
                         self.quit = True
-            if not self.haveui and self.lastui and self.timeout and (self.lastui + self.timeout) < time.time():
+            if not self.timeout == -1.0 and not self.haveui and self.lastui and self.timeout and \
+                    (self.lastui + self.timeout) < time.time():
                 print("Server timeout, exiting.")
                 self.quit = True
 
-- 
2.11.0


