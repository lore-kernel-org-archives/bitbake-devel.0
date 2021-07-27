Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.web12.4618.1627406520980066417
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jul 2021 10:22:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=B380Blyc;
 spf=pass (domain: konsulko.com, ip: 209.85.160.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f170.google.com with SMTP id k13so10034135qth.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jul 2021 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+LTTwB+D5I3Hfc6CqE528tOpFNB6E+vjv6qll0Sl3lI=;
        b=B380BlycqDWs3urrHNEYNyA8lkBwnMOe/lsVM3ZSY7Q6H5YYpaKNN3rTGRyrHjcFxI
         nX5pdvKaVCD9YV8VqjUw8vFtgn8LXjXxuodErF3t+eV/RCHrEpE5CMVKnOZuXcwFsJxN
         1KMKpL1CL0i8E9ef5Y/TtqePtQV+uuOeo6SyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+LTTwB+D5I3Hfc6CqE528tOpFNB6E+vjv6qll0Sl3lI=;
        b=hbiHe4MnNwQobNZHrOgh8704/0AwxC04L2cNrxliEwr5WyvmLe3LUHdq5Fr++z4fj9
         89eMEpbnoOkZN2rbz15+8bFlbaKxlDyMJxtZtMGrJ5EgKyCKG34OGAACoO4WnnoEH7Xu
         xc+qH7HsXBBEsEDcHUUFnecgFK1I5SOpwH8AkWTDN97NQxHlicSbL5w2yUbpMOt4fgZl
         mD1w1aY68LZozSxbQ1IXIpA4rMaqo4PXApvoTvtH7iGiWffheXHemNk+BESXn7jMI2ls
         aC7w0iC89jGlPnmOgHbbrwg8JW81tMWo36Y1NiGPZgng7y6qhQzkzeqV7Kj3ekCJ3STF
         iMXg==
X-Gm-Message-State: AOAM531N/cqb3EE4Sm1xFGuVrG/ypc5+DIejttvwDcLAbwj7b20EyMnP
	FEfLMDHQsvvhdio4BMv4uD9TyKluboiavg==
X-Google-Smtp-Source: ABdhPJwx81Oo4ntn2+TkmlSm9PMl7Brmbxu4wQJCGeidw0ZXKoIMDGOBGwWkIj9FHlbKYVap3qRu4A==
X-Received: by 2002:ac8:110e:: with SMTP id c14mr20456473qtj.76.1627406519866;
        Tue, 27 Jul 2021 10:21:59 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (198-84-179-103.cpe.teksavvy.com. [198.84.179.103])
        by smtp.gmail.com with ESMTPSA id f2sm1648719qth.11.2021.07.27.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 10:21:59 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Paul Barker <paul@pbarker.dev>
Subject: [PATCH v5 3/5] asyncrpc: Handle exceptions
Date: Tue, 27 Jul 2021 13:21:43 -0400
Message-Id: <cbf50a4ee193c247892db579fbeceb14af1896fc.1627405824.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627405824.git.scott.murray@konsulko.com>
References: <cover.1627405824.git.scott.murray@konsulko.com>
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
index 87d142c1..0e60997d 100644
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
 
@@ -231,6 +236,7 @@ class AsyncServer(object):
     def serve_forever(self):
         asyncio.set_event_loop(self.loop)
         try:
+            self.loop.set_exception_handler(self.handle_exception)
             self.loop.add_signal_handler(signal.SIGTERM, self.handle_signal)
             signal.pthread_sigmask(signal.SIG_UNBLOCK, [signal.SIGTERM])
             self.loop.add_signal_handler(signal.SIGINT, self.handle_signal)
-- 
2.20.1

