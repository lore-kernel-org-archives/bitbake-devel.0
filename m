Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC41CD98D2
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 22:53:29 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33442.1781132005256195692
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 15:53:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=OuQiz8oO;
 spf=pass (domain: smile.fr, ip: 209.85.128.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b12270b3so44003155e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781132004; x=1781736804; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNC//NHZAI5gNisy88SrA7x3BSB85BtBOZzunxXdwas=;
        b=OuQiz8oOyvkHNlwtyZWXYsQvNbDcVDm9Ol5C1Nv1u/M13tpFtAVKGL0WC4KKrZ2/R+
         Rf9f0J2K01XS3QOBOgRSmMnZyGmV9jVAoIRtnDDVdj4COmBq5t9xL4un4JK83ZmTb0VH
         hIiD4N9yJRS5Z6/eO8oWNp7syKqdJ0ks6uagY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132004; x=1781736804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KNC//NHZAI5gNisy88SrA7x3BSB85BtBOZzunxXdwas=;
        b=L1KqEw/opbX6RJLZPrzo5jakKCEseSwJViw3nKNf4XmPX7HgTzPzCQFMuRTMUUf9Mf
         sYWylg4tyf0N29JhS5Ikq/yazTEJb+qwAqde0jtnquUg/4aekv4obPriC5mb8U5dJirs
         jVoCCIDIGZTlmzPxmxsuwX+bWE/rIvv0J/W8IYq1+Hcla1wkMaIh2UBRIzmfNCfcmIvl
         qVh1rcxda0BsAlrdvQ7Oe++zjXJfwj/n73yFF7TmRL0G9HFNxkvs3QulH5/ioLjpyuZd
         uOJBwoxH/78sXwCm7W3uA81o9NQzrvDp4bCDjooEH8nbera/KkG1uIFNMa2aX3w4rbQm
         /m9Q==
X-Gm-Message-State: AOJu0YzUHH6bM/eQ74qxhYH8a7flRiwKsdVwRoIk9d7vsP+LjY0HrOKj
	0OD1Z+J5xuO4IEMA/uyHOM1cOZEt34xWAcI+OBIV2lECjEENhZ9SZ8zVTjHtjxzog4DNnlC4d1o
	wrW1S
X-Gm-Gg: Acq92OHrr/FwB3eKiah67t4jJ6hI69jfFvEd2SDKJDHItuYeNH79meCc6VjvqLlrh5/
	oAgiyfSq0GPba+F985ML4W1/i3fRzWz/DGnhvjuLnL5bX2YRTRPig8w898uzGO54uMoTbf41uy6
	g/icryiN2H9knI7ymvJ8ap2MmNTFfydeDyOk8qhTRWwC+YmwtxxDvdf4pUQir9x/vviyb9DICn9
	wyhZ/8p4JdJ0Ov+QrszfZto2cqg2J4IAxWNoEI+4eR9uK4tMM6PVeBCdgO5Dd/gXPZqQUSw6rBK
	FAdAAFuAmI+pvN92wS6BtugV85Qvzihr6a1As4qiEpIp6aPDtYiJsBZg30i5Twe+X0LkKpEYRvl
	dSmc8bxgEX1bswrVvcEXC3nXg97BOU95KL5FtOq0vQE2isGZGg6AmJ/mSihQpVHAyDSA10G738o
	d//Z6P4k1z61Zpxudi3LFe8igpHQbg6zjyAp2sdnN99G/F4VJ5/bVo4u2OwGfXc9hX+LmVMB+YV
	y3vb80azNrjP6bXLTF9k8DYHbK16sTqZb7bp/I=
X-Received: by 2002:a05:600c:c4b7:b0:490:b8c0:d46a with SMTP id 5b1f17b1804b1-490e2e45332mr9517125e9.22.1781132003603;
        Wed, 10 Jun 2026 15:53:23 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00bb749f54eeb85d7b.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:bb74:9f54:eeb8:5d7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm132348771f8f.29.2026.06.10.15.53.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:53:23 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 3/6] layerindexlib: restapi.py: fix unbound variable
Date: Thu, 11 Jun 2026 00:53:05 +0200
Message-ID: <3235552aed757545a33db9cea5cfa23907f01673.1781131922.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781131922.git.yoann.congal@smile.fr>
References: <cover.1781131922.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 22:53:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19650

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
 

