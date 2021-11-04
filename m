Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5148C433EF
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 13:58:52 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web08.11974.1636034331552068689
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 06:58:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PM/UcPRC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id d13so8772225wrf.11
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIWGx362MU6gayNUcpxU1Eew6v6G01iHgJAmnLgDuxg=;
        b=PM/UcPRCTkXFUSt/bSRcD5mmSen+yA8FdCA/vplpiJalCM4UQF49FnbHPd29D4ImGS
         rvtZSV6VooyoNKel9AY78xrIU628rg2eKuzSGcyDPvnWPf3fF1RrHzNzHtwVL5EKbnqw
         PmwodplQQn64jxIJ1WfQh0xNVaccPYHgid8K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIWGx362MU6gayNUcpxU1Eew6v6G01iHgJAmnLgDuxg=;
        b=WZMdNLf/PJ9tPs4ZLWCuHSQ9CXU8e6VG+x2kiTiYs2Q+wLExYULuX4jEfPJj2PQuCi
         NvYN31s5JAO+IobqlQfik0faZ9SAj5IZgXz3GA/9FO4GDHY0FmQogrF1uIpExLfX3Dwu
         cjgF5m+1vp9K65zgiMgVBQgKfXxVm/A73cD5lZrhLvmqw88pE/m47swq5Q+pU0x9Hqs7
         Ixvt+tSuUqGymJmWoIgMe6Ww2j4IgWqOG4bp/0ZDrTD0BGpfu05ZU4cDx+YekCLpv8wV
         4q4rj0wKBCPLZWQ3YHPPUpxgeu57PoeLkc/jkkQEAn77G0VHnQOQxuRGjob0KY7icrrb
         R5pg==
X-Gm-Message-State: AOAM53332kgoDR/l1nu6qSVkR5R37cPYCEZ1olS3kgrcpQqn4jNm5qgb
	g4GX7r8JHUVhhCn+brRzlH6gsz/YQwaXng==
X-Google-Smtp-Source: 
 ABdhPJwcpSBf5LSjTheW3SrW6XXQIMI2HEXwbZ/jIH9tKi1HKnW0plD7HIXVnMQ4tIeoPd0seC6fvQ==
X-Received: by 2002:adf:959a:: with SMTP id
 p26mr64022314wrp.342.1636034329757;
        Thu, 04 Nov 2021 06:58:49 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:2578:3d9c:c55b:5282])
        by smtp.gmail.com with ESMTPSA id
 u6sm4938885wmc.29.2021.11.04.06.58.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 06:58:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] parse/ast: Show errors for append/prepend/remove operators
 combined with +=/.=
Date: Thu,  4 Nov 2021 13:58:48 +0000
Message-Id: <20211104135848.3621936-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Nov 2021 13:58:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12877

Operations like XXX:append += "YYY" are almost always wrong and this
is a common mistake made in the metadata. Show warnings for these usages
with a view to making it a fatal error eventually.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 743ea0dfc0..93cbf285ef 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -130,6 +130,10 @@ class DataNode(AstNode):
         else:
             val = groupd["value"]
 
+        if ":append" in key or ":remove" in key or ":prepend" in key:
+            if op in ["append", "prepend", "postdot", "predot"]:
+                bb.warn(key + " " + groupd[op] + " is not a recommended operator combination, please replace it.")
+
         flag = None
         if 'flag' in groupd and groupd['flag'] is not None:
             flag = groupd['flag']
-- 
2.32.0


