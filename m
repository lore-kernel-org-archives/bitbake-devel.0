Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7684CCD98DB
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:11:56 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45068.1781183509834505252
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 06:11:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=dzIqsPZJ;
 spf=pass (domain: smile.fr, ip: 209.85.221.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef1198766so578738f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781183508; x=1781788308; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNC//NHZAI5gNisy88SrA7x3BSB85BtBOZzunxXdwas=;
        b=dzIqsPZJVIJ/ywx2wdMOAH9m89wsKpjhvmMwxTmqI+vshDpOU7+Qg+gEMrnFXZysZp
         59nIzfxV4RHwboF1nHjr5ig8q2cTZZ76O+2c+0Wt+dMUeIhATqpWRl3F46rsIYeXbE6C
         Zz6WVAzaDkYGC/Cvn/cykGp8PxVTXNM8Agt0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183508; x=1781788308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KNC//NHZAI5gNisy88SrA7x3BSB85BtBOZzunxXdwas=;
        b=VkVTBSoYaTA3gwABmmpp+Mh29HoWWx/8duaxvTiO6J11v58t5t6V9VAUR0dD4yoI67
         BLgb0pmbyq0rDsqbevHIGStxsWSPki5q9ynvsf9WZWEoQMdwxq8r9TZJw7kT7riKnMwp
         y/XT6gt4AZY09LwyTIxU7jNZcz0eDA7uKPrFk19DcPvrQC4+4DWxC9bIMZ7hM3r6XazM
         8opE9Wy+r7YGzJ/cEevL54W2tUlFVUsqcdwVzsVZpZtgEvIeVoon5jcpmX5UeK8En9I8
         EIgO7YTea//OJ5fEGpERK3oA29j3taZQTTl7WJg/gr8ST/7KcpwK/f9TujSNdNM0L2b9
         gAvg==
X-Gm-Message-State: AOJu0YygDgWB+MHZvCRWg1FryJQkUrxdyniYxnAqRJC2tiNZ4RYrzwuA
	C5lBG0qrjT3sZKYr5QyFdezsetTw6G/4UenqqpvPialogpEa1a3Fni7QwalTR+Z6/9zdx+CS/nY
	xQ3Th
X-Gm-Gg: Acq92OFjgmsiD7LHHSqSumUMkDmXO9fgrp5xsZmaFG/D0XDqmufIG2DoPaYSXy58vDk
	4Wr9cts+ja2OnrWLUqV7yeHE9kQV3RkTYi3avkEOoUBjWD+HMFDyGik3JFY+onV8fgdCmW8qzMe
	0edxU8JPZYi4gWRcYt4ulBBiOcSIXwrTq+KEy1Fiu017gQj0fS+poM58rbdCYnRWDYqrS5uDUZO
	uWVC7kZjmPMlJLma1kOPwAWlxYOvF5reufaRiFzfD/4Jd7vycgUF0/FPdqI6ioYlnwHrG2bJ+cs
	BjRN3OsygtCtvlzZMiMAkfgM8IIh8jXspM7DsqwkADn/oIXHE9JYOWTBIvqhC6lXh2jKFQDwdpT
	v8UtpV2M2S6ldzhDIrOiftc96/FhBogrUMdFZABN/netCEjKjONwI+FacQxuh8ed7T13AXpTGsw
	quVrRJYUtZ+acivhppN+zUcYt63502YbOUO2ATpXo7StjMzNZ/BkJuuv3JsF6/c8KpA1wfTwrfL
	k3JUuVXG+4CpQkxRJUJMSJKrbjUv9rEhUYEYQM=
X-Received: by 2002:a05:6000:4910:b0:460:133f:2a4e with SMTP id ffacd0b85a97d-46067be8615mr3894718f8f.13.1781183508088;
        Thu, 11 Jun 2026 06:11:48 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0084744357c26c6744.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:8474:4357:c26c:6744])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm82048251f8f.28.2026.06.11.06.11.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:11:47 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH v2 3/8] layerindexlib: restapi.py: fix unbound variable
Date: Thu, 11 Jun 2026 15:11:25 +0200
Message-ID: <3235552aed757545a33db9cea5cfa23907f01673.1781183212.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781183212.git.yoann.congal@smile.fr>
References: <cover.1781183212.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 13:11:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19663

From: João Marcos Costa <joaomarcos.costa@bootlin.com>

If the requested branch(es) is not found, a debugging message is
displayed to list it, so the expected behavior is something like this:

$ bitbake-layers layerindex-fetch meta-firefox
NOTE: Starting bitbake server...
Loading https://layers.openembedded.org/layerindex/api/;branch=wrynose...
ERROR: Remote layer index ['https://layers.openembedded.org/layerindex/'] is empty for branches ['wrynose']

However, the variable currently used is unbound, and the error below
comes up:

File "/src/bitbake/lib/layerindexlib/restapi.py", line 216, in load_index_web
    logger.debug("No valid branches (%s) found at url %s." % (branch, url))
                                                          ^^^^^^
UnboundLocalError: cannot access local variable 'branch' where it is not associated with a value

Replace 'branch' by 'branches' to fix this.

Signed-off-by: João Marcos Costa <joaomarcos.costa@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit df3295f016a74a1414b8af5adb9f2a3967c365b6)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/layerindexlib/restapi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/layerindexlib/restapi.py b/lib/layerindexlib/restapi.py
index 81d99b02e..65405cb7e 100644
--- a/lib/layerindexlib/restapi.py
+++ b/lib/layerindexlib/restapi.py
@@ -213,7 +213,7 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
         pindex['branches'] = _get_json_response(index.apilinks['branches'] + filter,
                                                     username=up.username, password=up.password)
         if not pindex['branches']:
-            logger.debug("No valid branches (%s) found at url %s." % (branch, url))
+            logger.debug("No valid branches (%s) found at url %s." % (branches, url))
             return index
         index.add_raw_element("branches", layerindexlib.Branch, pindex['branches'])
 

