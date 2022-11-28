Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34BAC433FE
	for <webhook@archiver.kernel.org>; Mon, 28 Nov 2022 18:22:31 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.126126.1669659746166071338
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Nov 2022 10:22:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=B9wW/OTV;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.51, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f51.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so10935776pjj.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 10:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9QKvu2qULAvEMutkhcjOfJMmdU3PWR2iofWF1+5IlY=;
        b=B9wW/OTVOu7B+dsx2QkvEYtCXLcyNEaxc1DIgn9ha0HrfrTIbM74SNVv/q4OYQRjVx
         8jcKiFBEVD96+MiVO+V9pZRXwbi4LRt5bMTCeNSekq5IEbk88FqyRbP9Lpx86stNuZlk
         l+1vwnObJ7Bs2MIJvL1puzM2MmO+F4l1sEkp4XRucCnj67KCIdTxNBIe/mzZ0VkOCBlb
         KqggzWT1faySB4KaREh1rrvJDbKowxnJ00dtDc1B7FP7NEaqYjG45O9vLyITRbVqT+J0
         uHMW62WMl9IhxJbwG2KpofvtDbgVdZ4gbl80OUe+ocfUn6pnDdDbYhdaSQIv3MhWGcgJ
         rAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9QKvu2qULAvEMutkhcjOfJMmdU3PWR2iofWF1+5IlY=;
        b=kwRDC9KUCxSZx+Gva3zcGyCqBlSFy1hguU2Rx7uLH0mH2kX+VknIiXzXe7QBTEXrMP
         bYzfvynneTnOP4zBa1o9ied+ezw6GEjVpfdu3Y6pyEbHIzv3yRfQC3G9sfo5zPNYaO0R
         1icreLaGV+4dd+Feokh73JL4IQvYir2QUD7xcmy/V/dsLvM7mo+fRRF5y1a2HB9c68iY
         jVs/josOMt6Zwlne2GZmSEIlbix/eITHpc4ZS3MonQA/eBqGiyRvht710/vGnuWULIt+
         vJlM8fwrwhqkLx+xpkZxLHoxZRz2sZ+wYJnXg+ldRXyL+D306qaU3kNci1g2HJfGOlov
         cGoA==
X-Gm-Message-State: ANoB5pkyul6/Wi2J1jCILBNvbM4zFK5GpQnx8wu/kYODgHzN/by8clEu
	gvwzF3UOKNwK/I4UiV1KYrTVJRPY0XFPkE7O2Qc=
X-Google-Smtp-Source: AA0mqf46ZvohD4p7AcY7SXTGzOq2nw3FxT+Mn74StO9warxkGQ5xjIM6D/PlaH5lUY84xGpV/nPpTg==
X-Received: by 2002:a17:902:f646:b0:189:3eb7:1c86 with SMTP id m6-20020a170902f64600b001893eb71c86mr29437464plg.53.1669659744988;
        Mon, 28 Nov 2022 10:22:24 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id v6-20020a170902b7c600b00187197c4999sm9165791plz.167.2022.11.28.10.22.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:22:24 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Mon, 28 Nov 2022 08:22:20 -1000
Message-Id: <cover.1669659695.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 18:22:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14123

The following changes since commit 72a3afd99e8b785cb2a2f687e71a58e08cdd9c74:

  runqueue: Fix race issues around hash equivalence and sstate reuse (2022-11-22 09:21:04 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Pavel Zhukov (1):
  gitsm: Fix regression in gitsm submodule path parsing

 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1


