Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 19E3B6C17F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 09:35:46 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wAE9ZRG1015293
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 01:35:38 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Wed, 14 Nov 2018 01:35:16 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Nov 2018 17:46:40 +0800
Message-ID: <6ecd4de66b74e1ca2506764a502986426446279a.1542188647.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542188647.git.liezhi.yang@windriver.com>
References: <cover.1542188647.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 5/6] bitbake: server/process: print a message when no logfile
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
X-List-Received-Date: Wed, 14 Nov 2018 09:35:47 -0000
Content-Type: text/plain

[YOCTO #12898]

There might be no bitbake-cookerdaemon.log, print a message for debugging.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/server/process.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index ed930c6..12f52b0 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -428,7 +428,11 @@ class BitBakeServer(object):
                         bb.error("Last 10 lines of server log for this session (%s):\n%s" % (logfile, "".join(lines[-10:])))
                     else:
                         bb.error("Server log for this session (%s):\n%s" % (logfile, "".join(lines)))
+            else:
+                bb.error("%s doesn't exist" % logfile)
+
             raise SystemExit(1)
+
         ready.close()
 
     def _startServer(self):
-- 
2.7.4


