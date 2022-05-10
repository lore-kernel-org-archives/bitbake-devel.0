Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D6CC433EF
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:43 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.614.1652205993340569441
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=UZtb5WVv;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.53,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f53.google.com with SMTP id
 a15-20020a17090ad80f00b001dc2e23ad84so2640237pjv.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MUTfbQBVdwP0MUzP0QYHspmFyqMeTnWUzIbo98ngA7o=;
        b=UZtb5WVvKus+LKpOt/BRgeI3pPnTcOEV0c7iDDh8ckynksAijkpa1Napg/ocxcmMCy
         c8M2tLsF//s3dlJ1AvxTfW81Q+6B0KEbGFA4zd6l5W0fIbjz/xckVrVnNCE6IzwG3HDc
         2lulLTaoS79J9J93PnxZj3L3httw7PZz9v2RAeLtdJmrOmNLdvYhk3EVUacUhLogkv8O
         CmRjai55CgUXQ85fIWDoW6p9m0270omJdvUME1w9r4Hm5BQPRXrTqOwV22Sba+sA6Tv9
         ZvG34FkpNxhUUzhb0GPJKiyYW6ibeX3k0/bdUjc8e7sYdRD8TkTKN25HieyEF2MDf+fF
         E4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUTfbQBVdwP0MUzP0QYHspmFyqMeTnWUzIbo98ngA7o=;
        b=o7gPqrJuzrPGum0OhRjYu2kF/pkfQUXmenugm62riYP06K9jivQh/tmWRO9vq1conj
         syyvZMNaZcjsEyIO7zOKvQS3flM7dVSh0QmrjkVHC9kJg2ILAI3gV5LMrHdb0GEVpJBc
         xqBK8Ec46jNTcY5r3TZhzxMjFvOdpZxyLbVS8YI1GQnItLxOMcLmwLtlNpO1PTYbym01
         /EhvboPXn0WdoPIobdw+Iq/Z0bp227cqQHckphpB19vkzGxIdmHT8uWTGmC0J+abHIOC
         a+hHJ4jHUHHP9LaxFhWzKC98YyBCJmSv+SurZf5UNPhV3qEcoGlBw3R+D1isONg0mP5b
         B7tw==
X-Gm-Message-State: AOAM531N8rOAAFTV6rnweHM12DqgIRpQJOuZE2IBBrhODFY26pXVydna
	W5FPiPqWGc9D8E6ZRpfKSPoK7PqhJLNfPJpM
X-Google-Smtp-Source: 
 ABdhPJyjBCWPLozkrgY8LVVQcbjJOfsGhZoXtbSzvs+mbE9Lw2VyTvxSKZmdtX0VSiClPKuf/e7cZw==
X-Received: by 2002:a17:903:244f:b0:15e:bb9a:3aa9 with SMTP id
 l15-20020a170903244f00b0015ebb9a3aa9mr21494571pls.78.1652205992247;
        Tue, 10 May 2022 11:06:32 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:31 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 12/18] runqueue: Drop pointless
 variable assignment
Date: Tue, 10 May 2022 08:05:37 -1000
Message-Id: 
 <190c61d94a54b5eaecfc850640c91f1360ff3543.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13692

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This is set at the start of the loop anyway so it does nothing. Drop
the pointless code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e6a3173c9cdf349ccbd4cf612868f92cce8717c8)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a7a84630..a4e82f37 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2664,7 +2664,6 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
             sq_revdeps_squash[point] = set()
             if point in rqdata.runq_setscene_tids:
                 sq_revdeps_squash[point] = tasks
-                tasks = set()
                 continue
             for dep in rqdata.runtaskentries[point].depends:
                 if point in sq_revdeps[dep]:
-- 
2.25.1


