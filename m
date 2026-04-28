Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8806FF885A
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 15:40:52 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.506.1777390850738275102
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2026 08:40:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=R+jOBlD3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d77f60944so8338480f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777390849; x=1777995649; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/5HJwIfNAdH60HjHR1yw5Af4ef1HD/bGmQKX7MmUYqs=;
        b=R+jOBlD34L5PKQHaNH6LamtKn920VGq2o1yjz5MMTAbw4k/6fU5u2MkXAb2IhPnmc6
         v6li7gMoG3wgL9PW/W4jBwtjUA6ohCxtJzaunUyoslbwkONbPoEgrmXbO0gyx883jp2s
         0htr+9B6bgkYoiD+7jG8n2/7su7yzpYSHbkmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390849; x=1777995649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5HJwIfNAdH60HjHR1yw5Af4ef1HD/bGmQKX7MmUYqs=;
        b=l2d1RguXId4Vq8mdWdNoCs0koVGa4cUrxLfQTEV8xCXZIwj6ADhRoGtOJFEUVPS66T
         taXakrZeN65276mOALRs6djQKvheimOYkrqvnmv8+9yqboLqwq5LcBE4CN9b5BSo795e
         +LbXF1Tcml3vbjZaEZyDdmEAPcBZM0Zstp26sC4BMCaWBHU3m8A/PYun4RR83pwmloNW
         0yGLjlXwE72Egk02HvN+d/iH2Yq1cJZAA896sRhhPsXj8nLrIuBiPoPeJC7znloO6+Zf
         nswH/rT0bYFsUCinwJXoEh4WC0Ra5468CLYqLQLZl/eSZ+EnHGGjg6v1gW/QDrkZOGL8
         g33Q==
X-Gm-Message-State: AOJu0YwNDVmuphLAdk2xEBPGwCf3H6Hagv6wuUbcuVSKbHpA1WFPJ+gd
	UHADKqC4ThfDrZRBO7NhPCPRkNTk2PUfEMA5ssr1kuMHZ6UtjMWB0PlmDqlWq8iVWlK63gZj1ni
	oDoHImOU=
X-Gm-Gg: AeBDies5W3vFHHD5k+enbTaF7kE5a3Io38IbMvuLBTAK6eXLShossChwN+nPl6KjGSY
	V7fttC1skMxIC8p+u/Au6OTL4jDJPjvPHcVn0p/feeCIAyqqx2JQRn9qIOPNZ8PF+eupli/3io1
	kJsDKmFhfI0Tag0z8A+Q0bryk/d3Sbfc+4y5T/011CuLZ6WYX6nq49fG16IFGEMy4If+F6Y8dNT
	vQCSJ9UPe/zXtefQ/6rSBnbea+woSs8dzQ8INkT+0QOTKK54F+1QEJ7/D3OVULQvanMPwSrt+6T
	ruNCW3RkCRpSj0l7tENAvNL8MOyRa9/nyhkJXB4lJ4/fB7M2uRyMdj5+eKgvEYjj0TR8wEn2oy/
	iMfQA81Ogtv788EdtVINLabFut/MeXlKupjiIrrsm/Civ0gkzb2jY1n3mbF6sqaOYs88dXFQ87S
	yduUm0qj/HOR9ula2n1p+bIMJ8zKfVf/5wNiYkf5jtKfYTVDihqobCd4NEvtD7srI=
X-Received: by 2002:a5d:588c:0:b0:441:360a:9438 with SMTP id ffacd0b85a97d-446496d5473mr6677483f8f.25.1777390847634;
        Tue, 28 Apr 2026 08:40:47 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d7fe:f02f:1ae8:3ae9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463f5b4fa2sm7239000f8f.19.2026.04.28.08.40.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:40:47 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster: Increase pytest version requirement for toaster tests
Date: Tue, 28 Apr 2026 16:40:45 +0100
Message-ID: <20260428154045.1913762-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 15:40:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19403

Switch to use pytest >= 9.0.3 for toaster testing to avoid security issue
warnings for older pytest.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/toaster-tests-requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/toaster-tests-requirements.txt b/lib/toaster/tests/toaster-tests-requirements.txt
index 6243c00a361..86ba9b42c17 100644
--- a/lib/toaster/tests/toaster-tests-requirements.txt
+++ b/lib/toaster/tests/toaster-tests-requirements.txt
@@ -1,5 +1,5 @@
 selenium>=4.13.0
-pytest==7.4.2
+pytest>=9.0.3
 pytest-django==4.5.2
 pytest-env==1.1.0
 pytest-html==4.0.2

