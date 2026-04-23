Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07D5F9936B
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 10:31:13 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16584.1776940263345646455
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Apr 2026 03:31:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=wdInTmyr;
 spf=pass (domain: smile.fr, ip: 209.85.128.42, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so80226635e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 03:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776940261; x=1777545061; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFvcLF2vz/VnAMvJ/34URS1/SIp2qLg04nGe/McP+xk=;
        b=wdInTmyrMJ6CLSl+HHPWF4UiF29e2/uEbdhv+Nbi2hzjsSeqJuFEMmssepzk2TS01p
         bhu7IVotzbiI9/eZK4UwJWNNX4Awvv848CEJ73UDjmBX7iaJGBIARrEe/2mzN3Fq6pJo
         Nvne7n3O5qkdz/9PS5irzSt6s53d88u37BZyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776940261; x=1777545061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFvcLF2vz/VnAMvJ/34URS1/SIp2qLg04nGe/McP+xk=;
        b=K2tE+ev4hvkDzWgNWuLRmiCJqmY7VnpTr3YdV1wpKDk5xButkLC/GpKbiNdF3JsT3z
         Whau4JQmuwPo2JhGcu5csqVLBW+yLALt8rsmHzL9k0PZnhTV2BiFXmOMW4zU6EJJhdsy
         /DCQ6oiZy0q1UvW6EAnVu3AgbxQ3kIZ+Jr8Hfgy6JEh3dvvSXfc51wo6tOAWoSaiSltu
         8AyB6No9lZrmp3v/r8+aJLUUH/lVPa2VCxJRdMy2M5Uz34tiAoDPbSkwo6Xk1C0/OTWr
         fqkZCCZm5b7MhxpJEX7+LxaPDQ183kjrKu5PL4cUYSty1FM1CMwppsJ/dluDQzl0NsPf
         BtxQ==
X-Gm-Message-State: AOJu0YzK4lRVp9ejZFrS9AcdOi4khv3Gg7MIE4eoS4ixpX+epsprzzuS
	t3NQYZHb1S/L1LDyJSftPuGkV0zW7UFMJTyWyJtHefG3FQNF7U9vLcFR3yaLs0IlK+jl4fYjISP
	dKZwKE4w=
X-Gm-Gg: AeBDievXQFDEljWyb5qztn8LkjO4S3o0pV2eF7Iure9YVsqgVRO6Vn6+P3tiOY0aQhF
	BNzYqjzzC3kBnh60EOaiklErN/EDe2pXXRgQEYQE6QaYhPgJcUVtly0JOrBBy8+r9tMecd+zD7M
	cldkhrm9ntTnOes4licIUDXPrkurWK2435Rv5IIk5zcrtNTS5jMHfkcsMH8O9PCX+zfaJYvm69C
	oiPWV1wzak2OKfKHw4K+nYljT3JG4lxm7ls5TG+Q1utEdvHNs/J8PelgXgHgseLB1NOC7jxTq6u
	yVsAnTSUXTgl1nxs5lnLl0EHEdwy6o22ajISvrxjP2X5uOUeiip/e13495nhz4yXTJtd8rP3i0N
	oWuLfHyOOnR6L9CeDgxvpLKLmtcCTA2ixwo34jgn8SGfOitTUnyfnQyxLw8O41A9HTjdwwaQ8ft
	wd5eLJhxYmpx3KlesunVTtJEOOYWTe3XTFNv19Ow==
X-Received: by 2002:a05:600c:548c:b0:48a:568f:ae6b with SMTP id 5b1f17b1804b1-48a568fafcbmr147589055e9.7.1776940261439;
        Thu, 23 Apr 2026 03:31:01 -0700 (PDT)
Received: from heaven ([2a01:e0a:2c:37e0:31a6:f161:bbe5:6cec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a4b329542sm416746315e9.3.2026.04.23.03.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:31:01 -0700 (PDT)
From: corentin.guillevic@smile.fr
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH] cooker: limit the execution of the hashequiv client/server ping
Date: Thu, 23 Apr 2026 12:29:51 +0200
Message-ID: <20260423102950.697501-2-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 10:31:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19378

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
BB_HASHSERVER_TIMEOUT variable.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 lib/bb/asyncrpc/client.py | 4 ++--
 lib/bb/cooker.py          | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 17b72033b..7ef76c90c 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -199,8 +199,8 @@ class AsyncClient(object):
         self.check_invoke_error(result)
         return result
 
-    async def ping(self):
-        return await self.invoke({"ping": {}})
+    async def ping(self, timeout):
+        return await asyncio.wait_for(self.invoke({"ping": {}}), timeout)
 
     async def __aenter__(self):
         return self
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4b6ba3196..0bc9b7aec 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -342,7 +342,7 @@ according to https://docs.yoctoproject.org/dev-manual/hashequivserver.html""".fo
                 if upstream:
                     try:
                         with hashserv.create_client(upstream) as client:
-                            client.ping()
+                            client.ping(self.data.getVar("BB_HASHSERVER_TIMEOUT") or 10)
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


