Return-Path: <bijak.dawid@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B706CD342D
	for <webhook@archiver.kernel.org>; Fri,  1 May 2026 09:14:51 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10685.1777626880684882160
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 May 2026 02:14:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qrXaEeII;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: bijak.dawid@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so28382115e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777626879; x=1778231679; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbkVjOYX2ZTYDmcV+w119AsgVq2edC5qOkWuWs4zWTQ=;
        b=qrXaEeIISbbF8GBxFBPirGM8//q1knjHQZmq58WusJDxVQIdZZMMgn/EDT9JnYRk2C
         2v4CdejQkuG9495dR0PDL0apOBzrf0tfo5YMZNWs3Q1F7UBiu5B1rlDiTgW4qZAHMpDQ
         U9ZyfZnfY/LgJBTdSK//GVU99lMUidVmuuu78cGuqxM195eu7Nd+t1bYT2hsgU+VgSRc
         oqQkoyGIQMILba704EpyQaCUHTcEvGLnb/JOGOZNFchWVHT+vxWDdjLoAppfo5o524MW
         bYJVs+KDYBMIDP8kkB+uzrnglVpw1DT7W06yJGPQ38ksRForNi9V4Vv2mhE5BR+0M6wi
         nwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777626879; x=1778231679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EbkVjOYX2ZTYDmcV+w119AsgVq2edC5qOkWuWs4zWTQ=;
        b=UA9PlaYoYiy6vGAQ0MjDneyLfK8A+quwRxjrNUMNJgOsZYc78JWzmUyMOAxIp7J0BF
         +aNUrj2edRiLPKuiD3GYx9SoZXVvLx1ln2Z3rtvYcwlNHgXFlQDhtjEDo6xLlol2BeRk
         U+I1XmU1M0FSDi7Ur/1dCKa/7E5dyFnrz9WsN9SI/AshZ4Q2s+LeOdyVqVfSJYJLH7cT
         A4oEJ0uHzDEaEBq3HF4t27Ga6P+d83Gi6t6h80jbDldQvZ7lo0WhBhJpLOdyx+3ulPix
         zTowyAic+CA+lrD/IM3Z1URebXuX350xGnYbxp5e0flE76lwejM7WnnTlP0KPMNLRHjJ
         BGBw==
X-Gm-Message-State: AOJu0YzgK5lN+/3Slmv0sN+GnDAWtgGrf9CM+DaMuXjAz/qbkmiq8Nk8
	jpzhigyDK9PEakC+Ku9WrwXIMSrWNWMrtQBxF7P6a0siERI3eRLVeY2MqY/+sueeuZI=
X-Gm-Gg: AeBDieuqT9QAw6N0sp46qWrTgxCBTUK/jMWSG3lYBgxSC2NtjOaRjaRG2gTyK4L8K/+
	3Mu9kzjR9UsMHHAn+dedq267Ym+RrWYVb1NbX2NDyczPKDh2Rb1A+5ZYrEApSQslT9Jz9azVqS7
	BVNBviSCegcBlHUVz0hCemS3JrLffiK99J1XNbJ5aI2svEmaPN8aReCLj/Nbwg2MpOdruns9+zT
	R23lrGK0+LL3AZMjKQhAKu9GbQViu3kOd22MBO091SjJc+FSsEZX9m3jZfNRJ2XvKZSiBuZXCwj
	BtybVV0MULFywqovXUaFqkV6cis/Q5eNTGgbaqBeVzVm2rn+g+lQ/GssnUa9eaqxENiznMSRwLz
	aQKrHrsM+/B+ENX0Yn10a0dh7G7/kNcJFu9ROK6SKLelBT5VYtijM8797MLFpcfRmC8u7J8IOcr
	K/0q7O5I2mHr4+BBkFlEqEyf26KUyhoLKbNURgW9GlXzIldQ4qaPbiaJxlmet4G7lF/CsrZHiUZ
	EqpUNpUwzLS3GE1cWOkgWvZDTIhUTpUka2YzV9p+IfNiyJsd8zIpKtquU0drhhbejoy1IDpiw==
X-Received: by 2002:a05:600c:350c:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-48a8449e51amr108314065e9.27.1777626878747;
        Fri, 01 May 2026 02:14:38 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:8070:d188:380:6a5d:7450:e8b3:758])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a8fe953besm12097955e9.2.2026.05.01.02.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:14:37 -0700 (PDT)
From: Dawid Bijak <bijak.dawid@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	quentin.schulz@cherry.de,
	richard.purdie@linuxfoundation.org,
	Dawid Bijak <bijak.dawid@gmail.com>
Subject: [PATCH v2 1/4] doc: bitbake-user-manual-metadata: remove incorrect claim
Date: Fri,  1 May 2026 11:14:15 +0200
Message-ID: <20260501091418.76994-2-bijak.dawid@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260501091418.76994-1-bijak.dawid@gmail.com>
References: <20260501091418.76994-1-bijak.dawid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 09:14:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19426

The documentation for inherit_defer contained the claim
"If VARNAME is going to be set, it needs to be set before the
inherit_defer statement is parsed"
which is incorrect and contradicts the purpose of inherit_defer.

Drop the incorrect statement.

Signed-off-by: Dawid Bijak <bijak.dawid@gmail.com>
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


