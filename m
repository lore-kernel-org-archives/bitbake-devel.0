Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E49C9830B
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 17:08:56 +0000 (UTC)
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.474.1790183333841603305
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 10:08:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=ap7ktW3Q;
 spf=pass (domain: snapchat.com, ip: 74.125.229.12, mailfrom: ecordonnier@snapchat.com)
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so1310118eec.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790183333; x=1790788133; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yc1rO+UTMpZUJ4u+1sXfL0qRJxJUlEDJre8DfttgHWs=;
        b=ap7ktW3QFpHpE1dmUO8Cqn9gyxdVpH1rW1HPzxdGPu8wLtrVl79C8o+xfpvbZ2V964
         AJGqdchnSFvwiVyofexSsdPZt/yegkoF0rMNproX3Eay1avDq9hZJ+pEY65mkcSHZA1z
         0UkUJ1ixX7GVeK5rIbU8xCQHIT+JlaRbVxBPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183333; x=1790788133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yc1rO+UTMpZUJ4u+1sXfL0qRJxJUlEDJre8DfttgHWs=;
        b=lnzFexNLjuc+L02o41FvBNnOV0FBCx17zJDrRsGzmF7GVmH6sN/04gXPFWDq5s9LwI
         US2l1nqIzBtsYkqY9xB6FOvtwEW0hLN0c0iejSxV0uPF1MOu1/e3kphtJVzyn5XOvF7K
         lxvM1CE/vrfeOkCI8EFTI/A0TaX1R3TOF1X0LAPQJkqU5AElbWZ4uUaYZg0HBfsXowAa
         mpdRRysFYd6VIYxZn6wxr7I46k/ujgnNrboCBBB0MopMYpNdnw/dUZWR9y3kPQpqqnRZ
         BIiBJ1zQRNkqWSAMONYQw8T2MErtTAkyMxLFktKwp3kXB9kkLNa0BoF6JrfodXiCDWS5
         7qsg==
X-Gm-Message-State: AFuF++m+tcWGl1yRzOkyXs/8NDW9rtFYrfWV2tmyZ8XgZcsO1Qti8tMB
	7kfWKUV7Cu7/h9YqfPBMfZHBgeEb80+g1WoZtSUiHH9enL6QPQB36IXiuWCxUoWUS23G+XoUZ3b
	G+JK8dbg=
X-Gm-Gg: AYBFou26RCNjbcOhB2xU8KJcSpeuaLdvZ5hCiST6cGxD9yapeyQHrM6sDh1MODi43Zd
	kboHLBPNOgz0vxs9T9rHERcQIs8Rbt8QZtluT4D1kWD5Z49pMdz9ay1+nFJJyYcTBft76GxdVvt
	70HbPD3XvBVmk1VsXLSwrBz7RQTYIgFNpBYbhUYuKpmd5WEH8bEQjTovlf5HOAhXXELLKWwxw7D
	s+3clHvm7nFruLS+DKq4r6RUHnnetpdqrFyaPmP03QdEW4sTaXL+9RoyvVyOWxFeQg1UI476qkz
	t+L3bHK2YmjIePBBCOmfVKWO/tpVJ4GpaAEnksDQwd9G3OX4mj/8Qui9D64zcCOKcz7Y1szeqnY
	lTkr5HF0dIWA09u/3ErprS20r7GOZT95KMJs2xXNH6RDXRfx/Ye3ViWxCSks95qsFvg6qNdkwvl
	rpkTBkmhhShd3G0jJ946Np92EmRmYHwPWuu0Q9KJNQR4ewuRqd/trqLylTrJ/RNqN5t3Mq4GBje
	FEehlh5ToBCjcFRcexjO+APgk9lpyY/rZG9pE78whJ3OG0ne4/kGQ==
X-Received: by 2002:a05:7300:b291:b0:33e:538c:c3f1 with SMTP id 5a478bee46e88-33e8d6cff7dmr3202698eec.25.1790183332757;
        Wed, 23 Sep 2026 10:08:52 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96358e2bsm7406609eec.16.2026.09.23.10.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:08:52 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH] fetch/wget: Reuse the checkstatus() urllib opener
Date: Wed, 23 Sep 2026 19:08:46 +0200
Message-ID: <20260923170846.1360600-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 17:08:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20246

From: Etienne Cordonnier <ecordonnier@snap.com>

checkstatus() builds a new urllib opener with its redirect, proxy and
connection cache handlers on every call, although sstate.bbclass calls it
for every object in an sstate mirror check with the same settings. Keep
the opener on the FetchConnectionCache, keyed on the certificate checking
setting and the fetcher environment, and rebuild it only when those
change. The handlers now refer to the connection cache directly rather
than through the first Fetch object, so a cached opener does not keep it
alive. A connection cache is only used by one thread at a time, so no
locking is needed.

Checking 2,114 objects on the Yocto sstate mirror with BB_NUMBER_THREADS = "8"
reduced the time to task execution from 26.9s to 25.1s on average.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/fetch/__init__.py |  2 ++
 lib/bb/fetch/wget.py     | 45 ++++++++++++++++++++++++----------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index 55ab710f3..0eb660685 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -2090,6 +2090,8 @@ class FetchConnectionCache(object):
     """
     def __init__(self):
         self.cache = {}
+        # urllib openers built by the wget fetcher, see Wget.checkstatus()
+        self.opener_cache = {}
 
     def get_connection_name(self, host, port, connection_id=None):
         if connection_id is None:
diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py
index 972c84048..9cb4a4f32 100644
--- a/lib/bb/fetch/wget.py
+++ b/lib/bb/fetch/wget.py
@@ -178,23 +178,24 @@ class Wget(FetchMethod):
     def checkstatus(self, fetch, ud, d, try_again=True):
         check_certs = self.check_certs(d)
         newenv = bb.fetch.get_fetcher_environment(d)
+        connection_cache = fetch.connection_cache
 
         class HTTPConnectionCache(http.client.HTTPConnection):
             def cache_id(self):
                 return None
 
-            if fetch.connection_cache:
+            if connection_cache:
                 def connect(self):
                     """Connect to the host and port specified in __init__."""
 
-                    sock = fetch.connection_cache.get_connection(
+                    sock = connection_cache.get_connection(
                         self.host, self.port, self.cache_id())
                     if sock:
                         self.sock = sock
                     else:
                         self.sock = socket.create_connection((self.host, self.port),
                                     self.timeout, self.source_address)
-                        fetch.connection_cache.add_connection(
+                        connection_cache.add_connection(
                             self.host, self.port, self.sock, self.cache_id())
 
                     if self._tunnel_host:
@@ -206,17 +207,17 @@ class Wget(FetchMethod):
                         newenv.get("SSL_CERT_FILE"),
                         self._tunnel_host, self._tunnel_port)
 
-            if fetch.connection_cache:
+            if connection_cache:
                 def connect(self):
                     """Reuse an established TLS connection when available."""
 
-                    sock = fetch.connection_cache.get_connection(
+                    sock = connection_cache.get_connection(
                         self.host, self.port, self.cache_id())
                     if sock:
                         self.sock = sock
                     else:
                         super().connect()
-                        fetch.connection_cache.add_connection(
+                        connection_cache.add_connection(
                             self.host, self.port, self.sock, self.cache_id())
 
         class CacheHTTPHandler(urllib.request.HTTPHandler):
@@ -252,7 +253,7 @@ class Wget(FetchMethod):
                 # request.
 
                 # Don't close connection when connection_cache is enabled,
-                if fetch.connection_cache is None:
+                if connection_cache is None:
                     headers["Connection"] = "close"
                 else:
                     headers["Connection"] = "Keep-Alive" # Works for HTTP/1.0
@@ -282,8 +283,8 @@ class Wget(FetchMethod):
                     # with the dead connection removed from the cache.
                     # If it still fails, we give up, which can happen for bad
                     # HTTP proxy settings.
-                    if fetch.connection_cache:
-                        fetch.connection_cache.remove_connection(
+                    if connection_cache:
+                        connection_cache.remove_connection(
                             h.host, h.port, h.cache_id())
                     h.close()
                     raise
@@ -316,9 +317,9 @@ class Wget(FetchMethod):
                 resp.msg = r.reason
 
                 # Close connection when server request it.
-                if fetch.connection_cache is not None:
+                if connection_cache is not None:
                     if 'Connection' in r.msg and r.msg['Connection'] == 'close':
-                        fetch.connection_cache.remove_connection(
+                        connection_cache.remove_connection(
                             h.host, h.port, h.cache_id())
 
                 return resp
@@ -434,13 +435,21 @@ class Wget(FetchMethod):
         # to scope the changes to the build_opener request, which is when the
         # environment lookups happen.
         with bb.utils.environment(**newenv):
-            context = self.ssl_context(d)
-            handlers = [FixedHTTPRedirectHandler,
-                        HTTPMethodFallback,
-                        urllib.request.ProxyHandler(),
-                        CacheHTTPHandler(),
-                        CacheHTTPSHandler(context=context)]
-            opener = urllib.request.build_opener(*handlers)
+            opener = None
+            if connection_cache is not None:
+                opener_key = (check_certs, tuple(sorted(newenv.items())))
+                opener = connection_cache.opener_cache.get(opener_key)
+
+            if opener is None:
+                context = self.ssl_context(d)
+                handlers = [FixedHTTPRedirectHandler,
+                            HTTPMethodFallback,
+                            urllib.request.ProxyHandler(),
+                            CacheHTTPHandler(),
+                            CacheHTTPSHandler(context=context)]
+                opener = urllib.request.build_opener(*handlers)
+                if connection_cache is not None:
+                    connection_cache.opener_cache[opener_key] = opener
 
             try:
                 parts = urllib.parse.urlparse(ud.url.split(";")[0])
-- 
2.43.0


