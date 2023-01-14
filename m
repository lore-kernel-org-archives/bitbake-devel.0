Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7913C46467
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 14:12:12 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.116406.1673705531146980983
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 14 Jan 2023 06:12:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=mGNeysAs;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.54, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f54.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so27044369pjj.4
        for <bitbake-devel@lists.openembedded.org>; Sat, 14 Jan 2023 06:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DJAnNLGoqKymXphFOBlcwllMHawYl1RBvX3qcj9wq9c=;
        b=mGNeysAszp/XCJtQf92ROJKtQQ4fuRb74KU87I5t3iytwzEoR3zFvRID0Y29yjfOfb
         5AjPHMp7sgV6YHUJjzZzSo+K+fg/TNydBwRppGSmCcgR4nx4BlNpgp+bf8I4x1k0SdnC
         wolzY1ZfVgkDMIq3VlciAQNz27K7opxDr/RZFoZF6+I/9EO5mQP/srdrlyiX/yuhvwqE
         4i7WlRPxdG0LX8FQiZptdpvXli+C1+koleFrYGG0dkVwSk17hF7hZBJP/7pYduG3sFv1
         ehgk9Jzlgha94uaikYhIpoXBQ7JNc2ppXjIWxA+XcagU62x0idAgdovJsg9Xe7vCUitP
         rwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJAnNLGoqKymXphFOBlcwllMHawYl1RBvX3qcj9wq9c=;
        b=12NzIvP0etfhHsoXqZ12Q4Sk6ENKplrIzGUeBzxBFeBpi9yHvCfNdO16vbMR6iXGWa
         PIMk7mgLGwuCkG1F1IJWM9LaHxTjjqxLT4gbj+G8nS+AAFNEPqQ7h4leX19D69vXODaO
         fMhZSfOpeC2l1PM+3+/uQkhGW5N7wWlUvaCywgk3cCOITZDoFp5gGr6lXPwr+hxelxok
         TZnbbcTQSoA3mdtDc//O5bI9L0xUW3sG7B2H15ZA1KBwTqwTF47QE1uABHTvgdBxmqSr
         dPDo7RfGdjdG3L4WJhHcnYdniMuKtWrr9I/sfIyiqfvZJWSN+0jtHn8x257QOhs+VurI
         lSHA==
X-Gm-Message-State: AFqh2kpiGwdZ+Do8odBvKAScCbujycPYDu+6SiClN1kN8HlAGjxM3oXJ
	m+jbLozI5WgyyzAF8N1/iubaq+56whjnBqXBLgU=
X-Google-Smtp-Source: AMrXdXv5WaERswq2f2GXxPDJpUhNDmzA5Df8kW0a7ObGbAVJM0aKC/5AKS3aD7STg3vK+PTNwYtxWQ==
X-Received: by 2002:a05:6a21:1509:b0:a7:c9a:73c with SMTP id nq9-20020a056a21150900b000a70c9a073cmr107684911pzb.2.1673705529848;
        Sat, 14 Jan 2023 06:12:09 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-5-74.hawaiiantel.net. [72.253.5.74])
        by smtp.gmail.com with ESMTPSA id q2-20020a63cc42000000b004788780dd8esm12942463pgi.63.2023.01.14.06.12.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 06:12:09 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 0/2] Patch review
Date: Sat, 14 Jan 2023 04:12:00 -1000
Message-Id: <cover.1673705296.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 14 Jan 2023 14:12:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14313

We're seeing some race issues on the autobuilder where langdale builds are
causing master builds to fail. This is likely due to langdale
missing these patches.

The following changes since commit f0f166aee766b4bb1f8cf8b35dfc7d406c75e6a4:

  gitsm: Fix regression in gitsm submodule path parsing (2023-01-06 17:27:39 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.2-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.2-nut

Frank de Brabander (1):
  process: log odd unlink events with bitbake.sock

Richard Purdie (1):
  server/process: Add bitbake.sock race handling

 lib/bb/server/process.py | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.25.1


