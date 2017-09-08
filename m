Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5FE176FFCD
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Sep 2017 04:59:34 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v884xZ6q007584
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 7 Sep 2017 21:59:36 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Thu, 7 Sep 2017 21:59:33 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 7 Sep 2017 21:50:47 -0700
Message-ID: <4c1fc4b37f28cabf8fb8b526549a51f71e953502.1504845976.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1504845976.git.David.Reyna@windriver.com>
References: <cover.1504845976.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/2] toaster: handle early exceptions
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
X-List-Received-Date: Fri, 08 Sep 2017 04:59:34 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Stop the pending build and report to the user if there is
an internal exception due to a git error, a bitbake server
error, or if the server-only mode halts due to for example
a user syntax error in a layer or recipe.

These exceptions were not caught because they occure before
the normal toastergui processing was started.

[YOCTO #12056]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 8eacb5e..791e53e 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -79,6 +79,14 @@ class Command(BaseCommand):
             br.save()
             bec.be.lock = BuildEnvironment.LOCK_FREE
             bec.be.save()
+            # Cancel the pending build and report the exception to the UI
+            log_object = LogMessage.objects.create(
+                            build = br.build,
+                            level = LogMessage.EXCEPTION,
+                            message = errmsg)
+            log_object.save()
+            br.build.outcome = Build.FAILED
+            br.build.save()
 
     def archive(self):
         for br in BuildRequest.objects.filter(state=BuildRequest.REQ_ARCHIVE):
-- 
1.9.1


