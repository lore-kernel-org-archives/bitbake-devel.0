Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web12.15583.1629667769082203924
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Aug 2021 14:29:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LjCgvtLQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso12734547wmj.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Aug 2021 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+5tNIYg2Wr/UBibOlwphmxefdESTyo0rTP5F+bGE+V8=;
        b=LjCgvtLQ67c1qCqmdv6myBwUHOp60jRjvSq01MYElNfm0PAEq7mToTjwULEvKYQJV6
         PeUU6x8nwnR/ZSzeH0fWegmB/xRhe4lhAN68ti+XHPtNLcHr6BnUv1UkFCiSAe4EpdWZ
         NlW2R6VsCXEew+hjxJnfaofJD9kz4/600DCBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5tNIYg2Wr/UBibOlwphmxefdESTyo0rTP5F+bGE+V8=;
        b=CFA7/5/HhcX9YGGoU6o60/c+Teik0Xc7bvkejPrREF/6dMRVDbDQxr9L7n+xY7Kf+C
         QWRIj+Rb/e3Py7HsC2EfjX95PVvY9KsuLRWPP4exaPVmRcRrWraRQYN2Dtv8ZQ/twdqO
         8x+sIXraBAjFzhC+hsxa7NFkIzAWMgnewUUgHDI2cy3JgmwALusT2urliM4sKJjt72S1
         JlRMKXG42fiwHzZ19nfdCFQShwAxOtiN9pg7dK3CLWGGou6GTb3O+4YN5yhVnxWBiIGW
         VINAeh3HtK5JReQO3TaFFVU2R/Dxhdfnlg3wWnmSC5cSJA4TlhrFsKVLsCkRv7bszwSO
         4Pag==
X-Gm-Message-State: AOAM533tp3roqVpOcetO46M/+hm++g5XGqH0PwRfRSOx4DnbeYrKg/Ub
	cduRMn4bfUtUUZHE+Z7Lz6vp4r2sWUJJWw==
X-Google-Smtp-Source: ABdhPJz1AKJrxlph43U3Mq7Tb5cvob88TzosVNZ7xoXVIKduRiBIieinYD007LZS8GfueGSfKNCINw==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr375043wml.62.1629667767397;
        Sun, 22 Aug 2021 14:29:27 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:d09e:54e5:5f12:c43c])
        by smtp.gmail.com with ESMTPSA id u8sm5223102wmq.45.2021.08.22.14.29.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 14:29:27 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] README: Add note about test suite and new tests
Date: Sun, 22 Aug 2021 22:29:25 +0100
Message-Id: <20210822212925.612609-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210822212925.612609-1-richard.purdie@linuxfoundation.org>
References: <20210822212925.612609-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that bitbake-selftest exists and that we appreciate test cases.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 README | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/README b/README
index 64206de8a8..b9b3762972 100644
--- a/README
+++ b/README
@@ -38,3 +38,11 @@ Mailing list:
 Source code:
 
     http://git.openembedded.org/bitbake/
+
+Testing:
+
+Bitbake has a testsuite located in lib/bb/tests/ whichs aim to try and prevent regressions.
+You can run this with "bitbake-selftest". In particular the fetcher is well covered since
+it has so many corner cases. The datastore has many tests too. Testing with the testsuite is
+recommended becore submitting patches, particularly to the fetcher and datastore. We also
+appreciate new test cases and may require them for more obscure issues.
-- 
2.32.0

