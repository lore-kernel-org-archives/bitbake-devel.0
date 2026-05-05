Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB7FCD3441
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 16:07:44 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.439.1777997257941582233
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 May 2026 09:07:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Zolc9wWM;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso41790005e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1777997256; x=1778602056; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sX6ATOPa2cHG2TiASt53bSlZM/NUCJKAA1sgf6Bi4sc=;
        b=Zolc9wWMDW7YOVZyUnCzJZ8GttK4FTvrgoGLJ7sGcwA6VbhrL2m8ObSyBohCWTjW0D
         1GZ3aqxo6g5S78qlJr3vZxOAszDaO6hcwSYnDZs7CW/LjAWRaEv4cCgcUqAvmqaTCn0r
         sZVtbE2rnXb/l6bGf2FP88VYSx0OaDZwRu9/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997256; x=1778602056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX6ATOPa2cHG2TiASt53bSlZM/NUCJKAA1sgf6Bi4sc=;
        b=bxiPw3ijSwJS33RgtzziV+OikBeYwQND+QgmtNCz6PNT2oBTjaJAnU1scf6WI4nBCa
         UFrpO7z1gNDrtpLK6h2ztUkUHV4FPYX5FAhnwY201+SRuPtErj72PnEf2P7n4msV2LHj
         aHWecOLarGi6YmsAbEPv94Kpv1IhG3mE64N50lhMGL1UWiH6lzCh4M8nDQEod7g37qVL
         4foNL5H/1F0mgMwJjxX39YQ9FRFiTcMjjs67kZQaH8PHqg6DMru0q5l+ycY2fBCutqew
         K3ZstdYGCswljfW6cd5l+RUBWDKQiT/sFjOv8lLZi6sDwZqVtZ/PlBJfJNgLh40R+sZV
         gz1w==
X-Gm-Message-State: AOJu0YyD0mjbXcNDTMy98yZWlrdN63SMdnd9aZIW/7feztmRRVfB0GvD
	G+E8KA6nfignCDO5B0gfBh4msXZVjRsUrhE527U7bXh8PJbXrtUh+sv7epln6TwckdJhTtfNnPQ
	btBCENss=
X-Gm-Gg: AeBDieugPRVTmF88F4Rs13nGYlc+RuHKEkV980344eWHP469us8Zir7YPCMS/nyOf0/
	6E6ZJ7tKDTUeFWd1a6RW9qrtTsUdAwyLhch6t6OQIUIH+pYtKZphPjNVIS1CpVDa3BcJxF299ng
	LsCWGyildiwrsIJfw3/8vFitQlfWhAs7jb1LTAbhUA5HUwt6K6n+t3K66+bQRGeyhptjjQkV1Mm
	TcGlZc1Iz45xZIV1yrE6RK99dogx1cKVFlOf/j7yV5Dug5S8LmN25RebZhxaikzyw4gv0A/A1Sc
	4NQMeLbU0ldMr7/OHhLN9044gondeepQalojCsAOe54q+tiD3aQ+FNakHnvhAvNVRPKdqrz+9fA
	KvXmAuqGbGUWZhB+Li9XIsF5zZjjnS6BU77JBdSUeWEeXE5gzPPcrLkGdb8wV7WyIzzbyGXYpI6
	ito0hHARWwmNafTW35ptqUZKpLQ7vV1gGmdRmKKQ==
X-Received: by 2002:a05:600c:444c:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-48a9866dcd9mr247910715e9.22.1777997256252;
        Tue, 05 May 2026 09:07:36 -0700 (PDT)
Received: from heaven ([2a01:e0a:2c:37e0:31a6:f161:bbe5:6cec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82307f28sm691685045e9.13.2026.05.05.09.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:07:35 -0700 (PDT)
From: corentin.guillevic@smile.fr
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v2] cooker: limit the execution of the hashequiv client/server ping
Date: Tue,  5 May 2026 18:05:57 +0200
Message-ID: <20260505160556.3688048-2-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 16:07:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19437

From: Corentin Guillevic <corentin.guillevic@smile.fr>

The ping method is used to test the connection to the hash equivalence server.
However, if the server is unavailable, the bitbake server has to wait several
minutes for the system to terminate.

While waiting for a response from the hash server, the bitbake server does not
provide any feedback to the bitbake client. The latter then closes the link and
fails with the error:

Timeout while waiting for a reply from the bitbake server (60s at 09:50:15.377337)

Adding a timeout to the ping step allows quicker action when a remote server is
unavailable, and prevents disconnection of the client due to timeout.
The default timeout is 10 seconds, but this can be set using the
BB_HASHSERVE_UPSTREAM_TIMEOUT variable.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---

Notes:
    Changes in v2:
    - Rename variable BB_HASHSERVER_TIMEOUT as BB_HASHSERVE_UPSTREAM_TIMEOUT
    - Document BB_HASHSERVE_UPSTREAM_TIMEOUT
    - Set a default value to the "timeout" argument (keeping all calls to ping() unchanged, except for the one that connects to the hash server)

 .../bitbake-user-manual-ref-variables.rst             | 11 +++++++++++
 lib/bb/asyncrpc/client.py                             |  4 ++--
 lib/bb/cooker.py                                      |  4 ++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 9824b58ef..cce03bc0c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -511,6 +511,17 @@ overview of their function and contents.
 
          BB_HASHSERVE_UPSTREAM = "hashserv.yoctoproject.org:8686"
 
+   :term:`BB_HASHSERVE_UPSTREAM_TIMEOUT`
+      Specifies the duration (in seconds) for which BitBake waits for the first
+      response from the upstream Hash Equivalence server (specified by
+      :term:`BB_HASHSERVE_UPSTREAM`).
+
+      This variable prevents BitBake from waiting too long for an unavailable server.
+      If the time expires, the upstream Hash Equivalence server will be skipped for
+      the build.
+
+      The default value is "10" (seconds).
+
    :term:`BB_INVALIDCONF`
       Used in combination with the ``ConfigParsed`` event to trigger
       re-parsing the base metadata (i.e. all the recipes). The
diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 17b72033b..5e2505494 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -199,8 +199,8 @@ class AsyncClient(object):
         self.check_invoke_error(result)
         return result
 
-    async def ping(self):
-        return await self.invoke({"ping": {}})
+    async def ping(self, timeout=None):
+        return await asyncio.wait_for(self.invoke({"ping": {}}), timeout)
 
     async def __aenter__(self):
         return self
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4b6ba3196..c7ced1e37 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -342,7 +342,7 @@ according to https://docs.yoctoproject.org/dev-manual/hashequivserver.html""".fo
                 if upstream:
                     try:
                         with hashserv.create_client(upstream) as client:
-                            client.ping()
+                            client.ping(int(self.data.getVar("BB_HASHSERVE_UPSTREAM_TIMEOUT")) or 10)
                     except ImportError as e:
                         bb.fatal(""""Unable to use hash equivalence server at '%s' due to missing or incorrect python module:
 %s
@@ -352,7 +352,7 @@ Please install the needed module on the build host, or use an environment contai
  - or set up pip venv
 You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in significantly longer build times as bitbake will be unable to reuse prebuilt sstate artefacts."""
                                  % (upstream, repr(e)))
-                    except ConnectionError as e:
+                    except (ConnectionError, TimeoutError) as e:
                         bb.warn("Unable to connect to hash equivalence server at '%s', please correct or remove BB_HASHSERVE_UPSTREAM:\n%s"
                                  % (upstream, repr(e)))
                         upstream = None
-- 
2.51.0


