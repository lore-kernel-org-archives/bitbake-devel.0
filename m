Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.9756.1612362153972422046
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Feb 2021 06:22:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=BWGRLff9;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.173, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f173.google.com with SMTP id t29so16721071pfg.11
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Feb 2021 06:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fCHh55kCjVnLNAtCi8uP2byelIY/5c8a3W54G3KBSNw=;
        b=BWGRLff9PFTKEp0ETwRaAkSbXak5ibKw43HvbsxNjQ4yRLz9dz8y7+f8q8Ff03JzT2
         VDoh8ceYjnHhL1EiKzDLjT46AWk6h2R9epU/slxDYhhykyhrl8isUMIEfQALh8+EupoY
         LkEn3y38YiHHaasjVRxhRijbCMyAp8FqK89puh2YMZFwcbMyDMk2DeE94Yrf4IDRrQBh
         9a88QWLQ5/o+sZ9/37CKx6Mi0UdUvyScCIVQYpeBWe7JSzq8XYcmmKjTMVQ7wlBI2D3u
         Llvjp/fJCu38W246gc0E+MkooP4kt31IVCtND19qCdlISO6VJn4vi3BwM/H1nICEIJfI
         5Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fCHh55kCjVnLNAtCi8uP2byelIY/5c8a3W54G3KBSNw=;
        b=fF0aJAeK4/Y2hliAdlXk4ZwHD0QY9wKli40kH27Uo7GcsIXVTUBuGM+EcAvWqxrjpL
         VUj3ZKyASavW6riuSEML3+tJ9rfxOP0u0/bxNCr+FuSDmNl07ccqaRXKZL6CfvGZZ9Cs
         4E8lCywRhp0z0L225ww8stY7RLpYaxz5Z98qwVXIIuENTQTO0h5A+2VxdcOqbeZ98L5m
         paLyNH4HsITkJsMCoPWSR/B/yIKywZCAfUa5G5lBsXssGg0PHXcKMAa5Pzl0VFk2C5rC
         iwtA1A+P0th9SKqnHpWuQQl3oRCVzibgQ4JB7UNfIQOLUIHzOkLCno7RAqk102dSUHXv
         r59Q==
X-Gm-Message-State: AOAM530+ZeCEBnAK7E3STBBph7klVLNZlON5Zk5clcwpWxdM0hxleV/2
	7EOkq4zeMKwmvMHZlDtKWKu7m/vu0o0/7HRWdOY=
X-Google-Smtp-Source: ABdhPJz4BtlP9OqNsHDQYN9iACJhN9KXVrGj/WsmKwvrUm4IA1B5KMcJZllnrgbQ4Jnr1VjKWZpFyQ==
X-Received: by 2002:a63:ee4a:: with SMTP id n10mr3859857pgk.375.1612362152619;
        Wed, 03 Feb 2021 06:22:32 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from hexa.router0800d9.com ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id t129sm2882713pfc.16.2021.02.03.06.22.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:22:31 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/4] Patch review
Date: Wed,  3 Feb 2021 04:22:05 -1000
Message-Id: <cover.1612361853.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please review this set of patches for dunfell/1.46 and have comments back by
end of day Friday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1815

The following changes since commit 418c00c570a60845556204b4f52de047b284dd8e:

  data_smart: Ensure hash reflects vardepvalue flags correctly (2021-01-26 15:45:01 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Matt Hoosier (1):
  fetch/git: download LFS content too during do_fetch

Mauro Queirós (3):
  git.py: skip smudging if lfs=0 is set
  git.py: LFS bitbake note should not be printed if need_lfs is not set.
  git.py: Use the correct branch to check if the repository has LFS
    objects.

 lib/bb/fetch2/git.py  | 56 +++++++++++++++++++++++++++++++++++++++----
 lib/bb/tests/fetch.py | 28 +++++++++++++++-------
 2 files changed, 72 insertions(+), 12 deletions(-)

-- 
2.25.1

