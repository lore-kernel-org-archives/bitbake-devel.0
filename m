Return-Path: <kergoth@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail.openembedded.org (Postfix) with ESMTP id 96477731E0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Feb 2016 00:13:44 +0000 (UTC)
Received: by mail-wm0-f65.google.com with SMTP id 128so13424050wmz.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Feb 2016 16:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=lEt8pySoN4XIm4RNvq8GlSyjXEoqGlE5KnHzVpwHciM=;
	b=UBT+1LVA0EPnC7aBb5K6/JadVguL/4l/dPNK1QMyiItJ3HCXiTxl+0DQY3g4l2viDb
	Y03vGT1R1KclWY+ReTcaSOTzvtxQ5yS0us7S2ZpNAnVxXSUqlM92xInO+AZqGUkpVayp
	tSgp40Emhbd9OVuXW+Vb7tnGv0IprqtCJ9+Dgbq2S5a9Nk9ofVGnQaNPRI0W0MW586Xf
	dNPZlfTdqKr2f0lqHSSu9HbPj7KUSGlFP8JniV9IguD1d+T6R+5/IY0mSNmUxOqA0l5Z
	IVcjSt34DHC8xq0H1R4hTCf111+3idBiwDglCnHf5D2wb5ov3iAbVLfVwoaqc71QZCB4
	xUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=lEt8pySoN4XIm4RNvq8GlSyjXEoqGlE5KnHzVpwHciM=;
	b=CGh7dei18BMYf/RmsmywxqRRLBPq8Urh+EkdkssJrQG0n7oDAqHaXjlaXPvpLYaAOy
	lSNhJ9m2RXIvj1Ac9gjNg/yBIlaLftAGbLUag28YRP2LdBgS+axIX+vtTUOmnqit2QWf
	5OHBsFYA/LV371JyFoadBfZAGoVPH+0mAKNiSWBJDoitETPYfYhwjxCDjQtPQVflPZEj
	YJvHsM/87Jcrthm5ndx8+aRrV61NEfEEvycXMVfx39HZBVf4rER/53q5TcBRrKuXE0tu
	YOr5A8WBPDbQAK0/LDii7090tlv+ebx1+v5t7UZQSeXQEN0Ctaua2lfyVrSMN+8SQyPk
	NILw==
X-Gm-Message-State: AG10YOS+YRgwlaESeO/eOVp9h+sHK8DWevuRHx4wLOq6qYNmhgvddPNZGIPdB90qfAeTow==
X-Received: by 10.194.242.67 with SMTP id wo3mr47808388wjc.180.1455236024878; 
	Thu, 11 Feb 2016 16:13:44 -0800 (PST)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id s2sm9684576wjs.39.2016.02.11.16.13.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 11 Feb 2016 16:13:43 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Feb 2016 17:13:36 -0700
Message-Id: <bfefd7e111665ad68f9c30a115cf307921561f7d.1455235907.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <cover.1455235907.git.chris_larson@mentor.com>
References: <cover.1455235907.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [RFC PATCH 1/1] bb.ui.knotty: prefix task messages with recipe/task
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
X-List-Received-Date: Fri, 12 Feb 2016 00:13:44 -0000

From: Christopher Larson <chris_larson@mentor.com>

An example prefix: `perl-5.22.1-r0 do_compile:`

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/ui/knotty.py | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index a8b968c..87e2a64 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -359,11 +359,19 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     return_value = 1
                 elif event.levelno == format.WARNING:
                     warnings = warnings + 1
-                # For "normal" logging conditions, don't show note logs from tasks
-                # but do show them if the user has changed the default log level to
-                # include verbose/debug messages
-                if event.taskpid != 0 and event.levelno <= format.NOTE and (event.levelno < llevel or (event.levelno == format.NOTE and llevel != format.VERBOSE)):
-                    continue
+
+                if event.taskpid != 0:
+                    # For "normal" logging conditions, don't show note logs from tasks
+                    # but do show them if the user has changed the default log level to
+                    # include verbose/debug messages
+                    if event.levelno <= format.NOTE and (event.levelno < llevel or (event.levelno == format.NOTE and llevel != format.VERBOSE)):
+                        continue
+
+                    # Prefix task messages with recipe/task
+                    if event.taskpid in helper.running_tasks:
+                        taskinfo = helper.running_tasks[event.taskpid]
+                        event.msg = taskinfo['title'] + ': ' + event.msg
+
                 logger.handle(event)
                 continue
 
-- 
2.2.1


