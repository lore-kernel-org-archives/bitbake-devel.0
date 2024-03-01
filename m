Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26785C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 15:27:25 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.25913.1709306837956145611
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Mar 2024 07:27:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=TKq41x9f;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.171, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dcc7f4717fso21906085ad.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 Mar 2024 07:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1709306837; x=1709911637; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGB8xUvE7rlJlT8wUysfcRNk/0nPltQGuPfrUj0zEcY=;
        b=TKq41x9fW4L7C6vX/bMYTkJvuApIynqbGX3wWpl9FS9Pf5TwNmP68AguZxADOEHfot
         qMS+GoVlnTPkYEAZbXhgW17h7zWnsIgOx8LRE2hzehtUla3oEWdj5jTGxtSA1r4wuKfV
         v28FwoeGG5zYXroF3fG0Idyql+5LcOhTKxkruR6BCMeNZOgUjeLM/hhP4HTvZy5qNn/F
         b519wKcLS4gUrnsVNTBwaqXKFNfx9ztYsFDTbalcOgVApBlB7p0/wbiyO+3kvCuvBvwl
         oXI+mHibb6hfjiQaABiXkjmLSpGG19XU4RVomy/xHHuJ7zqIhfRQRMvtQHHMVmVxiqBx
         AW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306837; x=1709911637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGB8xUvE7rlJlT8wUysfcRNk/0nPltQGuPfrUj0zEcY=;
        b=vVgHXcatMuFwBTJiTmbNRZsEz2HGzr7yrfKUGg45UyN2vYEG8oZfn00XgRsdvhbmPS
         YBPVzPgQwx2kBr1itN2nzNRr4ChUXi73wX7pNXx8W+aNP2M6R4q3eJR8sxtURS17W8u+
         0vOML3zqW0SmuoJNk/MEywxI1vEzvD7xxab4RNEiAtki2qGVDiKSDwiX3STOH0Fzg958
         3eb9QBmzWusZlH2RLp1teVS/XNvxBmqwM5CeJHGzDK8CZ/azEOfXu7Yn8GGgg1TI4p7v
         ZnT38q34mkK+DfQVSro4rR4lvqcCgaqHVAwOxIbSIuGEC2W3ZNwvfIjeO59u1PEg7gdU
         XElw==
X-Gm-Message-State: AOJu0YyE43pZI0wM5ZKmasJF6pNV3FRn3LZF8A8623whGw11uQyo28sp
	nO7nAzsn7w6D20UJir52+mQb3iQcYjSiIywVFP+nOXJupJoFO2Pk5CiGkEWQkAIrWwUPC6V2eFS
	dcuQ=
X-Google-Smtp-Source: AGHT+IFB0RrHNFhDBRKi2bZvTyamH7HmuFgtuTfd3hVqFFh45lKzY9XhjFO1mmQ25R2UDP2drLS9uw==
X-Received: by 2002:a17:903:11c7:b0:1db:b8f9:ea69 with SMTP id q7-20020a17090311c700b001dbb8f9ea69mr2362645plh.34.1709306836990;
        Fri, 01 Mar 2024 07:27:16 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001db5bdd5e3asm3575905plg.84.2024.03.01.07.27.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:27:16 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/6] Pull request (cover letter only)
Date: Fri,  1 Mar 2024 05:27:12 -1000
Message-Id: <cover.1709306757.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Mar 2024 15:27:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15983

The following changes since commit a4c516ef5e72b2d77ac5ff7e86c5ee2190ebc42f:

  toaster/toastergui: Bug-fix verify given layer path only if import/add local layer (2024-02-06 10:10:20 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Adrian Freihofer (1):
  bitbake/lib/bs4/tests/test_tree.py: python 3.12 regex

Alexander Kanavin (1):
  bitbake/codeparser.py: address ast module deprecations in py 3.12

Chris Laplante (1):
  codeparser: replace deprecated ast.Str and 's'

Paulo Neves (2):
  tests/fetch: git-lfs restore _find_git_lfs
  tests/fetch: Add real git lfs tests and decorator

Philip Lorenz (1):
  fetch2: Ensure that git LFS objects are available

 lib/bb/codeparser.py       |  24 +++----
 lib/bb/fetch2/git.py       |  45 ++++++++++++-
 lib/bb/tests/fetch.py      | 135 +++++++++++++++++++++++++++++++------
 lib/bs4/tests/test_tree.py |   2 +-
 4 files changed, 171 insertions(+), 35 deletions(-)

-- 
2.34.1


