Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4101C47422
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 14:07:16 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.web11.15450.1706537233775886254
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jan 2024 06:07:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=oUafVy0Y;
 spf=softfail (domain: sakoman.com, ip: 209.85.161.51, mailfrom: steve@sakoman.com)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59612e4a21eso919905eaf.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jan 2024 06:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1706537232; x=1707142032; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lqb9KIKfMMjNJVH/zu9fPYw7ClxUqhcdW7+G/Y55a1M=;
        b=oUafVy0Yka2gIt23/YTAbdlKS4+hOFsW/rTxzZr+0bZBbqTGtutUJS3Kl8zwOQMaTH
         7X3e+2KvcNf4+X2DntewgiDWDVz/tghxmmrc9Ygm4R11igfAfQuuUI7Q0LIaMQWGTBfw
         2fAW4l2nNF8GDKP18ko3THak7hz7NJda9rTTcBCxIHc2IUvu++ITARMaKnToaMmkhAH+
         KZSex9cGKDVuNZiNmLk4waDkWOgkVj44bBILEPUtxWN0I8I7zihElcDwFqRuJraog/R9
         iHIrq3mD166tBPU1JCWCGqHfw8cWJI/d0n5zI416kemeoeX3RDl8wprxQR6+i6wcnVtu
         C32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537232; x=1707142032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqb9KIKfMMjNJVH/zu9fPYw7ClxUqhcdW7+G/Y55a1M=;
        b=qdytFu8Blr58sHmO28kcurXdhFcFemi9O06vBUkasAtye4mwRDimEh3spr6378fGy2
         FIAOiNQekmNnr644YvoJFPOZ3it5EH/P9xD3372N1nAqftRuPGNKzfp9eHN/2KWnG22e
         ucONa5L9hV3i5cNQYEEmAaVnMdYhJuPth5yhvhmGrZ3mDL619E5QfaXahZRNiuH96nmW
         fb5QoYFFH/kJbnN8Sa/eJAONOc2ssK9+jcWud3Fq1buDs4vdfbhQXsCpZ53wyZX3KBnF
         boQdgkhjvokhqGcVNfW5evM6Tc0Uv0cnXYhq2d6Vn5xe5xXMfC/VDOcGwTZey6NmdmPz
         y+cA==
X-Gm-Message-State: AOJu0Yww1I1AxydP06Wp+wqmyDc0J8IaLiOFosISJE2gfrCEqeYCb1lH
	IParjAWp3XoObyp4J5r4x0hDl2YZgVg2dSXArbcCJEx7/7ywYralAUGr32pcuehSYrNKEVn5O0L
	giuz7+Q==
X-Google-Smtp-Source: AGHT+IHoziN6A2poWzCiBYmsjzlp0GAe7q/l87n051NtzYzcPq+YgiyGEGbYAgGzA9+jxeBV9Npmdg==
X-Received: by 2002:a05:6358:c90:b0:175:1f1b:3fe with SMTP id o16-20020a0563580c9000b001751f1b03femr2229398rwj.61.1706537231997;
        Mon, 29 Jan 2024 06:07:11 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id z5-20020a626505000000b006de3535b35asm1259468pfb.118.2024.01.29.06.07.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:07:11 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46] Pull request (cover letter only)
Date: Mon, 29 Jan 2024 04:07:04 -1000
Message-Id: <cover.1706537113.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Jan 2024 14:07:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15802

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6495

The following changes since commit 36959b25c64044dd4bca65bd1bb1243823d51545:

  lib/bb: Add workaround for libgcc issues with python 3.8 and 3.9 (2023-12-30 11:04:47 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/1.46-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Diego Sueiro (1):
  layerindex: Fix bitbake-layers layerindex-show-depends command

 lib/bblayers/layerindex.py | 1 +
 1 file changed, 1 insertion(+)

-- 
2.34.1


