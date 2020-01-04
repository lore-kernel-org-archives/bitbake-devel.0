Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
	[209.85.216.51])
	by mail.openembedded.org (Postfix) with ESMTP id 2E5857F894
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:33 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id bg7so5385913pjb.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=llXd6aAwYHSZBYXhHIeDmAte9+8AzMM7Vh5eFaUubpI=;
	b=U8klphTPrk+NZHQ+UxkoaLaAoM4tOKWEHZUrDlNm6iaDakusm2jffoo+wKuuNHifTG
	pm4i+S2AtWCAXTjGamdqliza9L10GOGy4ONnkh5Wl2O+L0L5y/0wOh9sHX2oqNX09V8Z
	NjhKFGlhjwERcAI5TsE4YzAtozcgx40mZ2B9YuwE4JWRWGq8vl+fM1pO1TveJEXPpfaZ
	K+sohBf18TuanCnwvEGCixkdcpVF4dL0jV33GoPZI1CoXdhu0CLFuxMV7hg+a6ilAdVT
	QLutgHbT5XorSj/8mh3mTYxfZrl0NO8TeGLdwHRsmvGIpMvEC5Lqijo6lfKKQrk9gY2D
	nv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=llXd6aAwYHSZBYXhHIeDmAte9+8AzMM7Vh5eFaUubpI=;
	b=rzJzPx2hUvrXNxGzSNat1RVCLqZbMae0Dkb7w0yRoRY/hYE+I7vuO7sLUquPJGcH+z
	vsF9ZH01eC9yESiGuAGWWzEklQm+SUl4hbwHxdY93EmUgVBMufpgho1zWYqoMkjz+ibx
	4L5mV9IMD1gpcaZMZi/r2liv4f4QMZDuMUOx7ZwbWeduu89uuv59Uo6Ur401hLs4O1ak
	fa4dO9Kv8nFJ3nViHAVeJCAn4AdzfQ8s0UqUto6n6CdJDfbXJm+IRli1aQFY6lJ1qULD
	xkLweSYS9xUPznQV6sE9ZqbyUb6ryO2qVxoVDFng7ofn+09va8yFV3orli1z14rMuwXJ
	v7uQ==
X-Gm-Message-State: APjAAAW84QemxnY4CvibGBULQF6Asvf5DuuM82cMnlvp7feo4Td6niWw
	LeyB0Adw7BJOjH6dCoHSPkYHuMgcdl4=
X-Google-Smtp-Source: APXvYqxErB2LSmDATWpTkZ9pBBdX/xfaQnkrIu+ibzML2sYTX8e4DSaAEuhPENFV5uVkRs8MbNHpRQ==
X-Received: by 2002:a17:90a:cf08:: with SMTP id
	h8mr30285137pju.81.1578104614120; 
	Fri, 03 Jan 2020 18:23:34 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.33
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:33 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:23:07 -0800
Message-Id: <182b2ae7bab4a943978154be3a65c018aaf21fdc.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 22/25] runqueue: Ensure task dependencies are run correctly
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:33 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We've seen a number of mystery failures where task B would run despite
task A, its dependency not having run. An example would be do_compile
when do_unpack didn't run.

This has been tracked down to this code block. In theory it shouldn't
trigger however it can and has due to bugs elsewhere. When it does, it
causes significant weird failures and possible build corruption.

Change the code to abort the build. This avoids any chance of corruption
and should ensure the issues get reported, putting an end to the weird
build failures.

There may be some cases where this triggers and it shouldn't, we'll work
through those as they arise and are identified.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7a92b7f58ab187eddfe550bd6fb687240c7b11bb)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/runqueue.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f8279980..56ca2529 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2353,6 +2353,12 @@ class RunQueueExecute:
             if tid in self.tasks_scenequeue_done:
                 self.tasks_scenequeue_done.remove(tid)
             for dep in self.sqdata.sq_covered_tasks[tid]:
+                if dep in self.runq_complete:
+                    bb.error("Task %s marked as completed but now needing to rerun? Aborting build." % dep)
+                    self.failed_tids.append(tid)
+                    self.rq.state = runQueueCleanUp
+                    return
+
                 if dep not in self.runq_complete:
                     if dep in self.tasks_scenequeue_done and dep not in self.sqdata.unskippable:
                         self.tasks_scenequeue_done.remove(dep)
-- 
2.17.1


