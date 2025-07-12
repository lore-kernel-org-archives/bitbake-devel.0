Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE1DC83F20
	for <webhook@archiver.kernel.org>; Sat, 12 Jul 2025 12:06:55 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.35023.1752322014753349529
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 12 Jul 2025 05:06:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HqJ4b8cd;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so4453905a12.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 12 Jul 2025 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752322013; x=1752926813; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oo4di2HAGyiCzeVOrDdZ0cOuS46tvLmmecUFnJbG09k=;
        b=HqJ4b8cdery69nmPzkqsgUuKcgGmLQAQbXlf8JDtGZWv5Z8gDBIKxtY90gMsNXkzJ7
         BOaJJVrEnptzgipKrcQ+V0rxrA2EMAdQpYKe14BQUAHY59kAdqqgl5anjpCgbmSuoabX
         Ql6I9mI7wvKqkIwTwKSKLlkXsNg63e3ArXYcEiUVMXHQDwz+H3X6jHTYzbkPaBaO9EaB
         BhaARDFQJsLhmWpjTqtYbdVWM8PLONCRw4UdvsWh6oP8B8igexa3mVoUpzZYtKaO8KbR
         8kZnWyVjYTv3lj0KdKmezFJytlX30/SE21nAYIz9Q1IxhiAtt02d9O8R2yxiCCIm98Ra
         4rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752322013; x=1752926813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oo4di2HAGyiCzeVOrDdZ0cOuS46tvLmmecUFnJbG09k=;
        b=MWJn+cxoKcynK/Z7JpwdW0s/XEZudaIiXf9yyEwMPpnIl4qX8QdomWELUfgHO3dEr1
         uuuMDcDzz6yKi8EsLYlekrA5O4NhOGRvDY5D9CobOSj9lnmWKEC2TQq7h5p8sTst7E8s
         s+h85pgs93TV7zZ+u1NfSGtnviDWZq4QdsoqTEOglZwOPR2AH62mQLCizmaKdkTgQRPv
         GJ9mX+IBbmuMgpR582bP73nUmV58hFouLdUXfKEplzVXP3S3tQkgR6CR6GD0kbVmDSxS
         mwkaLzrCfS8UO0lzQkflGVsvNf0UNG5M6+ZZIJuKTzhI1L/+NllchAla0PqJtqImp6Xz
         G2CA==
X-Gm-Message-State: AOJu0YyeEKBrfaCWwQTsHAbe+Im1QFjp5RXIG/8QKSM8e8l25nC7uuAt
	ugwzoBbG/FOAhVvOt0DUuXQpKNvsvcZH+j0SqtuVMS1/iSS1SvY9fk3nx7hrfg==
X-Gm-Gg: ASbGncs7BUFpjxfXOA23ddbX0s8IUkeMKBrEFFFY26pa/47pKM8z+WEDpMLSYkuPo8x
	vtxrey9c4RhUDoUKMNxP2/55FuGYDOJOzjar/m7udNhPv9JTxcO51YwwowBCJo5YUe+rbAN9PHK
	p/W2eLrc0Lk53ednWqYcTDTxQk2teKD9Tbx3FwbB1ohs57QkbYorpOZzGlX5MVL5EVp53YEVXvE
	ihRVoSDttr11QImwOh3yvREetJSr09Gocv51F9Asa7CayFmoz+VWkzoLnP5wRzlZPBH78xFrjo6
	Xy9jvuWAckQ64ZIEvkt7YYtAjNlbJRqWbU5iIJrG2V5JiVmMvikyxnIzhfun7jZPfbtjCGEItOk
	TAyhnXGPqo9ctTKONlpI=
X-Google-Smtp-Source: AGHT+IFe+Ui44eBohDlh/noTFgZSu7odXMmjukl6ogEPbE4HiFjglR+2w3SwLFoz3Djv5rBXbNzJEw==
X-Received: by 2002:a05:6402:2686:b0:606:eb8e:d975 with SMTP id 4fb4d7f45d1cf-611e7454ad5mr5880020a12.0.1752322012696;
        Sat, 12 Jul 2025 05:06:52 -0700 (PDT)
Received: from desktop ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976adc9sm3462002a12.58.2025.07.12.05.06.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 05:06:51 -0700 (PDT)
From: Gyorgy Sarvari <skandigraun@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake/tests: fix typo in test
Date: Sat, 12 Jul 2025 14:06:49 +0200
Message-ID: <20250712120649.2758870-1-skandigraun@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 12 Jul 2025 12:06:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17770

The test behavior did not change visibly though.

"bitbake-selftest bb.tests.runqueue" passes completely, just like before.

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
---
 bitbake/lib/bb/tests/runqueue-tests/classes/base.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/runqueue-tests/classes/base.bbclass b/bitbake/lib/bb/tests/runqueue-tests/classes/base.bbclass
index 80b003b2b5..3a3db55d2c 100644
--- a/bitbake/lib/bb/tests/runqueue-tests/classes/base.bbclass
+++ b/bitbake/lib/bb/tests/runqueue-tests/classes/base.bbclass
@@ -98,7 +98,7 @@ do_package_qa[rdeptask] = "do_packagedata"
 do_populate_lic_deploy[recrdeptask] += "do_populate_lic do_deploy"
 
 DEBIANRDEP = "do_packagedata"
-oo_package_write_ipk[rdeptask] = "${DEBIANRDEP}"
+do_package_write_ipk[rdeptask] = "${DEBIANRDEP}"
 do_package_write_rpm[rdeptask] = "${DEBIANRDEP}"
 
 addtask fetch

