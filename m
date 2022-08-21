Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41691C00140
	for <webhook@archiver.kernel.org>; Sun, 21 Aug 2022 23:07:01 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.11889.1661123214394620627
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Aug 2022 16:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=cp68ZaRc;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.54,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f54.google.com with SMTP id
 r14-20020a17090a4dce00b001faa76931beso12295417pjl.1
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Aug 2022 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=Qlccl9rwgPJlOkWwgpNhUAOSepcsBRW7CwfND8s13zg=;
        b=cp68ZaRcURjMSp2U7coRVrGwTBETLzQ4ZKhr/5WDkl/2Y9bd88fNPEKjByM6U7QoKO
         P2OrQ3QgzHpL1wiuXBY4t0sJ+7qjameRoV8rYsE0aihhR0NMQf+NaewAxIgtMdggcHXT
         ptFC9uLuVLomiUKqeHYylDdOqrVdDX+4hSqbL8gMkYBonIYZWHwAbeXZsdgHfGMUAlK7
         gDWx/7JdMWLm/hFMYNmQSJyzBkYQGUPTV5y50YHcHqoVtWGX8/TofRBozBRVpW1txrUs
         MNaYFDsaBeSE5Vm71K/jliwpzlDqj4bUXDV1FvDR+Qa7Pz9eQ/Utt/Mb8GUR2r6F31Iz
         E8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=Qlccl9rwgPJlOkWwgpNhUAOSepcsBRW7CwfND8s13zg=;
        b=vIS0Q2NEY5Z6kqECnBIdOa3i4pug0T6PDyaeVlCJua9gbFZnxeoPV8gFWOgYnKVnbX
         pvor6nmY752hGH1ZC/vDWCTzRbUmMJ6FZuxCm5t1FDmwphaXeiaX+IW2ANBPVbqMeadm
         yfS5z97YdpgrSfyXxsQPOpMOLcTKGDmTwlB1x1JLz+ny6tl5Y1thYqeUYl82E6koIWxW
         9DA4UfNU3pC2lG9V5DJ+RoOE8CnxcRSpGA0SK8+qLFxYDtL9WGa7UJ9OctaoyBOq2wsE
         m5N22RfDaI0zG9nOz2CSXSswrYbaU0Qicogg3RFhqFu35jjX+rYcil39g2aoAil/upDf
         GXDw==
X-Gm-Message-State: ACgBeo2w9ZwH1CT0YnQ46wJhfB2+baOTI7FZu1xP4LOxtGKNUqlUqiFL
	5m+Wty6KuQlqkrLeUc3CK40TfsRN+Wgzd/th
X-Google-Smtp-Source: 
 AA6agR6c+WZheVsxHL3d9OKPlfnXcByeheriJPzXbWXnUDlPGYKDmkodQs4C8Rb/1In3aGOnlnVe3g==
X-Received: by 2002:a17:90b:1c0c:b0:1f5:494a:304b with SMTP id
 oc12-20020a17090b1c0c00b001f5494a304bmr20292511pjb.157.1661123213476;
        Sun, 21 Aug 2022 16:06:53 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 i11-20020a170902c94b00b0016dc6279ab7sm6983074pla.149.2022.08.21.16.06.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 16:06:52 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Pull request (cover letter only)
Date: Sun, 21 Aug 2022 13:06:43 -1000
Message-Id: <cover.1661123122.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 21 Aug 2022 23:07:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13909

The following changes since commit 7fc4cffebf5dcc1d050416c0b7f7d58c765c1d69:

  fetch/wget: Move files into place atomically (2022-07-08 06:48:38 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Christophe Priouzeau (1):
  fetch2/wget: Update user-agent

 lib/bb/fetch2/wget.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.25.1


