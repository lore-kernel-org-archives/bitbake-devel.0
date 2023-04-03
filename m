Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB88C76196
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 19:03:26 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.80542.1680548598946106144
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Apr 2023 12:03:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=Trxqudb2;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.178, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f178.google.com with SMTP id ja10so29026881plb.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Apr 2023 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112; t=1680548598; x=1683140598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=168BTLsWwrAPvZBSZQD0OL8sBQq6YQ0aarvd4x4vSYM=;
        b=Trxqudb2ZIa7lJbvqlu/F/llF2mPvBIFLNIyWKc+KG7+1xVQYHaM2ShZMQJQAvHJyl
         M34K2GXANsCb97jJcGJZwE+UMrmQHSnsklsDTPDz8RiAEm03mRLYAbhr9pB73xva/JOQ
         a7gDxsQLuB8Hnku0KcQ04sYW28v44ZB4lgTOKdXLTdCorXUlulrCy0dxKZLFhiqSzoj6
         wFtpolkp+kklaa10DAJRmFoulCyIEjjvqG1K6bgYpjhBaWTOktPuJyZqxFfxFNBj3oE/
         nrlGuB1/Js8fil1gtunBd1uScfErNO+uumt0jn0S+dDgdJ7bs85v0u8+x6lBx4cT6/Rd
         dXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680548598; x=1683140598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=168BTLsWwrAPvZBSZQD0OL8sBQq6YQ0aarvd4x4vSYM=;
        b=vv2nDE/ejP1Izbt4ax22ZjHZfEhZtEF/3ncTtM4LUfnZqlS34s1c7MWVWdSRCow+pJ
         D+jeTgG7LGZw0G2xX+5j7XGFtHMHgiRR5Fmy9pCr1YJcVMWDbm+NRlgYU43vnTCbs/xx
         pZv3niUrajY2RpAPidoCW+mmY8lNnkQqBmlsnMKL3qRUkpirKAR+1v//+9Ne0OFdgM0V
         Ol4+7tqp0C44+ldpDWaPswYKHQ0y7NG5IgNkjZhkL6SeGC1Yq6Tr5/HXRQ/QwDYzmXi6
         r20exHBxXL6ZBPYDUBuVaTAqi3n334R7/zRPLBt6rpjFFLFIDoxyBiEt/kr0iFqPkxYG
         dxlg==
X-Gm-Message-State: AO0yUKUgcvDpekETUQOtL4MtSakG6fYPJeg+M6bnfOpXxLghvxXHo7TE
	L+jgr5PThItdjuL6rCrYGOhUauiJx5DPZPz73kQ=
X-Google-Smtp-Source: AK7set975iPw7lkdhel41B5QA36QW8GrMv2/eeKguaFDUV1h+jnI5ikGcwH+1K0Dl5vlJ6f+pBZn5A==
X-Received: by 2002:a05:6a20:bab0:b0:d9:c3f5:2933 with SMTP id fb48-20020a056a20bab000b000d9c3f52933mr31443924pzb.20.1680548597718;
        Mon, 03 Apr 2023 12:03:17 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id e13-20020a62aa0d000000b005921c46cbadsm7514026pff.99.2023.04.03.12.03.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 12:03:17 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Mon,  3 Apr 2023 09:03:11 -1000
Message-Id: <cover.1680548475.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Apr 2023 19:03:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14630

The following changes since commit a29ffcc12df24737e702e198aeb8f6892884932b:

  cookerdata: Drop dubious exception handling code (2023-03-14 15:05:00 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Robert Yang (1):
  fetch/git: Fix local clone url to make it work with repo

 lib/bb/fetch2/git.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.34.1


