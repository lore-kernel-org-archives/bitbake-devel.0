Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web09.37053.1623078222235956519
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Jun 2021 08:03:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=O0P0mt+2;
 spf=pass (domain: konsulko.com, ip: 209.85.128.54, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f54.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso206959wmj.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Jun 2021 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xxjT7d94j+WCj0QLGcmhg1uRaBp4Bt8HiJLHWxNSn0=;
        b=O0P0mt+289Wk2/PIq6v1JTLhH7s8AU/jtRJTDZbIEeKhc1ShOnOP7GxcqfFJPY7W+t
         tIL0dENutClVmAbj9DQ2SootFSTNm6lKU6gtPsgcG+ccMrt0O0NifgK6OwEyin2q8l5w
         nIx1wAcrAa2tUUn2BcTZOkzf8YM5MMQ7zndP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xxjT7d94j+WCj0QLGcmhg1uRaBp4Bt8HiJLHWxNSn0=;
        b=rcwtWletxQ117Ppl4JET5+qUXuTSQ60o45XFB5+0XYeN16Ja95cizJPLKO6VJxpnrJ
         4H89KtsheJTkCPgmoGwdyNxnUMNhcjA24IP6wD/5oSki4BFrnYpS8V5B7zubBn5jWzxM
         iMbiKDGVgULppz1SjhghiVdrdDxotsZgzKV8OjjatWPYY1NQ0iGqBVQYExaNTUFFaSrF
         v8i5p3mqkjBntHFPFLWGxOWqZT9SH8PhWICt85TScoF5mCgpj2IUHsYq45p4cLTscKmC
         9v/9rZh5btr7cUJleti20lZasl0lroGDeOPyW4iaqo3jFgrQ/8zzc1YZ+krL3pstS0YE
         tHHw==
X-Gm-Message-State: AOAM531CZCWF9D9ex7PvgKIVCET6nPlP4iqACbkb9mqKqR9csfrF2W6i
	rsUTPeJrIfsAUl9j2DZebqg5EzJ301ugYQ==
X-Google-Smtp-Source: ABdhPJyuGtfvzGykCSjtjH0BCZDVAUDdvn+z829zOoIWumsuy++QpJ2jL7tPLZM44zvt96lNBOEGMg==
X-Received: by 2002:a1c:9807:: with SMTP id a7mr17088073wme.10.1623078220536;
        Mon, 07 Jun 2021 08:03:40 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id l2sm15995488wrp.21.2021.06.07.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:03:39 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 3/4] prserv: Add 15s timeout to auto shutdown
Date: Mon,  7 Jun 2021 16:03:34 +0100
Message-Id: <20210607150335.32326-4-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210607150335.32326-1-pbarker@konsulko.com>
References: <20210607150335.32326-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This timeout prevents bitbake from hanging if the prservice process
fails to terminate within a reasonable time period.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 5e322bf83..50d7cb694 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -362,7 +362,9 @@ def auto_shutdown():
     global singleton
     if singleton and singleton.process:
         singleton.process.terminate()
-        singleton.process.join()
+        singleton.process.join(15)
+        if singleton.process.exitcode is None:
+            logger.error("PRservice shutdown timed out")
         singleton = None
 
 def ping(host, port):
-- 
2.26.2

