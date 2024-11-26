Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FB0D66B82
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 22:18:35 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web11.59009.1732659514437012698
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Nov 2024 14:18:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UWbNyFIx;
 spf=pass (domain: gmail.com, ip: 209.85.167.172, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ea5e405870so674251b6e.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 26 Nov 2024 14:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732659513; x=1733264313; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u/ejljB5F0zQsIxxDZyUV2qFVBA7DkLLo2FLtavpGsU=;
        b=UWbNyFIxfIWrkLRlBvkctMZyON2FBVY4v/PMncSAbn0NNAivIbAh1+Z6R1rZxYg8qX
         k62kSLOcS/o6jvsn4XFVGily8P1kMN2Yps83GDkz0M6oz0sRFMw+J04lUnZNZ5Javi/6
         QrTng2x72btRuSFrqto2juirNAaHFw202lCJw7LVZFfNl7Lp5EJ4WBdC7Fku7v88dMJK
         N8lxMNISummopneIT+QBSOfMywZO6uJbeDpSe7uqOdxZkWlkW4gmvxZ6PM8ob0PxnDdf
         kdQImoxUHfPAZapX7wKra8vw5cBjjY8na75vuC8sUF6p2I9Csep/erahprsJWvTtLnPj
         SOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732659513; x=1733264313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/ejljB5F0zQsIxxDZyUV2qFVBA7DkLLo2FLtavpGsU=;
        b=H9xLykgceVI3xQCK0a/eIU/QjW+AVuNqwBFOpRRR/3aeUbT8BmEnpKmKFmQU12cFzk
         udX0a8XvKjRuX2hUO9frlIzQEGqSGIx/4+wTMaUM7B4IfOPve+G7moAhWc8kjX83JBP7
         3n5Tx33GE6YHGTGxy8l0opUWbxkl3fdtFn6vdekTMuM/2vQzjtmH8mnfdDnmv7LxHGmU
         O2LwlFm20ZspvWU0JByqi/VQn3OM0rkSkfV0jneWmYqcgRiHzn2bWRCH7GTDW4Yt14FJ
         ux6pqMnPJF92m1bo89pn8CH4R76KB/5fxeXUJEfjpv4egFJbkgQjIRNSDhRmgvIokh+6
         +kPg==
X-Gm-Message-State: AOJu0YxB+Rw80UoUIjlqEblnGvvtrJ6dpYyVqRlKEafvB91QQZh492hg
	VRzmq/dANeAx5y2zwxk5jXYFajrGQ1RiGMXKH/T5QoRBDKGNSiBPdc1PqQ==
X-Gm-Gg: ASbGnctkvw/2OBKGS3Pci71ZEkVv9X5J0VpB5SYMD2r5UrDgUY7UdbNq7mZCbwdP7U0
	FkqVDKjJdPL6FihZXC04BZ7DhsAHxtzW3sriSd3NJ5RdJS2SaqsVyzBvL8QUGX58K3NlaPO9BIP
	f51sfey4xAAXdF0uxc1rN+3+VF7PWFofatp7NuCuaZfm0nDm6UoueLmNKP0zWCbNfvzGurjWoBu
	Vz19h7jXpE++DOjxaXfiZtXDo2D5KlucZFINLULcODRe55k
X-Google-Smtp-Source: AGHT+IGYQxoRut8165gUtVlnNA6Ye+pQLzvJmp7nb7JFG71ofU4BhMtDSq5+dtDTdgaW/pnRJktfJQ==
X-Received: by 2002:a05:6808:f89:b0:3ea:6b09:da1c with SMTP id 5614622812f47-3ea6dd48830mr1057777b6e.31.1732659513123;
        Tue, 26 Nov 2024 14:18:33 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::dc1a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d5bdf568fsm776133a34.41.2024.11.26.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:18:32 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 0/2] Fix hash server passwords leaking in logs
Date: Tue, 26 Nov 2024 15:16:00 -0700
Message-ID: <20241126221829.2825101-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Nov 2024 22:18:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16838

bitbake prints out function arguments when an exception occurs to aid in
debugging. However, several places in the hash equivalence code that
pass a password as an argument which means that an exception in one of
these code paths would cause the password to be printed out in plain
text.

Fix this by implementing a mechanism that allows functions to opt out of
having their arguments printed in backtraces and set the flag for the
affected hash equivalence code.

Joshua Watt (2):
  exceptions: Add option to hide frame arguments in exceptions
  hashserv: Do not print passwords in exceptions

 bitbake/lib/bb/exceptions.py       | 24 +++++++++++-------------
 bitbake/lib/hashserv/__init__.py   |  6 ++++++
 bitbake/lib/hashserv/client.py     |  6 ++++++
 bitbake/lib/hashserv/server.py     |  2 ++
 bitbake/lib/hashserv/sqlalchemy.py |  2 ++
 5 files changed, 27 insertions(+), 13 deletions(-)

-- 
2.47.1


