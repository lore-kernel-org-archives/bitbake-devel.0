Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F3C02192
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 14:29:10 +0000 (UTC)
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
 by mx.groups.io with SMTP id smtpd.web10.52709.1737988142416832420
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jan 2025 06:29:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=T6sVObiE;
 spf=pass (domain: gmail.com, ip: 209.85.166.196, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-3cf8f2c34a5so34069305ab.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 06:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737988141; x=1738592941; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F6AaYLlOvzvsck2pdF+Gg2P1Ch4hMsZvQGHgFgSgv+o=;
        b=T6sVObiE3S2tiQBNbYnO89EA2iq532Czz72vpM99vVpZEUqGx9zmxLOSF1PjIoLfpD
         e6TqC5jwewy0CxVoEqXW+y4LwnuIm/DtoureQmYFEiTWGEypzGJf5rtRsmS2h5AKrc/d
         0kvt1BKNo9cn2uWk6bImNrIx3ca+iEpjYGXA13exIO2kKUfvTBdQYhQ3ltUqgIm50/e/
         mzv9tQYoRfvPG8O32VgtjIMgNRsdWOQ2REJeZji6WgTHBOPbtrP89JcbrzegHcQ4WTod
         5+mrZzUoXOCqj0otUpmSPKP00sc25ohl6ZNL9jYWtKIe/SM+DYlkt82r7n6b2asy9rS1
         VvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737988141; x=1738592941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6AaYLlOvzvsck2pdF+Gg2P1Ch4hMsZvQGHgFgSgv+o=;
        b=k5Sr4doC/8eEqm4239PlWPGQEb7g5DiN57P3Xyoyx3zrJQzDKr21v/2ROr0lfIbmuF
         4AsiKDJVWPqrrrgk+l2NhCkKKWesFh6McDnwLc73ZPcheeOV2vT/5nV2wx2aF5cue+Fp
         SFgJmlGR9eAJMnllSCuvvPyyQvzCS5UHvRDMliT8UvGVTSk9J1ph+tVR6bPiAUQpjEUB
         2YCGWeEifC+jnCu/90YZecd5FJCdCSE5yxqWZhDX9xEgx5AUuY2rVxzNW0vayJ8TyOSN
         lBHlyL04cdSv0IJ9dOhkB2HAXieanIVgsLzZyub6mJEq/U10AskDmhtcAnjm6ZAwF6gi
         2KxQ==
X-Gm-Message-State: AOJu0YwHHpcq6ILaeRaV942P694feOeZiF9R3Trp6NMav2tpSftXYe1i
	ux5ofH4gewuJzjmlNIDMVo32If+lLb/Xlj7Z6Kp8wTbaO2/uJUBTWUTbCqh7sp4=
X-Gm-Gg: ASbGncsE6K7VL6W8T+9desmFG+JDf9Hvbrn3gJF9wedVZg7KQGKDDX4ogKpRS6JlgPA
	oAed1TYngrA2IZalp4nl9qrMNFSEqI1qGMHuGwusCldwL7E22H5a2+dRJCJx7WmUKSsKLqI1Cbj
	f5i9vwJ0sEcOnVLR2K/vWbPhH3XKebsrdBqDZmtGXP4pktyG/Irc2zWUHefSJE5JFhX2j/eh+Uj
	Ix03JX0b1J6upsMjA7Zi5Eb0PtthagjeUHUy1mnYyunSxCVBPGFQOiQOtFkWqe4DvbKCxqRNU1e
	3EIPAI6M2hau9X9L89Z9LWhn5CKbR0nxIVUOramv64t6NTBUdVgHyUNQyn/F9k09+Xz/NUeDVTv
	rkg==
X-Google-Smtp-Source: AGHT+IExJjbTUNvQOGaLSWY7hProc+OTFFVXayFWgp63hQMkguhRtT0bGUoQWjQ7/oo7Rw8/eUyCTw==
X-Received: by 2002:a05:6e02:17cf:b0:3cf:b365:dcf8 with SMTP id e9e14a558f8ab-3cfb365f155mr227415845ab.21.1737988141475;
        Mon, 27 Jan 2025 06:29:01 -0800 (PST)
Received: from 95d5ae3229ef.yourbase.domain.local (c-73-168-239-54.hsd1.il.comcast.net. [73.168.239.54])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cfc744be43sm26228645ab.33.2025.01.27.06.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:29:00 -0800 (PST)
From: eric.meyers15310@gmail.com
X-Google-Original-From: eric.meyers@arthrex.com
To: bitbake-devel@lists.openembedded.org
Cc: "eric.meyers@arthrex.com" <eric.meyers@arthrex.com>
Subject: [PATCH 0/3] NPM/NPM Shrinkwrap Basic Authentication Credential Support:
Date: Mon, 27 Jan 2025 14:29:15 +0000
Message-Id: <20250127142918.163-1-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 14:29:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17096

From: "eric.meyers@arthrex.com" <eric.meyers@arthrex.com>

Changes in this commit include:
- npm fetcher changes:
    - Add “username=”, “password=”, and “namespace=” parameters to “npm://” SRC_URI
        - These parameters will be used to create a “npmrc” file that is passed into the NpmEnvironment object - used for authentication when connecting to NPM registry
        - Username and password parameters will be forwarded along to wget fetcher after resolving the tarball_url in the npm view output.
- npmsw fetcher changes:
    - Add “username=”, “password=”, “basic_auth_registry=” parameters to “npmsw://” SRC_URI
        - For each registry specified in the shrinkwrap file, the fetcher will attempt to match the basic_auth_registry argument to the registry URL in the shrinkwrap, and if they match, then it will forward the username and password parameters along to the wget fetcher
- fetch test changes:
    - skimdb.npmjs.com was shut down, so switched alternate_registry test to arbitrarily use registry.yarnpkg.

Eric Meyers (3):
  fetch2/npm: Add basic auth credential support for npm fetcher
  fetch2/npmsw: Add basic auth credential support for npmsw fetcher
  tests/fetch: Switch to working npm registry for registry_alternate
    test

 lib/bb/fetch2/npm.py   | 64 +++++++++++++++++++++++++++++++++++++++++-
 lib/bb/fetch2/npmsw.py | 36 ++++++++++++++++++++++++
 lib/bb/tests/fetch.py  |  2 +-
 3 files changed, 100 insertions(+), 2 deletions(-)


