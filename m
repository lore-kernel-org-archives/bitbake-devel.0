Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65DFCD343F
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 10:44:02 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9797.1778323437675853499
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 May 2026 03:43:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ioaClIet;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso25076445e9.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 03:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778323436; x=1778928236; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/gfo6xS2VGl9I6jZAN9maWCY/TzpDh7+NefMkw5nc4=;
        b=ioaClIetCbHgUgGPzwVUUrbYZrPqfe23tguN5uOxoRnCrA9h1iOfYtuS7Wl/K90t6P
         DuTVQBcP7dLJMlBF0St40OPqqaW/Tky8RSDFJkbXW3evUteFU1jVPV+6qIczhkcdEFyC
         ZnYIrnnp5YqY8h4AmtI7vr6AdypfCZq5SxIZR3HyTvR7Hpa1S3o/HdDCV9HXXw5IBPP7
         p/Pycep72nbdY3+yQl/YVyHXHnSURfcb3eR/EFWftE3fuEVAMpOVMlwrupbnq+e3UNNT
         bLMr1H/Fav8ppKo93hxgoxYTURgYrAbJtpBJAEQOT21gihPGQzEVb4hHyubf87PCI7x4
         qU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778323436; x=1778928236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/gfo6xS2VGl9I6jZAN9maWCY/TzpDh7+NefMkw5nc4=;
        b=Oo3/AhrYPABHeY2qK4abz/u7U1Bb25aCDGprRm8OAbBkCJsoE5wk+THu4I9JJUZO2M
         1qlBoD19ropDvLe/kUmsd0svBswnxSYXHcxKrRuWdoAVRLQIHtjljji2ygzGp7KRHhzV
         jOosiuxXniF0JDgyvPI6XDECNyuIhaCA6+I9yyUzl8giapCMnla9eFFGtaceYBl4JTxt
         OHb8jcVdNFSyPTs5SXH/i+CNyPSA03si6owUSSxLgTmIJXRL9SsTGfR/3hJuwHm/jPed
         yz8SLvJtEg6ofjWkYVgjF3c6dKk+tFoqFDh9zFiqJtx14nmtKdHz2n0cy6EeF2fGC6WK
         wdrw==
X-Gm-Message-State: AOJu0YygXWI3wdEx7a7lAG811aI/RYSyh5ANMWQzanhWGoQeboJrt0rg
	pBoKA4odOeE+RCUOTisAasBE0S+HD59P8lFj89MZMDr4HNgHKlxv6QxObiKNlcjjQQ396g==
X-Gm-Gg: Acq92OGbKzekvr9neEFaAyJvLKEQo07OG1CL11MYlhEQZ9Jc2x+l3fCdMlz9IP3A/Ce
	j4jrZaNNq2waZfsyVS42UGLswdbQBEZMZxf1snIJ/XvDqQxR1UzPBlgklAwGOZSC++Edqx2WHJG
	acLArVS7NJlynulWIeo0HrtbDbHK8WACB/9wD6vdwpjbJ6dWkql7xRf/Vl9y7a5MEb0KxUYy7GC
	ScoNT05JCimGEWITOMoTTmL9VKoXbuGbzGzVIDnSZWf2utqnYjHul+FMKgnsHc21Cti00iPW2Hb
	nNdU8yf3OKdku6+r/E7WL8tuHbA7P6bF2XbRDIPoct6g1sTBQlBxDAt99OR/zQUlUkdcXoHXZ+j
	XWKxssDix5wsUVP7wbctVhjnMNhXEcAlRnKSW8gTTR1Ex4ZkCeWTDuNAaRxIHyO3zGal1rJccs+
	yvfxtKsrEE4ptJzJCzz+/alKzL3GMZoGpTNhjW8cnizCg1zRh4QPjHsqvTwHdkGDjcrYo/8zoDa
	OfIrb3eRxpV9H4eDnO4IEnUgpjiKHRLaMAI/wZBwOyX81uAjA2eTbo=
X-Received: by 2002:a05:600c:8486:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48e706be062mr31199445e9.20.1778323435643;
        Sat, 09 May 2026 03:43:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:d188:380:b100:f430:86bd:b50])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm38837255e9.0.2026.05.09.03.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:43:55 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	quentin.schulz@cherry.de,
	richard.purdie@linuxfoundation.org,
	Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH v3 1/3] doc: bitbake-user-manual-metadata: remove incorrect claim
Date: Sat,  9 May 2026 12:43:05 +0200
Message-ID: <20260509104307.26698-2-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260509104307.26698-1-bijak.dawid@gmail.com>
References: <20260509104307.26698-1-bijak.dawid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 10:44:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19485

The documentation for inherit_defer contained the claim
"If VARNAME is going to be set, it needs to be set before the
inherit_defer statement is parsed"
which is incorrect and contradicts the purpose of inherit_defer.

Drop the incorrect statement.

Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 40cae6b05..ee6919dc4 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -829,9 +829,7 @@ Here is an example::
 
    inherit_defer ${VARNAME}
 
-If ``VARNAME`` is
-going to be set, it needs to be set before the ``inherit_defer`` statement is
-parsed. One way to achieve a conditional inherit in this case is to use
+One way to achieve a conditional inherit in this case is to use
 overrides::
 
    VARIABLE = ""
-- 
2.48.1


