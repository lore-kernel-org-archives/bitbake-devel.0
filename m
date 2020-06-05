Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
 by mx.groups.io with SMTP id smtpd.web11.913.1591316547513702592
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2020 17:22:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=sH2pECzX;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.195, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f195.google.com with SMTP id b16so4034366pfi.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2020 17:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=Ki1N3maMfywSk7PbzzIJyNPBRwlj6rlXMfZ5n4kYaAI=;
        b=sH2pECzXScvzTPILz42BVFIaM0ERinMk5ZFbNyk3/dD3jvl8Hc60G/5a9WmPl6R3tb
         SIp8EbM1orOpznRk+4vM0XqLbXmCcQKFsluDsba08ulQTkV4asWssTd+a7tV8iiNNT4z
         kUOmcuiFMv3jrYCudoGUJxHgS/C4bZK8MWMW1pI5yZvUQKN/yqpym0s0LZzHsXW4b8Jr
         dOK4Nx0gQaMzI3bBSSxbZC2enFWslwVKWjcnibwnAUeQLg8O28KFTKfOP9g7+MEGUisB
         U21kfRvm4/PKFGSxR4Ktv94FUrDxzkh57P9kUTvNJRppEzYmVHxbY5BufgP/QEP8I+F6
         zTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Ki1N3maMfywSk7PbzzIJyNPBRwlj6rlXMfZ5n4kYaAI=;
        b=k8zWEtiwBaWnzjGi4bv1Yxzwn6cpx+W0OxWQVAD8etBygfE2cA4GqKUn4dBXN/bMUM
         XsuvG6kqYS8hp++shp+AFmd2tsLcclaKdjwllp8car6Mx8bfDEQ3XsYQeCwiTJkg0cNe
         f+srBS8SLkRQn0ya5huFGXlxl2sd1wyfqOgBCaU+SxVJoxS+4HsrcKkxwmGlBmBCav3P
         F/YTWdngIg6PZkuAVOwzEmYzSOWItFA+UGYeEz7eCfixJCzF5b1RVx4sysYJ4LvZzan8
         xQuY3AKU4nCf0iumWOfp/4hGzZ0ExkQbF/dkDZ85LgL58yVrzHBJo78F4X6A6Ei2tVSi
         c2IA==
X-Gm-Message-State: AOAM533zM9UeAct+CcPw7TLjfPPQNa0lMWLVIGo8I/52dmV4hhf2XYMl
	ZQUmg8Zf2vfN2xo213HHQYCKDAayDpc=
X-Google-Smtp-Source: ABdhPJyT5vGNlk51SDCXTy+C7nMwLgVwbu8wkkBoNGUSNwtHBTBJpAm5k4s9I2hmd0wkAXGZDJQKQg==
X-Received: by 2002:a63:fb14:: with SMTP id o20mr6949620pgh.144.1591316546302;
        Thu, 04 Jun 2020 17:22:26 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id 73sm4978237pge.15.2020.06.04.17.22.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 17:22:25 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/6] Pull request (cover letter only)
Date: Thu,  4 Jun 2020 14:22:12 -1000
Message-Id: <cover.1591316350.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

The following changes since commit b94dec477a8d48ebceec91952ba290798c56c1f5:

  bitbake.conf: Drop unneeded variables from bitbake.conf (2020-04-24 14:31:30 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Jacob Kroon (2):
  doc: Clarify how task dependencies relate to RDEPENDS
  doc: More explanation to tasks that recursively depend on themselves

Kai Kang (1):
  bitbake-user-manual-metadata.xml: fix a minor error

Robert P. J. Day (2):
  docs: delete reference to obsolete recipe-depends.dot
  user manual: properly tag content as <replaceable>

Tim Orling (1):
  toaster-requirements.txt: require Django 2.2

 .../bitbake-user-manual-execution.xml         |  4 ++--
 .../bitbake-user-manual-intro.xml             |  7 +------
 .../bitbake-user-manual-metadata.xml          | 19 ++++++++++++-------
 toaster-requirements.txt                      |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.17.1

