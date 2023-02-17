Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C709C6379F
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 14:29:14 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.7579.1676644150780724110
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 06:29:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=fcHCmi9H;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.169, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f169.google.com with SMTP id p8so1542083plr.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 06:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zY/OfHAYT3Swk8MLx3hKYqV5y8qpSEJjuYI8Bd2J+w=;
        b=fcHCmi9HFd3LuD4sVBRRs8NsIHC6qU6/GPVeU8P9x+3VzMh9tJj0405mtpz/wRuMdM
         4oyy3o2zCoHtYLAl/RDMyaWw0Am3330Ncs0QH+Re+cNMkc0hGY9970AQ4JID0N3HLQw0
         1nx9C6kVp69+9hy3AtE17PKgl2MCanQ5sgvf3dKgTQAAvmD9ILPTsXOEg51KtVylM6lp
         /ilg0Y7jYWCZa4REE/FBXH53dyIRQeQb9wXYZ2VO4+kh3gPoK9yR1A/usGiAAeIpvP8y
         50O8bY6DiwPkTcm2HWC2BEAWHNhCG/9gjbXF5YIOhCcrjAHNhBzhelYllckq4q4fRBGl
         ipKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zY/OfHAYT3Swk8MLx3hKYqV5y8qpSEJjuYI8Bd2J+w=;
        b=ZTV/QQ9px56K80inFDR7Gdq1esdUoNrjbNw/35dopZMBVOipXyQWsJ/yy8wPK17rwu
         dV+3CHmxwsQVjRLfpw0TMqkzRp3hDs5YUdUI7v4is0VDpibCaGmhx1fCuDsOqBZZ2QS1
         TwWjHYLQQRQ0M0GCSY7BFUqodJ5roLxkRt3Eya6GM4sBb5cZ5+/uc3H3MmYXXQlUyuXT
         /SMB3EQj2tObS9w5ufyHmQGM9OjZrv8Q3i6aU74RqyxZvYXw8TRMhilKrI12LlNklPZA
         gmZDhbwJwqj55DQNltg44cqgv/abAfhZ9Ww1TgbzJUOwzUq9yqHD8fhw4QR0OBmae31f
         qo9A==
X-Gm-Message-State: AO0yUKVlVYHNnitkrxorVYqq+rOev3KjOWK/OaBGGY/b7pMq9RPcohqN
	NpbaYcMNtcCYZDsSgVpHCJkTBrpmDF8ZC6/I2I4=
X-Google-Smtp-Source: AK7set9IlJiTMdMLxRUnkceLNQA+7xlVrDbUEpcEqQNq5n/q2OlpH8l+p8S9ehKHyPsYMwXbv32Tcw==
X-Received: by 2002:a17:903:2306:b0:189:5ef4:6ae9 with SMTP id d6-20020a170903230600b001895ef46ae9mr207617plh.45.1676644149786;
        Fri, 17 Feb 2023 06:29:09 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b0019afb7a02a1sm2929970plb.218.2023.02.17.06.29.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 06:29:09 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 0/1] Pull request (cover letter only)
Date: Fri, 17 Feb 2023 04:29:05 -1000
Message-Id: <cover.1676644047.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 14:29:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14455

The following changes since commit a40fc6a3f774bcb28cf72701ac146ceb7ae8061a:

  fetch2/git: Clarify the meaning of namespace (2023-02-01 04:20:40 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.2-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.2-next

Etienne Cordonnier (1):
  siggen: Fix inefficient string concatenation

 lib/bb/siggen.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1


