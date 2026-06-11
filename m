Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD965CD98D6
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:11:55 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45071.1781183512687311102
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 06:11:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=cOxsNpr5;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45efa80e0afso6233880f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781183511; x=1781788311; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RM45OF3EEzpBSFPiU887KE3K2Msolbx2eokvHGPF+a8=;
        b=cOxsNpr5r1ojFZ2a2mLQeAOFq+8gJd7cDpES9P1dUhu7l5EpOPkjZ2AQgRYGqEbcK2
         zQqrMC3j2r46i0grmjJUn/d6C0o5o0JGOCtj/ISHVtotyKyb/64p5ygwGy6uCBu6dSsE
         mlzLmkpSsyjKImpiYO3oIUpzo+Y7FPYDH3aGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183511; x=1781788311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RM45OF3EEzpBSFPiU887KE3K2Msolbx2eokvHGPF+a8=;
        b=lOmrcojvTBeNNExUE4g10hEW7LQg9y4aVZFFBW0PQG9QO1/EoFc9XAe81+9TXftPUt
         wyXFheE1GjPbiWrw1tIEh3nYDhNty/0Xf/lmm782SCXbIBYLYvH5Q3OHH6qhD+j8Xn9K
         vllYnRugQEruop+EhjW8AYIBhWeS5cjuumPV3A6PVEvMkQUfhpX0/s2EEL6N+jtXGCrB
         RAPwn369w2XwaUpZuBvtOcfOlfxuincZ750nFQhU0MDhKzoreB1moIlJMAL8EMXSb/lc
         tvFHP1vq28E7UNmHJzIfX6MG3eyrxKELNpcCRpMP6+VRIULL8sdSGNe8NyFkACeV7vw4
         15QQ==
X-Gm-Message-State: AOJu0Ywwo4GUb49KVSO1u68j6yhAukk7gxM32AuDUn/EfUmidM0klb9R
	qeNMAHEBcSpdR8yuoGaXNzMgRxTedkPpcTf0rhiHJEuY0dZ9+gjPAcBQP6/V5PNI8yKCUv59n+y
	PvRsC
X-Gm-Gg: Acq92OEvVfpoFQcXEa3gTKg64R4/u6PsnSp7CnH8RErhpE05aTRIi4T1oA8K4FIhetr
	Fpk5kAV+9ItNB01bP5PE8uwOTG7fwU7ITiaSjvT9kkpukcTXGqhb6J4NIG7M1W9vDl2Hdq0TIh/
	wuLeDISCCp15A8dc4PHwIkdKWo4PLObhJ1FGCEdTk1aCrXXgf6uBk2bYK8/beNqdSanz3DAic3c
	NzEsxjA9HFf40r4pnZh3OBT2IJCg9S0DXUWDguiSj7g1BjFkx0hyoz3RGADCPGEYEzCH9iRlL0i
	q2LXaeHC1obE91pI+gSNS521y0covZtw+vnl+kV7vB+RcxiiyKG64fFpT4TDIRtZAMTemV0q1lg
	ZwXOXOf4+FYDgxND/05Z1mTvxvJke4/vEzMd9ksPHJSe5UokSJqgM0Y6lzpOtog2ogEX6yizTLO
	0Jez8hSxr+dwJBofuGVV2OyXc7SJy1EQ+0pEvMj9ur54GonslUM5nKX+oQtS8EwL+M0GCF5cC72
	vXfKSbvSqrItywhpJIVygtZzB51bmU+J6WgmR0=
X-Received: by 2002:a5d:53d2:0:b0:45d:7bf0:c7d3 with SMTP id ffacd0b85a97d-4606757a4b4mr3187662f8f.19.1781183510970;
        Thu, 11 Jun 2026 06:11:50 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0084744357c26c6744.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:8474:4357:c26c:6744])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm82048251f8f.28.2026.06.11.06.11.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:11:50 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH v2 7/8] fetch2/wget: limit auth on checkstatus redirects
Date: Thu, 11 Jun 2026 15:11:29 +0200
Message-ID: <73625fd3cb82bd3f9241f77d4b1e9b77fc828860.1781183212.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781183212.git.yoann.congal@smile.fr>
References: <cover.1781183212.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 13:11:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19667

From: Anders Heimer <anders.heimer@est.tech>

FixedHTTPRedirectHandler copies request headers when checkstatus()
follows a redirect, including Authorization from SRC_URI or .netrc.

Keep same-origin redirects unchanged, but drop Authorization and Cookie
for different-origin targets (scheme, host and effective port), following
RFC 9110 redirect guidance for resource-specific headers. This only
affects the Python checkstatus() path; normal wget downloads are
unchanged.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1019d5a5c42c672ea673ae9d22363d626b57ccb9)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/wget.py | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6ac4306c0..fc83b301a 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -288,6 +288,18 @@ class Wget(FetchMethod):
             http_error_403 = http_error_405
 
 
+        def _url_origin(url):
+            parsed = urllib.parse.urlsplit(url)
+            scheme = parsed.scheme.lower()
+            host = parsed.hostname.lower() if parsed.hostname else ""
+            port = parsed.port
+            if port is None:
+                port = {"http": 80, "https": 443}.get(scheme)
+            return (scheme, host, port)
+
+        def _same_origin(url_a, url_b):
+            return _url_origin(url_a) == _url_origin(url_b)
+
         class FixedHTTPRedirectHandler(urllib.request.HTTPRedirectHandler):
             """
             urllib2.HTTPRedirectHandler before 3.13 has two flaws:
@@ -301,6 +313,9 @@ class Wget(FetchMethod):
 
             Until we depend on Python 3.13 onwards, copy the redirect_request
             method to fix these issues.
+
+            Additionally, strip sensitive headers (Authorization, Cookie) when
+            redirecting to a different origin to avoid credential leaks.
             """
             def redirect_request(self, req, fp, code, msg, headers, newurl):
                 m = req.get_method()
@@ -320,8 +335,16 @@ class Wget(FetchMethod):
                 newurl = newurl.replace(' ', '%20')
 
                 CONTENT_HEADERS = ("content-length", "content-type")
-                newheaders = {k: v for k, v in req.headers.items()
-                            if k.lower() not in CONTENT_HEADERS}
+                SENSITIVE_REDIRECT_HEADERS = ("authorization", "cookie")
+                same_origin = _same_origin(req.get_full_url(), newurl)
+                newheaders = {}
+                for k, v in req.headers.items():
+                    header = k.lower()
+                    if header in CONTENT_HEADERS:
+                        continue
+                    if not same_origin and header in SENSITIVE_REDIRECT_HEADERS:
+                        continue
+                    newheaders[k] = v
                 return urllib.request.Request(newurl,
                             method="HEAD" if m == "HEAD" else "GET",
                             headers=newheaders,

