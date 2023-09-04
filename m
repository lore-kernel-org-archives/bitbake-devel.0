Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A36C71153
	for <webhook@archiver.kernel.org>; Mon,  4 Sep 2023 10:00:22 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.45025.1693821621597058595
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Sep 2023 03:00:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PmnBWVwC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-313e742a787so760065f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 04 Sep 2023 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693821620; x=1694426420; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBu8T1UegsOWKIu99AkRcCucZ6YqkqyAU3uDYcGkHds=;
        b=PmnBWVwCVuoT6sEip3pzlt5HwA87U4wE2Wrow/HKS8uI9UI1pNNnxLJmdqAu9mSbt4
         gtOGf4OMcidh0ufgNZqtrA/lHUAsFLPHnwb507QhDFZIdwtTIEM1MtQAfM3nCsBb6qtm
         R6R/7RGtQd/Wk+FIHmmuOqUmq6kPL6+5kdBOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693821620; x=1694426420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBu8T1UegsOWKIu99AkRcCucZ6YqkqyAU3uDYcGkHds=;
        b=JWjvtpRB/bWZ0L/X+/0CXlb8WqxHaGdm1BJtdz4ZOmtf2AKukmu2nYdrwJP59g1DtY
         slL8qZa1LhMZWAmlvMiTOpHEcM7UqQLuzP2tBZ1jTJRpr7cVOVWnb9WKvRQhm8x8wyKT
         /saQqXl/2+OIzl9GBX+ocEOWNz/kSe29sPh5iD/SkUkOoirLfVXbYSkP/sASCNYgx4vv
         h9pPeGxl0lx0YZ75IsZTWy6cOR0oY4sAJsgTUjdht7WLuYqZyFliaey12uXz1pjYyKs5
         eSbjYO9+nGn5jO6Lt/OYzGd4LW0d+d5+fsb39BuIeGKTc+xYSyspZWrNyffxNnP2n7w/
         4qAg==
X-Gm-Message-State: AOJu0Yw7TN6d+QGoSU5F7AXfr3P8Ty6haJo8eSaneKunVHBHgJclI3lW
	4cwXD/2JmAU+a+5hdtCUw5EBvkPovewGAoXOwTw=
X-Google-Smtp-Source: AGHT+IFLxgm/c4c9RbNZJSUi05vS6mRGaiBUHmBZ7xlpeSfRjQIvicd8NdQGqdykTMD5mUXmXe29iw==
X-Received: by 2002:a5d:6708:0:b0:314:3369:df57 with SMTP id o8-20020a5d6708000000b003143369df57mr9345675wru.5.1693821619444;
        Mon, 04 Sep 2023 03:00:19 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:29e1:34bc:352d:65c])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d6351000000b0030fd03e3d25sm14240761wrw.75.2023.09.04.03.00.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 03:00:18 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] doc: Document challenges of tags with git fetcher
Date: Mon,  4 Sep 2023 11:00:18 +0100
Message-Id: <20230904100018.2677165-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Sep 2023 10:00:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15011

Using tags with the git fetcher may cause surprising behaviour. There
are reasons for this, document them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f5723d6767..c905288c48 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -476,6 +476,14 @@ Here are some example URLs::
    easy to share metadata without removing passwords. SSH keys, ``~/.netrc``
    and ``~/.ssh/config`` files can be used as alternatives.
 
+Using tags with the git fetcher may cause surprising behaviour. Bitbake needs to
+resolve the tag to a specific revision and to do that, it has to connect to and use
+the upstream repository. This is because the revision the tags point at can change and
+we've seen cases of this happening in well known public repositories. This can mean
+many more network connections than expected and recipes may be reparsed at every build.
+Source mirrors will also be bypassed as the upstream repository is the only source
+of truth to resolve the revision accurately. For these reasons, whilst the fetcher
+can support tags, we recommend being specific about revisions in recipes.
 
 .. _gitsm-fetcher:
 
-- 
2.39.2


