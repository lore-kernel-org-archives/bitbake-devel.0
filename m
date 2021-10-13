Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB68C4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 14:36:39 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web10.9165.1634135797735680896
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 07:36:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=LLv40khB;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.219.49,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qv1-f49.google.com with SMTP id k19so1759945qvm.13
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdUlUtiK08h9qYpKa3qAj3oDH7ZbwHGMaSvHp3KScJQ=;
        b=LLv40khBgyseLe7xGTOv2qA0GdJbUf1Isx/rCQE35dOt29yGXptALCasRKLM2zyrUt
         zJS/rjj8dYllgqXiuHwqf7lUybzvfQ0EDe0tXy6R/Hi1wL38xSg5iApOK2D2M3r0XBvs
         dkqSRuDUqcr5OlNxC/QOvaPvS/WFnqq5I6sLwCUgMlYfJrof8sCRUuLneBtN6lUUYX1V
         AqjcFehgSJeizjIx4j6q+HoQYma7mKTW3i1cH/dIcWW/2L8sdfpWbG2JUwGHvF/9WF3W
         Srjs92SRAOLh/hcqg4szCPnuxl64dL1sqyuyA0HF+32NaNdz71DYBA8Bt4W+ipuUQqeP
         rgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdUlUtiK08h9qYpKa3qAj3oDH7ZbwHGMaSvHp3KScJQ=;
        b=SKFEK6bkff1bWJ9j4U5V+R3DuuKNKh8f7v1ZJCzGo1vsmGzbZmi14TDRP/uzITYrQf
         d34wW1KlNeNf7qgh1v49vbyfFIgve01O8axiZIsIUuX11O6Agjml0kr9gOBQJx9A9Yxq
         saEWD11h7GgZLdQt64bequKC/Dfv5N6ONte7AxqFz2PiQrQuoMR57ev1r0XmQl+zcUlF
         MaKATFRDpJ/QDuSLt0HkHQNJuk0W10KCNw73bX4UnrWa+rT0qIaklSFs6BGRDjo7UUjV
         3Qoyree+ItwQXDJq2raZPvdjelBZRgKfYDDuZkZFeqYD1buPaSX+7hFSGS3gudxHq8Yf
         h+cQ==
X-Gm-Message-State: AOAM530RDebWtl4GnDXKSJb0LeMW3EXZaRgyRYWcgU+dH/Nlvlf+lt5u
	U67dpc6SioY3X2DcTXGD9Lc7IH/0a8Z8+A==
X-Google-Smtp-Source: 
 ABdhPJyC/kz/XI2Y1RvNJJXBJGPDs+9JIMaYoOZn1FpZ6gZSwahk4/+lrq8UjZu/xLCKhGe5tdLa2g==
X-Received: by 2002:a0c:c1c9:: with SMTP id v9mr36653869qvh.31.1634135796799;
        Wed, 13 Oct 2021 07:36:36 -0700 (PDT)
Received: from localhost ([2605:a601:a650:b700:d0ca:f716:ee3a:5cbd])
        by smtp.gmail.com with ESMTPSA id
 16sm7642003qka.80.2021.10.13.07.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 07:36:36 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: openembedded-core@lists.openembedded.org,
	docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqemu: add DEPLOY_DIR_IMAGE replacement in QB_OPT_APPEND
Date: Wed, 13 Oct 2021 10:36:30 -0400
Message-Id: <20211013143630.21266-1-jdmason@kudzu.us>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Oct 2021 14:36:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12767

Add the ability to replace DEPLOY_DIR_IMAGE with that path in
QB_OPT_APPEND.  This allows for anything present in DEPLOY_DIR_IMAGE to
be passed into the qemu parameters.  This is especially useful if you
want to run multiple flash images (as -bios only allows for one).

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 scripts/runqemu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/runqemu b/scripts/runqemu
index 3268bb18ada6..54f2336ba977 100755
--- a/scripts/runqemu
+++ b/scripts/runqemu
@@ -1412,7 +1412,7 @@ class BaseConfig(object):
         if not os.access(qemu_bin, os.X_OK):
             raise OEPathError("No QEMU binary '%s' could be found" % qemu_bin)
 
-        self.qemu_opt = "%s %s %s %s %s" % (qemu_bin, self.get('NETWORK_CMD'), self.get('QB_RNG'), self.get('ROOTFS_OPTIONS'), self.get('QB_OPT_APPEND'))
+        self.qemu_opt = "%s %s %s %s %s" % (qemu_bin, self.get('NETWORK_CMD'), self.get('QB_RNG'), self.get('ROOTFS_OPTIONS'), self.get('QB_OPT_APPEND').replace('@DEPLOY_DIR_IMAGE@', self.get('DEPLOY_DIR_IMAGE')))
 
         for ovmf in self.ovmf_bios:
             format = ovmf.rsplit('.', 1)[-1]
-- 
2.20.1


