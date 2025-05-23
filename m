Return-Path: <robbinvandamme@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5946BC54ED0
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 11:49:30 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.46300.1748000968993449935
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 May 2025 04:49:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h73QBZja;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: robbinvandamme@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so112026125e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 May 2025 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748000967; x=1748605767; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNKQlVJk8cjkhVZhDzakuWDR3RfTDUzQ2kfERcH3q84=;
        b=h73QBZjaf5tbY/C1zPUA5peaa1My9fApABduyAq2aozprNWdmH0XPSv0Bd8L4fPqKq
         W56KwT9UUcC5GnthyqqWls8sLo2PiFNYvnhN8rCmhewoHefp5RdplC6rP73LAN+dCALC
         UvOloxEm3980gkE9e0CDY9jpj4HdZR07iozRsihrVGR9YODya3MMvanF9bSqxqF0hRRD
         aoVvmeF1EtQ3zteen0PAsHm2boZlm3ShYcUXfi49qtgUeoKE2jIUrogn8HNasbQ/vv9G
         tadJP9uZFZdvMKlz/ZbM2ec9ionvM5Es85J+d7TXSZ5ykY+328l1tc9IkNDID9F8VbhB
         NkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748000967; x=1748605767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNKQlVJk8cjkhVZhDzakuWDR3RfTDUzQ2kfERcH3q84=;
        b=GSY/l/GGg99fDmnyyfi/jQbS3ErWPkOnB6f9uwOeitUm3MSavcqPFMPsMiDH1RgolQ
         HV5bJG+NgqIROIveCHyyoU8tpnn99qMmAtyD5PF+bekVGsZKqYgYgd4WmrbBIgKoLaO+
         L/HUkVqvHB8ME8svp4FHLPKMd42+GsMQrzqGpECWA4R+Ef+PsvV8Eej9mX6iY7JxrhtU
         d7bB3vxhF64f5Q9MuhmwA7sggQb6cpE5jjdpdy+t4VvSaCYwDv6TgCSaQIvqWUQQ0SMh
         GJxPUJeE8g1PGrRkRmVjp0E/BHGXek70jfhsjav99s4Ctp1vwf+15L2wIi1D78BdRhvB
         60WA==
X-Gm-Message-State: AOJu0YwHjQHgoDz4I7T4Qri0EtCKPJ+gUlgVS5GeUwJH5L3BFpOIT8nh
	yXFPp1taNTtIgcbDLtgjbrKgg6rlrdIOgnAKqWDXCwQ6EN7P2fjeYllEJmHuhg==
X-Gm-Gg: ASbGncstX20bKY6cNOJflKGO7Lj9ZDYxKSxDv27Lcop2m8w8fBOJK3MVYRAe3EQUvCD
	iTJT2zeR7zDKZhXCAdtY/jgQAn0c8/d9FgV0qmU6+43Xffa7Y07FzQ6wOuEuWOCf9usyWw2kN9w
	nMQkiEQwnPLBN0nV/vazpm8cXTQtis9uB3QPimeDwyzsvFttd+kvBqL2xkeOU4sIt3cqAx5bh/6
	3VrNxLf7MvlbDaKx1NMKieMuSIC4TT8rC3HUvJmAfy3z9lOT5YSFogc1Cd6mzwnfZ9szhXrqGeH
	Asq9FgBiQQCW0EVi37UKOKRF8J6jlMc4GUEgZUK3Tj0UbMcLHaRx1dO1il1ySc+HevVdCgsFIyI
	Tz2+3P9vq0ghp9JtSUpyH+8mpkqc=
X-Google-Smtp-Source: AGHT+IGUL1v7cRF8O0kPxVp6sxy5KxmkPjr82lEwqy07UM292Op7eg5U8Upp3StHEKAHzr6jeLjFRQ==
X-Received: by 2002:a05:600c:3e08:b0:441:ac58:eb31 with SMTP id 5b1f17b1804b1-44b6e7634bfmr20471195e9.20.1748000967112;
        Fri, 23 May 2025 04:49:27 -0700 (PDT)
Received: from PC-G502T14.localdomain (78-20-31-164.access.telenet.be. [78.20.31.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0ab8sm136591845e9.13.2025.05.23.04.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 04:49:26 -0700 (PDT)
From: Robbin Van Damme <robbinvandamme@gmail.com>
X-Google-Original-From: Robbin Van Damme <robbin.vandamme@renson.be>
To: bitbake-devel@lists.openembedded.org
Cc: Robbin Van Damme <robbin.vandamme@renson.be>
Subject: [PATCH] Add ? to mark the start of the AZ_SAS query parameters
Date: Fri, 23 May 2025 13:49:23 +0200
Message-ID: <20250523114923.2206133-1-robbin.vandamme@renson.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 May 2025 11:49:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17632

---
 lib/bb/fetch2/az.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
index 346124a8b..327273379 100644
--- a/lib/bb/fetch2/az.py
+++ b/lib/bb/fetch2/az.py
@@ -36,7 +36,7 @@ class Az(Wget):
 
         az_sas = d.getVar('AZ_SAS')
         if az_sas and az_sas not in ud.url:
-            ud.url += az_sas
+            ud.url += f'?{az_sas}'
 
         return Wget.checkstatus(self, fetch, ud, d, try_again)
 
@@ -62,7 +62,7 @@ class Az(Wget):
         az_sas = d.getVar('AZ_SAS')
 
         if az_sas:
-            azuri = '%s%s%s%s' % ('https://', ud.host, ud.path, az_sas)
+            azuri = '%s%s%s?%s' % ('https://', ud.host, ud.path, az_sas)
         else:
             azuri = '%s%s%s' % ('https://', ud.host, ud.path)
 
-- 
2.43.0


