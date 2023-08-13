Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D88C001B0
	for <webhook@archiver.kernel.org>; Sun, 13 Aug 2023 09:29:35 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.82468.1691918975099552365
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Aug 2023 02:29:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=POXN3jHU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-317798b359aso2951618f8f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 13 Aug 2023 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691918973; x=1692523773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ItMKqdMOgw33ggodqciIAr3uZlY7JEQLnWIBwVjp5w=;
        b=POXN3jHUiSsgthwuwIDV1hdpgkL1sYGKEkcPpNxDxOfegTW5J4mJYscHAlhwHHPA4e
         IcgkgivxQkCa1tm/LGyw2mpd/ABJNbNF5BlgrVxYstdpingRg5DyxdjE2CnJ6CdOVJTz
         GznhCJa/8pkzLU5Z72MzoMLDe5GmEthZQMkzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691918973; x=1692523773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ItMKqdMOgw33ggodqciIAr3uZlY7JEQLnWIBwVjp5w=;
        b=DB477UDDEXooQlF29+TWZHv04tXUx8XfpwoGV5rCxheP0a0cAPhE0J6hHMeWyoyYuv
         zVcSbkaxb64RvJAaDTLr5vDeHgCt3vI7+1wgwIdNlI1aJtYzPYqyebZ5mlurPkHH7BHS
         Qz7omkwJjJopYsvEgzjMvt3a4uwK9dwT+Yhf+YbJoRGu2NS/dZq5eJY+ry6+wi4g1uUh
         Fi8h84+TqKkJoVdRU137M7KI+bidiDvTJEKR9ADRcqmrDyifAjIYuePAEvzmTP/niq3y
         kUpzUHWOE8Kdy1mUSUu2FUMyN+KknHl9mVKVOpstPYnhOhXAzIyk9Y5xkNUFOpOugDop
         hpUA==
X-Gm-Message-State: AOJu0Yy8Z8AgGqFCB+stgTUlrPwmFG97KSr6XY2jyDlwRYHk/mvqKZso
	Joxq8pl+zeD6Q6IELGHVlvgtypqSZFXn2MTxwFY=
X-Google-Smtp-Source: AGHT+IF/zq9KHISKKNCbB3NLnmufNLMJOiYG1sWY/Q8H1KClZOm4Pp0eqMSz3JY2ulahWlNmdK7zhQ==
X-Received: by 2002:a5d:538f:0:b0:319:7428:9caa with SMTP id d15-20020a5d538f000000b0031974289caamr544230wrv.38.1691918972780;
        Sun, 13 Aug 2023 02:29:32 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:17a:7286:2cf2:8a86])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d698d000000b003180027d67asm10922347wru.19.2023.08.13.02.29.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 02:29:32 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Fix indentation
Date: Sun, 13 Aug 2023 10:29:31 +0100
Message-Id: <20230813092931.129442-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 13 Aug 2023 09:29:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14938

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index d0a555654b..dcb1334e8d 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -418,7 +418,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         data['varvals'][task] = self.datacaches[mc].siggen_varvals[mcfn][task]
         for dep in self.datacaches[mc].siggen_taskdeps[mcfn][task]:
             if dep in self.basehash_ignore_vars:
-               continue
+                continue
             data['gendeps'][dep] = self.datacaches[mc].siggen_gendeps[mcfn][dep]
             data['varvals'][dep] = self.datacaches[mc].siggen_varvals[mcfn][dep]
 
-- 
2.39.2


