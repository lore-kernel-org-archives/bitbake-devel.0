Return-Path: <jeremy.rosen@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB89CD98CE
	for <webhook@archiver.kernel.org>; Fri, 12 Jun 2026 14:29:20 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71950.1781274551701508991
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2026 07:29:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=tYHg3Oc0;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: jeremy.rosen@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so12191665e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781274550; x=1781879350; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ag61jpVTuVQdwQg3PmsDrkph34VaeiPdikM7E+xxxo=;
        b=tYHg3Oc0TZZmctGR7enmtdsZMNkBNg536A5IFYXkvjUfqlRbDupjPrWjgZlLYQTUw4
         ho2sFbv12QtQuDlreQV+WH/V9h6d+vcuA7EO0SDWfZ6cydWUdWkfhzFa6CGUSQbTJA/z
         AuNBuXfiaQp90I/ccoQ0P4TUTm9TmfYdxedEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274550; x=1781879350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4ag61jpVTuVQdwQg3PmsDrkph34VaeiPdikM7E+xxxo=;
        b=FkIcibfU83JQfBX86eLCIG3hsiBVwz/1ATCf1NTV2yNTiXxuzwle6mZ0Edqnyz9lOO
         QLNE3djwMV4EicCvCqzBB5bswRO7wNDRyvSxqS2KPYdN26qxwCdyytvZ6V2HksNcUTwD
         i4Yf6Y5mgVBMPqEkiHUdJzh+xQ1+GU/wIgrApk69c8fZZlcCUG4cd/cuMvBHBue+L7JV
         BdzXE796SK6vt6XDwREhYDRHhYNTG9TsWxHBycporleFABOU+hJz0HHVVioSVpOv9SK3
         TC+X8minS0hG15s8b5yThGS8WBTY5OLbZvoIwuPbiHKoVOUnBlxWawRynPsZ2gSIV1c6
         nAFg==
X-Gm-Message-State: AOJu0Yx1tAsPsomxXsvWnvWeIgl79YgGHm12t8jAxvFVY71zjjaZaycG
	5vtkXvQ3I/NY8BLRxFA7PxZx/MvFbE5Fo56ABdZkzXqGdvS+HXy0tpQdbtxNNi+UZO5Wkazdg/Q
	8najVfg==
X-Gm-Gg: Acq92OHmHVUf+4+olc1uFMB4fdYrvzeXwuvtzii/9vtkJ9rHA2swPcEN9KCufsVGGNG
	jFBJ8z3hSu/YEEN1uGJg9qTA2OeJ1HtgSUkmGzllhaWC8Lq4rkdBT2/idQShZkenovQ5zXa/GRw
	Nf3EhqllwpBGQKA9nBvvTlUjxRApdikBTSXgs5q6Tmk/IjxWflMfSzVn4gpYXkRee0dqSGVntJI
	+rLMh3rvcOmipRjU2UqBu5DpzFO2Jw4hSja75LLsrx1+0NEO8o+KknHFPoxkbj/NGmJPViH0Xh1
	U/Dd3ygLlwXLR6/fpZJjB5nw2Q5xAZo75hlHUB0NrERfELFus6ViAbLzTT6CmWx+93LJKGSh/5a
	NzDi0JfSoufRiz0M5HfMDrN/laGgIBiRmEYlAhIE5Bt78ROR/0JcGX/piLYu+FM0Lfd68x53geL
	SrG2cFCIVWa8RHoQfUi3Nvbtk=
X-Received: by 2002:a05:600c:4f94:b0:490:bad9:de43 with SMTP id 5b1f17b1804b1-490ec3388dfmr47241725e9.0.1781274549867;
        Fri, 12 Jun 2026 07:29:09 -0700 (PDT)
Received: from Logrus.lan ([2001:861:560f:240:8dd0:2c2:7492:641b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-490ea8123e1sm74072065e9.0.2026.06.12.07.29.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:29:09 -0700 (PDT)
From: Jeremy Rosen <jeremy.rosen@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/4] fetch2/wget: limit auth on checkstatus redirects
Date: Fri, 12 Jun 2026 16:29:01 +0200
Message-ID: <348edecf9e663c3b432c6cf76c3f911354e83487.1781271084.git.jeremy.rosen@smile.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1781271084.git.jeremy.rosen@smile.fr>
References: <cover.1781271084.git.jeremy.rosen@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 14:29:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19677

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
Signed-off-by: Jeremy Rosen <jeremy.rosen@smile.fr>
---
 lib/bb/fetch2/wget.py | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 55b2ca2fe..14a1a80ea 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -303,6 +303,18 @@ class Wget(FetchMethod):
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
@@ -316,6 +328,9 @@ class Wget(FetchMethod):
 
             Until we depend on Python 3.13 onwards, copy the redirect_request
             method to fix these issues.
+
+            Additionally, strip sensitive headers (Authorization, Cookie) when
+            redirecting to a different origin to avoid credential leaks.
             """
             def redirect_request(self, req, fp, code, msg, headers, newurl):
                 m = req.get_method()
@@ -335,8 +350,16 @@ class Wget(FetchMethod):
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
-- 
2.53.0


