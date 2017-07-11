Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 9BE5B78164
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 22:04:46 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v6BM4mJY024567
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 15:04:48 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Tue, 11 Jul 2017 15:04:47 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Jul 2017 14:56:08 -0700
Message-ID: <e87d6c4ab20b42e8f066010381fcbd2d82ed390d.1499809423.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1499809423.git.David.Reyna@windriver.com>
References: <cover.1499809423.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/3] toaster: include setscene in task progress
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
X-List-Received-Date: Tue, 11 Jul 2017 22:04:46 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Change the task progress counting from the task order field
which excludes setscene to the task completion field which
counts all completed tasks regardless of type.

[YOCTO #9971]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 630e4a0..e9182c5 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -508,7 +508,7 @@ class Build(models.Model):
         tf = Task.objects.filter(build = self)
         tfc = tf.count()
         if tfc > 0:
-            completeper = tf.exclude(order__isnull=True).count()*100 // tfc
+            completeper = tf.exclude(outcome=Task.OUTCOME_NA).count()*100 // tfc
         else:
             completeper = 0
         return completeper
@@ -709,10 +709,11 @@ class Build(models.Model):
         tasks.
 
         Note that the mechanism for testing whether a Task is "done" is whether
-        its order field is set, as per the completeper() method.
+        its outcome field is set, as per the completeper() method.
         """
         return self.outcome == Build.IN_PROGRESS and \
-            self.task_build.filter(order__isnull=False).count() == 0
+            self.task_build.exclude(outcome=Task.OUTCOME_NA).count() == 0
+
 
     def get_state(self):
         """
-- 
1.9.1


