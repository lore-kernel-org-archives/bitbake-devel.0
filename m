Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7968BCCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 15:02:39 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19570.1762873357483871506
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 07:02:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=3ZIY6grq;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.169, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b75e366866so44094b3a.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 07:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1762873356; x=1763478156; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CdK+rBYAl/Ih6k5uTYJ/phh6rO35tsHnUTnclEuUuWI=;
        b=3ZIY6grqHZJ5AIWvfDf/LAZe2Zbh6Ib+70QRAfIBszfsaj0aYBljFsYL8oj3a/bEuP
         Ak03KvAmhZdlWjm3MvBDzn2Cpl60qqAVPKopuNrSTFpAG7k8geanbdMwkQh2+W9xVe0S
         zSrSTJDdwf5/WtXBNNMaqg8nhcTjTizaxO3Zpogt7h4KAXgVXcoPcgZOsclEejXjg3UY
         XsUNMx+Hr2bz1Z6niaQq305r2LIiQg+Bq6U32wLKjb4NAvnM3YNhp+JCPooVd54T7UbQ
         2oSIFe9Suo4kgSGmeMO2jK79WJS0IkJw2F/WMYdo90ujDNt5QNKeAOQRlQ5z5swHWzXW
         3toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873356; x=1763478156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdK+rBYAl/Ih6k5uTYJ/phh6rO35tsHnUTnclEuUuWI=;
        b=T/rRexwooD2RQoCAOxpJ+9FgY17Qv5mHjo3WPxXQhd4x+CJ3Kut7KN2CQuhYMSuFWH
         23LSp3maFSnly8LQNaDBwaHuBCwQIQyh5zz7Rnk1ow7gGKlCoXkb+xI8QcSGI/nkcJjb
         zeF2zMxtF4+MXV/nnZpeXCKLKBY9p6puvkHg29z2yoPIrIS6Vy1ur4Gl2AvvOhxdZjkf
         IvLgpy/u/DWQ6Gb47Nhu4kSJ98SleygLOHmSDtuZG696ZBeKevYZth+AlOsjXtmnv3ky
         NzbF/97I1XNgqgpYkuY44+q0JOnWv6oiinVtXGfdfGq8DWi9dZALmGGPcOv7Abrav2F+
         iDKw==
X-Gm-Message-State: AOJu0Yw33KNRxxhfBgDg9HSrxfxGLkj+Wj2hK3etqEazb/OojEUfK1WZ
	sGCxysRURLdHHu+GUEu57MuwVHabBgSlq1CHrA5DDQf7vcU9ajVXxEUyVIAn2ioTn/+i42kfrVU
	ad9qbhJo=
X-Gm-Gg: ASbGncsaqqTm85SQ3mNnGWqlKsU6J5ZGBHiFMtZPvAVaWJB5lYVkNIvMWVk72hLPN7V
	O/9xu380qu6wjtN5GJ70c4GTPPcEyuefHVCf4YI8Scd0JVBS+G3CgskdzTZps/Ovvs5M37k8DvH
	GUzgF98+Ij0sVRbzfIlkawbzi4rUofQrzRLAxnqzrs7AUcG+oXiHA9ys2eWZsr4z56VtZADf9fP
	nq3ssJZ5DuwH/K5zhcfpcn8cUuMQZJjyUq6sQ9T6KfVmqzLY+dNuCbuZYb2VkZIsMmvjiGwYzbf
	FOYlUh+EV6ILFKqSP17XpCCYq0MCOEEfDNkyCXrNsOLAMjs159SXr8jQBBawkftyKWaoBEO8JDu
	OEwVRYxKLomNEsl8NLIiTdrfSLTYwXGapbE59i22/iMrveJoqto7r8DJmxbpNFQSNik0=
X-Google-Smtp-Source: AGHT+IExPtnQMOBk2Ce2eK5jtcUTN6O37r/1g78p91X2Ct/F5Z1p8+Bj6i6kZFDCdXMMhECfJQEFAA==
X-Received: by 2002:a05:6a00:230b:b0:7a3:455e:3fa5 with SMTP id d2e1a72fcca58-7b2231091e7mr14005947b3a.0.1762873356304;
        Tue, 11 Nov 2025 07:02:36 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:db6b:ed5a:7890:6b41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccd56de8sm15778946b3a.68.2025.11.11.07.02.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:02:35 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/2] Pull request (cover letter only)
Date: Tue, 11 Nov 2025 07:02:21 -0800
Message-ID: <cover.1762873246.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 15:02:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18323

The following changes since commit 1c9ec1ffde75809de34c10d3ec2b40d84d258cb4:

  bitbake: Bump version to 2.8.1 (2025-09-17 23:22:33 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Bin Lan (1):
  bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()

Philippe-Alexandre Mathieu (1):
  fetch2/wget: Keep query parameters in URL during checkstatus

 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/fetch2/wget.py     | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.43.0


