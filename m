Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0753C3DA7A
	for <webhook@archiver.kernel.org>; Fri,  6 Jan 2023 14:44:00 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.14992.1673016239032948999
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Jan 2023 06:43:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=HYyKSdjF;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.171, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f171.google.com with SMTP id c4so1859666plc.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Jan 2023 06:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PCn4wn9atTNrBVTjw26csf+GvBx82PGlfzjHkFn0A+0=;
        b=HYyKSdjFdeLMTNT1Yyu83ZsTe/rUDPSJAKn30jA/jOiQXU2rfwEUq8hYVn11u+MzhQ
         zpkrQLZloksS0NuIRJBIQFNgQyu9raOqwavxEOVfx+8Ux6M/V2PBLpAnJgzW3r30ICvN
         C5CL/wlCic9THUhc7Md1PwvONSPSDimT3seAmXAikC0JSoGhwl0vcQxWMoYMMGm2QHVN
         fiaKrwr/VOzpjHJawzC8vg/4WIz+MThASNTTp9UmT+PlZEJf/wKtcWdiV8pjK1GMvhFg
         DmUVTdpUlLJL3jx2CNFNq0pFSGtYiDOR8v6WAuD6SIQ3IZkcauQ6r8E7ieThC2to3WAZ
         v2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCn4wn9atTNrBVTjw26csf+GvBx82PGlfzjHkFn0A+0=;
        b=GdBT5L7oWfKFHXbYtnHWf5k6MxFjitHlH8qkRY5nl2heUzSNaeYFFFwJnKtS41+V2l
         65gwQgM2cjYrTXojaQHfLQdjkOdnrSZHMIsrxybmxPRGCs2ZntGSxqbSpmQtHnEq6iZ0
         bRbOT3vUIbS4Q+nzqJUmk+f3EmCiddSe0avOk74qVXd2OcVDBY1YNaAQKpHwt59uXlVO
         qBVL/77gp3ygdUgwD2UByJx0EGYhKlF5i0OwLDryDd7ayiCon36SFR7KE4A5qrF6dcFe
         e+5tzABv+DdO30OfEM6cxZ+9Zy+Fwxfq3KDJLY6seJQgkEPHw6XKxx2oNOPI8Q3Wis0f
         TkPA==
X-Gm-Message-State: AFqh2kpa5UlkPtsHFX7SvUk0HiyXlvEPLdlA2ZGlOAtKP8J1ThmxFFJf
	XWHDEEDJ0N3nRmfWoWTRe34SkzVGIgBVN5xljlY=
X-Google-Smtp-Source: AMrXdXtASUJrL4TG7h2HUZlpOGEHCqBVgg0zXnWSaDQQUoQdgLHCDwC5EjJ18+LVdvrIBjy+yyXRig==
X-Received: by 2002:a17:90a:fe88:b0:226:8141:ac3a with SMTP id co8-20020a17090afe8800b002268141ac3amr15784799pjb.39.1673016237810;
        Fri, 06 Jan 2023 06:43:57 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-5-74.hawaiiantel.net. [72.253.5.74])
        by smtp.gmail.com with ESMTPSA id o100-20020a17090a0a6d00b00225daca646csm1017926pjo.34.2023.01.06.06.43.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 06:43:57 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 0/1] Pull request (cover letter only)
Date: Fri,  6 Jan 2023 04:43:52 -1000
Message-Id: <cover.1673016122.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Jan 2023 14:44:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14292

This is the final pull request for the langdale 4.1.2 release on Monday.

The following changes since commit 3b2d1331487a74863e74cc0c5564004cbb1b5a4a:

  runqueue: Fix race issues around hash equivalence and sstate reuse (2022-11-22 09:23:09 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.2-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.2-next

Pavel Zhukov (1):
  gitsm: Fix regression in gitsm submodule path parsing

 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1


