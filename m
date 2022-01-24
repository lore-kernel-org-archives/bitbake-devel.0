Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3503CC433EF
	for <webhook@archiver.kernel.org>; Mon, 24 Jan 2022 22:35:36 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.3269.1643063735242224274
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Jan 2022 14:35:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=LB/oUmZh;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.172,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f172.google.com with SMTP id v74so14226929pfc.1
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Jan 2022 14:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W1pHE+RotulTRgIuCnQNkm2uzh9aaTjzCmZEhgnLdk0=;
        b=LB/oUmZhIc0zRyf7UDH9TwUyZN+mfPIqfJpy2nV28IX5KDbt9NjcuG1O/VFyseHihb
         U9oqs9qsVLYZ+ZTJTO11vy7i+L+onoTZYG8VO4E51knFwfOGJiMRmwYRNnNFu3sEkRMj
         aya5UvTKrOmtm5Uyrl7ab7IQGnUVZRoJ3+PnAjPHqoE0i3fgly6NqJMXv85vbnBTB3m1
         6bG0STlvx7T0+oBs5As8MfaxZs8WWo2oepg5yeQNyEq9LGTsDmk1tdAWIAXqdV8x+0+L
         D3kEFLM3PJYbeKtUa+oNZmXaAilobXfuS7z1xL300xjwcbt1WdF2X9sZTyr+DzNFUhS1
         4oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W1pHE+RotulTRgIuCnQNkm2uzh9aaTjzCmZEhgnLdk0=;
        b=NzXyWwjnJfAYa+zm3SLrZBa4jSQ2i7GIA0ZnQJ2ElMdBSVIPQO/26YUoCeKTtiGDMu
         caK1CF8z82EcatTp8gC8ME3COSaFIP3UTCEMbudii1yzgsBWFDMqbur/Lx53WrAbBak2
         eAfl2HH7IXaM40JZgCdm/cfxofU1SysFnLzs3LngZ+98GddQQsmUbaDOzU2Y3Y+K/1v7
         Ia62yvC0bxIUmQ2KBVMCu9OgsWgX1ISekUieImioyavdxsu6N53kLzbLc31q8HMreJq3
         KpJd51fq3tknrS0GAlo3NSelVdeBnYnzFnK+tCXuH2GlSSxpvOX5fFS3eMSfSgpWxNFp
         0XFA==
X-Gm-Message-State: AOAM531718Rz1b2lvgRVGqZpCMW1S8dxlIoW/TqFCZA9y8oAVZH2T157
	OFxcAYvTcvtyyrobWbLhHNAJvw9eTE5nNTyA8BY=
X-Google-Smtp-Source: 
 ABdhPJySQ5h2xDR/9zN9TfaK3064n2nBFuwJGdQCeaiWneCUB68QzUHPLPUNOZ4dDCpSckSySrhjhA==
X-Received: by 2002:a63:844a:: with SMTP id k71mr5611140pgd.495.1643063734228;
        Mon, 24 Jan 2022 14:35:34 -0800 (PST)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 190sm6469299pfg.181.2022.01.24.14.35.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:35:33 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Pull request (cover letter only)
Date: Mon, 24 Jan 2022 12:35:25 -1000
Message-Id: <cover.1643063657.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Jan 2022 22:35:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13276

The following changes since commit e6d75e0beb95aa0cdf82bbc0a6b767c7f6cfcfc0:

  tests/fetch: Drop gnu urls from wget connectivity test (2022-01-17 21:53:02 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Jate Sujjavanich (1):
  hashserv: specify loop for asyncio in python < 3.6

 lib/hashserv/server.py | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

-- 
2.25.1


