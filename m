Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3348CD37AA
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 07:13:51 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8201.1778224424444477934
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 May 2026 00:13:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=HI3sqaT/;
 spf=pass (domain: smile.fr, ip: 209.85.128.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48d102471a4so16447545e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 08 May 2026 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1778224422; x=1778829222; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llhVX+QwpQ6Vl04SZ5/+RhWOig+NErNwTQ4gS1lTeic=;
        b=HI3sqaT/5HCwtJRiibHRpq8nu4joHhJ+wBiMdbyMBVZB4fsBQrPDAQHNg4NnDVjoT1
         vt4cSqR6VTE0aLp/Wpju5Q4mMnY8/5BKrwyh7ZY4Cr9oCFEG81QCzGrbIws931zYtL89
         Jan9QtAMSHWKAWLpXIMahcFFeFoQRn526kb9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778224422; x=1778829222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=llhVX+QwpQ6Vl04SZ5/+RhWOig+NErNwTQ4gS1lTeic=;
        b=VGwnABzmW4DaEuMX02YMb4CfHoEZTl7QQL9HLZpHGpYD1mGCVSx+jSzSTWc+m3X8wn
         hKJ55a9LIdcUIWkSRWPp2qDM8c2cvlJ29trjegoMILreZS3sPkpnOkwzFyW5cI6TwXND
         feJjEsjeebGpzuIl7c/5DaTyKt1NX+tsZKAdCKO5CohUyP+x1JFJd+qIcxDPmDL2qYQ3
         6VArZJDTF13Kh2DjzgqD5A5cWdZK2sncBWC3Ws4KP/aP1VWnvHBQ/FPXYC49OldasesW
         hX/u6ytqUGCaaPgNP8c/myI6Sqtu1jSwWFU883C5icVfrc0EBtC3Ebjq7mfRCAmKD4GR
         f3Og==
X-Gm-Message-State: AOJu0YxO7Q2xj+3vlP1CVIv8162AhajQn16ZFtIQfrj5V9AT1urn4FLw
	xCdyo6ShQT6vGUYF1Mdu7nawU+Nl2wJBsEqA7bBtnDtXskkp09RuvV7ZTe90OYqAsaNH/5MmDlT
	06N7PgLY=
X-Gm-Gg: AeBDieverWdbzLTwB/ZOHJvKuwSEMoDvHfzBt7udAGUPJTd8ChpbmH8kao8a4V1iv/D
	F7jF+OoB96e/vthglWOf6BNgf3NegU+sbB6rYX/h0lJay3niycRdccfEW3gLU/Mf9UTSjBxX4nB
	rnDw0xEkG396Y7zkJ+qDq9xQ4BADkbXGf/JGHXNs76f921trIXMvbOpzGmJCxo8iXE7DZNIl/In
	hY/NTYaOzkw87llXo9upRxa7e1FTIGb48QDVySv2U6XSXl+aU47t4WNecpsjICNZ1RtQ5tdlZd3
	TxmDZi99xL4tn+LUPCzD6UVy79e8aUFGlvpTGREoezwuQWYm6hQFhqVtoKvoovlTLdAwF0a8FIz
	wh2rXWaRVnqLFz3y79gc4kFGj19aav7u5uqKlDCKSRTJZr1Y/mNh9oJz9A5Ve6m2QQ92KcKk9NW
	8f6MXgLJ0O062OvNSCwlE8yMysmY4GRzdHlZQcKxhlpIsGhxKysZHY3gM6iFMVlndD6+XzJZskz
	udE+T3drVBe1FjTDxepCzD2DvvjBGmbjDLRfw==
X-Received: by 2002:a05:600c:4703:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-48e676ac029mr20625535e9.20.1778224422228;
        Fri, 08 May 2026 00:13:42 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68edcc3asm26363195e9.6.2026.05.08.00.13.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 00:13:41 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 1/3] doc: Fix description of git shallow mirror tarball creation
Date: Fri,  8 May 2026 09:13:19 +0200
Message-ID: <a771d90e1e521f691ceaac519216bfa8b9ea5686.1778197991.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778197991.git.yoann.congal@smile.fr>
References: <cover.1778197991.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 May 2026 07:13:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19475

From: Paul Barker <paul@pbarker.dev>

The method used to create shallow tarballs was changed back in 2024, but
the associated documentation was not updated.

Fixes: a5a569c07522 ("fetch2/git: Use git shallow fetch to implement clone_shallow_local()")
Signed-off-by: Paul Barker <paul@pbarker.dev>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a7acbfd454c1ce33e32e09a23d4573e06b44e835)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 .../bitbake-user-manual-ref-variables.rst                    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 8d8e8b8b9..9824b58ef 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -349,8 +349,9 @@ overview of their function and contents.
    :term:`BB_GIT_SHALLOW`
       Setting this variable to "1" enables the support for fetching, using and
       generating mirror tarballs of `shallow git repositories <https://riptutorial.com/git/example/4584/shallow-clone>`_.
-      The external `git-make-shallow <https://git.openembedded.org/bitbake/tree/bin/git-make-shallow>`_
-      script is used for shallow mirror tarball creation.
+      A git shallow fetch is used for shallow mirror tarball creation (i.e.
+      ``git fetch --depth <depth> ...`` or
+      ``git fetch --shallow-exclude=<revs> ...``.
 
       When :term:`BB_GIT_SHALLOW` is enabled, bitbake will attempt to fetch a shallow
       mirror tarball. If the shallow mirror tarball cannot be fetched, it will

