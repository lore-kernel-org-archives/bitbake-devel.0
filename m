Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AD2C64EC4
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 14:24:54 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.7463.1676643890702381195
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 06:24:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=U0day16p;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.42, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f42.google.com with SMTP id s4-20020a17090a764400b002349a303ca5so1432403pjl.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 06:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKJsoxip/NCyRjWaErTn1jihCULsEcApKnvHh8KGkp0=;
        b=U0day16pxl58EUNg4LFAivAshh0FpyrQRgpyL6pyYXYYD3ALV7P0DRkcRkhFJL2HCo
         Qi+y76H1519JWRl+5LHWtQfmv9v/Gji1oSjWbVbFkEP5ivs/Cm9hhnCkmw32yCJq+a1X
         jzBky1SSESLFLhEhRaY1S0zx+WC6mQJ+kDCZTc1q1j/djRVrJ/vAkH20z/bXmMkJSICo
         brBWIKp5CsyuoW+I0iX2z9mzKwmdDtmoKzdSbJ49Xudtg4o3lJHPbTtQWMVfrH+LQNoN
         aZKatklthEpy/HImaelw/MsFNLho8IFX7IwSsup4P6yGkS23hsV1IevSeF4tArXM/zJn
         Z+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKJsoxip/NCyRjWaErTn1jihCULsEcApKnvHh8KGkp0=;
        b=mvbdfhtABRVcxJdFApMV34BORDDV1VF8CNZMiZeV+3v4CLdz6DWbrhtf/ZGP6f+BfL
         g0qPRPZGKQQ956pNo2Llz+Wwge4keY5MSkF7tLJSjZlWSTYeWiZ1xAxifQ8qQhvbT/pP
         +bbhfCQdYcE4Xk0UPusuf7BrRZ6+3kUzE+uet75NcycvwpomTPG7SR7X+hIdHAGMQ67K
         Q+ktGu3nDa2bhAPGIyl75TucaObi9FcgWQR5WtFcHKNeL/1YaTyhVWUWaaQvH9a57T0w
         09WYBVj6d/7jIE7WsvXxVYxUJshLJTa3rlbHLRAhzukIxoY+olhfYrqcNqa9KeVksAPl
         bvEA==
X-Gm-Message-State: AO0yUKVI2+lOlDJGocan8GMgF7H+LlbrtZE4ruriAW77vpcWJconRfkJ
	xAVWxDN2R5JkftzTaGzRG+BK53WaVcBEdrWgxH4=
X-Google-Smtp-Source: AK7set91Gxfq8OvPk1E5U6E3GjBxvjz9z1ytoxn9gnf+NMsMJKbZMg/QE34/JLgp3XjELoEffnUAEQ==
X-Received: by 2002:a17:90b:4b41:b0:233:ebd4:301c with SMTP id mi1-20020a17090b4b4100b00233ebd4301cmr11159206pjb.1.1676643889385;
        Fri, 17 Feb 2023 06:24:49 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id b12-20020a6567cc000000b004e28be19d1csm2909268pgs.32.2023.02.17.06.24.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 06:24:48 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/4] Pull request (cover letter only)
Date: Fri, 17 Feb 2023 04:24:43 -1000
Message-Id: <cover.1676643830.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 14:24:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14454

The following changes since commit 86f2fa5261da959cda706c794a0047e5e89d4d6b:

  fetch2/git: Clarify the meaning of namespace (2023-02-01 09:03:36 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Etienne Cordonnier (1):
  siggen: Fix inefficient string concatenation

Marius Kriegerowski (1):
  bitbake-diffsigs: Make PEP8 compliant

Mark Hatle (1):
  utils/ply: Update md5 to better report errors with hashlib

Schmidt, Adriaan (1):
  bitbake-diffsigs: break on first dependent task difference

 bin/bitbake-diffsigs | 49 ++++++++++++++++++++++++--------------------
 lib/bb/siggen.py     | 11 +++++-----
 lib/bb/utils.py      |  7 ++++++-
 lib/ply/yacc.py      |  7 +++++++
 4 files changed, 46 insertions(+), 28 deletions(-)

-- 
2.34.1


