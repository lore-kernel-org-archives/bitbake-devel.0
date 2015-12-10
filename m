Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 3A46A606A8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:04 +0000 (UTC)
Received: by pabur14 with SMTP id ur14so40485569pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=kdHmq6Je/igJCopl/IuAL6aUPD7Qfsfs0Si/xHKnuQo=;
	b=EEL04nXg8xx66jLvRjnWKMKp08Gv8ApZRTPdqcbpuAHSLlo9UynOmzjQRz1FClIyou
	raD680OLLy3h3iVO78p6Okh4MakTjgS5reHE+OKliMOePnPm0tH1SgCwHIWE8x+OVsqJ
	z5hvzm/ycS6AsZGa4aXZPg4QmhPae7sUNhgBFNwkQyvV2Pv+Zl0qfmnDJZwbkr1YfA48
	R0dxbW9sySdjlXRYBc3Qnk17bVnY4gPRirHvosmFjKXB3Q/QgJ2fKhqRkz8/PgLabNP3
	d/Gd6AzTpay5uyGipOsc0CeM/Vnb76PVrdMUisimkYhzuvY8rolQpgPLuGvBFBBhrdRw
	LVCg==
X-Received: by 10.66.219.194 with SMTP id pq2mr13296043pac.107.1449719585654; 
	Wed, 09 Dec 2015 19:53:05 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:05 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:32 -0800
Message-Id: <bc852424ca89abdb58dc9b590bb6c1675af7cd2c.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 07/18] toaster: Update API used to make runbuilds methods run in transactions
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:05 -0000

From: Elliot Smith <elliot.smith@intel.com>

runbuilds previously had its methods decorated with
transaction.commit_on_success, which is now deprecated. transaction.atomic
is an (almost) drop-in replacement for this, so use this instead.

[YOCTO #8364]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 48dc618..d40dedb 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -14,14 +14,14 @@ class Command(NoArgsCommand):
     help    = "Schedules and executes build requests as possible. Does not return (interrupt with Ctrl-C)"
 
 
-    @transaction.commit_on_success
+    @transaction.atomic
     def _selectBuildEnvironment(self):
         bec = getBuildEnvironmentController(lock = BuildEnvironment.LOCK_FREE)
         bec.be.lock = BuildEnvironment.LOCK_LOCK
         bec.be.save()
         return bec
 
-    @transaction.commit_on_success
+    @transaction.atomic
     def _selectBuildRequest(self):
         br = BuildRequest.objects.filter(state = BuildRequest.REQ_QUEUED).order_by('pk')[0]
         br.state = BuildRequest.REQ_INPROGRESS
-- 
1.9.1


