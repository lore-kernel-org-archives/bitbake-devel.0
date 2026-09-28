Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A515CA5FA2
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 12:51:42 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.57710.1790599895807024058
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 05:51:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=BQ3CZNq7;
 spf=pass (domain: snapchat.com, ip: 74.125.225.140, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so18401515e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790599894; x=1791204694; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtwR5YUtIlrzqx2OTqxvFnY5kPPGqA/IUZqDdbbL854=;
        b=BQ3CZNq7FlR8pTmu5kXAIU2I1Q8NlUQdZc84L7iCKVmWKqbMK2vVqTRwBBaBSUnNcN
         u2ioaKqDB8hlYVgNPcmSLwSYCYIxzux4z4g1eMIPDPCuaOWp9A9WbSBoespR0ogtlU77
         h1h6HW7JCpRIkiyKBHhJ86Z5YXaZuGLacTgmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790599894; x=1791204694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EtwR5YUtIlrzqx2OTqxvFnY5kPPGqA/IUZqDdbbL854=;
        b=IVzxd0rL07MaOUpBjLFZ9w5r2mSXHuhex1mSNPORXMfKXuKUK+0zZdl8SipxACwQHr
         55+yZbh9hNds271TEm6HLixts6mylDwXZYrljigcno6fI1PjbIvLdRFn3nAJZyYsRI4d
         PSYcAjXDvrWqLYwjtRKDBrgBq9NYvSb6lRNKmixmrfR1PaajxsbU6lP8v2c3OJ7Ey1rT
         2Kg5g0M0Iy4Op0sUh0AH9HdhE3elV40GxjFB/tKf+NcLA3d1iOnUevhHolJ9YWVqOrYc
         6zRwl0PYYQ5D5SWimDdFqQBwptI5D9LLtmBn/OYGUVgNPOMGYnlkdGKotRIKMdnvTeF/
         Tf9g==
X-Gm-Message-State: AFuF++kAsXcBC3lTO7e+dcQA8TIzs61kaT/BIldatuwWJxa6EsfshopC
	bTY/QeBYfPlA8zPIrxAQVWGmOQPxp4h3L5OQhqtlMh6325QkudbtQrbDpbrFWlMRdaMnHIo7k6W
	EyE3NU9Y=
X-Gm-Gg: AYBFou3+UHcV9fyfHC6gZbDz9DEEAqZKUfdBlcXZpw/EPk06/OSxCf4BWf4bDxR3JRp
	vfYiDjMHH1pRtZ8kQOiwg8arM08iMiOwIm7KYYm7p/jfjml436SEk7vXbUcfVqJPLNYpQLO23W0
	2AFKnLtv4CGntTshLrperfz2eRc6xwTpYnpogR9TNFxaV7+8XXh4RWY0ehHTMEJ9No179Qq3rJn
	x2NjcXrBh2xFecCiruH8SdajkbUB9dUuQurNIZoqLCs+D4LYAbm928/22C9jcSca7eWDUY3K3VL
	bns/csqx37dTEtdCMPJz+SPF5ytpUSbjrZvxdHb8+OcyFhwRviJIB0/jx8BMlDm56/SUza4wj5f
	xnyZ9d23sH3Z7bHr6D2qBa2xhcG234BWEoMwOeA6WM80sxWFkJRWsDQM/acVe+LGi4f7+Hgtne1
	1HbkpwfVqntLkG7M9ayNCA12TOVXTXvSgQApdRterLDSRNDQ72StJYkXL5hgXPN8VikMqTs2wGq
	n+Pv9qMqEjBV9HrGgQqwnRJySc/eiNbS9c3L+cbPw==
X-Received: by 2002:a05:600c:8b4c:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-49fe66eb0f0mr225069365e9.19.1790599870213;
        Mon, 28 Sep 2026 05:51:10 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a007fd1a01sm37041925e9.0.2026.09.28.05.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 05:51:09 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH v2 2/2] fetch/wget: Reuse the checkstatus() urllib opener
Date: Mon, 28 Sep 2026 14:50:51 +0200
Message-ID: <20260928125051.2483039-3-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928125051.2483039-1-ecordonnier@snap.com>
References: <20260928125051.2483039-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 12:51:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20273

From: Etienne Cordonnier <ecordonnier@snap.com>

checkstatus() builds a new urllib opener with its redirect, proxy and
connection cache handlers on every call, although sstate.bbclass calls it
for every object in an sstate mirror check with the same settings. Keep
the opener on the FetchConnectionCache, keyed on the certificate checking
setting and the fetcher environment, and rebuild it only when those
change. A connection cache is only used by one thread at a time, so no
locking is needed.

Checking 2,114 objects on the Yocto sstate mirror with BB_NUMBER_THREADS = "8"
reduced the time to task execution from 26.9s to 25.1s on average.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/fetch/__init__.py |  2 ++
 lib/bb/fetch/wget.py     | 22 +++++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

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
index fe2de25d3..9cb4a4f32 100644
--- a/lib/bb/fetch/wget.py
+++ b/lib/bb/fetch/wget.py
@@ -435,13 +435,21 @@ class Wget(FetchMethod):
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


