Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
	[209.85.215.177])
	by mail.openembedded.org (Postfix) with ESMTP id 500997FDA9
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:11 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id l24so27107141pgk.2
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=llXd6aAwYHSZBYXhHIeDmAte9+8AzMM7Vh5eFaUubpI=;
	b=abjD+fIVQESaWvqQZOxi/oXyrse6eQ1YPhqqfKYFXxkehYKLde8VzEDh4kAgb1ok+r
	naYEVWBIC6N56IXsRQBRJuy8wc4IubQWzG0BMW82wh2doAGRMT9Zx2Geq0Ovbm6gBxi7
	5JDzNr1a/CN/IY9ROwpL0O1XVsAJ46yxjtYZotAc1AkWaezRzOE7dTla1C2a+roO0A7f
	KMk5MvkhLRgLf6trlI/muYS1rkfAwRvgjLPiwXGbnD8d7msj+Si8o1FgXlWaCnFqkcS8
	vbEQoxUDekxduQdj2YnPAzixT0xaXQmfNanAkwIGO5GFxQV/4U/qKFUd/buiUuuc44K0
	ZQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=llXd6aAwYHSZBYXhHIeDmAte9+8AzMM7Vh5eFaUubpI=;
	b=lxu6sIhj4hhR+gZ/gGoObpYEkcbGkuk2PXK67tdEzqGep17hptmB/9aobaQ2zLJqNH
	65K7I831j/9nQZhLndHrTVhZv+PoGWuIEnqhxdz+RBKOozRBFOp5nEFKNFhnpljeSAzd
	yxoSffIXmfu9keXbNmvOd2hPIRtR9zPDWxn5dRs3k/s0WPu13OII3IVLJYrOgbNGLXg0
	fvJpbUcFJk3RLZkxpx2GvCCL2r/Ws+xGwq7vbPy8vjBykGBq34EDIvaJkpxHpuS7NCYJ
	IdsYMG9pOjJqYouZabknMsCl5SWo4797nk+A1enPf7ZMyPRa1lEFfZ+xg7Phw1VQ6X/9
	HU9g==
X-Gm-Message-State: APjAAAX89lgDlUb2CgWyt/TBpeC/DF2+xlJmHCEwqOKbYYGdRHcPOooF
	xXLMSaYanklSTGS9uem9CSwi4leZ
X-Google-Smtp-Source: APXvYqyshmAHYdk6L5Nb3411ymqFyGLrFt4J9bJxknA1zcj97m98MVnXY8mm9J5BueC/U87VuxxHQA==
X-Received: by 2002:a63:f24b:: with SMTP id
	d11mr109905906pgk.381.1578328032266; 
	Mon, 06 Jan 2020 08:27:12 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.11
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:11 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:43 -0800
Message-Id: <182b2ae7bab4a943978154be3a65c018aaf21fdc.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 22/25] runqueue: Ensure task dependencies are run correctly
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:11 -0000

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


