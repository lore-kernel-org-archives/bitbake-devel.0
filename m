Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id BF74C60125
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Aug 2017 09:12:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v789CEHQ024752
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Aug 2017 02:12:14 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.361.1;
	Tue, 8 Aug 2017 02:12:14 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 8 Aug 2017 02:12:06 -0700
Message-ID: <c75315a4930a447c156f55e1ce80f4354e1507e6.1502183410.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1502183410.git.liezhi.yang@windriver.com>
References: <cover.1502183410.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [WIP][RFC PATCH 2/5] bitbake: main: add log handler when status-only
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
X-List-Received-Date: Tue, 08 Aug 2017 09:12:13 -0000
Content-Type: text/plain

The ui is not a must for logger, and use logger when status-only is very good
for debugging.

e.g.:
$ bitbake --status
NOTE: bitbake server is not running.

$ bitbake --server-only -B localhost:-1
$ bitbake --status
NOTE: Reconnecting to bitbake server...

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/main.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 62f9e1eacf1..fb082e7e0f3 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -397,9 +397,7 @@ def bitbake_main(configParams, configuration):
 def setup_bitbake(configParams, configuration, extrafeatures=None, setup_logging=True):
     # Ensure logging messages get sent to the UI as events
     handler = bb.event.LogHandler()
-    if setup_logging and not configParams.status_only:
-        # In status only mode there are no logs and no UI
-        logger.addHandler(handler)
+    logger.addHandler(handler)
 
     # Clear away any spurious environment variables while we stoke up the cooker
     cleanedvars = bb.utils.clean_environment()
-- 
2.11.0


