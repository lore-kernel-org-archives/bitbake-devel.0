Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CC0FEC11B
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 22:01:05 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9029.1774389656107844939
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Mar 2026 15:00:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RamTBouZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b4d734678so1720033f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Mar 2026 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774389654; x=1774994454; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j38dY99DQqTQmBPrCdm3zNpyGNSN26KIb3Ry/xZCsCo=;
        b=RamTBouZV2bUJApaMt3Od/ZVEZwDxcFriQx6lg2NXed39gBoARoqRgcXaWA7VEpt+K
         o/aZyq2pMB4YES9TlXxx+73etj+Rk4zEdVTLqkiyQOfbHFzHORun0YJdKcmcRTi4hSwR
         aedf4F6YUO6736iFyuhFUjT453BZiA0KJ2zzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389654; x=1774994454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j38dY99DQqTQmBPrCdm3zNpyGNSN26KIb3Ry/xZCsCo=;
        b=o78VqH7CULm7SVpFYOqIhz5ln+Yc/GGDyoghrOWvZvanKlKhG3IM0LOJ1z6K4P9Aip
         wBnVhISgzajHm6sKoo+w7qgKWs13XDPtY8T9kFdw6s1eRDeBjmDnqucJOeQQjYyGCyko
         8EkAG5Cx21RWoioqXUvX5iWa6SLrGu2ezyOvgpUHtdXlHyyyvEtpDB5BFT/4V4hRzKnX
         Y7CoZLy1t9g70Svh0KlrOg+Zhj4IY1a4k/WQ019QiBQUDKti7CZGcg0XVL+9gODro6aC
         43kFBElSq23xeSfz6QCRhBTtrRXa/UsQ4VXdxXtYjON3EPSBhBmUVNaVzWQIY5AOK52M
         mnjQ==
X-Gm-Message-State: AOJu0YzWCH1zc3xPgGx38EnrEaT+RhzMmPEyxK/a1Z+fPhJtTEy9VJ8n
	g2wjcwze96pDdbKfriDk+sxt1IE4NlMHlVJ2pUPf/qEX2PkBMMOX68fTFOkuEA2rlMs2edMh9tt
	+1oCj
X-Gm-Gg: ATEYQzwPTIIfZM5EOt99Dhmqs24LG2t8n0WkAhhfmv5RFjo1+fmHEJkA4RyvM5TwHIk
	OHQ18voJ86I/6kLJi0UNZU4UXdXNxcpNSgmrl2dQYJH/byGO3wvZk+AaA6z2OCTTSRDXAtisi3Q
	XA/7WDZNxRMw2MnRLa7CEwa6Eza+ZdOxCrGjM6LfIOVYxc5bWOiBDw/+VGkkQIfIzz+B+qKITA1
	tY+4oW6NjQo6421FfJ+IeM4ruLrfcWiF2afkHvs9HAHcTCCWI5JOItovsePEeIeXHZhFvvrs0gb
	6tLS6xYI8GR5fQedXStBq6rKhwV/djvG/yGhoYb8JdYRo7q8mKZS7CzSds5uUEh9zO6NAIWx1X+
	e2tcpZQt5GP0LXPM0JlOGXZOI4LE7U+5De1mGisW/R/81EBlaobmEqVFa1Kf9sqO4SbUlIXTKkn
	pDrLwSB362EODoT2rIaZjvbWOW9hl5CPS++dbaMyoQSh/CMEF8uWQ=
X-Received: by 2002:a05:6000:2405:b0:43b:4352:1be6 with SMTP id ffacd0b85a97d-43b88a39b6fmr1474617f8f.48.1774389653481;
        Tue, 24 Mar 2026 15:00:53 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5a86:3f36:450:3dc8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b86fbb195sm4955240f8f.14.2026.03.24.15.00.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:00:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] progressbar/knotty: Allow mixing log messages and progress bars
Date: Tue, 24 Mar 2026 22:00:51 +0000
Message-ID: <20260324220051.3701826-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Mar 2026 22:01:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19216

If we try and print a log message in the middle of progress bar, the display
can be corrupted. Add a clear() method to progress bars allowing them to be
removed for the log message, then reprinted using update().

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py            | 5 +++++
 lib/progressbar/progressbar.py | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index e4b7b83061e..06b654c4422 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -791,7 +791,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         event.msg = taskinfo['title'] + ': ' + event.msg
                 if hasattr(event, 'fn') and event.levelno not in [bb.msg.BBLogFormatter.WARNONCE, bb.msg.BBLogFormatter.ERRORONCE]:
                     event.msg = event.fn + ': ' + event.msg
+                # Need to remove any progress bar, then add it back after we print this message
+                if parseprogress:
+                    parseprogress.clear()
                 logging.getLogger(event.name).handle(event)
+                if parseprogress:
+                    parseprogress.update(parseprogress.currval)
                 continue
 
             if isinstance(event, bb.build.TaskFailedSilent):
diff --git a/lib/progressbar/progressbar.py b/lib/progressbar/progressbar.py
index a8e2dc09c91..1562774ba1a 100644
--- a/lib/progressbar/progressbar.py
+++ b/lib/progressbar/progressbar.py
@@ -278,6 +278,9 @@ class ProgressBar(object):
         self.last_update_time = now
         return output
 
+    def clear(self):
+        self.fd.write(" " * self.term_width + '\r')
+        self.fd.flush()
 
     def start(self, update=True):
         """Starts measuring time, and prints the bar at 0%.

