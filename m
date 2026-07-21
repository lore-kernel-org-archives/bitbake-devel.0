Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE38AC4452D
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 21:52:05 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34927.1784670723993030492
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jul 2026 14:52:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=gB6J3X39;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47de008b020so4079028f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jul 2026 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1784670722; x=1785275522; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QH7uUrAbYBg90MbQJKyW7ChAhQazh1uMNtNWVJhekLk=;
        b=gB6J3X39OcaFVO0L+bmDLXhMyPRJFlgGAHQOFNuqbxxflHqAbfzoMyULrzAkn4xwtU
         PSJ852yQi/Ofx890Ygm7zoE2kTpos0ArRC2JllyUh57iAsvIIDvcF2bNY7bADIoksJzg
         X875jd8JwBRQnIwpTZ61I+HbT2i2tztMS3amI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784670722; x=1785275522;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QH7uUrAbYBg90MbQJKyW7ChAhQazh1uMNtNWVJhekLk=;
        b=lvu+W+k6Dn45g+hRjS/Q8X1+Y6uNUOjm6tjlSB6HnUduH2bgF/OgHkW+zOUMXH66HS
         w7Xzlo9c2LuU5xs08QzDBbPMj6R/o9Hp2xcDU8dNECPjCyO1eI/gv6ME/Bp1UuQQHNwZ
         q1/VOArBBnti0OnrNDna/L/qKHWYl3AcwZicgGW2HCBjAZYqn67i0xeeAyr1SuiDFTa7
         McCcVNRn5K1se3C1MY5blyIG7xL+6lTNuQx93WEH2qu/AMIacIqIz4LVIXFWIfCf7hM5
         GCQJQiP52PAO3cMPAVI/Rn55FmcVPPlixDUjwqClLgz846fZKICyYTxtCYkfmO7XCNmf
         077A==
X-Gm-Message-State: AOJu0YzmcHfIkpAYrOUvywcuptFo9Vi0l3FwxYdknihImv9MaPEgfq52
	o25AJJf1gU8ettuBKe4aHhOIVC4FBWOHabKnGLu7RcGlRg04US8CQ1JwCHigDjDr5MPAjioGA4r
	J6Ldj4CA=
X-Gm-Gg: AR+sD12wcEv+paQT1Mre5ddwaLsJCsCVsskR5yqDRWIiNdax0m8JMmRmEFVz6Ba2onH
	vMIHSALigqHi8QA+mein4PbjRYDwD8c7/0Qu21KUEwGUMQM9JT8W39EI5Pe///vXPbyS/PyJtSM
	QuUYFlM6ieySMAD+jnE2fstW1s+VHTAmJ1Vx6xUI4kOqR5UdIeKpH/aBON72GUhvolIC/9GV7Nj
	VFgolenCGnPnOOnZWO88ayhUitWAWdS9dTD3JfPblglpEWdAMFZvnxIgnGusJkOIJ9cMd02jWcI
	OWf8u16P2nWeCvSLPO3v/x8J2sDxx7YDQqHVqlJ/wlPKsRRupScEMZcprK18i9mP0wOi42Pyeru
	Zwe4f7vCF6sbZJAt0PzkuQfZ0wS6UnjrJFbLojG8g3wx9b4a8vnkxFbpJK6XnC/h71eHzFdGZRw
	UORat5QhuP+OmEENwneDyhirSx/mgm46QegHd+cxlzyGOQfEslgkpm5zdUJejOQhrYIh+lsGO41
	XD4wBAJ1TYANhGZFhg5uAdEHUE=
X-Received: by 2002:a05:6000:2805:b0:47f:775b:f5dc with SMTP id ffacd0b85a97d-47f840c94d1mr953427f8f.19.1784670722159;
        Tue, 21 Jul 2026 14:52:02 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85a2573csm54819f8f.0.2026.07.21.14.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 14:52:01 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 0/2] Pull request (cover letter only)
Date: Tue, 21 Jul 2026 23:51:55 +0200
Message-ID: <cover.1784670547.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jul 2026 21:52:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19847

Those are the patches from the last patch review:
https://lore.kernel.org/all/cover.1784281828.git.yoann.congal@smile.fr/
(no modification)

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/4256
* oe-selftest-fedora failed with 16308 – AB-INT: selftest: xterm: Xt error: Can't open display: :1
  Retried https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/4160
* qemuarm64-musl-ptest failed with 15814 – qemuarm64 musl ptest failures
  Retried https://autobuilder.yoctoproject.org/valkyrie/#/builders/109/builds/768

The following changes since commit acfe02fa38b5da9e6a36c6cedcf91d4fcbefbfbd:

  tests/fetch: cover checkstatus redirect auth handling (2026-06-11 11:50:29 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-next

for you to fetch changes up to fae9db3168dbff1b8c76fe9c6726a9687ff97514:

  utils: Add NFS EEXISTS/isdir failure workaround (2026-07-09 17:37:07 +0200)

----------------------------------------------------------------

Ernest Van Hoecke (1):
  bitbake-setup: always write newline at end of the README

Richard Purdie (1):
  utils: Add NFS EEXISTS/isdir failure workaround

 bin/bitbake-setup |  5 +++--
 lib/bb/utils.py   | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)


