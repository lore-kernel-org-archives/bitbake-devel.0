Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 99F6F6FF72
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 10:15:40 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u04AFerA019844
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 4 Jan 2016 02:15:40 -0800
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Mon, 4 Jan 2016 02:15:39 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 4 Jan 2016 02:15:39 -0800
Message-ID: <11cf5052016496de57d2253aff35c20c62d90703.1451902509.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1451902509.git.liezhi.yang@windriver.com>
References: <cover.1451902509.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] fetch2/local.py: avoid using PREMIRROR
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
X-List-Received-Date: Mon, 04 Jan 2016 10:15:40 -0000
Content-Type: text/plain

The PREMIRROR isn't useful for "file://", so avoid using it, this is
good for searching speed and can reduce useless lines in log.do_fetch.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/local.py |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index 2d921f7..7245651 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -126,3 +126,8 @@ class Local(FetchMethod):
     def clean(self, urldata, d):
         return
 
+    def try_premirror(self, urldata, d):
+        """
+        Should premirrors be used?
+        """
+        return False
-- 
1.7.9.5


