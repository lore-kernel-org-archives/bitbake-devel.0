Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 117EA7836B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jun 2017 05:00:14 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v5F50GbP009564
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 22:00:16 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.200.76) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 14 Jun 2017 22:00:15 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Jun 2017 21:51:29 -0700
Message-ID: <499dac446c1e6815c8780345eba5d51d74d1ade1.1497502167.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1497502167.git.David.Reyna@windriver.com>
References: <cover.1497502167.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.200.76]
Subject: [PATCH 1/1] toaster: add getMessage to MockEvent
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
X-List-Received-Date: Thu, 15 Jun 2017 05:00:15 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The MockEvent needs to not only stand in for Toaster and Bitbake quick events,
it also needs to stand in for LogRecord, and for that it needs to provide
the new getMessage method.

[YOCTO #11440]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/bb/ui/buildinfohelper.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 46be5a5..12caef9 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -858,6 +858,12 @@ class MockEvent(object):
         self.pathname = None
         self.lineno = None
 
+    def getMessage(self):
+        """
+        Simulate LogRecord message return
+        """
+        return self.msg
+
 
 class BuildInfoHelper(object):
     """ This class gathers the build information from the server and sends it
-- 
1.9.1


