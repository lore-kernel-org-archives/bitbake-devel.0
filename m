Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97BCFF8848
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 21:02:35 +0000 (UTC)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32116.1777064547680335986
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Apr 2026 14:02:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=jfyE+QEv;
 spf=pass (domain: smile.fr, ip: 209.85.221.65, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43d572f7437so5429823f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Apr 2026 14:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1777064546; x=1777669346; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IH+yaaJWApW9bfTgYAxDbMs8aKOTC7g6E8lsWHFiwyU=;
        b=jfyE+QEvy5xn481Y9TwWFcamqRfwxgkFfDYODniCUjTeE8Ytjkdkxa086tDJtnxLh2
         QfVk6SQqwvbnVs3W68H2fe970panil/YVvsQXwhwUjT9qibOr3/YUHQLyP9YYmJVWHdC
         Or7CD+lX0hb2F+TaiRJCZQODARX6G7LzZE+Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064546; x=1777669346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH+yaaJWApW9bfTgYAxDbMs8aKOTC7g6E8lsWHFiwyU=;
        b=VBf6g61kBc4mW9ANxmG+/p97rq+BApNsW5cgqy/g57JFNFQslHr1hFiA7Kz6mYJd+9
         3Akn7pV6zT/7fYSDd0tBJuGgZveKmFiT7L5gUOvADgnkQccPlUR1exN5gAbmSWy3p16K
         0CFkpMpKA4L60NXyfCqSxbV6N8SqJcuwaVczT+42UDZLUkyVyut8YTzIC6QoZ5GEnuTU
         coMd/9Zr0u/PgdaqSrUDxuY4fiNSMveFr4JFRbwfMrrpk7qnils8Qle08oHzMHDOw6FS
         ydCMmjH8KloCIObhbV9uZHBjAkrToXM/I1Ym3QGpL3BfgTp0gbI+1LKpKIet8BIvXI9c
         QGag==
X-Gm-Message-State: AOJu0YxZszJwYDiCgYRVVWqGFBlhnGB49v6cZUuHdvUXaPIIuTn7y/mm
	vSFxl2ppdmVXp7hORk45hdwGMjYYMqusGkFATM9AJ9XKh+y+JIjhumn1H3AlYGJ8C110nCJvhiB
	4oJkLB5cNmnDb
X-Gm-Gg: AeBDiev+igMu1QwE47z2QLSxDZ+zmbe15IDiSkpZkBLN6UYwD3WGMP7z/sTMegORHRj
	xB9R6WodKfgNXMQ+ltNmDl8NwQ+/1ZXeXHYHi6PC21I9LRUtZVOtP9ZS+N1EwvlNpo/g0GyDN8C
	DSVnMXaFKsRTThzrTQu8HycTyT3yHUyUqYBIpMtj8/UlZl4HYMvbyBMSDJFD5+KTvRs1DBTAikI
	1SNZNCIqZyiFjpn0yKAxIWJkKOmtLxRAgWhd0t42GODMXEupZqn0BKFG1lQAb6vgkcGHp4eIAB1
	9lLyiW7L1ceNXDD4hBhLLxcclKXWPQXPypE5uPRCft2XnV5w+avrQ08we/CLBZBYOE5fuFBb7WU
	qTkD5teOKlHN1n7IGbiZrKrRIRbj+TsqtHIUkgN7pnzoEbJP4Va0fO/f034AYu2aauWc8emLxDn
	bDwFjRM/DTMvGA1oxuNxITgZA7x4bDa9RNc+QfEwKWMZmV4VWHIW9X130Gge7M9Yj8CF6XTPcTX
	E/wR2tFMJ1HnRNZB+NFYvA7MwBS/35twAzMKw==
X-Received: by 2002:a5d:5e01:0:b0:43d:c95c:5e75 with SMTP id ffacd0b85a97d-43fe3dbec67mr50111128f8f.4.1777064545522;
        Fri, 24 Apr 2026 14:02:25 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm58146548f8f.22.2026.04.24.14.02.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:02:25 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Patch review
Date: Fri, 24 Apr 2026 23:02:18 +0200
Message-ID: <cover.1777064423.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Apr 2026 21:02:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19390

Please review this set of changes for scarthgap and have comments back by
end of day Tuesday, April 28.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/3732
But got impacted by 2 intermittent failures:
* qemuarm64-ptest failed with a python3 ptest failure
  https://autobuilder.yoctoproject.org/valkyrie/?#/builders/61/builds/3558
  * I reported the (new) issue in:
    #16267 – [scarthgap] AB-INT PTEST: python3 failure (test_wrong_cert_tls13)
    https://bugzilla.yoctoproject.org/show_bug.cgi?id=16267
  * successfuly retried as https://autobuilder.yoctoproject.org/valkyrie/?#/builders/61/builds/3559
* oe-selftest-armhost failed to download Rust crates from crates.io in bitbake selftest
  https://autobuilder.yoctoproject.org/valkyrie/?#/builders/23/builds/3835
  * This bitbake commit did pass in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/23/builds/3814
  * This is a really recent issue (it also impacted the 6.0 release build)

The following changes since commit d3b4c352dd33fca90cd31649eda054b884478739:

  fetch2: Fix LFS object checkout in submodules (2026-03-19 00:14:50 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

for you to fetch changes up to c118575bc4f278bc857c532089e1c66ae81234f8:

  runqueue.py: make sure we use bb multiprocessing (2026-04-22 17:28:54 +0200)

----------------------------------------------------------------

Trevor Gamblin (1):
  runqueue.py: make sure we use bb multiprocessing

 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


