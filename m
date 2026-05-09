Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14379CD37B2
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 10:44:14 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9739.1778323447253041165
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 May 2026 03:44:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JZM0k1Pc;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso24522615e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778323445; x=1778928245; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heDiQGmStxsWzjZ7C89JEP4FQGM193j9xrAoXMmBsqA=;
        b=JZM0k1Pc3uOEZHnP+PA9u7klUwlXVnABW18i2wGDD4zdynZtGSYYqm7Uz2FnuS38dr
         1+YHcTvBFe3hN1iu1a/bB8stg0Cb4AvgAyYn3VZVlizhTfQ6sgONi5HKAG3vhggLjlsI
         TvyPBB4XNn3UIzWxn2tbTVyvd+uotN5qW1TqU7B++fxhdyYbGQE15/1CpybXJeZQXJNe
         cwo7VWioxokLrG73Uhb8jJtrk1FzVwm/Fi7l9UkSoyeFKM1aqrSvBHpylzZI5KmgisSA
         WzHXuvww33MnaxrNRYKNKPQ5f4vALM88hlEWYrdOUdgyffIU5TUWka20+ZREkfn6IncQ
         1rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778323445; x=1778928245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=heDiQGmStxsWzjZ7C89JEP4FQGM193j9xrAoXMmBsqA=;
        b=JZ0x9GGucmq2P1YrWBRk9au0GdGqbCjpTYfK/1j1/pHH6Ml+iSeF+EtTebHk7Apzqr
         9/2TmCwOzrcQb8zSJKLgN6TKa50KMbPksRY8l9qUd1PsePtEzLioBVL+Rdvb1HCCwlNA
         bWexhv/YouGM6DJmyH/ZMiBUyOK/UT5OsZKbWPs4ebsJpIsg3tLy4JmsBEoV6WSlFpCp
         XKlnXHaSfjDL/A0EUCa8Bku3IhSEpMVtpa3I1EqXGI0HABEN+yZckZib7soGrncJQ86Y
         /s7vtU3AM341v3QkT/tQIFoXaRBmBkOdZZz7VQ5KvRbWBmLypk0KeJy0qwAIbXp/9U8c
         sj8Q==
X-Gm-Message-State: AOJu0YzNBe1UpIiIrKGxBUQhotAHbHSx2hESKMRTqmtLrrk15R6/D3GE
	wXpYIl7dbCjxDYnGkTh1mOOzVJdzxRxuKCE89/zHhoCqz8owZBWo38y9K+D9ptBaaoBblQ==
X-Gm-Gg: Acq92OG9FkQO8TLo0WAx8vrSKtdRnFQ0Lsgl/6a4byRQmw7eB1+O4vUpO/90Aq9E3wb
	UywK3Vtytnj4OB08OqziAwi2wZ7w1eSr5exej+vgmbsoYm7xky4QN4dx9kN+ubxbcLOzBQPW+qP
	32k5OZCRFeVUK/KQsojpMRUmqTfJauUa8r4JTz48sYV5Zt7qshclM8dKJ65algUh2PqGtw10Vxk
	hDHTHq9KOmYjv/4KLUG6xiAzOrkCLKLPhAduwX4cBdx/c0Xlb9MHV6ixAtWhEVuWmUirotiuSAo
	Tbs3oL7H10o1Nz+xkKoAZraMN6IcSsDj2gCk2kh9pFMFDB8prVkRW8hyByd/qD5U4g9pay9PRmB
	GYqIhKTMK1vOsD498E49URg/HCyfZdliYtxk1qzY0r+V0wZ7iuRgUudxFnCDcgl12t1A/cVE7ZX
	HS3arVxFGNtiTsMm6qlAqHTReyO3Bn6SP7OpEWCgIzVSynSAFyhtNv3Bi8r0I4IBRfAQ9lwg/Ie
	jC+dKAFhgRqb/3zd5qXsPdxSI0HY1E+m5sH0nWmybAy/eaQXmoexeI=
X-Received: by 2002:a05:600c:3b0f:b0:48a:7965:b943 with SMTP id 5b1f17b1804b1-48e51f4e9admr256583085e9.29.1778323445268;
        Sat, 09 May 2026 03:44:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:d188:380:b100:f430:86bd:b50])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm38837255e9.0.2026.05.09.03.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:44:04 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	quentin.schulz@cherry.de,
	richard.purdie@linuxfoundation.org,
	Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH v3 2/3] doc: bitbake-user-manual-metadata: remove invalid anonymous Python example
Date: Sat,  9 May 2026 12:43:06 +0200
Message-ID: <20260509104307.26698-3-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260509104307.26698-1-bijak.dawid@gmail.com>
References: <20260509104307.26698-1-bijak.dawid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 10:44:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19486

The documentation for inherit_defer suggested that conditional inheritance
can be achieved by setting a variable inside an anonymous python function
and then referencing it from inherit_defer.
This does not work: inherit_defer is resolved before the anonymous Python
functions run.

Replace the example with a warning explaining that anonymous Python
functions cannot be used to drive inherit_defer, since they run after
the directive has already been resolved.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
---
 .../bitbake-user-manual-metadata.rst          | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index ee6919dc4..52a9e7fa7 100644
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
 
@@ -859,6 +848,14 @@ In all cases, if the expression evaluates to an
 empty string, the statement does not trigger a syntax error because it
 becomes a no-op.
 
+.. warning::
+
+    Setting or modifying variables within an :ref:`anonymous Python function
+    <bitbake-user-manual/bitbake-user-manual-metadata:Anonymous Python Functions>`
+    will have no impact on the value of that variable in an
+    :ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>` directive
+    as the function is run after the directive is resolved.
+
 See also :term:`BB_DEFER_BBCLASSES` for automatically promoting classes
 ``inherit`` calls to ``inherit_defer``.
 
-- 
2.48.1


