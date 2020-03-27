Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.13189.1585320509297436708
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Mar 2020 07:48:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=efsOWS/K;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id g62so12662161wme.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Mar 2020 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUotwpfXMUv2nVYbdH1nmWLtuDbzXqjB4OkFknaoEQo=;
        b=efsOWS/Kk5SlcDsQdPHSYlrEJTVASwbBfhdxqNpdc4zWkg5F/VFt4lfpZPrfn3h6CF
         ZpAb3T7+RYT/eygrADbu+QPFiw+UpBKdrmjQi0HOgpABySnsjIJYbnyNlEXzQU4VhGWk
         zxXNCJfdAr9fWMDj4w61BHuZllu6IhAWcDo8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUotwpfXMUv2nVYbdH1nmWLtuDbzXqjB4OkFknaoEQo=;
        b=sr24XwpoDm7DcSFdxHwgzKXpNIKaH8qqcbdxMbFmj9bwQKYgTjsbgcHnx6UzqyHmVy
         RdgUQgZrZb6DkfDWjD6lwwJs3aSwxZGsXnPRCKJXioADH3V4fd/terzQeKGScO/975Fy
         dEYDK4wC3lEsc+qIX9HCumF1ab/LsTkOyxgVMqCS2+pbLGVZqbTPfzxboKI2ChuU88hO
         1QI/iSsHgrpxWdLIZ/QFz2U9363B5xgRnpUtPMIyfLhB9cY1qzQEHwNgWsLU1B+OzbeS
         Peu/ZwF//eUXvmF8al5bEre7IFig/9uXezH4PHu3pFp+VF1WFcq1+evsJC3UNzm5EB1v
         KsgQ==
X-Gm-Message-State: ANhLgQ1yhOKdtxvrkuffFfvoA8rcnW7upoYs+WCzh79dbBgUuX6lXbDS
	Bpu4+gACjwrlhpcNjsZd5wRT+2oGFxs=
X-Google-Smtp-Source: ADFU+vtHzc8dKjNic3g3dWd6d4YqukOcRzy8OCpY0jUDWmzf1a6fIpdSKTS9yxKhivxy0Ui6WMFyGQ==
X-Received: by 2002:a1c:e109:: with SMTP id y9mr5581356wmg.62.1585320507311;
        Fri, 27 Mar 2020 07:48:27 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id g3sm9093216wrm.66.2020.03.27.07.48.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 07:48:26 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Fix urldata_cache key issues
Date: Fri, 27 Mar 2020 14:48:25 +0000
Message-Id: <20200327144825.562857-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon inspection its clear the way the keys for this cache were being handled
would break it and cause the cache to never be used. Fix this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d8ad19b59b..813f5eb773 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1631,8 +1631,11 @@ class Fetch(object):
 
         fn = d.getVar('FILE')
         mc = d.getVar('__BBMULTICONFIG') or ""
-        if cache and fn and mc + fn in urldata_cache:
-            self.ud = urldata_cache[mc + fn + str(id(d))]
+        key = None
+        if cache and fn:
+            key = mc + fn in urldata_cache
+        if key in urldata_cache:
+            self.ud = urldata_cache[key]
 
         for url in urls:
             if url not in self.ud:
@@ -1643,8 +1646,8 @@ class Fetch(object):
                         self.ud[url] = None
                         pass
 
-        if fn and cache:
-            urldata_cache[mc + fn + str(id(d))] = self.ud
+        if key:
+            urldata_cache[key] = self.ud
 
     def localpath(self, url):
         if url not in self.urls:
-- 
2.25.1

