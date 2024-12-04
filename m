Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAFEE7716D
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 20:41:56 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.25535.1733344897107234670
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 12:41:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=vnxdZt19;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215c4000c20so1779505ad.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 12:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1733344896; x=1733949696; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/+0Exdiq0bDUiJf7vX+LAKB5viQn3FSFjGNCs05470=;
        b=vnxdZt19uYj11ZHmVvLZdJ+GIAVCXcG+YkfEsbCDq2j6GJYR88wxBVTqWwgLeyaGK7
         aGc0sXwO7hqqRjw8CGeId5MvrgLP7Ak3FxHJoZ3a+oMZy2vBvrTURDHfAhabjzDSOWgO
         AcfnQRQdJnoyWDEhKFYkX/fyURFfcx6gRfBQVekzdjymMbXIr/44PTB1+St96xiZVnZA
         jaLVUPMDWocWFVAs8nCY7k3QzmXRPPp9KZ1NF4xL+PX5VSvrsBH3QewCcEptiO1Wb0N8
         3y6xb3Z54aCn5KbGdobVYxUbccFnDA6gjLYx9TrgNbSTooXnDvNIkJyPvINgKzN3NTs5
         a2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344896; x=1733949696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/+0Exdiq0bDUiJf7vX+LAKB5viQn3FSFjGNCs05470=;
        b=v9AiLDoxQyeB7M3wVCdqEMfb4FYQdR7NJjIS/d+DhIOP0sjzWjKSirfkpBIfKXF/xS
         A5mFuE3042UybKamSwYt7j7SIk7ePQPpuEnCkMHevhS635k2EtHN7HGxnydjothN2qWJ
         H5YM0GrxLSMeO9KLT2GAiJEvBHGWEsjryWojgqCQhgK+qIgvBIRF8vzdQIpSilexEa2/
         M1C8BocoddwFSsqWjVhfX80pMve7YGegZhozbLhcTwGmNOqJN8zSqmNdhq89FHZVYbfw
         nLTX/pVuedA0ibCswGiCx3mz4sXfSnV2xc3jtr8xQKS5/RyQPIR518sbo1TO+CdnQEJ+
         rZ4g==
X-Gm-Message-State: AOJu0YzBOOFA7Fd+ZPm7CPqpf4hdcCPnXeX3ANP8mRGUc2poxABTIRnz
	eZQLRVlwclKZEQVYrr+fvQTDQirTP4SebjeqWALHx5QAtx/nK21j0N9SHbTjhYwE9lENZjlwgfs
	T
X-Gm-Gg: ASbGnctz05IaVojJie3UCTjtntzl8aHhJT+nTo2rvs1AehDYHaskb2wTTbqB1Cpzk6U
	ek37lVe4IbwVRVJSTV1eN5G5iTVcEJ2EDboc/x9FVpYVgHh1Vg6SA+WKViDtLXZCU5opN7tKb/p
	D2vEALq/CWjNw3b2aR3hAwPQYZo/KYXYkIKUvhKT065ctuNLQCBh3om570ZnaTjg0Wldjqp9bGX
	gsmix/htimhGRbInxOxAaJsM1htvuLbMKSawTU=
X-Google-Smtp-Source: AGHT+IHVgknewq0eKmv7R5rqMZ8uKBnZNA3xlaJUHvn0p4J3ChSRv0RX+AKHrxQaZQYic6pd8fl0Vg==
X-Received: by 2002:a17:902:e743:b0:214:f87b:9dfb with SMTP id d9443c01a7336-215bd21460bmr112195545ad.30.1733344896426;
        Wed, 04 Dec 2024 12:41:36 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155abd92ecsm80057415ad.200.2024.12.04.12.41.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:41:36 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 0/3] Patch review
Date: Wed,  4 Dec 2024 12:41:24 -0800
Message-Id: <cover.1733344775.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 20:41:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16873

Please review this set of changes for styhead/2.10 and have comments back
by end of day Friday. December 6

Passed a-full on autobuilder:

https://valkyrie.yoctoproject.org/#/builders/29/builds/583

The following changes since commit 9602a684568910fd333ffce907fa020ad3661c26:

  fetch2: use persist_data context managers (2024-11-28 13:59:46 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.10-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.10-nut

Richard Purdie (3):
  runqueue: Fix performance of multiconfigs with large overlap
  runqueue: Optimise setscene loop processing
  runqueue: Fix scenetask processing performance issue

 lib/bb/runqueue.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.34.1


