Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id AA7CE78164
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 22:04:47 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v6BM4mNB014568
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 15:04:48 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Tue, 11 Jul 2017 15:04:48 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Jul 2017 14:56:09 -0700
Message-ID: <91895190601febbcbabaca5207beb7c8562fad6c.1499809423.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1499809423.git.David.Reyna@windriver.com>
References: <cover.1499809423.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 2/3] toaster: set clone progress default to off
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
X-List-Received-Date: Tue, 11 Jul 2017 22:04:47 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Set the clone progress to be off by default for the benefit of
command line projects and 'Local Yocto' builds. For Toaster managed
projects that do use the clone feature the clone progress status
is already explicitly set by the existing code and thus displayed.

[YOCTO #11744]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/migrations/0016_clone_progress.py | 4 ++--
 lib/toaster/orm/models.py                         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/orm/migrations/0016_clone_progress.py b/lib/toaster/orm/migrations/0016_clone_progress.py
index 852b878..cd4023b 100644
--- a/lib/toaster/orm/migrations/0016_clone_progress.py
+++ b/lib/toaster/orm/migrations/0016_clone_progress.py
@@ -13,12 +13,12 @@ class Migration(migrations.Migration):
         migrations.AddField(
             model_name='build',
             name='repos_cloned',
-            field=models.IntegerField(default=0),
+            field=models.IntegerField(default=1),
         ),
         migrations.AddField(
             model_name='build',
             name='repos_to_clone',
-            field=models.IntegerField(default=1),
+            field=models.IntegerField(default=1), # (default off)
         ),
     ]
 
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index e9182c5..05cc5a8 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -456,8 +456,8 @@ class Build(models.Model):
     # number of repos to clone for this build
     repos_to_clone = models.IntegerField(default=1)
 
-    # number of repos cloned so far for this build
-    repos_cloned = models.IntegerField(default=0)
+    # number of repos cloned so far for this build (default off)
+    repos_cloned = models.IntegerField(default=1)
 
     @staticmethod
     def get_recent(project=None):
-- 
1.9.1


