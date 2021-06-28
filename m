Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.6920.1624853645372987454
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Jun 2021 21:14:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=k2Na6BmT;
 spf=pass (domain: konsulko.com, ip: 209.85.221.50, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f50.google.com with SMTP id g7so14769720wri.7
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Jun 2021 21:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dPDzjDukY2ba6YpG0bkoaT6L1Pl+ENIL0F6A8XK533E=;
        b=k2Na6BmTob0tihW3MZFRym1cSlt/PF/Y2c+LOYAOJYtFh7Pf2fS3CB6UmvhRANdVyZ
         AREnczYPOXBfb4rKdZKMgo68+Jy+7B+umTHbIXaIzQeP6DHG70EiESBC4aZc1c3HmBIm
         xE9xha+6CDcQVXpbtcFdnDwwxx/GugRfHi0xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPDzjDukY2ba6YpG0bkoaT6L1Pl+ENIL0F6A8XK533E=;
        b=IGPWyo6Jw3NBwHrRcgp4jsPyx4TuiBrHsji9MaF8sbd7bLMsSQidj4hR1Gk9znhTyZ
         t0qxsuJWQ+8JpvvkNGUAf/ceEKaWkN1sahZx6ZFRjKlnhWXwmLmesUp1Q95e8I8cVJnO
         0hlfph6i/TLcuSPa7PTbgRPzEG+xPCjC8Fu+U12vOqehVgz5IfOzoTrwhE9bllry5XxC
         ymK+UleEdD3VN0vwaqzix6LVBM2GV7kz7bnv+Hhgyi5EtYbou5lhucijBs9GiU9UyrTa
         wWt73MArtoNUvos9gd3M6sZNS+Es87y6rRaDWKGqXGKiXd6hyJJnFRkbvV276p8EfbFU
         rrww==
X-Gm-Message-State: AOAM532cVDtmCizC0zzEU41xrHd9ghEr6cVS8tC4fo09NuQjL9bOp5SM
	8tvAY3FTRFzhJUYLhN4OUDw969esITW++A==
X-Google-Smtp-Source: ABdhPJxxxByAOeZHa0ccYFEqUOtly8CgQ12Q7em8IEntv/D8qhvdOTLBtY5vRYy1Iqs4j57efWUByA==
X-Received: by 2002:a5d:64a1:: with SMTP id m1mr24152667wrp.377.1624853643793;
        Sun, 27 Jun 2021 21:14:03 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from owl.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id b187sm2874590wmh.32.2021.06.27.21.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:14:03 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v3 3/4] asyncrpc: Handle exceptions
Date: Mon, 28 Jun 2021 05:13:55 +0100
Message-Id: <20210628041356.2676-4-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210628041356.2676-1-pbarker@konsulko.com>
References: <20210628041356.2676-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an async task raises an exception it may cause the asyncio loop to
hang or may otherwise leave our server in a bad state. To avoid these
issues we can add an exception handler to the asyncio loop which
attempts to gracefully shut down the server if an unhandled exception
occurs.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/asyncrpc/serv.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 0cdae5327..b4dd6d080 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -198,6 +198,11 @@ class AsyncServer(object):
                 await writer.wait_closed()
         self.logger.debug('Client disconnected')
 
+    def handle_exception(self, loop, context):
+        msg = context.get("exception", context["message"])
+        self.logger.error("Caught exception: %s" % (msg))
+        loop.create_task(self.shutdown())
+
     def handle_signal(self):
         self.loop.create_task(self.shutdown())
 
@@ -222,6 +227,7 @@ class AsyncServer(object):
     def serve_forever(self):
         asyncio.set_event_loop(self.loop)
         try:
+            self.loop.set_exception_handler(self.handle_exception)
             self.loop.add_signal_handler(signal.SIGTERM, self.handle_signal)
             self.loop.add_signal_handler(signal.SIGINT, self.handle_signal)
 
-- 
2.26.2

