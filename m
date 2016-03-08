Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 3FE736E630
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Mar 2016 23:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id C2CD92E1C4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id U5HDTAYADqwj for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:03 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 7BDC32E1C5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:03 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 64CFF14B7
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:03 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 59AC41433
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:03 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 57FB2FE4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:03 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id u28Ns3GW023123
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 9 Mar 2016 00:54:03 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id u28Ns3Ex023122
	for bitbake-devel@lists.openembedded.org; Wed, 9 Mar 2016 00:54:03 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Mar 2016 00:53:58 +0100
Message-Id: <7bfb8f7c0d281351e03d299bdd5890c12a068934.1457481171.git.pkj@axis.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1457481171.git.pkj@axis.com>
References: <cover.1457481171.git.pkj@axis.com>
In-Reply-To: <cover.1457481171.git.pkj@axis.com>
References: <cover.1457481171.git.pkj@axis.com>
Subject: [PATCH 1/1] fetch2: Make SRC_URI[md5sum] and SRC_URI[sha256sum] expand their values
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
X-List-Received-Date: Tue, 08 Mar 2016 23:54:06 -0000

For some reason, the values for SRC_URI[md5sum] and SRC_URI[sha256sum]
were not being expanded. That lead to the following code not working
as expected:

SRC_URI = "http://.../${PN}-${PV}.tar.gz"

MD5SUM = "123abc..."
SHA256SUM = "abcd1234..."

SRC_URI[md5sum] = "${MD5SUM}"
SRC_URI[sha256sum] = "${SHA256SUM}"

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index e8d3af7..f86014c 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1153,13 +1153,13 @@ class FetchData(object):
         elif self.type not in ["http", "https", "ftp", "ftps", "sftp"]:
             self.md5_expected = None
         else:
-            self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name, False)
+            self.md5_expected = d.getVarFlag("SRC_URI", self.md5_name, True)
         if self.sha256_name in self.parm:
             self.sha256_expected = self.parm[self.sha256_name]
         elif self.type not in ["http", "https", "ftp", "ftps", "sftp"]:
             self.sha256_expected = None
         else:
-            self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name, False)
+            self.sha256_expected = d.getVarFlag("SRC_URI", self.sha256_name, True)
         self.ignore_checksums = False
 
         self.names = self.parm.get("name",'default').split(',')
-- 
2.1.0


