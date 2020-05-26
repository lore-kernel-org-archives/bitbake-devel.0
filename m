Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
 by mx.groups.io with SMTP id smtpd.web12.9.1590520918969724366
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 May 2020 12:21:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=spJuHAC1;
 spf=pass (domain: gmail.com, ip: 209.85.218.68, mailfrom: jacob.kroon@gmail.com)
Received: by mail-ej1-f68.google.com with SMTP id a2so25022746ejb.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 26 May 2020 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UcMP0OAnsDmfRrJZRZjlrSESVGSKhlDFnX+yPWw6U0=;
        b=spJuHAC1MHm2AWvICreKvmUGk20oaVG7bOriM9+eTSYUzzY5lmgSB2imVmkAlX3M+j
         8SSuzEQmt0TBPVeqHJQl2PzNDzjXGqGNPl6IvOEchSCxQqDXpRB2FMYO/iqF6vy1kXcd
         KxeE7ICE5H9/a4mDCNK678dOKhHZMM+vMCshBgTR0X1puFdAQOTUlnTnNCKHcpntaakC
         Ayl0c89HB8Wlo1t859FfFTMwMYv7mPUCuLmBFHhIUDYtSiYZOc6zaRUKSuQ+VR9OKWgD
         arqELR3wCMg4Sl/EPbzKoOCVsqms+EnIN51voHKbD2Lsw23A0zICEPrDItioyvB78sJJ
         /h0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UcMP0OAnsDmfRrJZRZjlrSESVGSKhlDFnX+yPWw6U0=;
        b=JuR8MY1auQXsBaQvIvE7y7pvYTKN5XbODSvSy9eGvNvlvAllsla487pW9nz301feny
         bFHKji+DxV+mCeOszW+YggsuyvqpzyAjpSa6t0xRtK+GGbmFPuTA/QVaG07fGxMa31iP
         imN6nc2MuGIUvf/BYrLrbFgLLvabM2ZnfWB37TnYTsfnecfgE+nlt2Manlmx0OnAywas
         cflwns7+JKeTCxJYOhb4adl1MuVnXsF5huqF+Q98IY2qXhiBuLoTCQJiNGodu5v8tj39
         fWj2G06l/Jb7L+38VoVFznG6NpoOHSodav2Xupx3vm7EqJXKJoFiCPfQA6LNXWOKwIJ7
         zDPQ==
X-Gm-Message-State: AOAM532qcrdaOZpMnp18LO4YK5lvyZIPNs1G2DHaRWJGze2D/wvg8I3Y
	MthKump1I/KOAddMiKvIB307tkHc
X-Google-Smtp-Source: ABdhPJzngIMs4619E3mmkpaJqoIafXTFpbfUHddGO+BTgkTyouX5JAMvNuKexcNSx3DKvj9aqliO0Q==
X-Received: by 2002:a17:906:55ce:: with SMTP id z14mr1066668ejp.50.1590520916884;
        Tue, 26 May 2020 12:21:56 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se. [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id dt12sm593979ejb.102.2020.05.26.12.21.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:21:56 -0700 (PDT)
From: "Jacob Kroon" <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] doc: Clarify how task dependencies relate to RDEPENDS
Date: Tue, 26 May 2020 21:21:46 +0200
Message-Id: <20200526192146.420290-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify that BitBake knows how to map entries defined in the runtime
dependency namespace back to build-time dependencies (recipes) in
which tasks are defined.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 10b58835..95a8b95b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -2526,6 +2526,9 @@
                 In the previous example, the <filename>do_packagedata</filename>
                 task of each item in <filename>RDEPENDS</filename> must have
                 completed before <filename>do_package_qa</filename> can execute.
+                Although <filename>RDEPENDS</filename> contains entries from the
+                runtime dependency namespace, BitBake knows how to map them back
+                to the build-time dependency namespace, in which the tasks are defined.
             </para>
         </section>
 
