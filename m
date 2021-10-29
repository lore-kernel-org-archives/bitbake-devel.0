Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2AFC433EF
	for <webhook@archiver.kernel.org>; Fri, 29 Oct 2021 12:58:03 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web09.4867.1635512282183981038
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Oct 2021 05:58:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KTHbNSSD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id k7so15966184wrd.13
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Oct 2021 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1w84S3u41G7C9uJznF1XBbYms45o/y1IRCkIb5aRBCs=;
        b=KTHbNSSD18CjXT9Uu2Q0utDSPsWxfdHkwN8D0nEyPpUmnDJ71xPMrS5+jAiHwa6KAS
         O2nMxjj4FM7ISqG2PgCwXwZZ7bKTVoFqAgyPTb4m9hQwlAQMj6ApUINYugSjHYPO6gv7
         IT32ygjHA2tn3Ai5wUPBxMpZDEk5D3CR+/Rks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1w84S3u41G7C9uJznF1XBbYms45o/y1IRCkIb5aRBCs=;
        b=SV0WdawRYUNMRf56fznP8WRQHEQUa0BCv+2SmQ8TfS+4L9y3IweDVKWIWxxsGi7XSz
         BoVzaMt7ZWpb5HEBOs6JcoTw5ES0Oyfe87rS2vP2MWKKQpx0srZEBmVMUu+N3CDMC49e
         qJrgbWFc1UDIijJqUpHfngZyZd+mlkXBs/KjL16XtaHQ/A+E0sZKB36BjfhgKUSK6eHG
         GsVkn8kGsSMTSFsTYvSds4bb0YmG+bpbbSDYMCRrzAtH7c9XQQHPzsiGID+G1BYz+MEZ
         EX7/buvGv5oy5rRXqPKyn87wYtRBkOoiuI9gGqwzmXhOexwBZLDH7U3j1dnHElQCqu9m
         +JBg==
X-Gm-Message-State: AOAM530WDo0E8ukjnHIjb/6OfDq3MyqZMSt6hV9bqoouvMlPRg5uJWHe
	cVl2Sq+YHzAzHMXQLeX/b8tg4Di5XrhDyg==
X-Google-Smtp-Source: 
 ABdhPJzBZ07nAKrXJ7DNPYpnbNs2/xaoG6qH0Z3Z82dYccLl6Ipxg2nQWefAvrybLegiiTE4dk4w/g==
X-Received: by 2002:a05:6000:12d2:: with SMTP id
 l18mr1973151wrx.289.1635512280380;
        Fri, 29 Oct 2021 05:58:00 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:f597:af8e:ac:d124])
        by smtp.gmail.com with ESMTPSA id
 t15sm4886406wmi.24.2021.10.29.05.57.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:58:00 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/git: Add a warning asking users to set a branch in git
 urls
Date: Fri, 29 Oct 2021 13:57:59 +0100
Message-Id: <20211029125759.3422953-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Oct 2021 12:58:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12846

There is much uncertainty around what tools and hosting providers will
do about default git branch naming in the future. To help ensure we
can handle the various scenarios, we will make branch names required in
SRC_URI. To start that process, show users a warning if it isn't set.
This may also allow us to change the default at some point in the future.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 51b616bad7..17a7927e52 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -165,7 +165,10 @@ class Git(FetchMethod):
             ud.nocheckout = 1
   
         ud.unresolvedrev = {}
-        branches = ud.parm.get("branch", "master").split(',')
+        branches = ud.parm.get("branch", "").split(',')
+        if branches == [""]:
+            bb.warn("URL: %s does not have any branch set. The uncertainty around the default branch used by tools and repositories means we will soon require this in all git urls so please add it." % ud.url)
+            branches = ["master"]
         if len(branches) != len(ud.names):
             raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
 
-- 
2.32.0


