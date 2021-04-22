Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.9168.1619078099624480516
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Apr 2021 00:55:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=PfnLjRq8;
 spf=pass (domain: linaro.org, ip: 209.85.221.47, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-wr1-f47.google.com with SMTP id r7so31775563wrm.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Apr 2021 00:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MnkDn3AILaMJYwbK3C5DhDpiW9eROnK8zfRq9vhelg=;
        b=PfnLjRq8tTXVXc9PGSYmwqylaBgosqa/kpj1LGTHf70DKxDKUNfvxHrm/r0hIMeo7g
         7nAz4NORaZQz2Tpoyx7eYVXeizyMD26bAnLKGnsm0Y2yFtNBAKkFIIX8rYZdAmtMlEXb
         TtxnxJu1nzsP07q3LBPgkkiMVsTGuRyG9WQ78L2kgeR9gpY6tT0j11q5ial/XvtWQKoC
         XoeO4o5EaYy/D4E8r7+t4hz/rGjYF9z+mKBQmy6xaYts5U9A+8BQGti7neik8Ek5cupj
         BqO4A94j7426VKW4tSpbGZ76IZIosYkJAstqycnIlf5Zp42bUA1gFHWBXcmw6X4YF0J9
         3PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MnkDn3AILaMJYwbK3C5DhDpiW9eROnK8zfRq9vhelg=;
        b=bhIFSXjM6Ua8waMj3FQHmxQ4htaaLkj9sRmc9iRFfoQ8fC5smhifO2M7tc8JMyviaS
         8dh6vhXCkVwaHOUIEEHpG6LJYBr+TJ3e2oAt+I1u5LH6LtiYb8aN2Spw2uGUUl2Cblwj
         t+1cCDoD/XFAF/m/uREIecrX8WyQlMDFzeCIWMpQLQQyKo+P1x6rneRR+01mfMeHpVUe
         9OB+byWIvk3WYPStKpR2S9Gpbpa/uWR30pMdX0XJeRQtUlcxWmHgbzn93PJP7hMWPq37
         uN7BYtU/vEjB0Q2zO9vLy4TOluZ9sNCncv5shqCjIlo57B8HRVIwCkkxdWFe51pFfi9S
         QWZQ==
X-Gm-Message-State: AOAM533JZl3sWAO9UbUtz0PKbcugUyB7viZOmTt5JduR02q46r6RuqbI
	nV9dv5MkcgZMCc8wU40Hw2a+8w==
X-Google-Smtp-Source: ABdhPJzP5X3Zsj3HHZV++mKMBNcB/6NZQErt4dGEs2wIr2zjAT0qCqvWeAJHIjPyEfBLIEJSpGniEA==
X-Received: by 2002:a05:6000:1789:: with SMTP id e9mr2561699wrg.110.1619078098140;
        Thu, 22 Apr 2021 00:54:58 -0700 (PDT)
Return-Path: <nicolas.dechesne@linaro.org>
Received: from matterhorn.localdomain ([2a01:e0a:1b9:3e10:97e3:5361:aa3:23fb])
        by smtp.gmail.com with ESMTPSA id x17sm2014392wmi.46.2021.04.22.00.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 00:54:57 -0700 (PDT)
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
To: docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>,
	Michal Piechowski <m.z.piechowski@gmail.com>
Subject: [PATCH] doc: bitbake-user-manual: fix typo left over from Sphinx migration
Date: Thu, 22 Apr 2021 09:54:54 +0200
Message-Id: <20210422075454.258616-1-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes d99760cc687c (sphinx: last manual round of fixes/improvements)

Reported-by: Michal Piechowski <m.z.piechowski@gmail.com>
Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 doc/bitbake-user-manual/bitbake-user-manual-hello.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
index e3fd3215..fab1e8a6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
@@ -325,9 +325,9 @@ Following is the complete "Hello World" example.
     following: ::
 
       BBPATH .= ":${LAYERDIR}"
-      BBFILES += "${LAYERDIR}/\*.bb"
+      BBFILES += "${LAYERDIR}/*.bb"
       BBFILE_COLLECTIONS += "mylayer"
-     `BBFILE_PATTERN_mylayer := "^${LAYERDIR_RE}/"
+      BBFILE_PATTERN_mylayer := "^${LAYERDIR_RE}/"
 
     For information on these variables, click on :term:`BBFILES`,
     :term:`LAYERDIR`, :term:`BBFILE_COLLECTIONS` or :term:`BBFILE_PATTERN_mylayer <BBFILE_PATTERN>`
-- 
2.31.1

