Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF17C433EF
	for <webhook@archiver.kernel.org>; Sun, 26 Sep 2021 13:33:42 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.18680.1632663221290998346
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Sep 2021 06:33:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L6fb+dCJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id d21so43344092wra.12
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Sep 2021 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yV/CjFf6HumLluuSl6PIVGRMLgKiLxkMd8jICmwsK3M=;
        b=L6fb+dCJHCbnLT4uJV+q8IxDc7NqbbSC6TDK5BOec1Cb80mKUNIsUo/Znv//3w3nPJ
         8RiwrfOa1sRk0UZ+5kM3cdAQ3Byo0LCo1ja5wWJsFdG0+O2G/LonQlqHCJxgFwuBxq9D
         5UGf7fgKiAi60DJcE2U4wSmX+seX3e1tuwl88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yV/CjFf6HumLluuSl6PIVGRMLgKiLxkMd8jICmwsK3M=;
        b=otw+8Vj+LJg8Hib+8Fd5FqZ42bHrrZyati//AXVjW/fOAM+LXOYkmxWZB0SOIhnaAf
         isIM06sYxU/uHhkCurufqFsPgfyqUiVF+dn7CqLyarwDr/1OHdYWOihW1Kh7yfQGevY5
         LE4v+0v26YWORPOdd6bDft3ORK6+QOLSdaCh7xqpHHZMny6qb/L9YSifIxM5dWqVHF0t
         ajXDQ1ek/TSN17TqV4CxQLe3S9Q1b29b5Y5fCw01Qb9RfIda4Q7GeqFzNJn5ec+yZ+K3
         ZNcsBC6Tyyy8raGy2HCgiq3Dw2dv1YHyyEkW57nkOh7S1IATEzRNeOhEjuTZPQvti2YG
         1/vA==
X-Gm-Message-State: AOAM530jhIvdTETrd4uA4BczBP9+v4Kj38gxZVnBotVbQiEflGur6MSI
	tSMN13Lqps1hHnPyueeXdq9rprvWEnzM3uVe
X-Google-Smtp-Source: 
 ABdhPJxfLS0gYgWKGCPyuFUSB6A2MsKCfEdFB7QDdYrZhsW0nc70Kwt7HsiUnUGTwtoKEx0F11o9rw==
X-Received: by 2002:adf:b19e:: with SMTP id
 q30mr21775335wra.116.1632663219799;
        Sun, 26 Sep 2021 06:33:39 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:ea95:6e9a:b58c:3d3e])
        by smtp.gmail.com with ESMTPSA id
 o3sm14534162wra.52.2021.09.26.06.33.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 06:33:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] cooker/command: Add a dummy event for tinfoil testing
Date: Sun, 26 Sep 2021 14:33:38 +0100
Message-Id: <20210926133338.2011130-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926133338.2011130-1-richard.purdie@linuxfoundation.org>
References: <20210926133338.2011130-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Sep 2021 13:33:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12708

We need a command genetating an event to test through the tinfoil API. The
current test has IO load issues so add a dummy version which won't have
the IO constraints.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 10 ++++++++++
 lib/bb/cooker.py  |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index a81dcb1366..ec86885220 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -667,6 +667,16 @@ class CommandsAsync:
         command.finishAsyncCommand()
     findFilesMatchingInDir.needcache = False
 
+    def testCookerCommandEvent(self, command, params):
+        """
+        Dummy command used by OEQA selftest to test tinfoil without IO
+        """
+        pattern = params[0]
+
+        command.cooker.testCookerCommandEvent(pattern)
+        command.finishAsyncCommand()
+    testCookerCommandEvent.needcache = False
+
     def findConfigFilePath(self, command, params):
         """
         Find the path of the requested configuration file
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1f55d9ad73..af794b4c42 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1068,6 +1068,11 @@ class BBCooker:
         if matches:
             bb.event.fire(bb.event.FilesMatchingFound(filepattern, matches), self.data)
 
+    def testCookerCommandEvent(self, filepattern):
+        # Dummy command used by OEQA selftest to test tinfoil without IO
+        matches = ["A", "B"]
+        bb.event.fire(bb.event.FilesMatchingFound(filepattern, matches), self.data)
+
     def findProviders(self, mc=''):
         return bb.providers.findProviders(self.databuilder.mcdata[mc], self.recipecaches[mc], self.recipecaches[mc].pkg_pn)
 
-- 
2.32.0


