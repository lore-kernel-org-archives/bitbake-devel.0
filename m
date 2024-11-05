Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF11FD2C11B
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 15:06:32 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.20385.1730819191742216438
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Nov 2024 07:06:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Bb2SJiVA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so3422497f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 07:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730819190; x=1731423990; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=guwJN/OdgO0urXmRMOrluMwyMZ6mK73/xEwRUIg/zA0=;
        b=Bb2SJiVA0MOM3YkWfA+AeP+Z4mKO7LKEERvtPMndTfGm9RbtLfvK/qvfE9GqmJEIhH
         r7Qcix2TMUc6lnjQ2nu5T8k8UK8dyY12x5FRmgNFJhCneDfLb7j/mLtDCbgyN2vrTzZK
         ju6Hw0VAkoJthbcsJBbdY7gwtCZ1401zEkO2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730819190; x=1731423990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guwJN/OdgO0urXmRMOrluMwyMZ6mK73/xEwRUIg/zA0=;
        b=kqUEiS2oFnotQ8jocpWq7D0uP4pAXkNF8BUfOocjmMoEp0kEXynZwy7lXmATkiT85g
         Ikb+dsVVOMXLui0cPz83kP9EJ2n+liwoKPsdv5bsivQen2jNvZ2g/JdP/KG/psb1Rxih
         D3rJ5HRsqd7swpliJUnZwkYCRLdfLJyDBDs2tRr82QJgdKXh6ZX+zBkoY2hbgfAFDj85
         9W2CAGMXk9jdWEl7J63wBbdupsQ1SJJuhecQBi/2yGatcur0vF6CFmruG9dB849oVIzk
         a30joEdkBmq3DCPLVTgLVuHrk/7i7OQYyXLgZncX36Og73noijwm7vPR2trm/Ldstj25
         jPdw==
X-Gm-Message-State: AOJu0YwIRlCXK5xwSVwaHjZlz3nYtO2jLpqNsqYqLWoqMB1RANSEDnTs
	TzEC2t3bUIcuNGaNvtBBW/B0ijl4nOwFPIoiJOUxrgLsMp9Oeq/KbTxS0O2XFa8Ml/Cj2awkDcd
	iA9g=
X-Google-Smtp-Source: AGHT+IHA2x6WfJYR580krnmrWrEX7CpXRBN8AkU1EioO+K3fNsOFKLwHceSt0L0rNfnL3crtBZtM/A==
X-Received: by 2002:a5d:6d84:0:b0:381:bf27:e845 with SMTP id ffacd0b85a97d-381bf27e8demr17082079f8f.1.1730819189769;
        Tue, 05 Nov 2024 07:06:29 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7614:7622:3cf4:a240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d20sm16656323f8f.7.2024.11.05.07.06.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:06:29 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] server/process: Don't send heartbeats when no idle functions
Date: Tue,  5 Nov 2024 15:06:27 +0000
Message-ID: <20241105150628.2827698-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 15:06:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16777

If there are no idle functions present, don't sent heartbeat events. These
are only meant to happen while builds are active.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index ad4035a738..b627ae0ab6 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -477,7 +477,7 @@ class ProcessServer():
 
             # Create new heartbeat event?
             now = time.time()
-            if bb.event._heartbeat_enabled and now >= self.next_heartbeat:
+            if items and bb.event._heartbeat_enabled and now >= self.next_heartbeat:
                 # We might have missed heartbeats. Just trigger once in
                 # that case and continue after the usual delay.
                 self.next_heartbeat += self.heartbeat_seconds

