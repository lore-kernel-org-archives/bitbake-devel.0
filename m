Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
	[209.85.210.178])
	by mail.openembedded.org (Postfix) with ESMTP id E24257F849
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:55 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id w62so8559452pfw.8
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=D8KC3oWEnwDllUOSi+yfR+Lgp1qPN6V5HbLQjeAbGUg=;
	b=t7s9JwZU22n5ysZ50vmU/GOGZhJAqJeyNK4lLUU4fU91IEHw5r2C+3x4/3+BH9JIiC
	V5gthqjJR6XFTQ9iZg3yyVSZ90GVcZxhV5Gr4ciq/15LEH9KlU+mmYdgruqoHM+FUziW
	iuYEbezTVZyyBb4yWKRzrp5haLMpCvOSaBGxDayPxqCrBfpfJ050f13DdsTOzantW8zz
	1sCW/GFXRWI+jHV/V5WU4+JOjzMzA6uw6R0fmOmvx17LrK0v/0f7Rf3JduE+1g3BnL4X
	MG91y1Q8oHggFbL2PE/owgvdzYb3vhE3O79X5YAILOs3qR7q2xuOnxwe5UimOYik4pZA
	RX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=D8KC3oWEnwDllUOSi+yfR+Lgp1qPN6V5HbLQjeAbGUg=;
	b=slf+yEa7NFh/QGrzbjrr2U8cZS7bUXc9BJEavRRXhPEWXx6xrUpyIdLoe3/kJwdrkE
	gxLm2t4vTEIdCJju9SeSvSPyTFbj+pqFIOxQ3fXIf68a+ZPWFcw73oEdw/ijcPHimShz
	09nC/gSPOom+fq4sWvWp+E9CFCXrHBDCyn5yurKnBcbVTfbmazhmA2xpPn8Wy61hvB2q
	FZqYi8lcHQR4qDwVO87pPZv46e4hrAFwXsq2/qPJaPTLKZ2EpGk6ehnZAEtWC75vZshL
	8bekm9OuPIJjBNtGhyTj70ZBQQzeJNNceEn7e4mthrLpx1VSJGniOxiCTCH5qjmXrvM3
	8Fbw==
X-Gm-Message-State: APjAAAXrwgesUHcgzQpW4A90NUftRzBcJ+2WxqQO8Bise7mScwCua5SZ
	nLTnyw8uNXChpJjeeMY06isRYu250vQ=
X-Google-Smtp-Source: APXvYqw0V30J1xd+Ajkh0FRgKrqTz9ysADKgE6Z0ihPmTqiBNBTMlft1XZky4DBlCIZf2/x0Yjskhg==
X-Received: by 2002:aa7:8e8f:: with SMTP id a15mr28590148pfr.153.1577076656999;
	Sun, 22 Dec 2019 20:50:56 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.56
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:56 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:37 -0800
Message-Id: <a80024a4397485f96693c4df108b40f6b1bdf32b.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 13/18] runqueue: Fix sstate task iteration performance
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:56 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Creating a new sorted list of sstate tasks each iteration through runqueue is
extremely ineffecient and was compounded by the recent change from a list to set.

Create one sorted list instead of recreating it each time.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit de18824996841c3f35f54ff5ad12f94f6dc20d88)
---
 lib/bb/runqueue.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 515e9d4..2ba4557 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1965,10 +1965,14 @@ class RunQueueExecute:
         self.rq.read_workers()
         self.process_possible_migrations()
 
+        if not hasattr(self, "sorted_setscene_tids"):
+            # Don't want to sort this set every execution
+            self.sorted_setscene_tids = sorted(self.rqdata.runq_setscene_tids)
+
         task = None
         if not self.sqdone and self.can_start_task():
             # Find the next setscene to run
-            for nexttask in sorted(self.rqdata.runq_setscene_tids):
+            for nexttask in self.sorted_setscene_tids:
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
                     if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
                         if nexttask not in self.rqdata.target_tids:
-- 
2.7.4


