Return-Path: <debrabander@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6906C4332F
	for <webhook@archiver.kernel.org>; Mon,  5 Dec 2022 18:13:26 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.23144.1670264002708563894
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Dec 2022 10:13:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=D54SDkdX;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: debrabander@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id b2so485386eja.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Dec 2022 10:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2elFf2jIUYh/3XqB6wn6ULsjEkKO8lxbKaZUCBuBmY=;
        b=D54SDkdX0Ewl/ORIlAmr75T5hSMkT4E00vZHzDEh4AS5GB6Ew5PYediTOzGYgFggpE
         /ChV7Af2rxzC9pU/Vnqekz6PWsKCWYZBxvbVYHycLrS3SCrrKXl8z4Kzl8MaPqYHBOg8
         GQdkF7F9ApHnZN3myGhhId64oFXeMppghbs1fLlEol2M/d5SSHqxJS9vflGlcf0DlTBa
         n4Uf5jO8zzXXeE0TEd0TWoTY8YTYs9Y7roD2xzw292sixhe2S0KQUEWzaP0fi5vdXlMv
         /AdDMXdX/IAAwtGzjTwVM69qansQpn+pS7ykOistHWZ+/pEoNxGutJn4PU1RQOYjGhG4
         wYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2elFf2jIUYh/3XqB6wn6ULsjEkKO8lxbKaZUCBuBmY=;
        b=QYjvnvkjVn8rxpOvVMuJ6I3Duq7grUsZp529HM1KVOhRDoY38T6dzoZHBlKVNHxwCm
         MmW+S+Obg/Ujk20Jr0lbEvJ3t62aWtQWrGwOdhg6qP/8NRjonE70UvGE1LiMDRwdG1X+
         LMFWAIu8pLr2X+1KJ9oEiUAemKshFdHMRUEd8kXEmz6BhgTbOZqq77dom2YV6z3PzspS
         HkApDoxDzOw2vNV7yV8ARuDGl2SPOCtiBpTV1fGBGjWYKTOvXYG5RuVoCZhc5QFQGnPg
         pE6t6XREhH2YDMBzuGAzqNH/KLsAP0+/oWpEVk6YTSuPg/bs1NqIRAkJ9KYQ/9siurF0
         jiSQ==
X-Gm-Message-State: ANoB5plTz0EWxMPl+zjp2TsEDD4msLuo958eAqJ5E1VaZ8I11PcZ9cTD
	FnLg96WO8rNGbbLNxt6BB9zJgdR0ELT/RA==
X-Google-Smtp-Source: AA0mqf4ksCuAPVxo5hYceLyAweRgj76MtemDrxp0QlDmNCQ1xS529JHY3KQZ6fWshB8OjF712sRxkw==
X-Received: by 2002:a17:907:1dd0:b0:7c0:9e28:e5eb with SMTP id og16-20020a1709071dd000b007c09e28e5ebmr20619381ejc.390.1670264001156;
        Mon, 05 Dec 2022 10:13:21 -0800 (PST)
Received: from polar.foobar.local (186-153-172-081.dynamic.caiway.nl. [81.172.153.186])
        by smtp.gmail.com with ESMTPSA id kx4-20020a170907774400b0079e11b8e891sm6446542ejc.125.2022.12.05.10.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 10:13:20 -0800 (PST)
From: Frank de Brabander <debrabander@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Frank de Brabander <debrabander@gmail.com>
Subject: [PATCH] README: improve explanation about running the testsuite
Date: Mon,  5 Dec 2022 19:13:08 +0100
Message-Id: <20221205181308.14562-1-debrabander@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Dec 2022 18:13:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14136

Explain how to run the testsuite clear enough so no external
documentation is required.

Signed-off-by: Frank de Brabander <debrabander@gmail.com>
---
 README | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 7b4a2b76..af23c9af 100644
--- a/README
+++ b/README
@@ -39,10 +39,21 @@ Source code:
 
     https://git.openembedded.org/bitbake/
 
-Testing:
+Testing
+-------
 
 Bitbake has a testsuite located in lib/bb/tests/ whichs aim to try and prevent regressions.
 You can run this with "bitbake-selftest". In particular the fetcher is well covered since
 it has so many corner cases. The datastore has many tests too. Testing with the testsuite is
 recommended before submitting patches, particularly to the fetcher and datastore. We also
 appreciate new test cases and may require them for more obscure issues.
+
+To run the tests "zstd" and "git" must be installed. Git must be correctly configured, in
+particular the user.email and user.name values must be set.
+
+The assumption is made that this testsuite is run from an initialized OpenEmbedded build
+environment (i.e. `source oe-init-build-env` is used). If this is not the case, run the
+testsuite as follows:
+
+    export PATH=$(pwd)/bin:$PATH
+    bin/bitbake-selftest
-- 
2.20.1


