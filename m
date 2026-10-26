Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33001.1792974056717033049
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Oct 2026 17:20:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DxDLMdaX;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e985106c0cso20838145ad.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 25 Oct 2026 17:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792974056; x=1793578856; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DHefE/RY1zM8aIWve3GlxX7h6RcXr6k/7rRMzWuB8BI=;
        b=DxDLMdaXINRarUWJTA+/Ji9CEct2gKOItn3SO/3KpsRw3x7S1NQQPU3pSKKKxUD9ZH
         99FMg2wNkDsITQTC1ltr+tSv1Tb8rELAQmdxKB96uelCkWTaaAR3v+YPpjj2ORsd0q+T
         Rq2tWivEB44rsGGiSFP3ToCMJoTEJLBPt+5DoekEayjEm1BzSSAn3dZ7hneVAr+Z0Tlp
         p/Bt0Ru9Ah9kHKA+idMET03OnUKljfmoVO2ntwHb43TANjeAo6y762RBY+UOWdh/Iwkx
         SzJYwjvbR5tSTUk7Rfjvae51i0BDw4sogrp8Bav7OS0KiVMIpbwHdDex0vYaP9Dzij/0
         MazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792974056; x=1793578856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DHefE/RY1zM8aIWve3GlxX7h6RcXr6k/7rRMzWuB8BI=;
        b=02C6Dh8mrS3eSSpIvJGR6OlvKg8JsAv36JhO22USJ8B0SBaycn0bEwrmoCi//dHBOn
         gqmGfGkFOJfyeN18rcVVYrk/3p81L0pN2jdGDV1ZQ9hp+yFYxrawU+18C0+k8oT+34Rn
         qhdtbAVRrJeJMudgAe3sQ6jEahyMYV45Cw9JhNg1rOEke/RhhuA8Li2iosqyema7qb6s
         5tHOWBTwHa2nyzS02zj15LydVqxYIE9/aqTI4BbDLDGsukYh12Pbv4TgQPyQxWUpXfFS
         IGyU9BJ+0jaKPQrm4grX2skG53YFncM+6aj7QkavN+/EP+88vg7C0pqCF5pThPchLkbj
         5zmA==
X-Gm-Message-State: AFq9FYIPICbj3p3S/Qt7FL3EPWP0OmF3T9nar0Sm+6pdDIpsRK+81M81
	vHsHg/af2qs0xF39df5XSFAEppMKHomVDvRodw4az5IQ355lovDRrN+M6CwI8Ktp
X-Gm-Gg: AYBFou1OO7TRiJjBsIGDyWyrkQQaOfYGmA+D1vN9UAIW9Kl1P7Y9/H6pglAaLS78Odn
	En5oKP2NgNNkpILZ3BS6/7qhcBRtcQeYBc2D2sU0mDJIYSdQCCNPqcMSxRy4cc6FWtXSZ1nwfcM
	c0NX5urBTUdWJXTG8sSV8QEsL2qWPK3mp08iTOZVO7gUoRKkyeytOon7McaAPj3IYv6kCFwS1GE
	32mDzlyIScT2As+lEZrERUynn/GRfnye5jc5xTuETgK/K9fTQtv0xluu6dQTZsEkiNmIHA9hRGL
	VA9a3+N0aF99Ew8jhX3jvu1vDt/0E54vMPpdJTcM/t7tHcJUeDh4cpAmnOSUOnenqEhVmXDDyto
	Rpxbe4INUQ8ZwGcLWm6f1Dz8X1u7kIsFikLsjEkZw0Pbk7XeCJbrr+8f02IroXXQ2XzJYULJrNr
	Ax0jSXjZ+wtoNRdDpEFftnusVa1DhrSRNSB4KLYACgid0zlNPv3ew7rcpbCRlEgAQTrUh2u3zN0
	yPTg+8zYJnY2IEJmyMHjewRiqxou9+nlChxrtdfbuixwIM3Uwa+I7L7QaWFbTqF2ldbzJmNibj0
	z3veDZMmghHCuN5hUCgVY9yardvCfahlXw==
X-Received: by 2002:a17:902:ceca:b0:2df:aed3:2ac0 with SMTP id d9443c01a7336-2ea9c6442admr44097985ad.10.1792974055944;
        Sun, 25 Oct 2026 17:20:55 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b14c296sm9358475ad.30.2026.10.25.17.20.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 17:20:54 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH v2 0/2] Handle duplicate BBPATH entries
Date: Sun, 25 Oct 2026 17:20:46 -0700
Message-ID: <20261026002048.86208-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019020422.14365-1-tim.orling@konsulko.com>
References: <20261019020422.14365-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 26 Oct 2026 00:21:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20379
Content-Type: text/plain; charset="utf-8"

Following Richard's review of v1, patch 2 makes duplicate BBPATH
entries a fatal error, so the problem is reported at its source.
Patch 1 is kept so include_all stays correct if BBPATH changes later.

Changes in v2:
- Patch 1: commit message trimmed, code unchanged.
- New patch 2.

Tim Orling (2):
  parse: only search each BBPATH directory once in include_all
  cookerdata: error on duplicate BBPATH entries

 lib/bb/cookerdata.py  | 12 +++++++++++
 lib/bb/parse/ast.py   |  3 ++-
 lib/bb/tests/parse.py | 47 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

-- 
2.56.0

