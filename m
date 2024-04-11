Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5C1CD128A
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 12:25:16 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.16497.1712838311905826692
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Apr 2024 05:25:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bMm57cR+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4155819f710so60867165e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Apr 2024 05:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712838310; x=1713443110; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y82SJUptf/2pWzk5rStmtqRArFqWlGi/ALSX18ASurw=;
        b=bMm57cR+OO10Hu0PjM7U05ZrRBQo0MCX7AFwyCwrKPSO8GoaLeCSdFI7ap8pKaj8HD
         2Z74c7nMvKUyTvvZqCF52iqmm395A6CBXtTLI/nZuybEIUbq+CzD4PQqD7rQ/uULB8Eq
         K+HDFcECGWjLL1IiNL6XoTNCD2/YjsqTluKiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712838310; x=1713443110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y82SJUptf/2pWzk5rStmtqRArFqWlGi/ALSX18ASurw=;
        b=aZZTwrXygZ80xs8J2vUNMzn+2yMKQ2OKWuyfol2uqVymTIMLjOFcwn/1o4QHq67AFi
         7jCmGmfIcR0jXsYviWP2D0QU1LwvwMtcH0paeXvNi+S4vULDw2EDKkMb5ntmbw7qSDt0
         hGl/38klV/+7jlq9JGTOYvXTuEmoC8c+TA6x6jaSyiSYh0EDSHdDFR1rglld8CHpmWKD
         cPpG9FGIx9Yiklb0Ofqr3TmBDabCtkb2Np6CXCJ7gFDspReZAi81DePIRi4aGIBNE44w
         VMO6+YPcXYEU0YyWw8xLOCoXD62OjKsMRABduU6abNnaKYUyvlTok+Ach5byqDVuGGge
         iNIg==
X-Gm-Message-State: AOJu0YwKj1YsMcXq9nPvPJmBXynOp03vGT5m/th/+Vp/Wkne4YIZ4SGj
	gz1t7H4sULZf3aOVljKolEtV6gaTx/LOHM4EwGUwP9WhNBQqy8VhfQFMbz9d8ILyTssEqWoYju7
	Upiw=
X-Google-Smtp-Source: AGHT+IEAqKjdPzYefKauMl056IxrIGSqvsUJ2Yr1QTtAy6o7RslyIh5ELUdL0EYMVtC9M3jHdodt5w==
X-Received: by 2002:a05:600c:a4b:b0:414:726:87d9 with SMTP id c11-20020a05600c0a4b00b00414072687d9mr5209542wmq.12.1712838309999;
        Thu, 11 Apr 2024 05:25:09 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1824:5b7d:2973:625e])
        by smtp.gmail.com with ESMTPSA id d4-20020adfc084000000b00343c1cd5aedsm1665889wrf.52.2024.04.11.05.25.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 05:25:09 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] doc/user-manual: Add BB_LOADFACTOR_MAX
Date: Thu, 11 Apr 2024 13:25:08 +0100
Message-Id: <20240411122508.2149106-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Apr 2024 12:25:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16070

Document BB_LOADFACTOR_MAX which was recently added.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../bitbake-user-manual-ref-variables.rst                | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index d3936935cd..00faeea686 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -432,6 +432,15 @@ overview of their function and contents.
       ``ConfigParsed`` event can set the variable to trigger the re-parse.
       You must be careful to avoid recursive loops with this functionality.
 
+   :term:`BB_LOADFACTOR_MAX`
+      Setting this to a value will cause bitbake to check the system load
+      average before executing new tasks. If the load average is above the
+      the number of CPUs multipled by this factor, no new task will be started
+      unless there is no task executing. A value of "1.5" has been found to
+      work reasonably. This is helpful for systems which don't have pressure
+      regulation enabled, which is more granular. Pressure values take
+      precedence over loadfactor.
+
    :term:`BB_LOGCONFIG`
       Specifies the name of a config file that contains the user logging
       configuration. See
-- 
2.40.1


