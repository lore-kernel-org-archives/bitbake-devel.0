Return-Path: <gowrishankarstg@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB47CE7AB1
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 17:33:14 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.67581.1695663185340920204
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Sep 2023 10:33:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OBevCrqU;
 spf=pass (domain: gmail.com, ip: 209.85.215.176, mailfrom: gowrishankarstg@gmail.com)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-578a62c088cso5965407a12.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695663184; x=1696267984; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJJwIxit2Flj2brdL+c0or/vktXJiY6yl1or6zGnWqs=;
        b=OBevCrqUsnMiTcfijF8vdphkL9VlPpU4oTkxdvfvW1yLKAMCAu6Ky62GNcjSQD/APM
         j7BiDt2mfaOg6z4rTjCSvaECiRNgibzWOdRmP/CZEV7AVSJTSrBFdBmzt+frra4nZOXV
         ZQag6kBn8sisfWAhKKsuirn1v+XqNDqc5MMN75uk2KjKwNvBqz2OfS+b1QnqzGms7FXB
         ldcFWdcgh00gtbsIH/4/HEb7+Zvg0xf0PKL6imbE3m6PJ8yEzq9Qj+/oAyrrBlEqM+Af
         8mqfggSRvgee6fuDHCfZoW26sxH4/1e75DvfqeOKbOGt7xIUVycIztiG2zDALOT7UvIr
         0KVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695663184; x=1696267984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJJwIxit2Flj2brdL+c0or/vktXJiY6yl1or6zGnWqs=;
        b=vTUXsl9p5T8mg0MxoEgp65ohFeijtakOxB4flgf9KiCp5j2X3ttNqYvNJdLlM+NAHq
         ReHgoVsYzbXBtgGCHEHCGF5N7DuKnnzJwiDXZ6J7hGnFL4dhjwsLnWhGDzDJhc2HiCN/
         mLDKdZGms1hXdNmxUL+KFuF9rE2//YeoRNOdx2Wda861u7l5Uq52fs7auvdm4Adnfoe7
         jWSeu/5Y3IXMMgnVrgwYZBwFOwYDWdtYc76aIB74lMKsGMMjdToag+nK0Vgl1eR3F6ck
         3/YFGn3Vl98J3ly6Ii0ruX76ulzFLtdFzUa/wtTKL5LqCEQpA5PRmLmD6uP1kQ4bDAWB
         h5jg==
X-Gm-Message-State: AOJu0YyDcOKpc6ch5AF5kAlVsI7C4zuQIaCz6eZf5/ughTbUx6wk9gGu
	7YbJhx8QSaoRbUvg2VSb7pu+CTTVwB1rgoDF
X-Google-Smtp-Source: AGHT+IG0TUhgKHwR0VvTc7zSakL7o79y0CO7WUMCRC+eHLmj3/YNP92Vh9ubl5SMt/JfuxdYasxhxg==
X-Received: by 2002:a17:90b:4d84:b0:269:a96:981a with SMTP id oj4-20020a17090b4d8400b002690a96981amr396963pjb.5.1695663184298;
        Mon, 25 Sep 2023 10:33:04 -0700 (PDT)
Received: from localhost.localdomain ([183.83.148.74])
        by smtp.gmail.com with ESMTPSA id ne10-20020a17090b374a00b00277246e857esm4860677pjb.23.2023.09.25.10.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:33:04 -0700 (PDT)
From: Gowrishankar Saminathan <gowrishankarstg@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: gowrishankarstg@gmail.com
Subject: [PATCH 1/1] runqueue: Fix task execution dependency issue
Date: Mon, 25 Sep 2023 02:09:58 +0530
Message-Id: <20230924203958.35361-1-gowrishankarstg@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 17:33:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15122

When the recipe metadata is updated, and the Sstate cache remains unchanged,
a problem arises where tasks dependent on this particular task are found in
both the 'covered' and 'notcovered' lists within the runqueue.

For instance, consider the example of 'base-passwd.bb:do_populate_sysroot',
which serves as a dependent task for both 'systemd.bb:do_populate_sysroot' and
'dbus.bb:do_populate_sysroot.' Due to the lack of ordered task ID storage in the runqueue,
it often leads to the execution of 'systemd.bb::do_populate_sysroot' prior to
'base-passwd.bb:do_populate_sysroot.' This results in 'systemd.bb:do_populate_sysroot'
being erroneously flagged as 'notcovered' by the runqueue.
Nevertheless, sstate later marks it as 'covered' if there is no change in the task output.

To address this issue, this commit enhances the runqueue to store task IDs in an ordered list,
ensuring tasks are carried out in their correct dependency order.
This adjustment will execute 'base-passwd.bb:do_populate_sysroot' as the initial
task and then 'systemd.bb:do_populate_sysroot.'
This strategic execution ensures that 'systemd.bb:do_populate_sysroot' won't
receive an incorrect 'notcovered' status, as 'base-passwd.bb:do_populate_sysroot'
will have already been executed beforehand.

Signed-off-by: Gowrishankar Saminathan <gowrishankarstg@gmail.com>
---
 lib/bb/runqueue.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c40a3be2..446b1667 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1789,7 +1789,7 @@ class RunQueueExecute:
         self.sq_live = set()
 
         self.updated_taskhash_queue = []
-        self.pending_migrations = set()
+        self.pending_migrations = []
 
         self.runq_buildable = set()
         self.runq_running = set()
@@ -2422,7 +2422,7 @@ class RunQueueExecute:
 
     def process_possible_migrations(self):
 
-        changed = set()
+        changed = []
         toprocess = set()
         for tid, unihash in self.updated_taskhash_queue.copy():
             if tid in self.runq_running and tid not in self.runq_complete:
@@ -2492,7 +2492,7 @@ class RunQueueExecute:
                     #logger.debug("Task %s hash changes: %s->%s %s->%s" % (tid, orighash, newhash, origuni, newuni))
                     self.rqdata.runtaskentries[tid].hash = newhash
                     self.rqdata.runtaskentries[tid].unihash = newuni
-                    changed.add(tid)
+                    changed.append(tid)
 
                 next |= self.rqdata.runtaskentries[tid].revdeps
                 total.remove(tid)
@@ -2510,7 +2510,7 @@ class RunQueueExecute:
             if tid not in self.rqdata.runq_setscene_tids:
                 continue
             if tid not in self.pending_migrations:
-                self.pending_migrations.add(tid)
+                self.pending_migrations.append(tid)
 
         update_tasks = []
         for tid in self.pending_migrations.copy():
-- 
2.34.1


