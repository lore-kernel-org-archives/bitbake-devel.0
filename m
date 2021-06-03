Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web12.6640.1622720760635835408
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jun 2021 04:46:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=eau78cuo;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id y7so893383wrh.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jun 2021 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fjzMSL9dLF/1QzUyQ1SYgT0PKLUNY0N5VPKFfzDyVkw=;
        b=eau78cuorQ3A8mPKLpIcLqRzqHWfqwf812ImjTCB8iBXGub79PE4cqYacna1oggAgH
         0S9zD5WeyPYqPNzoA1AQeTY+O9LhOk4WaX2ZqZBDDzq95qro8/mWk56cQGOMyZZnxHgG
         UQtjZNRc54ZD5BtJvzMAr8gfGUcIqozcId5nmcIMRSJjeIH2RvgbDEGmX6sonJWSXHUV
         oRuXgn3BcJZEeB8uE1RElRX5oLBZxrqbyAP+9rg/wA05IyXbwEdTWuCpbJU/ljSaMosd
         7FjGetZ+mcT/mSPMXHai/Fg9c0YbY0+isrrBJ00B+zsN4t2rdEguTQxiFpnPypnb6W9N
         f85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fjzMSL9dLF/1QzUyQ1SYgT0PKLUNY0N5VPKFfzDyVkw=;
        b=AKsJwWVMj9BJZYR6wXejPeZft3sVroi6Do2l3TdkDHpLRY0B6BP7K5G+hYRW0SOymJ
         QxOGeo0sbB5QOddU32bZaGjExpBpR2o/P115F+IVP2By/SSHScWlQmA7P88tzXkJslvf
         jn6Az6gfBzxrhJKI/sXwsUg6k/4CyiVz9CbBjDY+17Wvvx3i0c+vHfPuASY24Z8/3H3u
         B8RNdk6548J2M1lUplqRVlY13tOsGviOZFVvQ6XrBaevb85E6+Bfo2aWckQi1yEFLmdB
         16nEQU6f7GOw5i+r8HmTqk32MeO9w1pM4EAbBF7bourVLsw6ZCnq/vkoDdNhstwqE9Sl
         oWSg==
X-Gm-Message-State: AOAM531WgFOkRVnP8JEgS5J7ql06c1bGwD2F6akekk9FU64tDufT5jdL
	vI08o/Fj6Wmb1wmc9CqGkm6AE8oeZE4=
X-Google-Smtp-Source: ABdhPJw3S6kl2FFLf1Am5/bZ/WcX7JQOSMO0YAG/Ssqz7uvF54YHEcnidyDzL0dfI5k6UcOBYt1TnA==
X-Received: by 2002:a5d:4f8f:: with SMTP id d15mr28047383wru.85.1622720759157;
        Thu, 03 Jun 2021 04:45:59 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id q11sm3085879wrx.80.2021.06.03.04.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:45:58 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.46][PATCH 3/4] cooker: Ensure parser is cleaned up
Date: Thu,  3 Jun 2021 13:45:42 +0200
Message-Id: <20210603114543.98044-3-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603114543.98044-1-Martin.Jansa@gmail.com>
References: <20210603114543.98044-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

During cooker shutdown, its possible the parser isn't cleaned up. Fix
this (which may partially explain why threads were left hanging around
at exit).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 87884574..4d2c62cd 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1636,6 +1636,7 @@ class BBCooker:
         return
 
     def post_serve(self):
+        self.shutdown(force=True)
         prserv.serv.auto_shutdown()
         if self.hashserv:
             self.hashserv.process.terminate()
-- 
2.30.2

