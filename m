Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F015C4332F
	for <webhook@archiver.kernel.org>; Mon, 17 Oct 2022 13:20:43 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web09.40801.1666012833209973040
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Oct 2022 06:20:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=jwlzPSI3;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id z97so16001355ede.8
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Oct 2022 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IfAXKR6CTLEkytXXf4RE5dfkK101hRwnpBsoNlb+IVU=;
        b=jwlzPSI3sUllmHtuSefNUhdtH06Pe+wbd3yQu6wUXQe2pAf9CjbCRpeRDuq7o7WrwT
         DsyxjhOxykHjfZfm+hxeBSIGUx/4mDfCCsrDL5vASoh8U+zVxQ+vGUozWOQ/B+N9T+mv
         cbstbEyDUsf3EQhhNdWbpgoHzy9E4Zc8+eCu0dfUSVwEyx9qXzDOFPwfklkPGXHfri0k
         jsUS6TP2jmmSst5UIjtpIJZgl4wTuOLr9co2xhBRPB34K1XOocAy2Fxa5ab6ztNB10c8
         o8o4lMvvpeFpcD+ayGkolC6RiI/epOZEp3w6GHmnbn8axWQdrMlzfZNqDYLvail2sbWa
         wFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfAXKR6CTLEkytXXf4RE5dfkK101hRwnpBsoNlb+IVU=;
        b=sShQVOaNOhdJJMTNJo51k1TbMFmOpfQTNN8q3pUGecDgV3xjufJsuQoAPfUqL6x0FZ
         5/I8mVQziAIE3hY/ShbnHuy59I1AFcYwZGKXTPW4JYwbv1PnWCTkovI3n+jeJ2aNWq3F
         QQ55CFcBBoNCTmtYJDHlS3BlqA1Dfme6lOFobYYbNyzBRw80Gq2z9CTrr6m57AqX9q7X
         0gzB6MZjNXMlud6NUQBMBGYTnrb0qsglGjbeTZXIXePRNDAAwoZLUfsu120JZjhJJLGZ
         fGqPEW0LaGhZkj7AYi1QxTX0wBxIHNrVB/xlxWU9xRbucDLOMoTvxOv2QW//eyJsoYxV
         03Kw==
X-Gm-Message-State: ACrzQf2tpv/74rQVV/7LzklVTDsnwaitA0X1FUCE6UTB5dkiL65z+BHY
	kPaCjNkshyv3VUuX5aH9cxsKQ0gieI1WBg==
X-Google-Smtp-Source: AMsMyM4+PbBxdLPkZ9KQrljmGFpxt01qa0a5aQ9GbzozXlrVOxFFe5N53k9pzds6oi443YQRrzS7/w==
X-Received: by 2002:a05:6402:f94:b0:459:42d7:ea9a with SMTP id eh20-20020a0564020f9400b0045942d7ea9amr10016857edb.392.1666012831468;
        Mon, 17 Oct 2022 06:20:31 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id d2-20020a056402078200b00459091c44b3sm7423661edy.3.2022.10.17.06.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:20:31 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Subject: [PATCH] gitsm: pass lfs parameter from main repo to all its submodules
Date: Mon, 17 Oct 2022 15:20:26 +0200
Message-Id: <20221017132026.88753-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Oct 2022 13:20:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14037

* it might not be ideal in some cases where we might require LFS objects
  only in some of the submodules, but still better than no way to set
  lfs for submodules which causes git smudge issues in e.g. vulkan-samples
  when LFS is enabled in gitconfig

[YOCTO #14938]

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/gitsm.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 25d5db0e..36f0464c 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -122,6 +122,7 @@ class GitSM(Git):
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
             url += ";subpath=%s" % module
+            url += ";lfs=%s" % ud.parm.get("lfs", "1")
 
             ld = d.createCopy()
             # Not necessary to set SRC_URI, since we're passing the URI to
-- 
2.38.0


