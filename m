Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id BDCB36FFC7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 14:10:45 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id g17so138270081wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=T8tbuq1Lk7b2wNTqOQe3aalx/V6jgSZWscapi8+OEYE=;
	b=dKo3XAOuuw/nY0hY7bcKmjkprJRtlgBcqmuahCZ0TRzVQzjnfVAlYvdC/eb4rldeq6
	POSYjyX1uUKV7jXiHB6ExdkO3802cCq3Hw+6A0oLpmstR9SEIJXTkj8Mgj6JjdeWfDzw
	3d9trDi5z3jSp0L3CHlYEoYLxF6oC43L/uJgiUMrp6eQ6eHzEXinjXx8ogtq2ZTd8LxH
	aa9qioEp/yPintAs4wmhHNTspXUJEnps77OzV0jRDqbJcXInIeFwTLBOPt1ZetrTzN9p
	eWpL/8zqnPG0MpoV8fXRn8xhiVk+qvrXtyZUwDhF5Uz+mKWBUAy9HQLsX0WOqn/tZd2A
	y9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=T8tbuq1Lk7b2wNTqOQe3aalx/V6jgSZWscapi8+OEYE=;
	b=iDyig/GRaxLamQ2h2ZoAhMtVOGs3L1CuyZvn56nip/Pg7Wr4DMRMbC7BBM/mvUWspZ
	egcZbcGqPX5N/qdcfj4VVY39FrW9RW1sCLxkTK7x3Qqhg7EkTyFjXk6YBd6vELSDdWc9
	RliNTVFakylEV1wE+euKftU7b89cbQpUkwGWCwmdzfntJsW2kGqpoQGfC7Y3pIYY1Tqy
	MrpxnYWm8Z+jKyJ+8Rv2OedLM60bFV3PMHMTU36D8z99ufXSlHBF7e1ROgenfMlVhPeP
	mZO0Or6q1ZzW+J+TG/+Uk4RY0fkO/5oXMFlk+B80A8J2Ld4XmTmxSybiu3lMUg4S6UUE
	/RyQ==
X-Gm-Message-State: AOPr4FWjiXwk45HLtqN7eSecmj6A4YhUWAugRwLafvCA3HCEbr4HQxx3AXHsVi0xBb+F8GtO
X-Received: by 10.28.102.193 with SMTP id a184mr6406672wmc.8.1463062245814;
	Thu, 12 May 2016 07:10:45 -0700 (PDT)
Received: from orion.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id u4sm13653360wjz.4.2016.05.12.07.10.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 12 May 2016 07:10:45 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 May 2016 15:10:36 +0100
Message-Id: <1463062238-12007-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1463062238-12007-1-git-send-email-michael.g.wood@intel.com>
References: <1463062238-12007-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 1/3] buildinfohelper: add method to set current build as CANCELLED
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
X-List-Received-Date: Thu, 12 May 2016 14:10:46 -0000

From: Elliot Smith <elliot.smith@intel.com>

This will be used from toasterui to cancel the current command-line
build when a keyboard interrupt is captured.

[YOCTO #8515]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index ff4da78..c5368f6 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1251,6 +1251,16 @@ class BuildInfoHelper(object):
 
 
 
+    def cancel_cli_build(self):
+        """
+        If a build is currently underway, set its state to CANCELLED;
+        note that this only gets called for command line builds which are
+        interrupted, so it doesn't touch any BuildRequest objects
+        """
+        build = self.internal_state['build']
+        if build:
+            build.outcome = Build.CANCELLED
+            build.save()
 
     def store_dependency_information(self, event):
         assert '_depgraph' in vars(event)
-- 
2.7.4


