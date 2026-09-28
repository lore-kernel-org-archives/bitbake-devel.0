Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F7BCA5FA5
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 11:12:20 +0000 (UTC)
Received: from mail-wr2-f40.google.com (mail-wr2-f40.google.com [74.125.225.104])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.54962.1790593931812097246
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 04:12:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d3228JDe;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.104, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f40.google.com with SMTP id ffacd0b85a97d-488780459e2so2861826f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790593930; x=1791198730; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NApnLtIsfhx9GYSd/NXfddqxy2PVHGVNNzp6M9HD1AY=;
        b=d3228JDetEDV1Stw+a44WJCgN2nGrH/XMguQZGbZYTaPDAFaqX906IRARGzeTV+p9+
         hdVq8kAY2fmVi1QRGFF9ouk0CScHjHfZCUK8sz30ScgbGDckcE+kNKO+KmAp6GFhVPu4
         3HQ0UNUvZUnt7FC8iPRM8RZyIrzoevNfyKcLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790593930; x=1791198730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NApnLtIsfhx9GYSd/NXfddqxy2PVHGVNNzp6M9HD1AY=;
        b=w8Nx1pC6LUgkjZ29NjZfF+Zeo/6BQhK/QqVVgYWQh5eKmYQPYR+IW814PlQASezKdq
         IE1UAXIYwClE5knoXBMXTPaDrrfC1Ms8pkbQzY6NhKA5HV+yDYyFsnpVpzGYioIbjVAP
         ErWIxHKjYWkXVAR6M/kc0thwg7qFGVHb2RAHVw76NQCfHbusxxEe1HcP5NLsxuNvjfz/
         UTt4lQQudMvxbiUVDSdAjVgD7usIsyxqBWtUxyQr0fO5cKU8IpbWWubpgESY2FPTgcsf
         ddJvlpAMC2ZbqJmFqoeT+U0W8yAZCL+p0mcNmt1hyN1MFgR/K9+zAx9An7M+JMky1B2t
         hu5A==
X-Gm-Message-State: AFq9FYLyyV8qpQlpoGgi9oGNFXpih/IEkI4EzZuv4be7gjzqPjGxQMce
	DidmF1w+SnRshMvwyk4ixGduEoKB6rhkGdcPvtnA9ILrpPWe5IQjOwE+JbGXxEyjxLD/du/2EAe
	Hg9rBZGw=
X-Gm-Gg: AYBFou0BAUtTHw9ThMJ633Z/l5WQWvQLDe52coO63Lx5koheloKH0NVQoOd8um4wb7n
	nbAf+qVfWmBx/YSDe7qA7JJ1U+bnu4aO0IZV9K3XITaju3A1cLSyEbD+ZTlLAUVZd8VQVlz2z6k
	gWPs1+76VicjsxdF0fMvrofkcIRi00yJnzOZgLhXHJOip2MOQiiROXp+5HE132XXNhf/4DOZllh
	o0SrsIVPdpAa4SThVFuDbppUgD1BFYjDLKtV5D1EBC6Vpne7784Z5+4eeWeb+8Vi7vuZg6WK/lF
	dviTZ153hyW50SgXT3Vz6YLDvCEmMm1bSlmSgoypN28OiH26o3cjBhSadYouJJ/P7/p8KJvNX23
	rqf6L3Zq71x2jhr/vyDQoq13x77DL4wcFTAtk9nNIyJCmSDNI/QnvmltmSDjc/kNHoJVDArYh6O
	XsYKCgtfj8+83D4k6jreIY5XUl8b3K7PyDbdPmWryMfpiLsviZjkvjkSd1OVhOLWDVOoQ9mt47e
	EQX8prnpDqqz5jfAzReaZoTmv0=
X-Received: by 2002:a05:6000:384:b0:488:63f2:8766 with SMTP id ffacd0b85a97d-48871728c55mr22828525f8f.21.1790593929968;
        Mon, 28 Sep 2026 04:12:09 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e53f:c6ab:eb79:60b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a35fb05sm29865076f8f.20.2026.09.28.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:12:09 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Lei Zhang <18792670849@163.com>
Subject: [PATCH] toastergui/views: Replace os.system call with improved parameter handling
Date: Mon, 28 Sep 2026 12:12:08 +0100
Message-ID: <20260928111208.3011807-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 11:12:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20270

Using bash to handle execution parameters isn't a great idea, particularly using
os.system. In theory this could be exploited by injecting shell code through the
placeholders although whether this can be done without security tokens is unclear.

Regardless, we have been cleaning up shell=True and similar calls in the codebase.
Instead use shlex to parse the callback command, then we can iterate the parameters
to perform any expansions needed and avoid the need to call any shell expansion.
Any invalid data will then just become an invalid image target to bitbake.

Reported-by: Lei Zhang <18792670849@163.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/toastergui/views.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 061e6436c85..3192b7270d6 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -8,6 +8,7 @@
 
 import ast
 import re
+import shlex
 import subprocess
 import sys
 
@@ -1556,7 +1557,7 @@ if True:
     # perform the final actions for the project specific page
     def project_specific_finalize(cmnd, pid):
         project = Project.objects.get(pk=pid)
-        callback = project.get_variable(Project.PROJECT_SPECIFIC_CALLBACK)
+        callback = shlex.split(project.get_variable(Project.PROJECT_SPECIFIC_CALLBACK) or "")
         if "update" == cmnd:
             # Delete all '_PROJECT_PREPARE_' builds
             for b in Build.objects.all().filter(project=project):
@@ -1569,16 +1570,15 @@ if True:
                     management.call_command('builddelete', str(b.id), interactive=False)
             # perform callback at this last moment if defined, in case Toaster gets shutdown next
             default_target = project.get_variable(Project.PROJECT_SPECIFIC_DEFAULTIMAGE)
-            if callback:
-                callback = callback.replace("<IMAGE>",default_target)
+            for i in range(len(callback)):
+                callback[i] = callback[i].replace("<IMAGE>", default_target)
         if "cancel" == cmnd:
-            if callback:
-                callback = callback.replace("<IMAGE>","none")
-                callback = callback.replace("--update","--cancel")
+            for i in range(len(callback)):
+                callback[i] = callback[i].replace("<IMAGE>", "none")
+                callback[i] = callback[i].replace("--update", "--cancel")
         # perform callback at this last moment if defined, in case this Toaster gets shutdown next
-        ret = ''
         if callback:
-            ret = os.system('bash -c "%s"' % callback)
+            subprocess.run(callback, shell=False)
             project.set_variable(Project.PROJECT_SPECIFIC_CALLBACK,'')
         # Delete the temp project specific variables
         project.set_variable(Project.PROJECT_SPECIFIC_ISNEW,'')

