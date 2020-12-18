Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.10810.1608301589304999412
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Dec 2020 06:26:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RzIuMudv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id n16so6043711wmc.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 18 Dec 2020 06:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uasLUQWI1Oibjz5sxZIOKNIuPWmFUUoVGn2yRpCDZbI=;
        b=RzIuMudv5cSIIqN+vpCnagCHwNWKxcg9UPQgRJGZibrUl15kdFoYxIBfQft3BL8tOp
         eKlmL2hvc3otULIJ51uLTPXcPmGtIiHmCa9iy5qExNDpX2u3yNgfemAPgG+OhCmucQc8
         pfZxNf2YC0MJT876WAyA0+WUl0bSWUY5PyPEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uasLUQWI1Oibjz5sxZIOKNIuPWmFUUoVGn2yRpCDZbI=;
        b=KQC15XGRZdmyp07pymRhFnxn/jAIb53Qr0Ke+TW+lTGC1mwjby8MLC0cC2gwD/uwwq
         8FtINX78p4QYTBGxC2Y9MzmdwDGjTW0gZPZXHROfm0B+LYjaqCdtRdh7Ik1VgJU2xI28
         MkTBjj5oyPKBMCCZFvQSmd3h8SKfqSyHirYS0iqfrC0DDy9mJ7FQcVOM0kUQQgjCNd1l
         MfAVIRNv6gihb33qOJU5RqNL1/J88C+6w6hIKyRiS93a8pTa6C8bj48qCJeUrgwMGSar
         gzGu7K/bUFMZ5M4rwiIqTc0Ymw7+RU5X4RgZpfFd2vRaOf4t/VMmZtjlwvyHkPbuBjYW
         KTSA==
X-Gm-Message-State: AOAM530VlGpt7IIyEbC256v78OGQbUgMv71++yFnyQUnkjMeV6lIasO2
	wMaqrSfKRkhU3JpOlgdnXh9IgVXGSzg3vw==
X-Google-Smtp-Source: ABdhPJxyi2b8GNUDneKwDT0MnFTpxSz6UqWXOQIAVObYuSdaTkKdRKtFEjX+K+mwSaTGwEl22x/Qiw==
X-Received: by 2002:a7b:c7d8:: with SMTP id z24mr4527861wmk.1.1608301587544;
        Fri, 18 Dec 2020 06:26:27 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (4.4.0.a.d.7.7.1.7.c.4.b.2.1.9.0.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:912:b4c7:177d:a044])
        by smtp.gmail.com with ESMTPSA id w3sm12714741wma.3.2020.12.18.06.26.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 06:26:27 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data_smart: Ensure hash reflects vardepvalue flags correctly
Date: Fri, 18 Dec 2020 14:26:26 +0000
Message-Id: <20201218142626.3960223-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_hash() function is used to decide if the base configuration has changed
and hence whether a reparse is required. The vardepvalue flag's value was not
expanded but it is often used in contexts like:

METADATA_REVISION = "${@base_detect_revision(d)}"
METADATA_REVISION[vardepvalue] = "${METADATA_REVISION}"

which in it's unexpanded form means reparsing doesn't happen when it should
as the data appears unchanged. Update get_hash to expand the values of
vardepvalue so reparsing works as expected. This avoids basehash mismatch
errors such as the one recently caused by using METADATA_REVISION in poky.conf's
DISTRO_VERSION variable. The issue there could be exposed by a recipe using
DISTRO_VERSION with the sequence:

bitbake os-release
<change the revision of the metadata with a dummy commit>
bitbake os-release -C install

which was caused because METADATA_REVISION changed but the metadata didn't reparse.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c559102cf5..2328c334ac 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -1005,7 +1005,7 @@ class DataSmart(MutableMapping):
             else:
                 data.update({key:value})
 
-            varflags = d.getVarFlags(key, internalflags = True)
+            varflags = d.getVarFlags(key, internalflags = True, expand=["vardepvalue"])
             if not varflags:
                 continue
             for f in varflags:
-- 
2.25.1

