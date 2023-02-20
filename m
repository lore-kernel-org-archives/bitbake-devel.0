Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB44C677F1
	for <webhook@archiver.kernel.org>; Mon, 20 Feb 2023 22:25:52 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.27832.1676931944997546095
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Feb 2023 14:25:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=KrpIYPKs;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.44, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f44.google.com with SMTP id cp9so3865640pjb.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 14:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BARB8zVTcsA1ibO49/oB9csZGNsfIQ0kMo7J9xwylbg=;
        b=KrpIYPKsN093n7ptIUBpnmI6vsgCtLeWNOiLc+W2AL1VeJgI0d7exWJ9np4fSLa39E
         8xn+ErF0F8pdtMZDrIfGklTt3c52GuxBWsWoYXJePLbCETXoK+TUumgty4Pe+kQwF/Km
         iDQIAb37byu99Z57csrIqOZey2fLT2EG8hAZ2ixlqYTvbibYHAcZJocQzRke8tYQp2EX
         yUiL9Ju+DxAHp/SNM00QrdVo2qyzSNWA5gI0I82BQ6OQ4mWwzFH6vCtF5Ij+g29ucFl7
         oIgUszCW7J20gKEJUGYnkY49HKx1kzfTpdWvSON//Eu3WMOsFhrTROu3FzjjZrMvvlKs
         YBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BARB8zVTcsA1ibO49/oB9csZGNsfIQ0kMo7J9xwylbg=;
        b=WEdV9xfJXBoSR+o07e2hF6HoRDUad1r8y/AUhGnUSAQr9urIkyCB2MJDtc9eo8LwP8
         m6uLeldtXdhyfbPKISQ05tB7KfwbH0l07tSjxEXB8d6N/Rv9I2iJntP1QZ8jKCYv2bi7
         m3wwTcE5sBoLjJgZcMGLsmjVDpSAaFee8EiIIINxNf4AjiDnmXAUBJV1Tnxlka8lIuzh
         ZG/5rEBsMG4DpDwEjBQZ/C3Vbzypb4iVfotZQWgz5pDM7uT3RRZl+P4zjw8d4yEXZwi/
         FT6u9lfpeEXlrhJFSH2/8xtWXu7+QnaVCOVZ8vHs14J7Q+0GFkh6E/jj3E5PrVndMZbx
         i0tQ==
X-Gm-Message-State: AO0yUKVTLY5AbHxMITukgmjU2wC0LJBqpfFIzVWov2ZzndDxP98oaOZz
	4YBXZrEXtV5XnaQsCvdbgaetRKpdEFIQcur3FwU=
X-Google-Smtp-Source: AK7set9a6AOXpZQl+z11LYnLHLd8TwdWawOlANdrrok2ckLUOB/ul/SO6u8hjg5GTuEg4B6kqt6JxQ==
X-Received: by 2002:a05:6a21:789c:b0:c7:7afa:5016 with SMTP id bf28-20020a056a21789c00b000c77afa5016mr16985109pzc.9.1676931943971;
        Mon, 20 Feb 2023 14:25:43 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b005a9131b6668sm8191447pff.2.2023.02.20.14.25.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:25:43 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 5/7] runqueue: Fix issues with multiconfig deferred task deadlock messages
Date: Mon, 20 Feb 2023 12:25:21 -1000
Message-Id: <03cf0d9fedfef1ae43b3c3cac07710487857af36.1676931822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676931822.git.steve@sakoman.com>
References: <cover.1676931822.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 22:25:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14472

From: Richard Purdie <richard.purdie@linuxfoundation.org>

In multiconfig builds with large numbers of identical tasks, builds were
deadlocking after recent runqueue changes upon rebuilds where there was
heavy sstate usage (i.e. on second builds after a first completed).

The issue was that deferred tasks were being left indefinitely on
the deferred list. The deadlock handler was then "breaking" things
by failing tasks that had already succeeded, leading to the task
being on both covered and not covered lists, giving a further error.

The fix is to clean up the deferred task list when each setscene task
completes. I'd previously been hoping to avoid iterating that list
but it appears unavoidable.

[YOCTO #14342]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ae24a0f2d2d8b4b5ec10efabd0e9362e560832ea)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c7f50fde..f63a2191 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1975,6 +1975,12 @@ class RunQueueExecute:
                 self.setbuildable(revdep)
                 logger.debug(1, "Marking task %s as buildable", revdep)
 
+        for t in self.sq_deferred.copy():
+            if self.sq_deferred[t] == task:
+                logger.debug(2, "Deferred task %s now buildable" % t)
+                del self.sq_deferred[t]
+                update_scenequeue_data([t], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
+
     def task_complete(self, task):
         self.stats.taskCompleted()
         bb.event.fire(runQueueTaskCompleted(task, self.stats, self.rq), self.cfgData)
-- 
2.34.1


