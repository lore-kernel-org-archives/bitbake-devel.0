Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A97EFEA818
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 07:12:11 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16738.1774422717925606186
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2026 00:11:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Gu8KjLIa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b4d734678so1971726f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 00:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774422716; x=1775027516; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDlrp4i2LcvUom+NjlkLxKqXmODFBXOJeGcAsltEH68=;
        b=Gu8KjLIavvvflAmcxuGg267Va/WBjk07lePjADMx5TNfasP26xSsvRcLP4AcZv8nM9
         knEAA9rJjGd3D/VBM76+ctQSPYezrc8hsD2e8b73Pcv1LrIL4UjqJIZgQp7diRiTxrun
         2MFoXIK7bWGqquZseWRv7dr9WKYUZrvHHcvaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774422716; x=1775027516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDlrp4i2LcvUom+NjlkLxKqXmODFBXOJeGcAsltEH68=;
        b=qdWgQ5xIiMsKezTVJXfe+Jq3qcAPsF9YmfopFara+nbuFTwysfizZpIMZ9nHBqG2Bx
         HllSXYQack5fHwIMee72E4FvKtvnHUHX9l0xJCE86Jeu21eP3LTmNbu291daHLjoh2zc
         rmXrJVFiuu8Sa1VzeLItZjXLyoimP6zVvt3ZukqeC9RYfclNH81Vb+l3W6mT2RhIQBj6
         8RgLphDft39/JTQuxYUIQrk98tdi5Rj7a6aNiqLx1O+uH1H9ZuzLh5+P2N14qhjxIhJr
         tmfRpX5qTMWkh8VHwyG+RggsyXiWhb8OEoelt5DLEFbBQw0vfi1U2w54ckUBU6WVlMEo
         766w==
X-Gm-Message-State: AOJu0Yyc+74ln1+RXbxtAFaALCkHLXOPUtgUHaW4qabO2Q252P/qGmHC
	1W15aE5aNOiki6uJCYytQRDflMpAyzS+kuOOVKaOPx5eiS8mjTCRmZ7IuT3Q7xEDp8uF130DxCC
	X0i5l
X-Gm-Gg: ATEYQzzuBjXa7UtyFLntfX9jJEw21gtwdtcNNrCWL6wJVoUkn9N5eK1+0FIUCbDXhX1
	cgdPQS9chjTc0tYAmaF/ZKc5P++o+Aydq5yyIeO9USMqTZmMd6aZa1WfdjhpnE8J/ucalZ/PtG/
	Q01lzB/bZuBowaXLpTZkIsMO1QKIg5sWA6lAG13Qwd9I3NHnpKfgCvCrXVwdT2RKK/BS/EHqw/d
	X1rMUFWjpfs57ihW+4xsddXzrAfZi/6dIs6HDBH+ICNIYfkZDx0qeRljKI2/3kCFqVLkJzJeMe6
	lKgT5+RRC9i9FCqB5ceHSa+gKIxUPwXymKvz7FawyTUJXnfl7JEK+5aU8Ul9gVVIT9MW2omAMUb
	WKmeWkzM4eWdxA8vXjLyc/wxWYtBlElVFoba4ys+5fJjgz23OK1OL0KpsA65jYa38Q0A3TfZIHW
	g416wUI5Hm/V2n87Wl7vHTq2FKWd0uymh8JFQG1v5P1YusKmtlXjJ9
X-Received: by 2002:a05:6000:4285:b0:439:f5ba:8c2e with SMTP id ffacd0b85a97d-43b889a8526mr3170444f8f.18.1774422715599;
        Wed, 25 Mar 2026 00:11:55 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:74e2:2425:51dc:4aed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470f902sm47450402f8f.28.2026.03.25.00.11.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 00:11:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] progressbar/knotty: Allow mixing log messages and progress bars
Date: Wed, 25 Mar 2026 07:11:51 +0000
Message-ID: <20260325071151.3947605-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 07:12:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19219

If we try and print a log message in the middle of progress bar, the display
can be corrupted. Add a clear() method to progress bars allowing them to be
removed for the log message, then reprinted using update().

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py            | 10 ++++++++++
 lib/progressbar/progressbar.py |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index e4b7b83061e..82531ef8f31 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -87,6 +87,7 @@ class NonInteractiveProgress(object):
     def __init__(self, msg, maxval):
         self.id = msg
         self.msg = msg
+        self.currval = 0
         self.maxval = maxval
         self.finished = False
 
@@ -96,6 +97,10 @@ class NonInteractiveProgress(object):
         return self
 
     def update(self, value):
+        self.currval = value
+        pass
+
+    def clear(self):
         pass
 
     def finish(self):
@@ -791,7 +796,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
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

