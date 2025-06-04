Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E1C5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 15:35:14 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.19756.1749051307752912413
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Jun 2025 08:35:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=AGX4htdT;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.181, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235e1d710d8so10564845ad.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1749051307; x=1749656107; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=igj6fLZLD75z1QMgS70ojjYPF4T4rfO9DtpEXhh7Q5c=;
        b=AGX4htdTdvCbzhS0C4+m3R2O49ZapyyrOXukIvdCQWC057PToYQ+AiPv5/f3E1eo+c
         Cg4XgFnH8kj6GI0ATn/ZGM2YltrUccd66zDi0T5nLROUDCEJSLf/dtFntMNTo+9koYzv
         vOJX05zqbI4xGUH/+4o59n6FmQGNS9LytPnQJFylwjiOXP7pS15PZP5WeOrU2r5II1V1
         RGAOmFqU3S9Vg4EyDMe/R8Q5WhqhAwi1hydQs6m+WnthWpmYibRFs7D+KAhWo+arXam8
         QRmOk5/4vJL9QEfH3AjnNJWSbswqQoxV2vh1BqA4RHVt2ZzWnhPPhpLyy02jQZ37i3HW
         uv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749051307; x=1749656107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igj6fLZLD75z1QMgS70ojjYPF4T4rfO9DtpEXhh7Q5c=;
        b=NTn0AlgWMKxuQu20VnNTGNlEUvnQk5iR+3o9DsQ6TdQhXojl9yMGvotadAqN8aVkEX
         wt4Byn1zs4EqwTzpXSNQpX0GpyD9esvwCwDKLvRey7h+TSRcjj2JRmC/dqCUI88mfAzP
         DqBDb16bxF6DTvQnKbCB16JBY4opV9jJv+wjaKe25tp9wxXAxbQafjwxPuythTTDx34K
         0YALSKqJuDTAz9rihPUWDcz6tIAkv47eFzSKdl6/WAUHGzBjdE2yuqjM5tJB5McrzdUQ
         pXcxfie3BV4hZJDKr3Ub/y91GvYohchEiQVL95Ycj4SKXmXnNHCS0Z2CJdVHW9SMURu3
         lHWA==
X-Gm-Message-State: AOJu0YyCNX1MVwRfDWUu8B4lZrSTrgmspGygGU3MqTB1neDCFBOb5qQe
	FyjEzjat9VueJInFlFXUv/o1LDOfrfqdBHMVl1DXi3bsE+ZXlWAk3JaAfLenYB4vaSfHRIup9M5
	EsoaV
X-Gm-Gg: ASbGncuhjMOrTuQqqSzb7j7FzfWFFS4ue8mPoIviMN4gueD/pREOOtd6k8+S6jXW9Hn
	+UfTBxrmOyq0Dc/BKl17a9BBzMUB32/MifRQBrKvcaWQP0ll2I7/71uQm/mUjFgXEAqZfIklpjQ
	dtEUtLIuD7NkBCO87FWkgQRrFA0lKVrYjysbTCwGoY4go96RpKuk15PL9NgiA7jsoj235/ElgCI
	6pjME/Iy9Mz5yBss6CQbdIkmz/fTmPLLNxEGfKdG3zOshWOZFbokw84VXaJAL137R3RWJSXUH8m
	CTd8zjUR96IwsHugqczlbMpkhjBk4SyX0wnKGpClzMk=
X-Google-Smtp-Source: AGHT+IGQtdmJ+rZWNphWW3Fc/ndjdRbtlAWfRZg+eInQ7J8Qq4qMOqBTKFvm9BBRGyjiYVApjepQUQ==
X-Received: by 2002:a17:903:2291:b0:235:779:edec with SMTP id d9443c01a7336-235e1255656mr44431325ad.42.1749051306829;
        Wed, 04 Jun 2025 08:35:06 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:e528:5fba:6ca8:ee3c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3407sm105590385ad.141.2025.06.04.08.35.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 08:35:06 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][walnascar][2.12][PATCH 0/1] Pull request (cover letter only)
Date: Wed,  4 Jun 2025 08:35:01 -0700
Message-ID: <cover.1749051242.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 15:35:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17680

The following changes since commit 5b4e20377eea8d428edf1aeb2187c18f82ca6757:

  bitbake: Update version to 2.12.0 for release (2025-03-29 15:28:49 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.12-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.12-next

Richard Purdie (1):
  toaster/tests/buildtest: Switch to new CDN

 lib/toaster/tests/builds/buildtest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


