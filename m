Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF03CCC6B2E
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 05:04:24 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32451.1792040654389013488
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Oct 2026 22:04:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=xnAjyw1d;
 spf=pass (domain: smile.fr, ip: 209.85.221.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48df54150dfso97656f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Oct 2026 22:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1792040653; x=1792645453; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hZtNnO88jheorN8Tquxks5aLZ6/kk6r8yJtG2M+fW8=;
        b=xnAjyw1dxoD8DISIOenIvjVCZn3faozlo7Bt5OS8Vk5U2V7xrtlWyHC07um/cfld3D
         0qg/PKgPawVtYMlXDvk6ReRZE8PT2/DxNBq1yxfgZ9nfXGRPCVibvYfrS0k6Ll1pwFF9
         JUvAUy/nrtmmCvfC+1cV3NQfIqXwkTA9I9zJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792040653; x=1792645453;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+hZtNnO88jheorN8Tquxks5aLZ6/kk6r8yJtG2M+fW8=;
        b=2FzAS1ac7m9RnyUrE4cDyN6Ch6o0Csyl8Tz5JTNvu4SgYQBA43J3pRGGr92RATifXu
         nMJJ7/Bs32pxHPciyEbNkBdPSOgoHJnJ9JPiahWJe75ifJbmyxtgKj/LClha3I5bImRt
         tEZ4ElGzJVqlYVWrUkyBBXUG3yMjTLEpjjKSZNJi25L7FIY2iNNv7On43wGZ1ecIUEkG
         7W9WW5FwLd6dU2ez5wRdXISu2CxON0tVtcAkGasQ/vcn5x1qGVH2tUpCwV2uoGOtVsdX
         MCtV7k5TvEOY5z/Ia4JH8jPzp1n//73IANOGWHr3wHMYgQLL8T/xzVRRMuvOIsM4Ftu2
         pRfQ==
X-Gm-Message-State: AFq9FYIH3SEcVQ+Md454NFO5QlNIXsmwveXvCi+/uNeDIo1DPx+raUZs
	11HhmrqzV76HXr7ZVohERYay/FsW6Cdqy5HVzhfpQhA4CAmPnhCWY+yqtD3h0CO2uH7ic1X6kbg
	hs6r6Kgg=
X-Gm-Gg: AYBFou1NAQ6ktf1acD/FG5jtRY/oHyy/9JChGQYsJxrnOopk1NZ8vrS0+iBuXZrL/NQ
	m7z6dyXEGE1J0eGgHIlU775y0DRMnWKpsq7xxn+IQb5oBe3vTSG72/qSVwZiyAXXpNxcSFh3WoM
	j+u+pN/9qrNkoH8dVVCuwRFk22SQ0Ofw5XFCk7wdKAcw1zWImDGyJ/4INjrRACZxaeqJbrzhAAz
	5Z8UU/JU9KUHECIF4fJ87U21HBj/FFhaUyafh2/vKPUIuGG1y6lSpIYlU9UzloauEPX+W5Mt6L5
	r3GVgR546Fd7b6yqGtD42FNz9ZZfTHU592yZKokIew+N5ykC1he/IVcNqZwp5ShpdrGMvyODJGC
	TiGmTZANdH+hvM0wfgNkMtlimBLG7CEjz5I/zZ+bKMwbCBMwPKGB8HuTYZS9ent6i462/V68C3c
	zMiVc57Pua9TiMIFCFWJGCwyYJCKL/b5RNsULmFBte9NqUjXXrKuruKq3uMwMD8nXGn6r8Xsswb
	jAxJj/y5ZfbclmDE7uvHGRo2BR9BEsjBJ6bHo6Dwm6cpg+LdycDoBuuxPHoa2QWvXDdBSRf4I8n
	lFW7+nyR
X-Received: by 2002:a05:6000:3106:b0:488:8bc1:a2eb with SMTP id ffacd0b85a97d-48dca34316amr26638661f8f.39.1792040652584;
        Wed, 14 Oct 2026 22:04:12 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df758258fsm452195f8f.17.2026.10.14.22.04.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:04:12 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Patch review
Date: Thu, 15 Oct 2026 07:04:01 +0200
Message-ID: <cover.1792020468.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 05:04:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20341

Please review this set of changes for scarthgap and have comments back by
end of day Friday, October 16.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4934
* reproducible failed with #15898 – New sstate.yp.org CDN revealed partial sstate reproducibility tests false-positive error
  But the test warns about a missing sstate object from the reproducibleB
  build that is supposed to rebuild everything anyway, then, rebuilds the
  recipe. So, there is no issue with the series.

The following changes since commit d3b32587c2314febf96897f97e0172790b4fc1cf:

  toastergui/views: Replace os.system call with improved parameter handling (2026-09-28 22:25:53 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-review
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-review

for you to fetch changes up to 6b443060ee96a62efb94723c97f22b51c9b20507:

  prserv: commit new revisions when a request succeeds (2026-10-11 23:40:57 +0200)

----------------------------------------------------------------

Wadim Mueller (1):
  prserv: commit new revisions when a request succeeds

 lib/prserv/serv.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


