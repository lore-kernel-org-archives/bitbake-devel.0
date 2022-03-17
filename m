Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E582C433EF
	for <webhook@archiver.kernel.org>; Thu, 17 Mar 2022 12:22:31 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.9376.1647519750409088964
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Mar 2022 05:22:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JoWw7ltW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id
 n31-20020a05600c3b9f00b003898fc06f1eso4854292wms.1
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Mar 2022 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/R6abOfYHmOqzXq6U7Kqbxfs/2200jQ/+3ebFvLGcVg=;
        b=JoWw7ltWhCBH5IIMco96qCPfzI9AvwPRMzRGNC0VycszmAw8xs5d8INreTCrF583Mk
         2gMkfsv0CnQSlqLZVdO1Drt9JwO68YgOtQwkERRO4pTjicrvZVX3SYnN6AvSNbKM+0L5
         wbpYRYNWVlKaQTUkod5KJUu4T60DplT8+WZ34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/R6abOfYHmOqzXq6U7Kqbxfs/2200jQ/+3ebFvLGcVg=;
        b=1j57CwrWfHRSxm7N4+eVv8tQTbtcafl3oFDC4Dez2D3gYT6qKYjXiGRiINiEQZcYAW
         w5vhC7N4dfLG54ToFjRRXT+NNqN9nCpu9IzJUUZwr/YWqjEffilLG7T3pJwC5kXHgjfI
         8qIGJf02R8+AJTufJsf7tp/kUhWWJVE6egI46aHjpvsfppPd5LAJvEqOIsDNmRiAueUj
         9efqaw0ZR/hlpI9H3aJXZNd8iL46nDX6qPneIAyKaM/I+6v/iA+MQ425sJTsjuEq5pn8
         hmqGa5XouItxuW6VOuOJD2ltgwfmEnEMr/qNcdlsHfhSQUXAkMGKG9tjzpsmW5ppF0uk
         8IDg==
X-Gm-Message-State: AOAM530UPHAosZg4lH90gpnGVm6KtwhWl143bK/kuFUXoc952pFhj4Wt
	9oGGcr025CBBkI8syA1u7DAi62o9LZlDq377
X-Google-Smtp-Source: 
 ABdhPJzbXg+J27+2W2wxuceMifzS4N6R0YxExsh14WwSmwZZ+bVbnMT1paDD422nAAj/bHWeP/oC6A==
X-Received: by 2002:a7b:c7ca:0:b0:38a:f22:701e with SMTP id
 z10-20020a7bc7ca000000b0038a0f22701emr3647949wmk.35.1647519748487;
        Thu, 17 Mar 2022 05:22:28 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:64d8:6f1c:d663:861])
        by smtp.gmail.com with ESMTPSA id
 i15-20020a5d584f000000b00203ded4f92esm6338248wrf.18.2022.03.17.05.22.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:22:27 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] data_smart: Avoid multiple getVarFlag calls
Date: Thu, 17 Mar 2022 12:22:24 +0000
Message-Id: <20220317122225.996597-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317122225.996597-1-richard.purdie@linuxfoundation.org>
References: <20220317122225.996597-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Mar 2022 12:22:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13484

We can call getVarFlags() instead of the multiple getVarFlag calls
which is a little more efficient. This reduces the number of overall
function calls so is good but probably isn't much faster (or slower).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index ca78d84133..dd20ca557e 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -673,10 +673,11 @@ class DataSmart(MutableMapping):
             self.varhistory.record(**loginfo)
             self.setVar(newkey, val, ignore=True, parsing=True)
 
-        for i in (__setvar_keyword__):
-            src = self.getVarFlag(key, i, False)
-            if src is None:
+        srcflags = self.getVarFlags(key, False, True) or {}
+        for i in srcflags:
+            if i not in (__setvar_keyword__):
                 continue
+            src = srcflags[i]
 
             dest = self.getVarFlag(newkey, i, False) or []
             dest.extend(src)
-- 
2.32.0


