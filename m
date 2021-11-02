Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407FCC433EF
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 12:45:04 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.232.1635857103226155693
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 05:45:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=b12FUZ3R;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id s13so25960443wrb.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JcDu7Pvwty7y5zGJ28fDzIjSV+P1Kl9X7WwFf+BDO/A=;
        b=b12FUZ3Rh636fLorlfA6gAFV1KZRn0mH1uuA95iscf8XuQGsMKTixvpX/qv9gfXyzl
         kJphGHHvZray1AWj0FAgXrwq1sNRnxl5VVkswm3Ll+Brb+SUruFWLCFwj0dLSHHfyjHM
         A4sOQeCsXVW6RQN8x7/xzk+9UmnA/iyGV12HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JcDu7Pvwty7y5zGJ28fDzIjSV+P1Kl9X7WwFf+BDO/A=;
        b=lucntMqtxV9oFoYOJ9rwv3x7dKDeNpe97hKXD3tf8SU5vhVivyy0EKi5NFaBsZDSha
         HCrH1vLz3fEnF6km7i6PLS/j0eShq8SXjjtH1kTnz0nvMWLPLaEz8qYE4h84Tc0diZQI
         P5/AKE3SA10Avz0LqbAUeXhtvUlVtg09luCgGe149VlMmYRhC4W4v86f7baax6A3Yn/G
         tnoMPfDYqBTS9QXk5KyBiAoeR0o4wniS89hC8KdLPQ5rXN2DcKfcX9IG+4RZYlWi0eq7
         xsoAyM1iVi2vcszb62SuEuBrjPYyw8y8wkSSkUzfiwFIsGeRiDnd8WoL7N68CJfu7SqL
         hBKQ==
X-Gm-Message-State: AOAM530l4flG/TTL8u1vOvOquzrij9nuB3guQwxKN72j0SUhPjLtrSXx
	RCD5SYjSKLcvoS+aveiBW4y1Za6nhETzUg==
X-Google-Smtp-Source: 
 ABdhPJwJH0q7YRSbZHaPuTCpL961+0ecp1QI7B56wezMYAn9+fOoRRKWBmnaLPUTQuCzd090TxGAhA==
X-Received: by 2002:a5d:47c7:: with SMTP id o7mr12821990wrc.204.1635857101637;
        Tue, 02 Nov 2021 05:45:01 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:e05:60cd:475e:19f5])
        by smtp.gmail.com with ESMTPSA id
 b6sm19748349wrd.85.2021.11.02.05.45.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:45:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] fetch/git: Handle github dropping git:// support
Date: Tue,  2 Nov 2021 12:44:59 +0000
Message-Id: <20211102124500.3542952-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 12:45:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12856

github is dropping support for git procotol iun git urls. Add code to remap
this to https in a way that could be used in older bitbake versions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index e974445fbe..f5be24d6ab 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -142,6 +142,10 @@ class Git(FetchMethod):
             ud.proto = 'file'
         else:
             ud.proto = "git"
+        if ud.host == "github.com" and ud.proto == "git":
+            # github stopped supporting git protocol
+            # https://github.blog/2021-09-01-improving-git-protocol-security-github/#no-more-unauthenticated-git
+            ud.proto = "https"
 
         if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
             raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
-- 
2.32.0


