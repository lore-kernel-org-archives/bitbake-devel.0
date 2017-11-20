Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 22A0978699
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Nov 2017 22:31:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id vAKMVQ3I025391
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Nov 2017 14:31:26 -0800
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Mon, 20 Nov 2017 14:31:25 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Nov 2017 14:23:35 -0800
Message-ID: <acfefa08404eb3e7227eab990afcf7d23d93e2ea.1511216528.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1511216528.git.David.Reyna@windriver.com>
References: <cover.1511216528.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 3/6] toaster: some recipe events do not include packages
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
X-List-Received-Date: Mon, 20 Nov 2017 22:31:25 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Allow for "SinglePackageInfo" events that do not include package data,
for example OPKGN equal 'lib32-*' or 'lib64-*'.

[YOCTO #12204]
---
 lib/bb/ui/buildinfohelper.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index e451c63..524a5b0 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -719,7 +719,11 @@ class ORMWrapper(object):
 
     def save_build_package_information(self, build_obj, package_info, recipes,
                                        built_package):
-       # assert isinstance(build_obj, Build)
+        # assert isinstance(build_obj, Build)
+
+        if not 'PN' in package_info.keys():
+            # no package data to save (e.g. 'OPKGN'="lib64-*"|"lib32-*")
+            return None
 
         # create and save the object
         pname = package_info['PKG']
-- 
1.9.1


