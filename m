Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B56C433F5
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:13 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web09.625.1652205971397246784
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=z/+NZjJz;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.44,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f44.google.com with SMTP id
 cx11-20020a17090afd8b00b001d9fe5965b3so2646079pjb.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CeeIF34ElbNLMddiQhn3rJ2qK3XhFwhoRw3IE6J4wDg=;
        b=z/+NZjJzQpfXVHSwSnayQUA7YlfZGESmEE10ku4mhvf5AY97G4BzZzBu8PmMoEIVJq
         S5mM3HguFAWEkjd9RNoaIEy/NqGMGSzLlsM6SZ60F/JX5MKeJ8FfOd8B7ISWZGfZS9vw
         uzBkch4jVkv/rqlExLdEJTXWthQkVwWVLk3a0dwdu8Ao6/RHnGQcKKzxuYW2Hko2BjTg
         0s190OJRtOhQ0qgVdfIP8NZSFrCYlFvOHvmshJvY9GPRcfbKpycUNDsamOyZjbzXIrK8
         229VzLtwy9K5AxbeVoAHbs80FCkEPPCfsOIcqy7vyJ0OYoulQMuTq+ljd1sX48aKIQZc
         DF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CeeIF34ElbNLMddiQhn3rJ2qK3XhFwhoRw3IE6J4wDg=;
        b=QAwGuS6kMCBdbi1IP/jMOwcWu5POGPtyf8JjSOjgiPr9XpOajiexghbFmtKlleiHKr
         l+vsXK9jZQyTL1EPTl8rXL3rh816kKkLxYtE+God0jppBfdlGawRU7WVIG4xPgP+bMsr
         RdVs2f8qdMBE5NOvku3rqGnG78u8OKwa/ojnE308rLoz0Yrgpq+rrxPjxhQyhgKspZpW
         P5N3dG6DWK+QjgJ6qZMwqQi72rqBU2NH/fAzkhTZBpqif3h0Q+jPo+ss/z3uCMkVPORY
         1NWNv5chcrE4LY9bvqPhYuN9VbUY3r9qd0iqZdi1AJlCUCbCpSvcEMWBb5RYB+ua5ePD
         wSeA==
X-Gm-Message-State: AOAM533O9FJaHZinYq/j/FVyNezIljIt6HoUPo7jRrDlg+6eiuNhLD9j
	ghSppuKPW0UD6wkLbjc4cPnEKeQ2prHB0K+D
X-Google-Smtp-Source: 
 ABdhPJzUtmbjC8Cmw9WHQECk7YVo6kPmiZKg7Jj/y9yeNRaa4bJqG8HXvRXqQU/lPNeX3RW5JuED2Q==
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id
 t23-20020a17090ae51700b001d75bbdf9f0mr1083308pjy.77.1652205970376;
        Tue, 10 May 2022 11:06:10 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:09 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 04/18] ui/buildinfohelper: Drop
 unused import
Date: Tue, 10 May 2022 08:05:29 -1000
Message-Id: 
 <f73fa10283321a5d4ea428835c9fff0868c1257c.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13684

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit aca0ff85109f4b0f3c201c02c3f59cad7ee2e787)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 0761f73b..9c4215f9 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -45,7 +45,7 @@ from pprint import pformat
 import logging
 from datetime import datetime, timedelta
 
-from django.db import transaction, connection
+from django.db import transaction
 
 
 # pylint: disable=invalid-name
-- 
2.25.1


