Return-Path: <jeremy.rosen@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F533CD98DB
	for <webhook@archiver.kernel.org>; Fri, 12 Jun 2026 14:29:21 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71948.1781274551053191349
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2026 07:29:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=OtsrmnBY;
 spf=pass (domain: smile.fr, ip: 209.85.128.42, mailfrom: jeremy.rosen@smile.fr)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so4905745e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781274549; x=1781879349; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0t9lZjhmmYXRY2a0YE8VQ7+4h3wgBklg4tjE30aPZJU=;
        b=OtsrmnBYz0+kjJdRnyo37Jqv9QxgdT6nz1MQe4FDz04UF3k2YG/PYQqHg3UsQhYmAg
         hc56/NJvjCA4xAWtmnL+2qBuKfINMd8SeYhbeLxGVHgmhKWhHoQpFQ7F/dORj/gx/xuI
         llj5X7WY8C6q9/T3i1DfB2xIzFtp1NNy4I+Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274549; x=1781879349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0t9lZjhmmYXRY2a0YE8VQ7+4h3wgBklg4tjE30aPZJU=;
        b=XTDvSInaXPWImzFEvVD/3MYFwwqUQwAnyOkmVKlR1BX8siQQYTDxYF/ihyUtasdvBc
         xs7gyallZHVYEVWDgc3r25amgrtdzr5SjlA0eVsWugyoV8lP0TRwpFLRy2WzsWxJr0Ke
         gxSOzOn63vf+x66Hd6XlgZhRvHscASVhdD7W7vqWv41iBuITlk6EN83/sc1eGVQcn9cV
         2qUfqMSXyqs9Y0ZqArCLVP4ccOPSLdWx0YQxkaCmk0i2AEABisCGFaTp3MOPunmOBG5U
         HkWjH5MKmcqnb7ZNmyw7OLr0Rb/lTlEpROoW5JYAxpCQcZgJyXg4bqbZivolarkpdgNK
         MpQQ==
X-Gm-Message-State: AOJu0YyoImtw/cr1Z6B63eUuXmykO/c5/uLdLLfOwpLir1ijJ/veZoFh
	PymP1JzzTJavnpHSdelpWgNcOYlwKaWCkcR8NfbuH8Oo1bpSThw8NOTp0oc0n2DpRDZvbfEZMYD
	p1Py8rw==
X-Gm-Gg: Acq92OG+sWho7zW1wUBPEGxx46jxKH3FVp2GUk93hwPm6I+En1wNMq+yaOK7LR09EEM
	7RFWvZ7mUbBd0AfbvSFaFIk7ty7EjmR1CTR4AAthT/fvqfg3QT2/H31UDymXGcP731MS9syw7tz
	EpQviZ+C5bpf9rnpSzFxsAZLCk63Q4tdWTe43yzY4NLG6jBAKRhsJJjqRxYoiItARrGHaQM9k1O
	XUYjDdnOsRw1blrotlE8o1I9bNCgaEP/g/ceyQTz/T0Fes88Zj2xKhlYAD+uQOFbYidCokUZQXD
	xljiodk9R9alNsHxLv0Dz1o1sW4Fvu9A9D6Ofk4kMS3aNzpZrpDtY9X/GzmbCNvq7rYDDnZpswZ
	IKaqi2BU9U65WwKSaGKUzjXdRRWSyUYPy/tLTiz/YAG8vPi3pUUqugXZ4HWplqgLALpN1p7cupl
	xp+wGaXcat/1/6zSOmp3sJMfcffX2WdmX53w==
X-Received: by 2002:a05:600c:214e:b0:490:e180:2ed with SMTP id 5b1f17b1804b1-490ec4bfe4cmr25268765e9.4.1781274549346;
        Fri, 12 Jun 2026 07:29:09 -0700 (PDT)
Received: from Logrus.lan ([2001:861:560f:240:8dd0:2c2:7492:641b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-490ea8123e1sm74072065e9.0.2026.06.12.07.29.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:29:09 -0700 (PDT)
From: Jeremy Rosen <jeremy.rosen@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/4] fetch2/wget: handle HTTP 308 Permanent Redirect
Date: Fri, 12 Jun 2026 16:29:00 +0200
Message-ID: <5ca465fc4ac49dc2f4172c83da651f316c0b4a7c.1781271084.git.jeremy.rosen@smile.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1781271084.git.jeremy.rosen@smile.fr>
References: <cover.1781271084.git.jeremy.rosen@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 14:29:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19676

From: Ross Burton <ross.burton@arm.com>

urllib2.HTTPRedirectHandler.redirect_request doesn't handle HTTP reponse
code 308 (Permanent Redirect). This was fixed in c379bc5 but can't be
worked around without copying the entire redirect_request() method.

When we can depend on Python 3.13, FixedHTTPRedirectHandler can be
removed.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(cherry picked from commit 365829a2803b954ee6cb0364749551a91d806075)
Signed-off-by: Jeremy Rosen <jeremy.rosen@smile.fr>
---
 lib/bb/fetch2/wget.py | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 2345ba6b4..55b2ca2fe 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -305,13 +305,45 @@ class Wget(FetchMethod):
 
         class FixedHTTPRedirectHandler(urllib.request.HTTPRedirectHandler):
             """
-            urllib2.HTTPRedirectHandler resets the method to GET on redirect,
-            when we want to follow redirects using the original method.
+            urllib2.HTTPRedirectHandler before 3.13 has two flaws:
+            
+            It resets the method to GET on redirect when we want to follow
+            redirects using the original method (typically HEAD). This was fixed
+            in 759e8e7.
+
+            It also doesn't handle 308 (Permanent Redirect). This was fixed in
+            c379bc5.
+
+            Until we depend on Python 3.13 onwards, copy the redirect_request
+            method to fix these issues.
             """
             def redirect_request(self, req, fp, code, msg, headers, newurl):
-                newreq = urllib.request.HTTPRedirectHandler.redirect_request(self, req, fp, code, msg, headers, newurl)
-                newreq.get_method = req.get_method
-                return newreq
+                m = req.get_method()
+                if (not (code in (301, 302, 303, 307, 308) and m in ("GET", "HEAD")
+                    or code in (301, 302, 303) and m == "POST")):
+                    raise urllib.HTTPError(req.full_url, code, msg, headers, fp)
+
+                # Strictly (according to RFC 2616), 301 or 302 in response to
+                # a POST MUST NOT cause a redirection without confirmation
+                # from the user (of urllib.request, in this case).  In practice,
+                # essentially all clients do redirect in this case, so we do
+                # the same.
+
+                # Be conciliant with URIs containing a space.  This is mainly
+                # redundant with the more complete encoding done in http_error_302(),
+                # but it is kept for compatibility with other callers.
+                newurl = newurl.replace(' ', '%20')
+
+                CONTENT_HEADERS = ("content-length", "content-type")
+                newheaders = {k: v for k, v in req.headers.items()
+                            if k.lower() not in CONTENT_HEADERS}
+                return urllib.request.Request(newurl,
+                            method="HEAD" if m == "HEAD" else "GET",
+                            headers=newheaders,
+                            origin_req_host=req.origin_req_host,
+                            unverifiable=True)
+
+            http_error_308 = urllib.request.HTTPRedirectHandler.http_error_302
 
         # We need to update the environment here as both the proxy and HTTPS
         # handlers need variables set. The proxy needs http_proxy and friends to
-- 
2.53.0


