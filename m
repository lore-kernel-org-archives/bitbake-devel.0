Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045E5D44D63
	for <webhook@archiver.kernel.org>; Wed,  6 Nov 2024 13:37:47 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.45880.1730900262602225455
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Nov 2024 05:37:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=P9xpEo6o;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.174, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cdbe608b3so67177915ad.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 05:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730900262; x=1731505062; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O1oX6Ecg9hqMFuLyor3OTe2TI8wtV6n20rFjaf/LAHo=;
        b=P9xpEo6oLzv6N4vRBPOLR8vTRlJHT6wbylwVA2Vr2tMIMJPTkmkJtjhpiZ4dItX5hB
         WFM3u3aVf6iOBYx8aw7p6sNUj7NkFUAxSHmh5WvueizeyyxedfA842n/S77z46+Mk2aX
         KR8Hy1k33+b+lOD6D5XiQwsGwL2SfPBWVzFZbDp3+oc1iRXKAUr4AIaRZ6lqj9YSR3ae
         REE8Jf6cdTQAMSaCG01edSg086OdkSeCu683nHHDdY+d1KfIgBA8JOiZuiTi+U8Hwo4M
         wowxlw0RJe3+vOKtIDEhtCPlLgXw6hyt5AQj7ZhEs7Y6a+ATyCc5WIJxD9cCQUZyfmpX
         7+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730900262; x=1731505062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1oX6Ecg9hqMFuLyor3OTe2TI8wtV6n20rFjaf/LAHo=;
        b=NWTiueyp2x1+5XYDtAuyF6H70vejnyEF+sAeexKz31QmbcflJDdw68ZXmV8hHWhUgu
         bN4x0KlIbTmlEmSWS/TXqczvVBv7orgMhjgEde/maTroChhfMv31HKo7HP86ETdTCY4b
         PxoKDgxyAdMtWS+k7vWdG88aHFsWu7LAXl4Ddr7zcGKuep7G/vS/KPy9xbCzRxBL8tav
         WM68ONBBofdRAkZfMqAfTOr3T8XY0Bue+L5djfVPtSOQuPeEdtf2r/7TmNH+gAwaXlWB
         SJLGdH+uAD4v59CPZynuGmC7g+GNdyyCtLvT/b8VqqKCR3vey9JDp1OLe7YKKHXnQ5oD
         SSBA==
X-Gm-Message-State: AOJu0Yzm/OHkbxVRfXLCOGwobWEF8XUtwKb4qkgWJ9otJPGGfNe1yBnC
	ie3V/3ILrgilnmBFCiJurFpv3RqV59X4xhccp6Fv7aaCm+CTMwYLOc73lbGgi3pg9c0q0Vf8b9Z
	K
X-Google-Smtp-Source: AGHT+IFDYrrCZbeyCvBBJ90CHYzYPqm60/AzTUaEc1YoAc79NjMG06VoJwWyaQgckNTSDS9Ndc9pWg==
X-Received: by 2002:a17:903:124d:b0:20c:b9ca:c12d with SMTP id d9443c01a7336-210f76d6860mr3073545ad.38.1730900261736;
        Wed, 06 Nov 2024 05:37:41 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c110csm95707665ad.219.2024.11.06.05.37.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 05:37:41 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Patch review
Date: Wed,  6 Nov 2024 05:37:32 -0800
Message-Id: <cover.1730900054.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 13:37:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16785

Please review this change for kirkstone/2.0 and have comments back by
end of day Friday, November 8

Passed a-full on autobuilder:

https://valkyrie.yoctoproject.org/#/builders/29/builds/398

The following changes since commit 0c30e9aadd30fc6f0dcf811eb8340687b52eb00b:

  tests/fetch: Use our own mirror of mobile-broadband-provider to decouple from gnome gitlab (2024-11-02 09:45:13 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Philip Lorenz (1):
  codeparser: Fix handling of string AST nodes with older Python
    versions

 lib/bb/codeparser.py | 46 +++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

-- 
2.34.1


