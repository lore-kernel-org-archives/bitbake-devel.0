Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AE1C433EF
	for <webhook@archiver.kernel.org>; Wed,  5 Jan 2022 16:56:49 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.3292.1641401808466158888
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Jan 2022 08:56:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=UXckMcvX;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.175,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f175.google.com with SMTP id s15so35718275pfk.6
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Jan 2022 08:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yPOzIUydNOBxN54I96UFK7zOpRDNM3prQIC7phBuAPk=;
        b=UXckMcvX8NzkphjXWYYGheYmq+Mx8Z+XtYz+JgIyyY94bnCmzFbx3ufQ6JgaINUeOw
         tmxvobAMgYEtcTVwDzdNhLyQMKRUqjh6/B2nvZFF303anwuoTa6jsnIUkl8NZQ/K9BBG
         wwW0WlF/B2TguXtg1GcWTO5IcAKlm2VlIViNjtkaO1CNZ67tpFXzcEqeEBRkJWvLcT53
         O05pkhPacOc8mPMilfX0RxvIPztr8gNJB+777jnISuXIuDHfQC0pmS712hDaEE8f/Cn8
         59/fuVJohI4pxefrE9rqoyxhi1i+KvFcANg/aQ7y7xai5PouqHsnq8UmEei0ERyhIpzE
         h3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPOzIUydNOBxN54I96UFK7zOpRDNM3prQIC7phBuAPk=;
        b=wr54902Z5k21S8JG261mkcmW790k8/Fm4FzGzTn47RZP8/YYYKSmPDaQtmsUyNbi1K
         BmRVCX9Uh5TJ6lVYv09H7WF8kR4KYpcsITADtmrIiqgdGn2uCtFx3DRx8+5dhdYYTZIx
         FI9Vf24dBwthYfvRr3DMbpHRQlXegWsSVOLNpkVSUYWx5Qu3j49rH+UJaN3yGb64jWDc
         7iiQ+nZeYjlrSAmTLkClYtDNih6KUyrAqC21peDMB5HrYBEUNihG0EP9uaaZjLO7zlej
         jJGR15GtR1nK6CdfD/J8Sx5g0iwpkjfmNjpcsAWukAf8g8neeRtKHP4LPxhot45wcjM/
         RIsQ==
X-Gm-Message-State: AOAM532bQ79V7zLZjRTevtP+CvtnEd3gMjUKJeveK9anSV5jRNVuzw6E
	Wf1CVmbbYfE3Cu3s1FIrMI/v/nrF27p2NnfLens=
X-Google-Smtp-Source: 
 ABdhPJyuT1stSZpIVezQVxiBKme8hXXLDH7pgMRde2aBaIFtIqHNTIQ6o8TvPia90DUfDvShmIjrhw==
X-Received: by 2002:a63:7511:: with SMTP id
 q17mr48636860pgc.256.1641401807119;
        Wed, 05 Jan 2022 08:56:47 -0800 (PST)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 q19sm46971195pfk.153.2022.01.05.08.56.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 08:56:46 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/1] cooker/command: Add a dummy event
 for tinfoil testing
Date: Wed,  5 Jan 2022 06:56:32 -1000
Message-Id: 
 <0c9b0fd205f206fc3318c36cd2abc16b565aa2a5.1641401726.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1641401726.git.steve@sakoman.com>
References: <cover.1641401726.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Jan 2022 16:56:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13223

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We need a command genetating an event to test through the tinfoil API. The
current test has IO load issues so add a dummy version which won't have
the IO constraints.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a144178584394ea0700ffc2f2bfac94e8690effc)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/command.py | 10 ++++++++++
 lib/bb/cooker.py  |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 07128027..98c945ed 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -624,6 +624,16 @@ class CommandsAsync:
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
index 8d9ca680..ac54d437 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1019,6 +1019,11 @@ class BBCooker:
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
2.25.1


