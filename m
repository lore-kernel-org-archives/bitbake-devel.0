Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id BD1FF7ED4E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Oct 2019 23:19:30 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id x91NJVg7014456
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 1 Oct 2019 16:19:32 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.209.225) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.468.0; Tue, 1 Oct 2019 16:19:31 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 1 Oct 2019 16:17:51 -0700
Message-ID: <daa7bf8718a4b82f82c7a2b907ba4bcdbd8eff45.1569971660.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1569971660.git.David.Reyna@windriver.com>
References: <cover.1569971660.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.209.225]
Subject: [PATCH 2/2] toaster: improve warnings when adding dependency to packages
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
X-List-Received-Date: Tue, 01 Oct 2019 23:19:30 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Some of the objects that bitbake reports to Toaster as dependencies to packages
are known objects that are not packages, for example library files and kernel
modules. In the Toaster logs, mark these as "Info" instead of "Warning".

[YOCTO #13386]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/bb/ui/buildinfohelper.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index f2151c2..5cbca97 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -646,6 +646,9 @@ class ORMWrapper(object):
                 Target_Installed_Package.objects.create(target = target_obj, package = packagedict[p]['object'])
 
         packagedeps_objs = []
+        pattern_so = re.compile(r'.*\.so(\.\d*)?$')
+        pattern_lib = re.compile(r'.*\-suffix(\d*)?$')
+        pattern_ko = re.compile(r'^kernel-module-.*')
         for p in packagedict:
             for (px,deptype) in packagedict[p]['depends']:
                 if deptype == 'depends':
@@ -654,6 +657,13 @@ class ORMWrapper(object):
                     tdeptype = Package_Dependency.TYPE_TRECOMMENDS
 
                 try:
+                    # Skip known non-package objects like libraries and kernel modules
+                    if pattern_so.match(px) or pattern_lib.match(px):
+                        logger.info("Toaster does not add library file dependencies to packages (%s,%s)", p, px)
+                        continue
+                    if pattern_ko.match(px):
+                        logger.info("Toaster does not add kernel module dependencies to packages (%s,%s)", p, px)
+                        continue
                     packagedeps_objs.append(Package_Dependency(
                         package = packagedict[p]['object'],
                         depends_on = packagedict[px]['object'],
-- 
1.9.1


