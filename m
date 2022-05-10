Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1756C433EF
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:33 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.602.1652205974213689466
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=tfsaHNku;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id c11so17414115plg.13
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aKbu0GvbKgFsdxb0O06GEBcfek2ATD+zAShT4dJgfHE=;
        b=tfsaHNkuqnIhUeAUtzTmVSt8HZfEp9/ubTHvthiHUYX7zRHyEHoYzKMQilVQlUnSsp
         UElpQa51+2oAtudxLoUStOKtFMu7oidOfIx2Y3ju/IL819+0gpP/xEMknjl1XPNrPyFx
         SpACa8fLV4ZEFXrXAhjBdJ/ghuYJGDnbvVgxonvwldzoPn7Hqo1HGbL0ABsO339rBs+W
         8Ru+lhiOgA6H4uegbnzwPPfQdWVyqnUJkUD45m2wUxRt4QI4pjK1yUq244SW3vCPCBCw
         j1c+oJk4YsAA7CuiHnxNSA5J5hcYKbwgflFHtLTnRSFspHwZtb3kSMmihBDOGBBRMw3a
         L2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKbu0GvbKgFsdxb0O06GEBcfek2ATD+zAShT4dJgfHE=;
        b=AcQTTqqHxlMXpYItp0kwCjhYwox8Ze2NQ96e+vTs3APx3l7aeeJmmD7vB/VD0zKwB6
         I+XFA71+gjJR1o+scM6FlaSFpxklmmhaFeeIkdlRGSv7J5LH6IOOIevqKlP6t0EjBmjW
         +Ae+2SH51k+iCpufyzJpPaYCAyp2KlwgdiCwEI+mjC46iiS5YvPKECS0JrlAbkWh09o7
         X2k3YiL2U4XUANA+3TCsC6NRWoyzoD2LnqAOg4sCNiIwGmfrrqt0Q5zq7js0w6SULHx9
         FTyy3PuuHx/Cuyi4ukObDVSUY+EBgQ3udsJMdEnpXqhzvLtjUrl0FoWqrO9xMG4ibfFv
         NNMA==
X-Gm-Message-State: AOAM532nOfxU7j3gPh2GTxV2SLyvtE2yfLxLupAm3Id6OQXAmo3+w1xH
	rj50dAx1v1SDHnIYiu5ZORz2C94dW95HyfV9
X-Google-Smtp-Source: 
 ABdhPJygC/mLF0skNHfe/b6mb8cfueRj3uEECekSFMSbyD5mQ7q8zeF8NrNqQnUydtVlisJHKZ6Nlg==
X-Received: by 2002:a17:90b:4f4c:b0:1dc:acba:9f3 with SMTP id
 pj12-20020a17090b4f4c00b001dcacba09f3mr1111732pjb.159.1652205989286;
        Tue, 10 May 2022 11:06:29 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:28 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 11/18] persist_data: Use a valid
 exception for missing implementation
Date: Tue, 10 May 2022 08:05:36 -1000
Message-Id: 
 <ed347c9a8147bac3860eadccd46ec1c72ecda50b.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13691

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7254eb6b3e8ef504ef2274541dcc55f1d42238c6)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/persist_data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index 9e20a837..ce84a158 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -208,7 +208,7 @@ class SQLTable(collections.abc.MutableMapping):
 
     def __lt__(self, other):
         if not isinstance(other, Mapping):
-            raise NotImplemented
+            raise NotImplementedError()
 
         return len(self) < len(other)
 
-- 
2.25.1


