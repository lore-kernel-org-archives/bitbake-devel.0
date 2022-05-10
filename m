Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33EDC4332F
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:33 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web12.676.1652205979333931980
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=ORN44P7C;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.180,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f180.google.com with SMTP id 204so12786675pfx.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l9mvRF+fYmbAFx4Hjsju3wAPx2UNNTLXahEp3b0m8GE=;
        b=ORN44P7CpGl0gy8PxRha+8xhDMpE58pd1E2FJV5EDrO9YYH26cyanuREkMKrZX1Z6U
         qDp9e3t/obCixFy/gjb0K36YFS3+ZuO94T2AzlawBGIf9eAKBjygOarbLcwNS44bJ2oo
         BZQjeDQycQBLuqq5kjgjqZglF251tgv8IEUhgowp8UilowU8pQwCRVgskJhx+N1ZoD7C
         F/3NuPSNuVR03db71AQajUAlk/WYa6de9o9DmiIgDvr8nSFsQRbnsR6fqurJLvTBxbwM
         epEaKU4Hk+uraFYju8oAes+tMZ1dkdMQYlSb7+kNCI3sMLqdM4QOz+lTVTiz/N2irqVj
         CUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9mvRF+fYmbAFx4Hjsju3wAPx2UNNTLXahEp3b0m8GE=;
        b=OOkv5tG221AwgQuDqfuJ5PidUtR58qJSRwfU1WC8MhAEXbvwT0wtbGHLXUo96hJrt9
         TUOCngN6k7UxAzEaKD/I+YNKQBL4wi45EWgw53gzjx35ecszFqewIQoWACGiXFC8xedz
         RQId8zfk941dMv/cnnzFYWSph3tdN30IdhLQAjY5kV2uti0+CkoUvaM81AtAdC+3eouC
         chxERsINw+T+NoqMkIhXfjl7eH7uwW9YV42W+9Iq2TAZKkN62+MGpqnWeKlvrFYKEitw
         KDeSRovkeYl3MjKVUNVVFgyrwj4komlHxtKff7Es/4sDSxBmlOMGHoEYFWBMfpN/10Yn
         JbfA==
X-Gm-Message-State: AOAM530Ze09Ilwg77AtbqqSGbNZzH4I38mJ0nf73ddlXU9voPPM3Tvw4
	KaLYOV2hcGAdU2L0uk/4gMEyLkwF9uEINwMk
X-Google-Smtp-Source: 
 ABdhPJz/WXgkZBdeLPlBp1VmRa52rEkWAEli3KAFhFycm1XQ6J8j9Dj/z12PgE4UozAqMe+eyCR/ig==
X-Received: by 2002:a65:62c3:0:b0:3c6:12b1:1177 with SMTP id
 m3-20020a6562c3000000b003c612b11177mr17612759pgv.597.1652205983826;
        Tue, 10 May 2022 11:06:23 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:23 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 09/18] siggen: Drop pointless break
 statement
Date: Tue, 10 May 2022 08:05:34 -1000
Message-Id: 
 <8f6d2339ed4578986fdf7a13ebd278df041067b9.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13689

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 42809f6acb79e39042e81d54c28efb92b7481e44)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/siggen.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 130b38d8..9fa568f6 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -40,7 +40,6 @@ def init(d):
     for sg in siggens:
         if desired == sg.name:
             return sg(d)
-            break
     else:
         logger.error("Invalid signature generator '%s', using default 'noop'\n"
                      "Available generators: %s", desired,
-- 
2.25.1


