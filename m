Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCCACD342C
	for <webhook@archiver.kernel.org>; Fri,  1 May 2026 09:14:51 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10752.1777626882542923219
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 May 2026 02:14:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EprUSB+t;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso22307035e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777626881; x=1778231681; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yWOulaSOL62l7Wg08B9kXAJdma9fT8Nk2Tg1J8MlHA=;
        b=EprUSB+tkwrg/uCB4BMDTgeZ2dKQF9T/V3SplEH9howaifyNNHz0CWY0EmLlLJpbX2
         X9WPjg+WQKpAkIoWsQxdWFHMYYLCFp3LAwHmw61VWAsnGA97O87fJRAofzRdx2xFuWAH
         ncWgYadR5bxib/4nMLJEw6Tdz1Yb2Lz+G7+cFsRYITTMDiP+Y0bVgvpJROsQK2USVcf9
         kc8W9+Xtu9O5YieZCIBvhpJVejRLX84xEFD7BnqB6FZHtsUzocTgYNoW0lZwDv8/zYV/
         rRPPoiE+oNIklfJtM0eEFWrIM7Ub3ddO0IsRqagweCGQws6ftPCZfCBzTzvU4ZEzWXvM
         tBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777626881; x=1778231681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yWOulaSOL62l7Wg08B9kXAJdma9fT8Nk2Tg1J8MlHA=;
        b=cH199gzds49i9zLQ3AaI63V/4puILOfBNGvoMSqMxgsWSmmuofDS4lu0OxI43KyF/R
         w36UN5RMU9xOqdXCL/YZYl55KemdJZEXClZESONQiQBtBUxvux9XVluP6ig0kSaBgZhM
         JUdWRPQkn8sn9yS362RIhI9SzLVCJtvyoH8rWBLz+mlKbvcxgoXQaY0XLTxis9MZgFN8
         +INOmlwvhrB45nWa1lj53eusbsK2Agw0ppiqp15dtBHZtYAAWsONEIfVHiTYROVAgCTt
         RyjIwmglEU1bQmzBnGsT+iHxN+c5SzG1rwKUfMzOHTL7IC4LEu1IVwFod98xjYA1awMd
         gOrg==
X-Gm-Message-State: AOJu0YxRGrpChJ1Famm96aspoIuWTV25qLML5jkcNqXfGynDWqptIqNQ
	mkWmnwquTKeBX0+TmYKNmK2UTr8rOiWrtK+Sf0gAoAb5WEYjhdr6UqHptfxQuy2D1F0=
X-Gm-Gg: AeBDiev8+A6tt14PxYD4U0zqvIxww7+oj7Q9TsDVVZdpOEVXo/duYh8D4q58mK/A35y
	vU+1pwHsaOsARqzSjt8QfylW/jUrgtsfNMO9Iguax25dWRl3IGdsQ+FzG1f5VMyri51WZRyoB4i
	gf7jolE7FECECx18GWKx74R9VNLkuq3YpkXClryj9hA6RaB3wvZEIXA5ouWa6PENqQ61JR3SNgH
	D7DjmJY8l3wR3s9tgHCIgnRWRiilIVFn6JXkvXn1tSgy4B0nqGcgDtofMt+oOpMS1C35T8hxEes
	WHFj+VzHAuMa/csrEX3g2xFurPuHAo+Ukm8d1wWMBW9SP4opbCnkX3vk75ZRpnI7S/M7sSKBlV5
	3Vcy1V1hLcci5gBeLJT48w7bZ01CRQw5Z6km6P4vb/xXqR/zB8MKz/Ycu9QD2EbQiTE/m0/R98u
	ynvRxQCfFMiN0dvCJ6cHQo0NduphOWi8VJfDiwEfWkPiDtbwRcSLwJABsGWxy88GmDDFONZrE4H
	vBBsPGf4JNLUh1HICipg4VzDrNpfg/IQt9hZgXm6Z/CTl3uTpkFcQqgrtm5qhImrXLo34wwTg==
X-Received: by 2002:a05:600c:4e02:b0:488:a639:b772 with SMTP id 5b1f17b1804b1-48a83d6ec66mr107583445e9.7.1777626880650;
        Fri, 01 May 2026 02:14:40 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:8070:d188:380:6a5d:7450:e8b3:758])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8fe953besm12097955e9.2.2026.05.01.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:14:40 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	quentin.schulz@cherry.de,
	richard.purdie@linuxfoundation.org,
	Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH v2 2/4] doc: bitbake-user-manual-metadata: remove invalid anonymous Python example
Date: Fri,  1 May 2026 11:14:16 +0200
Message-ID: <20260501091418.76994-3-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260501091418.76994-1-bijak.dawid@gmail.com>
References: <20260501091418.76994-1-bijak.dawid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 09:14:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19427

The documentation for inherit_defer suggested that conditional inheritance
can be achieved by setting a variable inside an anonymous python function
and then referencing it from inherit_defer.
This does not work: inherit_defer is resolved before the anonymous Python
functions run.

Remove the incorrect example.

Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
---
 .../bitbake-user-manual-metadata.rst                  | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index ee6919dc4..b886e0578 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -835,17 +835,6 @@ overrides::
    VARIABLE = ""
    VARIABLE:someoverride = "myclass"
 
-Another method is by using :ref:`anonymous Python
-<bitbake-user-manual/bitbake-user-manual-metadata:Anonymous Python Functions>`.
-Here is an example::
-
-   python () {
-       if condition == value:
-           d.setVar('VARIABLE', 'myclass')
-       else:
-           d.setVar('VARIABLE', '')
-   }
-
 Alternatively, you could use an inline Python expression in the
 following form::
 
-- 
2.48.1


