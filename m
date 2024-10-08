Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A4DCEF161
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 12:36:41 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.8081.1728390991277083516
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 05:36:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PJKp8E42;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cd0b5515fso3281250f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 05:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728390989; x=1728995789; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SauaoGIEcZqUv6fFacnfQczCeqWjwyPxLfM/hzdzCf4=;
        b=PJKp8E429JdQdNgcGarTdpMJrVFkap6NSsBdIKMN6QDpwHI9pNblqI/N3m+CaYUo8A
         AzxDEoT+0dDZgLYO4xdNTk86wiXEnrV/R9AqUac+2ggsEa1i6ti+SwB4RzVwTrE0Zpkl
         cvJi+xqsVoPAnwRuGkfeoijxpdiaU3uHSI7LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390989; x=1728995789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SauaoGIEcZqUv6fFacnfQczCeqWjwyPxLfM/hzdzCf4=;
        b=j+HQh0z+CPkDP84ICnLBAObKEeKzsFhR8WZpxBTgOQUid8EDZKR9yhc8KYqXAqX33W
         pKa2aEfI9KKq8JRhoHHGwafwVSsxP/7XKrDQ/BEWizbIIaTM+vuoruzzjRwOekkBm2ct
         X8PqnHjHhBG/alE3JxG2ec1LEfeBzLaIMuVDSJ4yzWnhjHXz+dsK61cFSh+IDKxZ1EGP
         5Jpi3Mjwge9ijROrOwCpU1w2Yiyk1S/+2rse+qID3DigZ9juP2ppQKGzaapZIH+IrS/l
         aImVLxwBpwglY4opzpLbipKhO1iPiVYhmZwUONlp169l1n+YVvrGLkOckGxzuoMfqczV
         bh4Q==
X-Gm-Message-State: AOJu0Yw8sgTb5WP6FawfFE59ezo1RYJ+FlHZLq8JG6nXY59Xd0jV4EtF
	dx9Fx87FBiWFHYCnd7nxo/LFBFf8ar3X3saVWVOlri52gOevYmef0peyGZ4otkU2NuXKi+/dSgP
	J
X-Google-Smtp-Source: AGHT+IErwk1pPxqrXLkxj7uzXmJaV7oEWg3Mw5ZYTDEITKClZrPtIyZqC5Fi4yb7Qy+XZKbeEEgZRw==
X-Received: by 2002:a5d:67cc:0:b0:37d:3760:1d9a with SMTP id ffacd0b85a97d-37d37601e33mr382979f8f.17.1728390989401;
        Tue, 08 Oct 2024 05:36:29 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f9a:5ae5:8636:3d57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a47esm8019492f8f.28.2024.10.08.05.36.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:36:29 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/8] fetch2: Avoid deprecation warning
Date: Tue,  8 Oct 2024 13:36:21 +0100
Message-ID: <20241008123627.252307-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 12:36:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16655

From re on python 3.13 onwards: "Passing count and flags as positional arguments is deprecated.
In future Python versions they will be keyword-only parameters."

Avoid the warning.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 33a8086f27..b194a79be9 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -237,7 +237,7 @@ class URI(object):
         # to RFC compliant URL format. E.g.:
         #   file://foo.diff -> file:foo.diff
         if urlp.scheme in self._netloc_forbidden:
-            uri = re.sub("(?<=:)//(?!/)", "", uri, 1)
+            uri = re.sub(r"(?<=:)//(?!/)", "", uri, count=1)
             reparse = 1
 
         if reparse:

