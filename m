Return-Path: <tdah@bang-olufsen.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FA0C3DA4A
	for <webhook@archiver.kernel.org>; Fri,  9 Aug 2024 11:50:25 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.82144.1723204218778181562
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Aug 2024 04:50:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=C7m+lb5a;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: troels.d.hoffmeyer@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a94aa5080so243952566b.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Aug 2024 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723204216; x=1723809016; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWrRbaqQJDKdM7ZpHlSBzRsBPAHmWqWa6m5AKdJ9c9Q=;
        b=C7m+lb5ailClN3gcw1755UaQzlFKo5G5sltnaBCLPNxgKy4I1AZTN2OePPp6NKS89K
         4/DG+plrdd4c6I8youEN/gjRSw48xRkW5QQIIJcDYYZc/68XG2oAqY4JcxW93CjUz06X
         45TNcMPxJ7wumP1u3hKNj3Hx9o4R1kHt/j72uPGoS3orGT/vqurIO25POZAgjHpXh6qu
         9IXkOCW99Ik/jZvxY9ryfUeiuRBXmM2/dDuR/2dKrSh4awyMWFc84Vj/wxK3L+PgE4SM
         fiPDffTyyQ9X7p/UVfMUqHHL0a2ZezOMu1YuYPaL8U2/T9OMOdbfp49K2cjFeqLTTzQr
         ty6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723204216; x=1723809016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWrRbaqQJDKdM7ZpHlSBzRsBPAHmWqWa6m5AKdJ9c9Q=;
        b=CiLhpq+KsUPou5JSpszq+n0QJ/ELZDT6q3ATjktc1Rbxuc4BzxlR8WD4qpc8DCGyhN
         dblMo8IBzXgPoN4Bm5Ibn+8WLldxx56qVqK1WIbZzR9nyKoJvlhAFHDmrzMCrGKtd/Q4
         Z//m8viqB2TnhUI7o2ejmx84upRj95k0aRFatQWRm4Dvtk6nWDtp2j/TlPvE9mhi2fh/
         C6Vp57GK1geL+h0r/N+7Ymy9P0ma/yL3yHbria2fLEc7Q9M2ANjFrRPL/pEcf7JkO3eG
         1rfrN7kvjQ8HFffNPph51ZowLij1U6JktK3apUktjpuOd+Ow4A1l1aqYLu9pzAiOPJfH
         8GsA==
X-Gm-Message-State: AOJu0YyijyjIADAl5QOgvH/FgYx1szAzQEFXQv60+art/6oP00e7/Mx/
	Xd3QNYkK1KNNER7wFrO1l4xkqypKtYxqxat79f6lxzFdHSJwT7Tfg5r5tQ==
X-Google-Smtp-Source: AGHT+IG5wdB4BQ6bqdJVgCi44bUd/QvBTmkjXYXICzjI2uM/sFp0qiBoIF/MXPr23LI1YL1sn77tSQ==
X-Received: by 2002:a17:907:97d6:b0:a7a:3928:3529 with SMTP id a640c23a62f3a-a80aa55b6b6mr113733966b.13.1723204216163;
        Fri, 09 Aug 2024 04:50:16 -0700 (PDT)
Received: from WindowsXP.home58.bang-olufsen.dk ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc44sm831361166b.76.2024.08.09.04.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:50:15 -0700 (PDT)
From: Troels Dalsgaard Hoffmeyer <troels.d.hoffmeyer@gmail.com>
X-Google-Original-From: Troels Dalsgaard Hoffmeyer <tdah@bang-olufsen.dk>
To: bitbake-devel@lists.openembedded.org
Cc: Troels Dalsgaard Hoffmeyer <tdah@bang-olufsen.dk>
Subject: [PATCH 0/1] Logging str() instead of repr() on exceptions
Date: Fri,  9 Aug 2024 13:50:12 +0200
Message-Id: <20240809115013.17469-1-tdah@bang-olufsen.dk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Aug 2024 11:50:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16460

I was trying to create a recipe for a go binary and was struggling a lot
in getting it working. One of the reasons for me struggling was some
poor error messages, i kept getting an error message with just
"FileNotFoundError(2, "file or directory not found")", with no
description of which file or directory. After some digging i found that
bitbake mostly logs repr(exception) instead of str(exception), and
repr() is usually used when you want a string representation that can be
interpreted as python again, whereas str() is for more human readable
strings.

Talking with RP on IRC, he mentioned that they might have encountered
situations in the past where repr() was providing more information that
str(), but wanted to see the specific case i was running into. This
patch only changes the specific log messages that i needed, but there is
an overall pattern of logging repr() instead of str()

Troels Dalsgaard Hoffmeyer (1):
  bb: Log str() instead of repr() for exceptions in build

 lib/bb/build.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.40.1


