Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 33E747806E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 20:53:23 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v5RKrOOX028382
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 13:53:24 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.209) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Tue, 27 Jun 2017 13:53:24 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Jun 2017 13:44:31 -0700
Message-ID: <2e1b6a036903f60bbca40338e1add42c52e5a2f7.1498595653.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1498595646.git.David.Reyna@windriver.com>
References: <cover.1498595646.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.209]
Subject: [PATCH 4/5] toaster: large package set breaks sqlite query
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
X-List-Received-Date: Tue, 27 Jun 2017 20:53:24 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

If you build a project with a large package set, you will get a crash
in "views.py" when the dashboard attempts to fetch the package set to
calculate the package count and size. This is a sqlite limitation, and
it fails with as few as 1220 packages.

[YOCTO #11717]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/views.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 75c5911..5720b9d 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -457,10 +457,15 @@ def builddashboard( request, build_id ):
         npkg = 0
         pkgsz = 0
         package = None
-        for package in Package.objects.filter(id__in = [x.package_id for x in t.target_installed_package_set.all()]):
-            pkgsz = pkgsz + package.size
-            if package.installed_name:
-                npkg = npkg + 1
+        # Chunk the query to avoid "too many SQL variables" error
+        package_set = t.target_installed_package_set.all()
+        package_set_len = len(package_set)
+        for ps_start in range(0,package_set_len,500):
+            ps_stop = min(ps_start+500,package_set_len)
+            for package in Package.objects.filter(id__in = [x.package_id for x in package_set[ps_start:ps_stop]]):
+                pkgsz = pkgsz + package.size
+                if package.installed_name:
+                    npkg = npkg + 1
         elem['npkg'] = npkg
         elem['pkgsz'] = pkgsz
         ti = Target_Image_File.objects.filter(target_id = t.id)
-- 
1.9.1


