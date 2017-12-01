Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 3C7F97872E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Dec 2017 23:37:59 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id vB1Nc0uE016322
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 1 Dec 2017 15:38:00 -0800 (PST)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Fri, 1 Dec 2017 15:38:00 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 1 Dec 2017 15:30:14 -0800
Message-ID: <a835929e4fc7196c80d9ba097e91893f20d38409.1512170660.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1512170660.git.David.Reyna@windriver.com>
References: <cover.1512170660.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [rocko][PATCH 3/6] toaster: some recipe events do not include packages
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
X-List-Received-Date: Fri, 01 Dec 2017 23:37:59 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Allow for "SinglePackageInfo" events that do not include package data,
for example OPKGN equal 'lib32-*' or 'lib64-*'.

[YOCTO #12204]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
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


