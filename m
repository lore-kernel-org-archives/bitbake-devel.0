Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9FDCD343F
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 10:44:13 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9806.1778323451134459635
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 May 2026 03:44:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QUGFA5oc;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso26829515e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778323449; x=1778928249; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei4+RvsXLWf6gFAPT9tu8Ww+AIZFSgxkmkl7zyQX4q4=;
        b=QUGFA5ocHCDP8UNjvsKPdb+BMWeQrGCXUKBUQZlILG5cfvfJPeeNgE8bdx9a4sBx01
         6SVjHdyPBzUQzmTQrYBrUSHpc65zyAG1pQERjbNITxUqglQY4PYV0nkIW5qWxZYs3+lr
         b5jUAcOKLh4Xu04F5RZc6eSUXRNwr6OC9/986xygLVY1TBSFub31W/KO49DYf3lBgg10
         unyMWm8ukzWwFn6v3JYnhBoVtSDYcZ2C8Jjbl5T2S8hTaKPn3aU3uHTsrbZ09aG2ZbXa
         2z3eRSjOrl3qots/Y1zqbbBPrXJpdmiHWq6hECUE3fbwynzPzqML2yi7Q8nAI5GS1Wvr
         KXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778323449; x=1778928249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ei4+RvsXLWf6gFAPT9tu8Ww+AIZFSgxkmkl7zyQX4q4=;
        b=VzGICChDCk3tnHDllysx0bvZ4z6T0j5rFcUxMZ1hr50/jn5v59eWVh+iERrVgr4Zux
         PRBdo255wavAuePJoPU6YvfCQu8T8+M5Nq3iS22/jsvs2z1+6PUy9wQyIwT1vfTL0QxW
         wnjR9wgIar6y/gbDmwAf1Dj/VuZIDuIkgOGPr/3YbEKI6HQnS7VVB5PKKDexyPgW5qDV
         gBFDLwqxZIk/G4cukvG584SE4TtwgCv5mUJ36bmOmsiFBOPl+bG1bDzGE4hs7gzaLgOI
         aJvIzcE0Vx5zf+559n9vuqw4R2Jv5qEXX/7P+14yLm2mW89U4UzUppSiFS0DSEp2/Woi
         7zJA==
X-Gm-Message-State: AOJu0YyvBvTyExVwbvPeIDO+waOszlmirMoBJcznJqqdehMRBqWSeVso
	TXDjSUOfuUfRQWRMCD0OEbV83ufoEAqE7xpElYiwlcZ4tqGD+r6PYL2KtCy3zNMnPTGYhA==
X-Gm-Gg: Acq92OFRle1VngbTPD+KJgB38uAul7Ds/i5FeSkwDFNHtatH8FZixe9aZve9l3lhJ7l
	ZA4fMguL2gmSxPSEvaXzwYY1thZIoS93EPItiLHsHVozdqRop9/VEa4/5SqquhUMiMAO1BSrMdQ
	B0oC5x6vPhQpu2+Qehb6/+kf19A2Z/O95Lz3ufjo/+1z4ziEsy35rzFnPPBCbT90qX96Au5DITk
	aEW55LK2wR2qNLphtfqKztuddsbJr7ZbbevYAlx/9Qau6HY9xlV/tcxGKXrDtviSSYRtSHBsTDQ
	MMyMgnPJiRH3VU/JWgRVI5+27J9yJFzVMcYlfvTdlwJEOUYlS4km+0xMKC+IDxf+Kzp7k11lPdc
	9oarRJQnUPBxcMzgP9mCy2e14tdWbUVfOlAEzvRPU5QOAb3SVOKZ+grwW3dln1vzUqL+XASsjxF
	zDrjxsZzuzNmZYyHqeTMuaOB17PZeHGjnAbomXgOaoed5+btv1wP8YS4MXzLrQvv3AssqNADY+q
	uQcPWutPFSQJdz1NGPn1xw6usfmA+fb72O+N+ZBTiBMWSLsDjpMVA9xtqvGjs1dXQ==
X-Received: by 2002:a05:600c:630c:b0:48e:6275:27e1 with SMTP id 5b1f17b1804b1-48e6275282fmr141690905e9.26.1778323449176;
        Sat, 09 May 2026 03:44:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:d188:380:b100:f430:86bd:b50])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm38837255e9.0.2026.05.09.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:44:08 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	quentin.schulz@cherry.de,
	richard.purdie@linuxfoundation.org,
	Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH v3 3/3] doc: bitbake-user-manual-metadata: explain inherit_defer example
Date: Sat,  9 May 2026 12:43:07 +0200
Message-ID: <20260509104307.26698-4-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260509104307.26698-1-bijak.dawid@gmail.com>
References: <20260509104307.26698-1-bijak.dawid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 10:44:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19487

Add a short paragraph describing how the inherit_defer makes use of override
syntax to achieve conditional inheritance, and rename VARNAME to
VARIABLE to assure consistent naming throughout the documentation.

Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 52a9e7fa7..59216f69a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -827,7 +827,7 @@ the variable after the line is parsed will take effect. With the :ref:`inherit
 
 Here is an example::
 
-   inherit_defer ${VARNAME}
+   inherit_defer ${VARIABLE}
 
 One way to achieve a conditional inherit in this case is to use
 overrides::
@@ -835,6 +835,11 @@ overrides::
    VARIABLE = ""
    VARIABLE:someoverride = "myclass"
 
+:ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>`
+defers the evaluation of ``${VARIABLE}`` until the end of
+parsing. Assuming ``someoverride`` is in :term:`OVERRIDES`, ``${VARIABLE}``
+expands to ``myclass``, which is then inherited.
+
 Alternatively, you could use an inline Python expression in the
 following form::
 
-- 
2.48.1


