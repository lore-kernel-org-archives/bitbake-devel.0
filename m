Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74A7CCD183
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 10:09:35 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.4860.1759399775010093423
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 03:09:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BYBYd52f;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1101247f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399773; x=1760004573; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkdaVN+no/cqOoBJpd6yvO/VRwXYD6/y37hX6rz6YK0=;
        b=BYBYd52fSLSQHCHc+6SoWbZylSD2/DZtgk6eEH/jxpTxADdUp8jPJcdjK8AegYMKE+
         5B5PUpJND1lu1xXk13VehgaEamadzveW0z5JpR86rNW3Vi0mdQ8t9r6VGJ04M8aDNMvq
         6/aD27d4KQF71E6MrYZVzaSNjeiYT4pVaVEQZ7y0KM0vGy6JVRNUtETjPzLUNYtsE188
         ra0PC5DW9Vl4Fg/8ytsf6y4kSAy7zzj15rlVxD/txSBuR1cmXEVqjx9cS7JS9v4Z7Jg6
         QtwC045pjCA17yCq3jzqDRPzKaZXcj+C2HfdfHvFLTID7PO7jqObIv9cpdkFz8jaRxJ0
         V2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399773; x=1760004573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkdaVN+no/cqOoBJpd6yvO/VRwXYD6/y37hX6rz6YK0=;
        b=PCh5riW/XreRoywYtupQjPE9KDrdebI+8g9wvYT5v7hPwnYvdVKsddnvi3HcX17nbA
         tno7bszkKEMw36kqbjQPeR+8+klOsCSu7xySqfqqwCl8kUgXOC7E95vNQ0VF3fTrOzfD
         yJ+WLkN1e/YzuMMwogBaT6b0b1iUFuocMVE8XhQZt4yaaqDo55xaSDxqaACp9PHEF1Ik
         5ligMEpsUQB7rxWLZzlYGtnqgpPaTsNbGzzxsDZhxovCLm94YZUUolMdv2B/pLO8lMrA
         5naX2DuDq+3TXyTHHfK0dW6eOGaghqjsltCQeDtZ4R7aPJ/P4BeyDeepEJvpy215DLz9
         gUjQ==
X-Gm-Message-State: AOJu0YwFU0t+o+N+X0o2JelYgshe+7DgEPy+y8Z/Z5r5hWTAo2+SeCuE
	PBhIXWpZOWYgucEtMfFuJsA3tjq9S2Oh9FLcblI/n6Wz0NX9wNp/ljSTXAFluw==
X-Gm-Gg: ASbGncu26q24CYMdVCeKhijmu6wwgpWjG3n49IPHPMdSpyfmt0rTICJy864jf4gmTxY
	Im/KdgfgwsVVfdtrwLCDqJXjapbJxWW7T3Q0HFZFQFpCNas84lQtTjRQY9bR1CFxiSA83njabC/
	sfUg2bIUF6TykdrHiyoIdCzSSL6Y4DXbeaPH9oPeA7XXtjz9yXg22cMXtCb85lcNKC8w+iyyD+w
	bZ1oMDpJR82lyrNukVcG3QOI/nNvRev2iOMcPk+UB4R6eFqlE9V6BnudJ46/XMW4tOn4aF8R8hz
	kH3LJmNDgjcThwlbsBs2x3hGW5Mwfw9uxA2dl/iFcH3xaboFp1ppVYVz4D74PqWs8a1zRMASPpN
	k3GvSMVQ3QJHAEstP5fZlULG7yMcsJGAaJcvX2PdEv0iNtleqy97YCO3xyKnS10EkFgD+T7vq9Z
	tj8/JLhcZabt9J8ScEy7xQMjN5rkliOVzBe0QiF+hBfgkDZZHPImpGNrVVDTlczM3Myx7jrU9T2
	mtrhE03oA==
X-Google-Smtp-Source: AGHT+IFLgurK1BFnPKjwSMx12MXmni3akUv1T6NnFE1Pp+1n/8uqCMJgUJPi+2VTb7T+o8p3WT0zww==
X-Received: by 2002:a5d:5d10:0:b0:3ee:1494:27f5 with SMTP id ffacd0b85a97d-4255d2ad184mr1985564f8f.13.1759399773172;
        Thu, 02 Oct 2025 03:09:33 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bbesm2953894f8f.12.2025.10.02.03.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:09:32 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/7] lib/bb/tests/setup.py: define test parameters in a single dictionary
Date: Thu,  2 Oct 2025 12:09:25 +0200
Message-Id: <20251002100929.1054540-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002100929.1054540-1-alex.kanavin@gmail.com>
References: <20251002100929.1054540-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 10:09:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18117

From: Alexander Kanavin <alex@linutronix.de>

This makes maintaining and extending them easier.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/tests/setup.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 329a0c525..c77e750db 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -227,9 +227,13 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         # (the latter two should do nothing and say that config hasn't changed)
         test_file_content = 'initial\n'
         self.add_file_to_testrepo('test-file', test_file_content)
-        for cf in ('test-config-1', 'test-config-2'):
-            for c in ('gadget','gizmo','gadget-notemplate','gizmo-notemplate'):
-                out = self.runbbsetup("init --non-interactive {} {}".format(os.path.join(self.registrypath,'config-2/test-config-2.conf.json') if cf == 'test-config-2' else cf, c))
+
+        # test-config-1 is tested as a registry config, test-config-2 as a local file
+        test_configurations = {'test-config-1': {'cmdline': 'test-config-1', 'buildconfigs':('gadget','gizmo','gadget-notemplate','gizmo-notemplate')},
+                               'test-config-2': {'cmdline': os.path.join(self.registrypath,'config-2/test-config-2.conf.json'), 'buildconfigs': ('gadget','gizmo','gadget-notemplate','gizmo-notemplate') } }
+        for cf, v in test_configurations.items():
+            for c in v['buildconfigs']:
+                out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
                 buildpath = os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
                 with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
                     config_upstream = json.load(f)
-- 
2.39.5


