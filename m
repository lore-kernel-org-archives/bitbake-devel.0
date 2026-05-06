Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3F6CD343B
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 12:40:55 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17450.1778071245671259940
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 05:40:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=DgexjiWt;
 spf=pass (domain: smile.fr, ip: 209.85.128.53, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d102471a4so31357085e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 05:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1778071244; x=1778676044; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MXbsHfhpZMaAqsqMz5O7yob+A1iTrfhG5lzv05G9Qqc=;
        b=DgexjiWt79uqTtBQDEP2hBDX+kRAak8ip7KiJEgPnugICrlpkNQc6UyWP1tzq2SUaw
         NXYwa7aITk32EY0j95au4TKZp30nYTcTexGhuUy/vo8ZSfoGJh4A0GcGr3kFR9GHa2iV
         Vz16oC0j2tGJySDTmUJDp8qIgMsttTAobS5g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071244; x=1778676044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXbsHfhpZMaAqsqMz5O7yob+A1iTrfhG5lzv05G9Qqc=;
        b=ERLoTY9VENG65Kd6Ztj2c8uccXkozlBA3CGjKORwkv3mLH0ZVD9wA1O2ubD9K8yWWE
         Z8ee4R3qxaMmttCdvvbLBUtNnvO4GTQCGrO+tNtUlmAz7RwQv++X5R1B2nhl6oe9gsrD
         XN7eSHq9B912QtXVTCvL1yD2cTLDwzAsoHRUhFqGk8JbTShj4luu1wlE3xZzXY0Lq8Sh
         ljBloGUZamXWafJVvh2vJGhVrx9kuJ4SYfCIoFTmgfEjlLuKVj2E4K+yw9bI5RTi34qM
         GKYjkaia57sBjCpl526ejpgGfWPZgHbt4hYbZcWc6bPjsvs0flOR5Wk3IubGzR3oUlSm
         rarA==
X-Gm-Message-State: AOJu0YyJHf782/PDfGgegDN4ObiHpXes2vWIju9kHMZ6jgtI0sMbzgOR
	pKjWTWNNzJsr/XfhbZ3BkDM0KX3PbS8QtYfzul5tI6jZsD4M7K2yZEVj3L3rkw1hHSuPWtsnILO
	whLDBoq4=
X-Gm-Gg: AeBDietjLq1X3Ze8W6t6PIrDzhsQPbKVIz6ZSOtttdnKQyDWBqZ90+HHxHQEbLx+sjy
	Qe9tM0Nytx3umKI8KFQA+kKmSOkt5lLPr169QnC5v5UPC2ARcKGlKqiV8YxLOIEjLCRb8VRt/CL
	TaUbwtDDVLQgDnBoZtJ1rremlARTCR7XF64FDkFeLWXfIoZE/HSp+AKml1mVrDW5PEtLH8NkOSH
	7YV+Asht0N6+bUbrhxA8kaaTrEJhVSVXvC70ifQ3l9M0pcjpZaLX75RLB43LzJF1hJn7l4Fs5eh
	lj5n0c1+yQY8GCns6jO17GfKVqpBFy/HRgu1aXQiBscEYYNaKaNaEUpWEXrGai9ilO3VCeXxS6z
	Xvv40S2u+kpynjqLHLGAuS0g7CrA56KsDWSCgCXKs1XxKTzPRDa4hTt+kEkdkofRm449u7Y5ga1
	CxV+hzcgyO/nOH99XAg2tqkPyz++XOOrXY8gb5AQzkyTJqP7GCYg+xWEp+orHOneYpnTQ/HpWaV
	LBnWB+4wYz5vUSmAHIx5sSn03UGCKhNIJXxd3r4BDQ=
X-Received: by 2002:a05:600c:4f53:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48e51f44577mr57707495e9.22.1778071243831;
        Wed, 06 May 2026 05:40:43 -0700 (PDT)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538fb19csm42657885e9.11.2026.05.06.05.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:40:43 -0700 (PDT)
From: corentin.guillevic@smile.fr
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v3] cooker: limit the execution of the hashequiv client/server ping
Date: Wed,  6 May 2026 14:37:57 +0200
Message-ID: <20260506123755.628267-3-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 12:40:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19445

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
    Changes in v3:
    - Fix TypeError exception when BB_HASHSERVE_UPSTREAM_TIMEOUT is not defined

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
index 4b6ba3196..128cbaee9 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -342,7 +342,7 @@ according to https://docs.yoctoproject.org/dev-manual/hashequivserver.html""".fo
                 if upstream:
                     try:
                         with hashserv.create_client(upstream) as client:
-                            client.ping()
+                            client.ping(int(self.data.getVar("BB_HASHSERVE_UPSTREAM_TIMEOUT") or 10))
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


