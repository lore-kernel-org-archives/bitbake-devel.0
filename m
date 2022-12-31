Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75102C4332F
	for <webhook@archiver.kernel.org>; Sat, 31 Dec 2022 16:59:02 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.45722.1672505932876185926
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 31 Dec 2022 08:58:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e37URGcs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id ja17so17512726wmb.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFl5FAdh2WnhMA0pZys+QDqkAiBAfGn7IY+3TA6sIKU=;
        b=e37URGcs/BV22O+BKSnTkD4j1W4Rqc6qoW4zmujRXVOZPTMx3jmNC024bULRBet48M
         KJ7oxVUHHzGOxk+j8NWc4H1WNoePaH507QxXXI21IS/GesngR9WIs4vcsEGkJd3ciNm6
         1iNjaSax38UtnOih54m7g89v/BFhub7VydMg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFl5FAdh2WnhMA0pZys+QDqkAiBAfGn7IY+3TA6sIKU=;
        b=46J444oeYGboRpaoxgaMwqtbjwgD6zn6jC1/fVl99779MGkj2Mlg9R0POh2YS6Tdcg
         TAlWM2myE1800COqe4MTpQDK2quR1/SIwaRQ+eZ/SPxxmDoMEZ7XvHOndc7lliPEN0Kw
         GLKZNd1CGMjv4s1WfM8SwviXW1HQldLVepAiK2FjJv9o87JAmauBtOsKIbHDE840ver0
         tczLq9lqY2SU2sezENu1KpxSYX/S1eMy+wSGO5ROXtbz5HhUrIXKBXwE1ESMG2bloHUM
         TloIrNK9NyORkTcv42OKVJKiAvmL5fpmtf+GxwIX+oydZhFYj1p9o45SJfA4COI7yE94
         +MDg==
X-Gm-Message-State: AFqh2kqf8S/UThb5blkBDJb9IL2lpAa70TFUavo0zmsGY9CzYPGwNVzg
	CRoe+QEHAP/FPgvETnTocQoIXvgAZxKBcw1j
X-Google-Smtp-Source: AMrXdXtm+jReVqTF9++64wwMUrCu4rbB6AAt80gy2YIQg41oZh5gSNkt7VrbVjuSiMTkrje2JWleSA==
X-Received: by 2002:a05:600c:3ac8:b0:3d3:4ae6:a71b with SMTP id d8-20020a05600c3ac800b003d34ae6a71bmr25655975wms.2.1672505930815;
        Sat, 31 Dec 2022 08:58:50 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a1f:74ee:21ca:3bb])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm36582812wmq.42.2022.12.31.08.58.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:58:50 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 00/11 v2] Bitbake server thread enabling
Date: Sat, 31 Dec 2022 16:58:38 +0000
Message-Id: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 16:59:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14261

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

There is much more work needed here and the code can be considerably
cleaned up to make it clearer and most accessible, those changes
can follow and build from this though.

Thanks to Joshua Watt for some tweaks to improve the code.

v2 changes the threading event into a condition and cleans up
some locking on the idle functions. As part of the changes it made
sense to reorderand clean up the series. One part of the previous
series was merged to try and fix issues being seen with master.

Richard Purdie (11):
  knotty: Avoid looping with tracebacks
  event: Add enable/disable heartbeat code
  cooker/cookerdata: Rework the way the datastores are reset
  server/process: Improve exception and idle function logging
  command: Tweak finishAsyncCommand ordering to avoid races
  cooker: Ensure commands clean up any parser processes
  server/process: Improve idle loop exit code
  event: Always use threadlock
  server/process: Add locking around idle functions accesses
  server/process: Run idle commands in a separate idle thread
  knotty: Ping the server/cooker periodically

 lib/bb/command.py             |  26 ++++----
 lib/bb/cooker.py              |  58 +++++++++++-------
 lib/bb/cookerdata.py          |  31 ++++++----
 lib/bb/event.py               |  82 +++++++++++++------------
 lib/bb/server/process.py      | 111 +++++++++++++++++++++++++---------
 lib/bb/server/xmlrpcserver.py |   2 +-
 lib/bb/tests/event.py         |  17 +-----
 lib/bb/ui/knotty.py           |  16 +++--
 8 files changed, 207 insertions(+), 136 deletions(-)

-- 
2.37.2


