Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
	[209.85.210.174])
	by mail.openembedded.org (Postfix) with ESMTP id DBCC97FC8B
	for <bitbake-devel@openembedded.org>;
	Sat, 25 Jan 2020 16:01:14 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id q10so2680919pfs.6
	for <bitbake-devel@openembedded.org>;
	Sat, 25 Jan 2020 08:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=7y2zBWwKC6qnS72kXGbDa3QCDiRfdiQ33YGrxTjhjTM=;
	b=NEM+ocpMWHCXbj8USTsl2uOHcxQuMXZOz65poANfe0cD0bF76DwLYDIMh/azl5sPz5
	jt5SGa+ufYH5WnmiD551nM8M88mbsUltp+K4z2UitSQaP+1fqKuOPrHHE3NUcBjtZQAv
	+kWQUekLJj1CBZLG0/k/0WFopTWpvvhd9l2+wMS+pRgS3TuhWdCwc9d1v1nWOPuh0E2h
	L6FhwDfRJCYabwrOXtKB4HSvN9hl1FdRJUZJS5P4OisiGxF1+tg9yyBYt01Y40PBTqum
	qqF7MsHgi9iv7qaXF9NB7LuQYe8/nmKCaYT4d1rjlafQLrLvGnl3LvuKsIweCMPuo3yG
	r1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=7y2zBWwKC6qnS72kXGbDa3QCDiRfdiQ33YGrxTjhjTM=;
	b=seOlae2PFkV7Zkrt6yY6Yo2m1s/ppkpc5hX3reiiXNbSTL7zjBm/vUFR9yHkIxAiVA
	MaZw4oUYDyIzwISFHD59C4Ph/IC/ncWh2LBQdahyH+3JO0rJkk68qNLr9SoAqSNHLNj8
	5kHaoEcAmI5iraEBmonGPaZeTafYBbk0OaLBxUfAXemzGzVOuhzTjVoLblxvPrk1DTAm
	Ij4uqn1uzz+rji1KafFwzY8l0mH7XkiUu4IRLB1geLk0XNr3Fkl8SDBk94ttfGxoYd8/
	mPCLVI2+SYTiJZsdXMOAYKyPW/2wyaurC7mJGHm15BOE5SK1zQMmsl88zFfzO8F3vpG1
	QOnw==
X-Gm-Message-State: APjAAAWJ93BcLZSIWJHhu+Qmt4tBURXQZ7OSpW83mHguJci27g7s0eRT
	kPeb0M5eM05YMaI/QMy20i2kwyC6
X-Google-Smtp-Source: APXvYqwrGqHrIPgdUusV1qUNg67L9k+XJCBJT9J27Y0Sa1IhZoBv0u8XO0Wkd/virbIFuwXiPNQglQ==
X-Received: by 2002:a63:512:: with SMTP id 18mr10340892pgf.221.1579968075851; 
	Sat, 25 Jan 2020 08:01:15 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:953f:6ade:6955:1d1c])
	by smtp.gmail.com with ESMTPSA id j9sm10291064pff.6.2020.01.25.08.01.15
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 25 Jan 2020 08:01:15 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sat, 25 Jan 2020 08:01:08 -0800
Message-Id: <1a026d4aca47ed1b0b74a8a818635e7520e8f9c8.1579968003.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579968003.git.akuster808@gmail.com>
References: <cover.1579968003.git.akuster808@gmail.com>
Subject: [1.44 4/4] runqueue: Use a set for the setscene tasks list
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
X-List-Received-Date: Sat, 25 Jan 2020 16:01:15 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This should give performance improvements to functions using this list of
tasks (sets are used for most of the other code for this reason, not sure
why this wasn't a set in the first place).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f5daef68703481a3c243dfecc7de404e6ebfdbb6)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6e3a91b8..d7186e85 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1124,14 +1124,14 @@ class RunQueueData:
         self.init_progress_reporter.next_stage()
 
         # Iterate over the task list looking for tasks with a 'setscene' function
-        self.runq_setscene_tids = []
+        self.runq_setscene_tids = set()
         if not self.cooker.configuration.nosetscene:
             for tid in self.runtaskentries:
                 (mc, fn, taskname, _) = split_tid_mcfn(tid)
                 setscenetid = tid + "_setscene"
                 if setscenetid not in taskData[mc].taskentries:
                     continue
-                self.runq_setscene_tids.append(tid)
+                self.runq_setscene_tids.add(tid)
 
         self.init_progress_reporter.next_stage()
 
-- 
2.17.1


