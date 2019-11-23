Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
	[209.85.216.43])
	by mail.openembedded.org (Postfix) with ESMTP id C22F17F369
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 16:25:08 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id ep1so4519323pjb.7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 08:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=k7UNZI1jGDhRcgfWRgCQ0NYO6Mdl2NPCF8YVzTmWbo0=;
	b=SFBKhkwcaBUbmze2/zV5o+RVcXZqya1bpI+mUGe2N2cZO1nVXB1x+Sr3lAC06Zk82Z
	2bbn2ta0hgwYeKiQKru//wXU7jlPgQ5FXYBhj7a+jqSl5CUoZDolDyG/2mFNmj1WnfLZ
	b9JBe0APai2TqZ1YRPwnPU63pQLfBVfNeFBBhjD+xmspoTR2RdG5rOihk+wji0TnWiTx
	L+ti8eV+ay9S7WBpHru82+Vhjw4lcExINtdnt+DQzlJSVn+i7OGjzgn77i59uv0/DYKq
	kO78B7Bq//PAjHZoKrH99IkxqDIT04AyKidUGl7XbZVGZ3p6OoA2WcyO3Vbjrwdswqaf
	7iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=k7UNZI1jGDhRcgfWRgCQ0NYO6Mdl2NPCF8YVzTmWbo0=;
	b=ICfFZoR89934heAgHZhHEbZ3kqxFvWzenMTIFaQFy+ncK6AkuY1LINTSKFDMiWPU+b
	wgowmeVAuWcIrxIG27EKcaDrYhhfNBca2J91VfCQtnVnGUSs7j7ZJBlsWwa6rX+KT81C
	on3MOXl4AGo9t93b5DxH2kn5yDhtuMbk9EDK+3MvCaaWCXolaF7VsLPTlWwYEWkWHetT
	Zs4O7psn8/5cjoW/nfh9SyQG+yf6s2Ni+U1tZYbIhrpBPX5iQTuB33gnnYMcrBpsq/uC
	lS6N9oRm8F0yBqoxJX1J+9eUKXlSGnOAmNud6zbfofq+FH+lumLzru88akNHdVKAba+M
	LK+g==
X-Gm-Message-State: APjAAAVYbfqnIfT7kXcRTr3p4qzNazf0jXRDdnUgy3YM1mZnDzRRcxDc
	sFH8Tru8biZZLXmwyiPTP8XkaQdJ
X-Google-Smtp-Source: APXvYqwyt7m9FFxiTqLSEXaT0TXt3ZdYXZd2fS6oeExHG5g9+kQu+YdsXf0t6dwlsklSdIc7g1K8sA==
X-Received: by 2002:a17:90a:db43:: with SMTP id
	u3mr26908957pjx.56.1574526309716; 
	Sat, 23 Nov 2019 08:25:09 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:d5a1:4623:137e:d439])
	by smtp.gmail.com with ESMTPSA id h9sm2735572pjh.8.2019.11.23.08.25.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 23 Nov 2019 08:25:09 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Nov 2019 08:24:59 -0800
Message-Id: <1574526299-21018-9-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
References: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
Subject: [1.44][PATCH 9/9] runqueue: Fix hash equivalence duplicate tasks running
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
X-List-Received-Date: Sat, 23 Nov 2019 16:25:08 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The key problem is that currently running setscene tasks are not
accounted for when processing task migrations. This means can allow
two of the same task to execute at the same time with unpredictable
effects.

This change allows us to stop doing that and refactor the code slightly
to make it clearer that these conditions don't arrive even with
deferred tasks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/runqueue.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 1804943..02a9b91 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2303,16 +2303,22 @@ class RunQueueExecute:
         for tid in changed:
             if tid not in self.rqdata.runq_setscene_tids:
                 continue
+            if tid not in self.pending_migrations:
+                self.pending_migrations.add(tid)
+
+        for tid in self.pending_migrations.copy():
             if tid in self.runq_running:
+                # Too late, task already running, not much we can do now
+                self.pending_migrations.remove(tid)
                 continue
-            if tid in self.scenequeue_covered:
+
+            if tid in self.scenequeue_covered or tid in self.sq_live:
+                # Already ran this setscene task or it running
                 # Potentially risky, should we report this hash as a match?
                 logger.info("Already covered setscene for %s so ignoring rehash" % (tid))
+                self.pending_migrations.remove(tid)
                 continue
-            if tid not in self.pending_migrations:
-                self.pending_migrations.add(tid)
 
-        for tid in self.pending_migrations.copy():
             valid = True
             # Check no tasks this covers are running
             for dep in self.sqdata.sq_covered_tasks[tid]:
-- 
2.7.4


