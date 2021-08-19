Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web11.71654.1629391613469275264
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Aug 2021 09:46:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BzSa2HOO;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id e14so7834650qkg.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Aug 2021 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HtWv7c3t2PB20ZCpuMaznQtgZnakhZoPIwTPaHbvxpw=;
        b=BzSa2HOOfSPqjuRm+YVGfTWhr6tvmIKnEAEIFHBUj4uriH9nf3ptHIu6o/+e7HbdXo
         x2vNBDXx73X55CcDXbYiPM1I6ZdNWJGTeUMjJM1qNA/ia/L5h9BeHqUmD44OzRpgac+w
         khUUB9rRDMRJBR4E5aWM30KMiFa0GLtJVBUyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HtWv7c3t2PB20ZCpuMaznQtgZnakhZoPIwTPaHbvxpw=;
        b=iFkqtCPpOaxoY4l9eFhaf31jX8LHg3v82f87c824QSDBMta2M7h7VcANJYba3dYe3z
         008uRNF6yO588NM+rV1Y2iTLDtkSlBzYiR/oAbtDPTXVGFUBu3/A3MNFUdV36iBf+jP4
         9K6KEaEScbhcygnorx5zB2AYAtAHgrcyDRX/0Ju+ysnkRLrPB5kiLgwhw4Mp3O194434
         18YUbhvrkK0N+qA6+vo4ltKBY0PmE2thUHwS0B8uIehiohLmw3S+c1auXecPYL2gvyI8
         uGWgza7ZyQyuYY8yFVFtf8YtIJKZUudoCfUVXM09XNSzOeF8QivKBIAjTN4+rVYnHcOK
         YsvQ==
X-Gm-Message-State: AOAM532jK9K8K3MA7jWjnmLVUm/WiciivmClDfevwvAbHTkirdP1+pdI
	qNearOHlJ3HROGkgg5B1zs4uh+WcGCRwMA==
X-Google-Smtp-Source: ABdhPJw4dhW1qAI1dTqw9QvHvKmN2vbCDICZK5kr+lCYuobWOYiQ8M7UMghhKHr8eo8l9V1EU3Ox/A==
X-Received: by 2002:a05:620a:d8e:: with SMTP id q14mr4562225qkl.409.1629391612283;
        Thu, 19 Aug 2021 09:46:52 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (192-0-174-222.cpe.teksavvy.com. [192.0.174.222])
        by smtp.gmail.com with ESMTPSA id c27sm1817987qkp.5.2021.08.19.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:46:51 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Paul Barker <paul@pbarker.dev>
Subject: [PATCH v6 2/4] bitbake: asyncrpc: always create new asyncio loops
Date: Thu, 19 Aug 2021 12:46:42 -0400
Message-Id: <385ebae0db5851cd4a6094810a794d90a0a85c92.1629388054.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629388054.git.scott.murray@konsulko.com>
References: <cover.1629388054.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

asyncio in older Python 3.x (seen with 3.7) can seemingly hang if
new_event_loop is called repeatedly in the same process.  The
reuse of processes in the Bitbake thread pool during parsing seems
to be able to trigger this with the PR server export selftest.
It appears that calling set_event_loop with the new loop avoids the
issue, so that is now done in the asyncrpc Client initializer (with
an explanatory comment).  This should be revisited when the day
arrives that Python 3.9 becomes the minimum required for BitBake.

Additionally, it was discovered that using get_event_loop in the
asyncrpc server initialization can trigger hangs in the hashserv
unittests when the second test is run.  To avoid this, switch to
calling new_event_loop + set_event_loop in the initialization code
there as well.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/asyncrpc/client.py | 10 ++++++++++
 lib/bb/asyncrpc/serv.py   | 24 ++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 3eb4fdde..50e60d5c 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -119,6 +119,16 @@ class Client(object):
         self.client = self._get_async_client()
         self.loop = asyncio.new_event_loop()
 
+        # Override any pre-existing loop.
+        # Without this, the PR server export selftest triggers a hang
+        # when running with Python 3.7.  The drawback is that there is
+        # potential for issues if the PR and hash equiv (or some new)
+        # clients need to both be instantiated in the same process.
+        # This should be revisited if/when Python 3.9 becomes the
+        # minimum required version for BitBake, as it seems not
+        # required (but harmless) with it.
+        asyncio.set_event_loop(self.loop)
+
         self._add_methods('connect_tcp', 'close', 'ping')
 
     @abc.abstractmethod
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 45628698..b4cffff2 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -136,10 +136,7 @@ class AsyncServer(object):
         self.logger = logger
         self.start = None
         self.address = None
-
-    @property
-    def loop(self):
-        return asyncio.get_event_loop()
+        self.loop = None
 
     def start_tcp_server(self, host, port):
         def start_tcp():
@@ -228,6 +225,12 @@ class AsyncServer(object):
         """
         Serve requests in the current process
         """
+        # Create loop and override any loop that may have existed in
+        # a parent process.  It is possible that the usecases of
+        # serve_forever might be constrained enough to allow using
+        # get_event_loop here, but better safe than sorry for now.
+        self.loop = asyncio.new_event_loop()
+        asyncio.set_event_loop(self.loop)
         self.start()
         self._serve_forever()
 
@@ -236,6 +239,19 @@ class AsyncServer(object):
         Serve requests in a child process
         """
         def run(queue):
+            # Create loop and override any loop that may have existed
+            # in a parent process.  Without doing this and instead
+            # using get_event_loop, at the very minimum the hashserv
+            # unit tests will hang when running the second test.
+            # This happens since get_event_loop in the spawned server
+            # process for the second testcase ends up with the loop
+            # from the hashserv client created in the unit test process
+            # when running the first testcase.  The problem is somewhat
+            # more general, though, as any potential use of asyncio in
+            # Cooker could create a loop that needs to replaced in this
+            # new process.
+            self.loop = asyncio.new_event_loop()
+            asyncio.set_event_loop(self.loop)
             try:
                 self.start()
             finally:
-- 
2.31.1

