Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
 by mx.groups.io with SMTP id smtpd.web11.16595.1592223763916293079
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2020 05:22:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Trxs0xY0;
 spf=pass (domain: gmail.com, ip: 209.85.167.68, mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f68.google.com with SMTP id w15so9388170lfe.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2020 05:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcAdjpry4YGs4rr3UhRt5C0lAY35IVnFb+Yae5o3Kuk=;
        b=Trxs0xY0Xe7eoBdbOC2QR9Ri4D+/lJnFNUFi3E3MGk/OoU33sIOE7VZ2i3dyU8VIf2
         h71sWWuewWJLvKAYdVcYqE5rV8rFhvwCnCEBHTaGNtXo08Kf6GYJb1WEj+zCtvjA0+SI
         fAU/Txeou25w3VSkKk+ivABzigmLhAIKIbFpgjThqd0DGdfCuX95iMT/7pi71hb+w0y0
         6BHRMPUE0yslRzl/VoyaVxU/urhaCaCu1trIZI6/Pc0sUaYmsfbdrguEknfKrUgCiEur
         PsxnkMi8yoqNF9NGvcLGALFBOlvE+uMLwGWRXUkd6gcPIk/9Rm6RefgVauIZJK3BpN0V
         vgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcAdjpry4YGs4rr3UhRt5C0lAY35IVnFb+Yae5o3Kuk=;
        b=EAcM1ouxXJXWITp/Wb4QCFox2VpkZyygdN73djALWQq9fgAww1VWKL8+6Mgjc8pr1Q
         ctIbpd6jIWrkMrcBCq2zvrSPSisRRLVWDVJI76Lj3cgDKbeoQq6K/Bt0dZIw2AkaQAA0
         hQnAR8+BcRFNxi8WA5p4AyQSz2pcanEvc96VHpMVXLCwCjxxtfCKTTADJdVjx7b0ZjZy
         s5nwy8OEpaGloduTl27aNwN7vUpMSsCX50zpKyNND4coEWHnEuk951/GsjM1E8G8Bqeo
         BCL+0XkP9vREJl6ASP6PVmr+LjtgQDXyljBYttE1D1ysMVvGCD537c682Gd2VfffJGwO
         lZuw==
X-Gm-Message-State: AOAM530DvT5+/yXBCFVSpkGkrXvmf/hPZY9h1EnIoABjlpV5MUpGbpAD
	5jRlCZrKOjxhsLs8rk+Yxd9zrEW7
X-Google-Smtp-Source: ABdhPJznk9uPWH1si5DbEfyvxo2yKalJ+TD3t7CGENokSH05NAWqDTeJpc36WsdEd0d6bkN1qMjxyA==
X-Received: by 2002:a19:641b:: with SMTP id y27mr12550950lfb.74.1592223761283;
        Mon, 15 Jun 2020 05:22:41 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain ([213.185.29.22])
        by smtp.gmail.com with ESMTPSA id b7sm1168947lfb.53.2020.06.15.05.22.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:22:40 -0700 (PDT)
From: "Jacob Kroon" <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] lib/bb/utils.py: Do not preserve TERM in the environment
Date: Mon, 15 Jun 2020 14:22:31 +0200
Message-Id: <20200615122231.1325750-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of TERM is leaking into OE-Core postinst-useradd-${PN} scripts,
which in turn can optionally be monitored by buildhistory. Prune the value in
order to make the OE-Core buildhistory output more deterministic.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 lib/bb/utils.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 5f5767c1..50032e50 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -580,7 +580,6 @@ def preserved_envvars_exported():
         'PATH',
         'PWD',
         'SHELL',
-        'TERM',
         'USER',
         'LC_ALL',
         'BBSERVER',
