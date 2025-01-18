Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E795C02185
	for <webhook@archiver.kernel.org>; Sat, 18 Jan 2025 19:11:20 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.226])
 by mx.groups.io with SMTP id smtpd.web11.1477.1737227475391820238
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 18 Jan 2025 11:11:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=Qi93Z17P;
 spf=pass (domain: freemail.hu, ip: 46.107.16.226, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4Yb5mb5RgLzNLl;
	Sat, 18 Jan 2025 20:11:11 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] runqueue: Improve speed of scenequeue data generation.
Date: Sat, 18 Jan 2025 20:10:17 +0100
Message-ID: <20250118191017.1331-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737227472;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 18 Jan 2025 19:11:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17036

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=1246; bh=OKue993SAaNqmRh0/MAzVMOvfqLbeCB0U6807gyFHqE=;

	b=Qi93Z17PMV52u3sGyFn1bnFY4nMIriuX3EvWsnHZDUiDqeX/atpw341yNl8mGkjF

	2GdtnrPRyeulDhcSLEB9Frqo7oCvTK42a00uZzQmq6oSa/K7OgxZaq4eBVF5UCwnfXf

	YmHyYIL8xSjG5IhOHiaBzrzKudPlQpA40L0kMRgURGr3EXx/xPZHQ0J8nexuN711YC1

	7+2gJdWwjWIXe2Fa14hNQAfJKgpRMqPIwCZXhVQvAdS1N6Ow3efnqIbm4cWEAbEseLC

	FR9WXtpsKyzq22WC2vZrRxKGFVG7uZTtmad3+e+GhXL4E/z3QmVHc7i+vbFGCJFvqJC

	OjXHWTPqfw==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

In scenequeue data generation loop, progress bar update in each cycle cau=
se
a significant loss of speed. Remove progress bar update in for loop. It w=
as
become quite fast (faster 30 times, about) without progress bar update.

Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
---
 lib/bb/runqueue.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ffb2d2849..04676de43 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -3033,14 +3033,13 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
     rqdata.init_progress_reporter.next_stage(len(rqdata.runtaskentries))
=20
     # Sanity check all dependencies could be changed to setscene task re=
ferences
-    for taskcounter, tid in enumerate(rqdata.runtaskentries):
+    for tid in rqdata.runtaskentries:
         if tid in rqdata.runq_setscene_tids:
             pass
         elif sq_revdeps_squash[tid]:
             bb.msg.fatal("RunQueue", "Something went badly wrong during =
scenequeue generation, halting. Please report this problem.")
         else:
             del sq_revdeps_squash[tid]
-        rqdata.init_progress_reporter.update(taskcounter)
=20
     rqdata.init_progress_reporter.next_stage()
=20
--=20
2.47.1.windows.1


