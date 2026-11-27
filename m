Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1413.1795801582520709541
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Nov 2026 09:46:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fTphmeLH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso79791955e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Nov 2026 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795801581; x=1796406381; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BjqNqeA04lg1SVARpOAdL0o/Eyxw7GSZLxPxXicWbIc=;
        b=fTphmeLHXn8FZwLmeUdVzkzbnc/GYecqDHZnaEOL3Grqhu1G4fsDq7HC3mXgJF+9/9
         bI158+p7eXqc0n8tKXS7CPcKJP8abX0fxkbnPAta2CtCuBKM0JoSAmvgTJMB21d7N1DN
         h9pR/jSecnkdREW4nCfdcQ70odfBU4283hJlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795801581; x=1796406381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BjqNqeA04lg1SVARpOAdL0o/Eyxw7GSZLxPxXicWbIc=;
        b=r7zBwm9U9dMgIkDrVsspvtIfitEsAZz2LNkmVVMCTcbZUfUXLtabaBTwE25N7oRtyT
         VpcrUaXI6rnNd3OljGBdToozLf5RgjIF4lGpJ5HyH/ALU41e99IW0Cf2sodarnF1686y
         FYcExo0I9qfmPbfPIAUit+HBauPxOT68JLQby1Dhux9VFfzCgUmQdBoNFEYz7L/xSqD8
         47IuybduFXnwOj/x8tP0ZULYAswGtGFHYULiJMZlF+U2ShfuZWpqqdqWDSw/YYex0WHr
         E+w7Ff2LXGqdy2jyCI2cLLnhXOD6LsqPSKCc2Tre3oZMkI+ELxyWRoSo0HIOvYMBDQUF
         YEjQ==
X-Gm-Message-State: APuU4Z93R+bdz8Qbe+BaxpQhpezRWGgg0ObHnBiKvtdWrV1sZvYmVp7c
	Tmt6ftAOs9ZDilTHvWYvOkF0k1+R7bTiwxF0uEZYf0RBB4IouIk6hn68Oo367DoNSR+fOZ92M4I
	v+OI/WLo=
X-Gm-Gg: AZFdTZcAvZ2U4+Dg0E7vJej784T2tHFeJBw4cOPHteGkKVgpfmn7tSPhn77v496Pa+C
	u7rSgye/bX6gOv9heD5p4xjYipDYlFGhtJDIehEDVWQUVrgS3WI8PqaD6Kn223nuW0FklAYE7AM
	VvYt2M+/BWeoJ+HakxOrbrbiyJsh1TaDHSf8OppIUFOemqPcjRkDh8Lzd/BphqnUbAy6A9koVC9
	SCkcYyswQNyam0FrcVtZlD9yAkwOTJp+hNQZSKtrfM9eJZdrBSHMt16YQpTYLPpf8VD1ke+FYSd
	hz4DhvrE796wDFWEeWaUJqQ++Mz/CMfHxV+rfVfx3M2u/Q/R9JyMknd1ASLq/0QmePgyx7+hTgC
	kxY5oG/KWZDUO9QAhrAeFDwIY1d2ee1E3pH+5/nejntRs+CZ+Uig3EA2Mb/zn/Uy2M92b1StBKV
	d1p6WM2jgVRoeXCJgdzjFbZdHJQQPqvNdrfTqTWLZsqTbhZlsxWojSY0FvkZOIhz7VvF3Hr6Q5f
	QwYyconh2Lb3RAszOtW9AX92YwRvZclb3U0gcYgvKOZJn1VGERO74OJQq0x+d7rl6srp0Os7r06
	TEMUvmfxAgl6ewtIac5O013ZZi8GM0btRMQ0e8lY8ewsKlhn1cCMy4kgFA==
X-Received: by 2002:a05:600c:5306:b0:4b7:6aac:7406 with SMTP id 5b1f17b1804b1-4bb887ca0bamr468296045e9.3.1795801580671;
        Fri, 27 Nov 2026 09:46:20 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:47cb:b596:3be3:8f97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm790022715e9.3.2026.11.27.09.46.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:46:20 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] runqueue: Add a RecipeCheckEvent
Date: Fri, 27 Nov 2026 17:46:16 +0000
Message-ID: <20261127174616.2269186-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261127174616.2269186-1-richard.purdie@linuxfoundation.org>
References: <20261127174616.2269186-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 27 Nov 2026 17:46:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20481
Content-Type: text/plain; charset="utf-8"

This event triggers at the start of a build, once the task graph is known
and provides a list of the recipes which will execure alongside any custom
variable data that was requested to be cached in BB_CACHE_EXTRAVARS.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 501fb92dc49..edb6c7d01ae 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1608,6 +1608,8 @@ class RunQueue:
                                   ('bb.event.HeartbeatEvent',), data=self.cfgData)
                 self.dm_event_handler_registered = True
 
+            bb.event.fire(RecipeCheckEvent(self.rqdata), self.cooker.data)
+
             self.rqdata.init_progress_reporter.next_stage()
             self.rqexe = RunQueueExecute(self)
 
@@ -3316,6 +3318,15 @@ class PSIEvent(bb.event.Event):
         self.pressure_state = pressure_state
         self.pressure_values = pressure_values
 
+class RecipeCheckEvent(bb.event.Event):
+    def __init__(self, rqdata):
+        super().__init__()
+        recipedata = {}
+        for tid in rqdata.runtaskentries:
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+            recipedata[taskfn] = rqdata.dataCaches[mc].extravars[taskfn]
+        self.recipedata = recipedata
+
 class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
