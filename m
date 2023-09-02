Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DFCC71153
	for <webhook@archiver.kernel.org>; Sat,  2 Sep 2023 10:55:18 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.6053.1693652112295809789
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Sep 2023 03:55:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fUjrN2Hl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso28892465e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 02 Sep 2023 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693652110; x=1694256910; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hcS58x8Clo7j9aWIoIPnlIw/opeaZooNIM/o3XSfOM=;
        b=fUjrN2HlgfTZKORU5tLY/JqFlfLYky7P1otwNv1ZtStD1tzDGpqQRSGD1Pnh8N9wlR
         lX8qrX/Zvgf5KMcMOSVqIxbku73un655Tm9PdlvpBByUJ4AOHXb+2OaZ4ebtyyairLxl
         VkWtqhwkdhy3NwrPC920mzcSQ28Q8sGRQN7fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693652110; x=1694256910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hcS58x8Clo7j9aWIoIPnlIw/opeaZooNIM/o3XSfOM=;
        b=c+YK/m4+H0CxA1eQtVHemhxnMMCCAzJAR/QhOlbMW0juNf+eaE2vxQvbDsu3s9Orxj
         5CThXO3V20ZZH/4gcoYkOMdW25bKKr3DQ6ezRcbTVr0yUWZxAGwDrcARsJuNWED1spug
         gfEHGKFbcuHOM1y+IwTH1NoIGE+gZHKjW/i+NeeRT27kC1Ge4MwHVUqbyeVqLYOl9j0O
         WQ3FNrdoXgpU4fry+Oy9GVZkHJgDamBPDmQ744Yh2pR5TklXTxHwl8mKJYVJRWpnwtDD
         6XaYxBvPRQScYmtQsTY2iShGFjU7S5/PPlEsTmf/sVP57Exr5iximc0ZQTJlaA8RfSwk
         VayA==
X-Gm-Message-State: AOJu0YxrPAIdeucwRYCGdQaKq/ok+wVdu9kpAPC22XP4x4J9bjQp1eL6
	eDyrZztlQeJw+Ax1jB9JMZmMQfgLUWpkYP+ewmw=
X-Google-Smtp-Source: AGHT+IGvYeExIR8mkMzdPaGCYpy4vJz79WB6gVvh3b4QOvHZ/0N9wa3QhZOUhs38tirM+gIYJdMcIQ==
X-Received: by 2002:a05:600c:d6:b0:401:c52c:5ed8 with SMTP id u22-20020a05600c00d600b00401c52c5ed8mr3620423wmm.13.1693652109988;
        Sat, 02 Sep 2023 03:55:09 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bb30:48fe:2031:d024])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003fe1fe56202sm7573643wmi.33.2023.09.02.03.55.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 03:55:09 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] doc: Document challenges of tags with git fetcher
Date: Sat,  2 Sep 2023 11:55:08 +0100
Message-Id: <20230902105508.2444252-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 02 Sep 2023 10:55:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15004

Using tags with the git fetcher may cause surprising behaviour. There
are reasons for this, document them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f5723d6767..91538f4059 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -476,6 +476,13 @@ Here are some example URLs::
    easy to share metadata without removing passwords. SSH keys, ``~/.netrc``
    and ``~/.ssh/config`` files can be used as alternatives.
 
+Using tags with the git fetcher may cause surprising behaviour. Bitbake needs to
+resolve the tag to a specific revision and to do that, it has to connect to and use
+the upstream repository. This is because the revision tags point at can change and
+we've cases of this happening in well known public repositories. This can mean many
+more network connections than expected, source mirrors may be bypassed and recipes
+may reparsed when not expected. For these reasons, whilst the fetcher can support
+tags, we recommend being specific about revisions in recipes.
 
 .. _gitsm-fetcher:
 
-- 
2.39.2


