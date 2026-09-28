Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0941CA5FA5
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 12:51:11 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.56689.1790599863295799033
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 05:51:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=bmyXo6BB;
 spf=pass (domain: snapchat.com, ip: 74.125.225.140, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so16744505e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790599861; x=1791204661; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pfEotD/hLYGf4BmE+RB89RKI/Rff7eblDHetRVyoDr0=;
        b=bmyXo6BBMCozK4Moe2IS7HBeKpi0u3W1nI8kygWRK0hWrLIERp+7WolwCt5t2kHhnS
         KiMQyFI+JiiBq6gQthhISz+e2v3Y2vk7T+duH+O4OoLzs0S+q7kofVliO7SO4iEyFdfy
         rM7OhegLU4DiXQN7Wr+eKG+b5uzwvVMCqY+Y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790599861; x=1791204661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pfEotD/hLYGf4BmE+RB89RKI/Rff7eblDHetRVyoDr0=;
        b=xovSK8OH8bfZlav7rS7tFT2oGhEzs59RemkejvXT8ZlwjWO4vjavFWB3n1eNMoFUg9
         WHkrvy97RtYOkFJI1VD38dfTLWyryS00su8X7JvjVix8Or6jMxfnTw6Cwgb5dILD0M2B
         eKQQ8SYpCPl1kzXKddovREDEBEDuFSH/oCV6bTDoKiJjerIemq3gB1ZYfCZk8rSCAsuS
         LH4EEV49ggCvP8juZ/vtLd6VkdUfWvSWCEzu/l9ecGUw63HpaDLXLp54BAF3ELjwjN6g
         3kW9Fta9LbPOqulxPZ5S+DH6CNzpSnrk7g+ogLpz9HaryD3g50yEh0eZh8FqCiM3Aoot
         Pcrg==
X-Gm-Message-State: AFuF++nbCSC+3nfhW3ILoZyz7ytv+F1webe5sx8r/NrgGbPjbtJgn35v
	zGD7lf/dI/vzKKMbm586ko9sQpcfzxle0c5tK4c+ESY371HN7iqXffRkk3Gse7juLz+Su4dZLyX
	/KUy+7WA=
X-Gm-Gg: AYBFou2XyvA+cJIzSTmPiYhAXxd44M0gb2/gpTndJ/4iZmVE8FD+9evqTx3DkBM9TEQ
	m8NzqZvGjz629JlA4h9GGHClo29kP8Y7s+U3YdNzYqkMRFNz+7+08Hjszn6bRHbiC8kBb1MI6JD
	NVEDfJK98RtmzvhKUl2AI81s1s1WkhC0tmYmvrcUVuvwfjeasa52ScjF2+d3BlhkOdb12GQCtFL
	dKubl6/QXdXuk/UEe/zniuMEr5Okdzhe/tr5IItnHdbGXf7+bxEfl0phe9sWLur+tsyF43SrW/g
	UIL81v6EpXZj+j9ol262flNd4sMIOwfU7hUqBDNdiCENXBpKKGy/BfZCF4v2f+ovMTq3QX5vF4p
	UHV7NDPjl4WXInEBLj36tPKtDox651szxKZ61gSuzDmMUj3vmd/pkOyiF4AcVvCH0+IyHhhu35z
	MGB/Z7T3Y0Ri5CMq5FyTTXisePWH/hvUgPgysXf0N12egRYugvcmX6PCu+gUhWgVCZHxkOy2lpE
	+559dBqBkkcJTyYEhP68nX0y9ime3+7DUOxntY1hQ==
X-Received: by 2002:a05:600c:4703:b0:49c:fc6e:a3e1 with SMTP id 5b1f17b1804b1-49fe66fd374mr219519565e9.32.1790599861428;
        Mon, 28 Sep 2026 05:51:01 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a007fd1a01sm37041925e9.0.2026.09.28.05.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 05:51:00 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH v2 0/2] fetch/wget: Reuse the checkstatus() urllib opener
Date: Mon, 28 Sep 2026 14:50:49 +0200
Message-ID: <20260928125051.2483039-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 12:51:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20271

From: Etienne Cordonnier <ecordonnier@snap.com>

This is the v2 of the patch originally sent as "fetch/wget: Reuse the checkstatus() urllib opener".
The patch has been split in 2 individual patches, as requested in the code review.
The sum of the changes in the 2 patches is bytes-identical to the original patch.

Etienne Cordonnier (2):
  fetch/wget: Have checkstatus() capture connection_cache, not fetch
  fetch/wget: Reuse the checkstatus() urllib opener

 lib/bb/fetch/__init__.py |  2 ++
 lib/bb/fetch/wget.py     | 45 ++++++++++++++++++++++++----------------
 2 files changed, 29 insertions(+), 18 deletions(-)

-- 
2.43.0


