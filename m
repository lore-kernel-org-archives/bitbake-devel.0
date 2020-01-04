Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
	[209.85.210.177])
	by mail.openembedded.org (Postfix) with ESMTP id 321597F894
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:26 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id 195so23424397pfw.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Rlc1OF0Phsi+GUzKQVF5KBH54uMrUokL0zzu3ychQow=;
	b=Z5RkOyRqrVvL8Jrv8kxA3Dg1pA6x6mBibSXU7UvHoKUuUitVkogYrlfG1Smh9ddzzr
	XFKE1sIvQfXT6Ky/E9RXT8dtIkUZ25kjQR24UofcRBWikR8LO2hkoAMLao7Ay0VRL2Wj
	nhlOXualKL8n1BgLaVhSJGI/GeMk40KdI047JH1sWymhsnEwBo07XXoingzA5y3RMcUY
	b4jaqtYUigsQoqam8R56j+mxnT3T9D9pVCrPLsYZ8/a4bJ73T7m8MOx5AedWMSIazzpv
	aay4AIQx5Me1U2LPOtZj/eXGk31Ukvnel2iyJ3R52oE75cziPyUq+SsFkBCqiI1eQXSF
	CM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Rlc1OF0Phsi+GUzKQVF5KBH54uMrUokL0zzu3ychQow=;
	b=mb8rd0CY8BQcBWaqRyeiVu3UG9iQOftvFoxzMQcG4jLd9J6GTXrPAYhg+NyckJIgFD
	L1oKV1BqRRQKs0HT1xbfJ/L9YMogoMrWNCs+/Ea8DaqkvBDEPg5L5G/5GH+5p6EeO/g4
	Uqm6Lu3W8fYhbt+pjU99WdZjLO2PkI6uHeFKwsLIAOXPm9JtPLNx9tw+PXoVHO+7Cw4e
	snz0gmzVg6RT2wRbwUXI9OOfVgAHZGoFSWIOhY3DvGxKzXvzrft8grJo41jsnLoVcPsb
	fPRPFzceOBV5HvOuZ5XevcYduUW+9I+w1TrXlKE4iwCTOwVbZ0nx2pWsIxEYQmP4jo8q
	TSpg==
X-Gm-Message-State: APjAAAXp/92J+p8QLQU5k0r+Qp8OJAx8kGqqZg+0IUQg0Fngz72xo0I0
	TaQv82U53GIvO3SxBR6P5Pkz3PFLytc=
X-Google-Smtp-Source: APXvYqxoxfSVZsvtWBvbpqpuKaVJUcTe/Cb+IxsP3lSUJB2xIk75W7uuy9FpYf439pbW6JsGHMpFZg==
X-Received: by 2002:a63:5b0e:: with SMTP id
	p14mr102530918pgb.315.1578104606070; 
	Fri, 03 Jan 2020 18:23:26 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.25
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:25 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:58 -0800
Message-Id: <a80024a4397485f96693c4df108b40f6b1bdf32b.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 13/25] runqueue: Fix sstate task iteration performance
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:26 -0000

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
index 515e9d43..2ba4557f 100644
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
2.17.1


