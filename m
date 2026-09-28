Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C4CA5FA2
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 12:51:11 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.56693.1790599869813210384
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 05:51:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=C2WFjyBy;
 spf=pass (domain: snapchat.com, ip: 74.125.225.140, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso8539615e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790599868; x=1791204668; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=64QV+d6WQ3D9OP8Uw6stSpxswOECuYrhnsh0kGEjJ3U=;
        b=C2WFjyByk/yvrcKuXLoHuX9eS3Zn0OyfbSqixBOBaFwyidVrQRPR48k0u5xIvUmSHC
         15VQYVwAa4aC/UfF+BPbBAprBVwm2j0hMykZsAnqpazVn4nTSbojUvYnfsatWPe87MzG
         M4MM+CnDNRjNMo9TCxgpihpqRtHKj/VT5ufwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790599868; x=1791204668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=64QV+d6WQ3D9OP8Uw6stSpxswOECuYrhnsh0kGEjJ3U=;
        b=vLRHVLBMWVs58ryx4rJF7wHBb/etopTgFLDFggNR/Hq8kyzOpM7/LnLdlBacQTJyMz
         Qt+Ru9y7zx5Lt5qu9Lu74Iq827Sy7ac2gai9Tmszo98FD2TuO3PWwD4FzH+iiVQoqnFc
         5o2xeK2H5qwZk58FpJSWLe//RLetI+OhnswZEtgDywzgdNponaXtVfM4zzt3qVZ6/b72
         uVrGpNtOEhYKFAvhbONheVx7NF9FvdXW1dSv5CwTKWaj0CWboMrUdYtMdxG7iHQG/sDE
         PAsGB44jKHAl8OSlFW8Y1R7/9otIaY6y2ETym2X1jOflgfFknzW0jRbYwInxlaAQh26n
         DIPQ==
X-Gm-Message-State: AFuF++kPZKAUiF639DTT6bkBDbIEvb7AtRqVMEJAr0+RjCPimGxZheVT
	u1ntxavfaklFnbce/j8XjeCcGw57YIpSSc85OTjqtGiqpXq3YbYdl68t0Wbfv7+dc+8IeWvYGla
	xUKm4iMk=
X-Gm-Gg: AYBFou1yxK8PciJaq/W9Y5F9GvdPE1JhE19Yb4XtTCJKHwLliq9s4c+qHGmPRr1x+wf
	TMZB1UX7oNQt67n0TiRptAPh41zs6mgU/YBEEo+uffHVLuR6b0jOEvaA7ZuqLO9k0uNlshJjbou
	8abuPig04G0FFSMN15citesapH5D+yJpv+rPCca3DFynph7VkW7lBhrYs4mKcyY23r0CrFlOlqi
	iAOSsaEThrxSjdwPTmt0IggeZNe8zJ2goq9P91k+oR0KRhmCKUB7quYNsOemLtVz6cTOMf9mg7T
	oxT66xLh+vpICBhzbDWQaBzzOXOEuaLaOD+edeisqFUxnhwQ9hv90nXSGeix+aQXpxin7keGS/v
	4Uv2ZE8EY+eOyy+J5oEVX5zKhqV5DsPqSYbuN3/NnfRC67eX4aEcEDvQ30m4CHi4wjP7fdfi/AM
	BC5X/MXC7fXCnD3EqtksVHtTVJGI5pKFFPLjCQmALvCZqhj+uP2KTQFPENR6ok7ZqmQJhJGTqly
	ik3DYXwml8spgSW4REjAv9takTMcLDlGofoDvU3x09G9FPe50Bd
X-Received: by 2002:a05:600c:1991:b0:49f:ffef:1db with SMTP id 5b1f17b1804b1-49fffef0280mr83468955e9.4.1790599867681;
        Mon, 28 Sep 2026 05:51:07 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a007fd1a01sm37041925e9.0.2026.09.28.05.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 05:51:07 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH v2 1/2] fetch/wget: Have checkstatus() capture connection_cache, not fetch
Date: Mon, 28 Sep 2026 14:50:50 +0200
Message-ID: <20260928125051.2483039-2-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928125051.2483039-1-ecordonnier@snap.com>
References: <20260928125051.2483039-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 12:51:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20272

From: Etienne Cordonnier <ecordonnier@snap.com>

checkstatus()'s nested handler classes referenced fetch.connection_cache,
so their methods closed over the fetch parameter itself rather than just
the connection cache. Capture connection_cache in a local variable instead
and use that everywhere. No behaviour change; this makes the next commit,
which caches the urllib opener built from these handlers, safe: a cached
opener's closures no longer keep the Fetch object that built it alive.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/fetch/wget.py | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py
index 972c84048..fe2de25d3 100644
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
-- 
2.43.0


