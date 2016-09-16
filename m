Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f176.google.com (mail-pf0-f176.google.com
	[209.85.192.176])
	by mail.openembedded.org (Postfix) with ESMTP id 2E75375C60
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:22:53 +0000 (UTC)
Received: by mail-pf0-f176.google.com with SMTP id z123so28769504pfz.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=pyjFJGaESsdsR0e8Gv93PJ/3ggJ5WSjtNLW0CkqCEus=;
	b=NGHwXXmMqpDvXOUriukAU9aBKnnBWkkEsGAQQyuEiVGfEUKpcfRmgKC43aDCw0sYTp
	1sgT+qPGnX8ouXtyApS2MkxwzZCyrI+uWY16YbY+Mu6csLSiL67KGwOZa3V76DIj070x
	BNB8Lu50M/eEH0ExBLz7tGEj3rc4qW2Vz3nsOQVL05QooaSzGxh/35d/dwgcfBvnhPJ/
	z8v5VbOCyt7VoaHTbPXTIaFTTd496yRUm4U8P2F/xRxuqhXponI1XHw1gl9ilxaN6mjx
	YKoa25yW5uLDh/MiJekz2ynOlj0UUh1nXHXJLPCXSNcgYu7XSkl7QG1tDMy2M9u7tuGu
	+dXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=pyjFJGaESsdsR0e8Gv93PJ/3ggJ5WSjtNLW0CkqCEus=;
	b=Uc9k/+fXy/hv9GV4/j4DNcyOhi5J6nxlSZmFYgnLd/xNcvjGMr2jNwjiA0YrqjM8pD
	61QgITvmchMTxw15xslp1ON47oEWGlfhp9rURzkbgFMlcXkhnOXqcJ7f6jDSSaT7CHNG
	oBxwWZDhsa5P51MlVrMojJ1nlpJO8zEuQA1O+7iCdOTENLXHxZ46YXGsDBJYWye4gSvD
	MkxtHoosuYVqBX8CZieDrCevw2k11hOHc6/34rM1fUitm7sjw6EG9Y1jgf6KgNR76e0a
	2csTALnqO30/NE3H7E4dl0TNV2Wd/zMu3Y0F3EMLXvMQz11z4vObh75Q6CynXgnYo5MQ
	74CA==
X-Gm-Message-State: AE9vXwPR3I9/uC1oBbD7D7/15O//gYFh0F1wuYH8V4SRDLzYT2WSUBapllNy9oj32H1xIjiJ
X-Received: by 10.98.158.90 with SMTP id s87mr24482019pfd.117.1474042974291;
	Fri, 16 Sep 2016 09:22:54 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	bm8sm13336146pac.16.2016.09.16.09.22.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 09:22:53 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 17:22:32 +0100
Message-Id: <1474042955-12618-6-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
References: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 5/8] runbuilds: process builds on start
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
X-List-Received-Date: Fri, 16 Sep 2016 16:22:54 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

If Toaster is stopped incorrectly there could be some
build requests and builds in incorrect state left from the previous run.
Running main processing function on start should take care of those.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 61a520c..7df81dc 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -175,6 +175,8 @@ class Command(NoArgsCommand):
             logger.warn("runbuilds: schedule exception %s" % str(e))
 
     def handle_noargs(self, **options):
+        self.runbuild()
+
         signal.signal(signal.SIGUSR1, lambda sig, frame: None)
 
         while True:
-- 
2.7.4


