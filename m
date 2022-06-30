Return-Path: <gen.iorio92@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BFCC433EF
	for <webhook@archiver.kernel.org>; Thu, 30 Jun 2022 17:25:12 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web09.28367.1656609905453434317
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jun 2022 10:25:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=gGtG96+m;
 spf=pass (domain: gmail.com, ip: 209.85.208.46,
 mailfrom: gen.iorio92@gmail.com)
Received: by mail-ed1-f46.google.com with SMTP id c13so27460458eds.10
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jun 2022 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsDJ3CFOQsB+GPEiQF7PxO4gY8ZQeQtKqLMWKlghOWw=;
        b=gGtG96+mvLM3Z3z5qfZ/rGR1+vE6wLAax1WxLF+l4J/GQd1CpA+ivHuMDqD94qxQ03
         SZc3kxmGkd1Sw5bNhdjLTRl4cIc+K/6j6N4MtvjUyyKCLuoahfx5KJJR0XGqmEcJVuHu
         lRDw9V/oMCWL3Y/7G/J5aq4h6IBl/xDAE9fRp3mIP31Z3FbiQ2vgA/lB67M/dcCbCjin
         TfmexU4tITYWUdq9Vq4EANiiuIXwHI0VdRpOeiyR2GRKeorREKrZYS/ym20PDyBIbfhK
         jrGpb3P/yGve2zgMKjBhO6/yserLLXbM0Vxkd8Xlq/AquqfDIsGjd5OOlcf5stB1PBRi
         9cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsDJ3CFOQsB+GPEiQF7PxO4gY8ZQeQtKqLMWKlghOWw=;
        b=l7o/tgM4WYvyomt8wXtsntwAg6MvDRlJhKH7iQyEnXTvWeUeC+WQ7W/dXQwm3nOQTR
         gC6SRatBT/ERZeKZX5caNJLN5kDXim8iY6arq6z0ORGEczUjysai2aOP7NwzOX+G5Kwy
         yhWBZRbF4FqoEyel51bcrSlSM5CLmsRu1qeuNqa95Rx3NhteySQ/hcgOg03P+2HmjKQy
         jLFnRG5nglnYr4jo/1ONcM9NqzXm3oKrIjk5ovk04/RdL1m1OcJVMDqCIi0LIHmpk5VD
         AO2d3L1uoD/aTGba+LNHM1iLVaOD66vtBw4Jo6/1+yXSqUi09n8MLeuTkjAkUk9t1+PD
         ZQsw==
X-Gm-Message-State: AJIora+DOETJZyrAVUa+Q4caK1kvJ93+dReDpCMzP+JNW2/DDcZlEasG
	f67tXxVGxCCuHcg0JrNyDc5VoCWeBe76
X-Google-Smtp-Source: 
 AGRyM1tyMKOU9tWlUN89Ke9d26XQSzQwkGWO+DlAf1xGMsz9j5x5nJwSEwbWqfQhMwLBbQ6CGaJqug==
X-Received: by 2002:a05:6402:908:b0:434:f9d9:3b18 with SMTP id
 g8-20020a056402090800b00434f9d93b18mr13229861edz.37.1656609903577;
        Thu, 30 Jun 2022 10:25:03 -0700 (PDT)
Received: from localhost.localdomain ([185.178.95.241])
        by smtp.gmail.com with ESMTPSA id
 k25-20020a170906971900b00724e6a55d1asm9233543ejx.197.2022.06.30.10.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:25:03 -0700 (PDT)
From: Gennaro Iorio <gen.iorio92@gmail.com>
X-Google-Original-From: Gennaro Iorio <gennaro.iorio@schindler.com>
To: bitbake-devel@lists.openembedded.org
Cc: gennaro.iorio@schindler.com
Subject: [PATCH] bitbake: fetch2: gitsm: fix incorrect handling of git
 submodule relative urls
Date: Thu, 30 Jun 2022 19:24:55 +0200
Message-Id: <20220630172455.3893-1-gennaro.iorio@schindler.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jun 2022 17:25:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13793

As specified by git submodule manual relative urls can start either
with '..' or './', second case was incorrectly managed leading to an
interpretation of urls starting with './' as absoulte urls.

Signed-off-by: Gennaro Iorio <gennaro.iorio@schindler.com>
---
 bitbake/lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index e7083001da..a307e55194 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -88,7 +88,7 @@ class GitSM(Git):
                 subrevision[m] = module_hash.split()[2]
 
                 # Convert relative to absolute uri based on parent uri
-                if uris[m].startswith('..'):
+                if  uris[m].startswith('..') or uris[m].startswith('./'):
                     newud = copy.copy(ud)
                     newud.path = os.path.realpath(os.path.join(newud.path, uris[m]))
                     uris[m] = Git._get_repo_url(self, newud)
-- 
2.25.1


