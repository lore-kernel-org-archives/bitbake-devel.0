Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web09.6270.1627353490162811200
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 19:38:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=cZDleZgc;
 spf=pass (domain: konsulko.com, ip: 209.85.160.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f178.google.com with SMTP id b1so8630175qtx.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jul 2021 19:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AlbwAP/340Ho06f6Be+wJk9sv315T+EEqRbjs+PJ/IY=;
        b=cZDleZgcKM18z0SWHrsOM1OcBF5aTLSh8YlNAnJpomkFSPEuCXOs5sWst8Awc1PDCp
         kCH6JFSzzeo1YSWf23CWUiA5wV8RVb6e1UD5fZ/osTbrInIm0oiBZ/DPb7fjavcuFKaM
         /eWpQOoj3e1mVVdFTeQ27aApQI4sEWOQUgZSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AlbwAP/340Ho06f6Be+wJk9sv315T+EEqRbjs+PJ/IY=;
        b=m3CMfvUN5jFeomjcscQ0acndZ4NhOmoTvZwQ3msnt5RMbOwkGFNr1IN1l64go9Hp3e
         uTXAfgWNPzUoxAAmgLDE6CIPEmJ3Gk4mVXSFCckj8Dul7fTfM2p9+7zz8II3dburpTiZ
         f3vb0Px9i4hJYZnh1MzLVOHqBgu6EHoZ00zJSEsokPtAOpqJYMLOobFmHWDue3w88zHb
         3WSClvpR/NXINHDmPpOTIapVHnTOJBAV3c5HVY8VlvUtK9/YcmM+FKwQIdADc1a9mixy
         c8+noNssbWPW4iUOmfU64GcnPz4vu+hGFFAWjXn19Wd6cB9GedL/Ybd75whMQA4EsDfS
         6UTg==
X-Gm-Message-State: AOAM533XirCmnd7G4PfS4dfRlP5B6EugCCH6Y2R0biO/Uf/8MGCIvNza
	xO0ZbncdrenR7u38TU4+bCQP2GVMARpFaQ==
X-Google-Smtp-Source: ABdhPJyE0tGzRCPLjh9lG2Zqow93IFFasOdYmQU/GlnBdMP16kf/qcOo4tyalJ9pihfaJdb6zddMuw==
X-Received: by 2002:ac8:7613:: with SMTP id t19mr17604534qtq.78.1627353489062;
        Mon, 26 Jul 2021 19:38:09 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (198-84-179-103.cpe.teksavvy.com. [198.84.179.103])
        by smtp.gmail.com with ESMTPSA id h10sm974887qka.83.2021.07.26.19.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 19:38:08 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v4 3/5] asyncrpc: Handle exceptions
Date: Mon, 26 Jul 2021 22:37:54 -0400
Message-Id: <7813b76d15609d40f20d4b91c9993e6caceba907.1627352176.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627352176.git.scott.murray@konsulko.com>
References: <cover.1627352176.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Barker <pbarker@konsulko.com>

If an async task raises an exception it may cause the asyncio loop to
hang or may otherwise leave our server in a bad state. To avoid these
issues we can add an exception handler to the asyncio loop which
attempts to gracefully shut down the server if an unhandled exception
occurs.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
[updated for asyncrpc SIGTERM handling changes]
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/asyncrpc/serv.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 1b7b7a6d..167b30c7 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -209,6 +209,11 @@ class AsyncServer(object):
         self.logger.debug("Got exit signal")
         self.loop.create_task(self.shutdown())
 
+    def handle_exception(self, loop, context):
+        msg = context.get("exception", context["message"])
+        self.logger.error("Caught exception: %s" % (msg))
+        loop.create_task(self.shutdown())
+
     async def shutdown(self):
         self.logger.debug('Server shutting down')
 
@@ -227,6 +232,7 @@ class AsyncServer(object):
     def serve_forever(self):
         asyncio.set_event_loop(self.loop)
         try:
+            self.loop.set_exception_handler(self.handle_exception)
             self.loop.add_signal_handler(signal.SIGTERM, self.handle_signal)
             signal.pthread_sigmask(signal.SIG_UNBLOCK, [signal.SIGTERM])
             self.loop.add_signal_handler(signal.SIGINT, self.handle_signal)
-- 
2.31.1

