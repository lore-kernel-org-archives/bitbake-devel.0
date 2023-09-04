Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86601C83F33
	for <webhook@archiver.kernel.org>; Mon,  4 Sep 2023 09:24:12 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.44657.1693819448656406995
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Sep 2023 02:24:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YPvJfcS9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso11771705e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 04 Sep 2023 02:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693819447; x=1694424247; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFav0reqIgFu9+zRrdNT3CqMkzHEaL6qUVBHF7/P0cA=;
        b=YPvJfcS9YCNrcec926lntgVfJxapktQcVR3D3zsZYmTcPlpyoxgy3jLwZiucardiEq
         zIpvPylsETAydbptTAyLOuUubAAlA2tEhl9yHmBV63NzuUCP8c/TVevsJXRF9Pq1l0Bd
         +J9xIdA951F1SBFGfTWGgmBwqJeldUKxAJBO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693819447; x=1694424247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFav0reqIgFu9+zRrdNT3CqMkzHEaL6qUVBHF7/P0cA=;
        b=L4ZkzNd7OlvKr6rEQZPBvqVZyG7eKXwPcw2lXeeSKo+qYuTDXKMv2uWH6JVsqvuKCn
         zA9/rpoq0ZSGCEFGzYAgBIkeiaJASMoQUumgMqWqjcmvWe8cPn1ZWuDrAJ9A9unQsvQE
         vpvLCz6U/I9Oh2ogb0zPEV0oBuEg/7LirfhnVBFOnURpG8a2gWBH8BWwyG2tAT0ZB1SJ
         pDPyYw3kBKgNiFfWUZmOtrOR6/4u5D6QuktdFdIZP3EaBOIFV9k/dA9fnz3bRMtPOoS5
         RSYlg/0/mtltqXr0pkuNXjVKodtP9q4g1xi2t5HvSrHGZja8HLB0qc6pxgNeKyGiTtr5
         CFhA==
X-Gm-Message-State: AOJu0Yw9j2lQ1AHcxu4B6y6dQ7gty2hJoQ0S/DuBl9SVkTggw06yQRRX
	WlLAJ0A2TShGwX0wUa0/wqEcFpaVOjOan4mjFBg=
X-Google-Smtp-Source: AGHT+IE4/ib97cS2prfEFasqJh+vrPSOpBhVSLgw0tPSrDT0fONUGSrnOx7QvVTBUBymk/C5Rtx3Gw==
X-Received: by 2002:adf:eac8:0:b0:31a:dd55:e69c with SMTP id o8-20020adfeac8000000b0031add55e69cmr6142693wrn.60.1693819446604;
        Mon, 04 Sep 2023 02:24:06 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:29e1:34bc:352d:65c])
        by smtp.gmail.com with ESMTPSA id j14-20020adfe50e000000b0031c52e81490sm13943173wrm.72.2023.09.04.02.24.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 02:24:06 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] doc: Document challenges of tags with git fetcher
Date: Mon,  4 Sep 2023 10:24:05 +0100
Message-Id: <20230904092405.2671456-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Sep 2023 09:24:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15009

Using tags with the git fetcher may cause surprising behaviour. There
are reasons for this, document them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
v2 - add tweaks requested in review

 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f5723d6767..dc125509ff 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -476,6 +476,14 @@ Here are some example URLs::
    easy to share metadata without removing passwords. SSH keys, ``~/.netrc``
    and ``~/.ssh/config`` files can be used as alternatives.
 
+Using tags with the git fetcher may cause surprising behaviour. Bitbake needs to
+resolve the tag to a specific revision and to do that, it has to connect to and use
+the upstream repository. This is because the revision tags point at can change and
+we've seen cases of this happening in well known public repositories. This can mean
+many more network connections than expected and recipes may reparsed at every build.
+Source mirrors will also be bypassed as the upstream repository is the only source
+of truth to resolve the revision accurately. For these reasons, whilst the fetcher
+can support tags, we recommend being specific about revisions in recipes.
 
 .. _gitsm-fetcher:
 
-- 
2.39.2


