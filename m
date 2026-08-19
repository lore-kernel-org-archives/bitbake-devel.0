Return-Path: <WXbet@proton.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C83C5DF6D
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 09:33:49 +0000 (UTC)
Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3217.1787132022709636178
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 02:33:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=j4dLBfnq;
 spf=pass (domain: gmail.com, ip: 74.125.225.66, mailfrom: wxbet.oe@gmail.com)
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so183853f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787132021; x=1787736821; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FSsB7s1iBbEGvcMZXGoFe/LUBq3Rg8D/0j4Y+gR+/Ag=;
        b=j4dLBfnq4UfExWqIPzFjBdXdsu8flG0BxY2gbxE262/YCcO0IOKCsO2LnRsjPzMC+l
         PpCdZesjk730S+Oz7AgvWBLtswRPwuBJVlZui8fWkkHhJggSqvu+PVXg86mnJ7Nlb3Ne
         nzbr4yga29T7dBRornNaAcERddEeD1tqxFx7kcEhRYzOlaNUyvgDMiHLeUlYef/rlDJF
         s4KWtaJxLhwMcc+Um8K1JeFgwNk7vb4bo4dp32mFQ2QHu2I1HOIfK8cHMd9AThHbg496
         Qw2Y17Z3QkutDQtLJprXpTUwSMUNFJFtD+2H/Muzh7HLJpIQwPWOeY4qjdykLhz4QBBg
         j+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787132021; x=1787736821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FSsB7s1iBbEGvcMZXGoFe/LUBq3Rg8D/0j4Y+gR+/Ag=;
        b=SOjDMeBova/FSEBLzCp2oInIH+fdjRcauC3uVv+GYlWMBIQ0jWRefmAxl1J/WuScUx
         2YDrE0YNN0+YBedLFmyKcLoRBt8c6M8fGaMApTaiDb0kwIbtVJzNBUzMqMBkFrnByMY5
         hL8MWJ9YJeNVksjgVH2kgl1MVORk8kSC84uSook/sm4cgAbsLVm0lNtFeteyqIvVaCDL
         GMS7ITro+eltnqpbPRe5D01ToscpdWVfnQWQP2nnl7xDIm+hi4NjwC2u5vPUqc3C4h6n
         NZWhp/mWBePyuH9328at9gseOmTtKzrSI89/T0JML1iv5dMUeXAY44xIsLh2twf6D0yG
         hViw==
X-Gm-Message-State: AOJu0YwNhegQqas1b1AUS+EK1BVhkAsofBQK+SOs5J5iBJHdUhwLUwxw
	DM5UeVp4zTWWYLlLbG6UVOGJNM2hMpAUkubl8oXSiVwDpFZFTUc2biGT5s3z0hBGiVdfgNJw5N8
	=
X-Gm-Gg: AR+sD11wfcMBjoctz+kJ/T6fcyZzsxsobWDirFQLguo1ztS10t+wJcRpq6gpSr6nEUY
	AuECnXuIbqcRGWznKIdN8XNVCWK2JoJu494Ak4g1PR7U9uyvqmOpQPgTzAbr1rdy9+SsuKVe747
	05y1H+9/C84IyJnFTAcw3eLW/Kv/626sXV05ui5iuGxx0v+KU9UQtWu5s0zs3PbsZ2MLQRRwW1W
	Pok73IsHj5CwRmpYbZ2VXvUB1AGgPxnA8osvkCZuu6uQzbw6A7PQn39+BLfD4lp8M3OMzj2m2MD
	J00TCWkfcbhElJgXdF4kx8EvjJ36KtJW+/dzrLv3vFM+0w7atFVEx+3DfTio3soBq7b6K7XuRFb
	+POIT27UMZpJ0uuelmw0Vn9AxvcDOGv3tcNx801HcBBGhtTD8YvQQ0+m0OMhCQTezGkwXTxV3sz
	fOGZvX9rbTzS9S+h1PvCFwcio1preG2xo0UpWBwvmgWBJbpDxoDqbwZ0hQ89sFmOVVDBzTdQ==
X-Received: by 2002:a05:6000:25f3:b0:481:4810:d701 with SMTP id ffacd0b85a97d-482b1feb276mr5983082f8f.19.1787132020710;
        Wed, 19 Aug 2026 02:33:40 -0700 (PDT)
Received: from localhost.localdomain ([94.31.114.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b80a5sm4563016f8f.24.2026.08.19.02.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 02:33:39 -0700 (PDT)
From: WXbet <wxbet.oe@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: WXbet <wxbet.oe@gmail.com>
Subject: [PATCH] knotty: show elapsed time on the task progress bar
Date: Wed, 19 Aug 2026 11:33:21 +0200
Message-ID: <20260819093321.3451-1-wxbet.oe@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <CANNYZj9uDoKqqx_WV2CZ0-Q99AdRWzVUXD4idpcrZMf2Zpw28Q@mail.gmail.com>
References: <CANNYZj9uDoKqqx_WV2CZ0-Q99AdRWzVUXD4idpcrZMf2Zpw28Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 09:33:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19991

The progress bar for the overall build shows a percentage and a bar but no
elapsed time, even though the individual running-task lines below it each
show one.

Add a Timer widget to the bar. The time formatting in
TerminalFilter.elapsed() is hoisted to a module-level bb_elapsed() helper and
reused by a small progressbar.Timer subclass, so the bar prints the same
"%dh%dm%ds" style as the rest of the UI.

Signed-off-by: WXbet <wxbet.oe@gmail.com>
---
 lib/bb/ui/knotty.py | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 15025e8dd..343045881 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -37,6 +37,21 @@ featureSet = [bb.cooker.CookerFeatures.SEND_SANITYEVENTS, bb.cooker.CookerFeatur
 logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
 
+def bb_elapsed(sec):
+    hrs = int(sec / 3600.0)
+    sec -= hrs * 3600
+    min = int(sec / 60.0)
+    sec -= min * 60
+    if hrs > 0:
+        return "%dh%dm%ds" % (hrs, min, sec)
+    elif min > 0:
+        return "%dm%ds" % (min, sec)
+    else:
+        return "%ds" % (sec)
+
+class BBTimer(progressbar.Timer):
+    format_time = staticmethod(bb_elapsed)
+
 class BBProgress(progressbar.ProgressBar):
     def __init__(self, msg, maxval, widgets=None, extrapos=-1, resize_handler=None):
         self.id = msg
@@ -250,16 +265,7 @@ class TerminalFilter(object):
         self._footer_lines = None
 
     def elapsed(self, sec):
-        hrs = int(sec / 3600.0)
-        sec -= hrs * 3600
-        min = int(sec / 60.0)
-        sec -= min * 60
-        if hrs > 0:
-            return "%dh%dm%ds" % (hrs, min, sec)
-        elif min > 0:
-            return "%dm%ds" % (min, sec)
-        else:
-            return "%ds" % (sec)
+        return bb_elapsed(sec)
 
     def keepAlive(self, t):
         if not self.cuu:
@@ -354,7 +360,7 @@ class TerminalFilter(object):
                 msg = "Currently %2s running tasks (%s)" % (len(activetasks), cur_tasks)
             maxtask = self.helper.tasknumber_total
             if not self.main_progress or self.main_progress.maxval != maxtask:
-                widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
+                widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar(), ' ', BBTimer(format='Elapsed: %s')]
                 self.main_progress = BBProgress("Running tasks", maxtask, widgets=widgets, resize_handler=self.sigwinch_handle)
                 self.main_progress.fd = self._footer_buf
                 self.main_progress.start(False)
-- 
2.53.0


