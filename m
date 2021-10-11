Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8F9C433FE
	for <webhook@archiver.kernel.org>; Mon, 11 Oct 2021 09:59:00 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.9861.1633946338735688554
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Oct 2021 02:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MQGDRLgK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id y3so21203083wrl.1
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Oct 2021 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6QETjTpNWAW7incs5LrTOJwejgHlU+GJHw1pcqWi8s=;
        b=MQGDRLgKPs7u1pp8DDVky/FE7Qmi2XF+ulz4EqGwbMQLM7dLDZYUbjxfKAjG1flsTl
         0EK6ROiJFDF8PmJMa3PHPQH900Wg+jBSiU0t9bFBb9W/q64TgJMU6f8HoKePlFPiENeE
         dk3En0PEofrBXzGnIQl9BpxpQgAq3PFw9hfos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6QETjTpNWAW7incs5LrTOJwejgHlU+GJHw1pcqWi8s=;
        b=gUGIISygAordSxFdM4qJTD+4OKWtS4w+fcUx8vyvYxaD1EBHaDIaUs+yR6429dcSwV
         ch2M3R8XH7wor2G+awKFcIN0o1Mt3F8wRunV7haGLMy07v07WD3TTHl9BtdMesvzECTc
         9kfSPufPaZXhBUcvM8u2KFA9Huls6a561pf9HTdZiRyTktB7JIhci/WEfRGES3j3kagc
         +LPXg/JNrfmTMDuFO0cPoB17YkjBwfeDdnD2ANl7SWauMq+VRwO8vf/d8mqtiTMegzb4
         Ke1zqGjho43JBqVLiDvcO7WEVihQrCxO0Xo/n0f7SFIYwZFD1zK0iW3WKjaAzBoBWvDL
         7eyw==
X-Gm-Message-State: AOAM532mBLcrA8qd63GW2AycGK2pmiDRqFYsqDAXJ0lGiAMNxyDZ3T1a
	XsxVM9ENYzdDad6ELjqUQ8G5i09qZ00jvw==
X-Google-Smtp-Source: 
 ABdhPJwqiLbwL81Ikhg31U+kZIZXtxwKzPlY2uZvd9L4nZ08apJUBMIVxiQPM833SNysdbTlEY9XMQ==
X-Received: by 2002:a5d:6481:: with SMTP id o1mr24150109wri.140.1633946337106;
        Mon, 11 Oct 2021 02:58:57 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:86d0:36d0:28d3:a79a])
        by smtp.gmail.com with ESMTPSA id
 k22sm7533057wrd.59.2021.10.11.02.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 02:58:56 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 2/4] hashserv: Add tests for diverging reports
Date: Mon, 11 Oct 2021 10:58:53 +0100
Message-Id: <20211011095855.2720493-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211011095855.2720493-1-richard.purdie@linuxfoundation.org>
References: <20211011095855.2720493-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Oct 2021 09:59:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12761

From: Joshua Watt <JPEWhacker@gmail.com>

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/hashserv/tests.py | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index e851535c59..1fcfb6b929 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -312,6 +312,59 @@ class HashEquivalenceCommonTests(object):
         server.process.join(300)
         self.assertIsNotNone(server.process.exitcode, "Server did not exit in a timely manner!")
 
+    def test_diverging_report_race(self):
+        # Tests that a reported task will correctly pick up an updated unihash
+
+        # This is a baseline report added to the database to ensure that there
+        # is something to match against as equivalent
+        outhash1 = 'afd11c366050bcd75ad763e898e4430e2a60659b26f83fbb22201a60672019fa'
+        taskhash1 = '3bde230c743fc45ab61a065d7a1815fbfa01c4740e4c895af2eb8dc0f684a4ab'
+        unihash1 = '3bde230c743fc45ab61a065d7a1815fbfa01c4740e4c895af2eb8dc0f684a4ab'
+        result = self.client.report_unihash(taskhash1, self.METHOD, outhash1, unihash1)
+
+        # Add a report that is equivalent to Task 1. It should ignore the
+        # provided unihash and report the unihash from task 1
+        taskhash2 = '6259ae8263bd94d454c086f501c37e64c4e83cae806902ca95b4ab513546b273'
+        unihash2 = taskhash2
+        result = self.client.report_unihash(taskhash2, self.METHOD, outhash1, unihash2)
+        self.assertEqual(result['unihash'], unihash1)
+
+        # Add another report for Task 2, but with a different outhash (e.g. the
+        # task is non-deterministic). It should still be marked with the Task 1
+        # unihash because it has the Task 2 taskhash, which is equivalent to
+        # Task 1
+        outhash3 = 'd2187ee3a8966db10b34fe0e863482288d9a6185cb8ef58a6c1c6ace87a2f24c'
+        result = self.client.report_unihash(taskhash2, self.METHOD, outhash3, unihash2)
+        self.assertEqual(result['unihash'], unihash1)
+
+
+    def test_diverging_report_reverse_race(self):
+        # Same idea as the previous test, but Tasks 2 and 3 are reported in
+        # reverse order the opposite order
+
+        outhash1 = 'afd11c366050bcd75ad763e898e4430e2a60659b26f83fbb22201a60672019fa'
+        taskhash1 = '3bde230c743fc45ab61a065d7a1815fbfa01c4740e4c895af2eb8dc0f684a4ab'
+        unihash1 = '3bde230c743fc45ab61a065d7a1815fbfa01c4740e4c895af2eb8dc0f684a4ab'
+        result = self.client.report_unihash(taskhash1, self.METHOD, outhash1, unihash1)
+
+        taskhash2 = '6259ae8263bd94d454c086f501c37e64c4e83cae806902ca95b4ab513546b273'
+        unihash2 = taskhash2
+
+        # Report Task 3 first. Since there is nothing else in the database it
+        # will use the client provided unihash
+        outhash3 = 'd2187ee3a8966db10b34fe0e863482288d9a6185cb8ef58a6c1c6ace87a2f24c'
+        result = self.client.report_unihash(taskhash2, self.METHOD, outhash3, unihash2)
+        self.assertEqual(result['unihash'], unihash2)
+
+        # Report Task 2. This is equivalent to Task 1, so will pick up the
+        # unihash from that task
+        result = self.client.report_unihash(taskhash2, self.METHOD, outhash1, unihash2)
+        self.assertEqual(result['unihash'], unihash1)
+
+        # The originally reported unihash for Task 3 should have been updated
+        # with the second report to use the new unihash from Task 1 (because is
+        # shares a taskhash with Task 2)
+        self.assertClientGetHash(self.client, taskhash2, unihash1)
 
 class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def get_server_addr(self, server_idx):
-- 
2.32.0


