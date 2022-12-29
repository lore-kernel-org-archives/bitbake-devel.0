Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4397AC3DA79
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:33 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.208594.1672333652242653825
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ULaPH9Yh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id bk16so4692496wrb.11
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Md7Ue0aWVwT33UkuzMS9YuDNG+awksiyS1xbvOmLxE=;
        b=ULaPH9Yhq+A2GOo74nYQEzecbY4mrV6vfb4II0zwocEwkAOIbcc5lAzAKPf+YxiehU
         Ho7BFn1T6IRXQp805fkpwpW/lENj67ACtbywN27yOLU39dHEOiHNdtUnaZ7bzcX6o5Zf
         oQI7qu2opmKdaznFPf4vfAS2CffIL0XoRvtPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Md7Ue0aWVwT33UkuzMS9YuDNG+awksiyS1xbvOmLxE=;
        b=A2QyhFgo+rFVWNapMMy8szUeIjX8jpLskQGAT8b0qdYltuTHIwWlFgVy5ufMOnYzAx
         oPw5/GBQZZs7B99Bs7eAhXtpfPmoIzHcbs6xETlP3NVH6APsBn8ewHTIZ3XtJEwwwRvk
         5KDS4Te4YLsIBk04UDrY2rhTwKOa5soBALB/kNw+O6NVkqsDNlr0u8zA2RLHmgLznAuq
         ckufP72NcJyg8SK8tq3RvcdyQWZpQu2wAmyXRx5eCuO7bkcjaT19SkmQrEW8cPU6SvsN
         sgJwfT6o2KIYwHb7239RLZGa68w5vAIXGpBE4skpDff5R8YzGyEyjVYFvomkDY1v4EGK
         gsiQ==
X-Gm-Message-State: AFqh2koXbl7g8twPDgBOy3NO4X5l56nG93Jm6KloDnYPYRd6xq/AHUKD
	PTKltwLj95BbcgYGZ8IpJbPYT5/CXtC6aYH4
X-Google-Smtp-Source: AMrXdXsR76nl1/qY4loO4JDLrx2skCXLupHWfIn6dvoLBFANTnCATJ8qFYMBpkHnS1h0lj/C76PB7g==
X-Received: by 2002:a5d:4602:0:b0:277:ae6c:a939 with SMTP id t2-20020a5d4602000000b00277ae6ca939mr12279137wrq.21.1672333650264;
        Thu, 29 Dec 2022 09:07:30 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:29 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 00/15] Bitbake server thread enabling
Date: Thu, 29 Dec 2022 17:07:13 +0000
Message-Id: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14243

This series adds 'idle' thread support to bitbake. These changes have
struggled a bit in testing as we're trying to add threading support to
code which never had it originally. We've been aiming at this for
some time (over a decade) but have reached the point where we need to 
do it and deal with any issues arrising.

The 'idle' thread is badly named as it is where the "real work"
of bitbake gets done, e.g. runqueue (task execution) is run as an 
idle handler. We can worry about renaming things later, getting the
basic changes working is my concern right now.

The problem these changes solve:
  * allows the UI to tell if the server is alive and still there
    even when async commands are running
  * allows the UI to interrupt the server and tell it to shutdown
    (i.e. make Ctrl+C repsonsive from the UI)
  * allow us to make progress on the various "bitbake hanging" bugs
    we have where the UI can't connect

I believe the changes are at the point where they should be able to 
merge. The series is a bit messy as the changes build on each other
and there are various fixes for various pieces of code along the way.
I could try and separate them into a different order but they're 
intertwined and I think the current form shows the issues each change
addresses which would be lost if it were restructured.

There is much more work needed here and the code can be considerably
cleaned up to make it clearer and most accessible, those changes
can follow and build from this though.

Richard Purdie (15):
  command: Tweak finishAsyncCommand ordering to avoid races
  cooker: Ensure commands clean up any parser processes
  knotty: Ping the server/cooker periodically
  event: Add enable/disable heartbeat code
  server/process: Run idle commands in a separate idle thread
  server/process: Improve idle loop exit code
  process: Improve client disconnect/idle sync
  process: Improve async command execution with idle interaction
  knotty: Avoid looping with tracebacks
  event: Always use threadlock
  server/process: Improve exception logging
  cooker/cookerdata: Rework the way the datastores are reset
  cooker: Ensure we clean up active idle handlers
  cache: Drop reciever side counting for SiggenRecipeInfo
  server/process: Add debug to show which handlers are active

 lib/bb/cache.py               |  15 ++---
 lib/bb/command.py             |  27 ++++-----
 lib/bb/cooker.py              |  58 ++++++++++++--------
 lib/bb/cookerdata.py          |  31 +++++++----
 lib/bb/event.py               |  82 +++++++++++++++-------------
 lib/bb/server/process.py      | 100 ++++++++++++++++++++++++----------
 lib/bb/server/xmlrpcserver.py |   2 +-
 lib/bb/tests/event.py         |  17 +-----
 lib/bb/ui/knotty.py           |  16 ++++--
 9 files changed, 206 insertions(+), 142 deletions(-)

-- 
2.37.2


