Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FCEC79FA1
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 15:15:40 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37507.1788794139067760665
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2026 08:15:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ffeukvd9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b965570d7so43397535e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788794137; x=1789398937; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rOZHkvsDqtUh2bLdZuQz6Krn2V9k9plKb5CRH4SoKq0=;
        b=ffeukvd9TNndtVTyHKWNPpbm4brtCb7FvA2agc8z7aCkzdJSJhMWJbrBtyi0XRPrFK
         jg/n/8sWPBcM828IFsRrgrXsH+WDAYzr6zQEyMhatUeToTz3vqMx+CTKmB/U+qT2oXEZ
         GytlSb0eMy3Y1EjpvXA2ex3jnJ9fAf6DBgjEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794137; x=1789398937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rOZHkvsDqtUh2bLdZuQz6Krn2V9k9plKb5CRH4SoKq0=;
        b=ElJCOGidQ3tGa/BDQO1Or5CS2OI1hDPxwDwzoVs1JL3OOHx3ervkeR/Ul1RnR0t8Vs
         z3kfcBkOBZlZB7xvgbP8uljRaIu2bNe9hRrsfxalA4iw2fQ7XksIFM1pqp2Or9Qkox4u
         6j8G8lqDayEPQCd47O3mItl+rkM+0zswI133duCg188/w8p0OAX6myZWC9q+ga+UKwMM
         KebUHV5JkDN+YoCIPppTtXRld3dDfr6yod3niQK5V3kCNGd7x0ofuUxffknzPbEEe+dH
         8OwaARJkIagWx4L2vA91BOXR5g0e8vroMRMUpX+uDxwQGHqXk2Vjal4pjK8gFR+7pEce
         daGg==
X-Gm-Message-State: AFuF++mKJdmm6GDTNXYGClqdVWYfnBYvzkjkrnQVUFjU+b0gEvwauCUG
	qo6/XpAwruDe2XjkHSMNIe5hmtRX0sfTiVuRVNEx0qW+0rQg4iVTeZDC8deXgQojPc+TfuiuV44
	U+2lbDWg=
X-Gm-Gg: AYBFou0pC3tvulsJ7J0fV0Xc5C67les5+k1FnaAi4dbHj9RUN0QUz77TJ8FbgVdFf0T
	jOJjI/16oMtUO6Fm32p+GLAwSz6t3N9DUOj7y2NghToFnPFC96fKOuJCiXYPvqmBAK5cggdSUWi
	z+yyHr+plcdniNiOgXTGMZHMVemXOGsrgFy48FL2wiGT9tzAtHMFoSpaeLUs8szHNtvXKYLLOl0
	+hval9Uv9DQlNiDPCLqYHgNzdANkxdx55rNq+2OZ6CNyZwfn0mPNO0bVkT4HTkDxJGUME86R3oC
	ZQ2RQyjG6OMQ1xDyk0RVkimRTAjP2y7jCgnL/hUpynpwjTD99zvnNdWXlMT5j47rn3zeuAsNZIO
	inFtfg1lbypyeCSzoVwjy3TLwaoN9sKYpnYpxY6cDJOYM1THb/LVGm3k1ceuRFqWCRc4D41B5Jt
	bY8WPkcpUgF/boRpZiJTnIQSzvbtspaGXOflsqZ4p5cGUd40VingMw7OLOI38oHiyhMFcx52JpE
	+ZoroVIaspPRhlKjQ==
X-Received: by 2002:a05:600c:a04:b0:499:db27:7b1 with SMTP id 5b1f17b1804b1-49cf82621acmr249288575e9.15.1788794137153;
        Mon, 07 Sep 2026 08:15:37 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e2ae:fec4:d03e:3153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cc7sm318995275e9.4.2026.09.07.08.15.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:15:36 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Drop ftp checkstatus test
Date: Mon,  7 Sep 2026 16:15:35 +0100
Message-ID: <20260907151535.4094875-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 15:15:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20165

This single url takes 100s in each of the two tests it is used in,
compared to the fraction of a second for the other urls. Nobody
should really be using ftp any more anyway, drop this test url.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e8c1c62175a..7738764537b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1716,7 +1716,6 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://docs.yoctoproject.org",
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
-                      "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
                       ]
 
     def _start_checkstatus_server(self):

