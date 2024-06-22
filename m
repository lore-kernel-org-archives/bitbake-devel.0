Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3F4C41513
	for <webhook@archiver.kernel.org>; Sat, 22 Jun 2024 12:20:47 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.96126.1719058844630147601
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 22 Jun 2024 05:20:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=XQyD7s2q;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.178, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70436ac8882so2338021b3a.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 22 Jun 2024 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1719058844; x=1719663644; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNHxwqjkiyGd5QSf+pKsO4948lrGCPbeCwlpm/3qHGU=;
        b=XQyD7s2qGlaHBv4yocAdmVMexN6KHkYJjhtEIolULmXizlxT7pona3I4lKcw20cWDB
         WMjGLK2+SEloNh5LeKk31Fc6MJhKgfgTJxZ+kxwDScxkYgsXPls9BWIeOcWMHIunGY1x
         Ycs91PekA7uXfZg0xEUBetOrhdUq23OM52SY5SsEo7AVcqW7wLCn+EUbzXApNJ0D6sMU
         QvuO1Kb8DDMzIJhNlW+N8CwWTlOSoNzgpAxNAJWGDr6h3Wobbn3vrarkYif/GM7np7sE
         svasg14O8hks0tF+5kar6x/djQhp72mCKP+HHB9bmoCdcMQl5vMsUH74KAowETOj+KEg
         ZWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719058844; x=1719663644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNHxwqjkiyGd5QSf+pKsO4948lrGCPbeCwlpm/3qHGU=;
        b=PQXP9GmdMe00lYnvdUh13tx1jjTmYryNnul1K3kyAn7eiVa2VQBb+FAm6y/DvR3wg6
         jj1S/ZDCBOmI2BmC9SUJ7yyldyGFBDkADcM5pQgkC/OQWGfrmoRaV5WArl4pDW126rv1
         506BGro6rEiFVk2NoVXR67Ogk3+zPMPX7CAYtORHJ/kz9/8THfVi8ZBVYGWusG/iHgOW
         AxThny/bL6nUK+IdSjGcxw8lT3KBHoilJqPMTqM4dimU7SvrFNh4aRmlQJ/OZn1l67B0
         Iw/jYVcniBScv4XSEv6ndcrnAV3nM7AJmnQXOFiFIsMCF/fwy27BpgfsFaOZ1wAvK+Ie
         FGdA==
X-Gm-Message-State: AOJu0YxNrFZ7bqwAJHLbcPK6P139KQHAHkUVMYZTlP/8HUbKrd7NXaBi
	IPNG2LhnbnIXeUrrU/DomzLoSvsGFajhp4Fw7XYKc+00OWKTJIuSPuaTUqPG1Pgxw4PlLJwfr0F
	F
X-Google-Smtp-Source: AGHT+IFqs8sH1u2M7M0/MEX2rwoBP9l8s7QplC4cLGequIZavnW6CiPlbohYYllNqTLIvecE9BENkA==
X-Received: by 2002:a05:6a00:399f:b0:706:6937:cb9d with SMTP id d2e1a72fcca58-7066937d9f9mr1235854b3a.0.1719058843661;
        Sat, 22 Jun 2024 05:20:43 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065130573esm2952762b3a.205.2024.06.22.05.20.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 05:20:43 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Patch review
Date: Sat, 22 Jun 2024 05:20:35 -0700
Message-Id: <cover.1719058713.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Jun 2024 12:20:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16374

Please review this change for kirkstone/2.0 and have comments back by
end of day Tuesday, June 25

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/7065

The following changes since commit 5a90927f31c4f9fccbe5d9d07d08e6e69485baa8:

  parse: Improve/fix cache invalidation via mtime (2024-05-23 08:52:30 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Steve Sakoman (1):
  tests/fetch: Tweak test to match upstream repo url change Upstream
    changed their urls, update our test to match.

 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


