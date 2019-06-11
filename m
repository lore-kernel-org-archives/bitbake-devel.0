Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id A26097D69E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jun 2019 08:42:44 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id x4so9348021wrt.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jun 2019 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=lnxaY2IaT/ToTCx/KvtMpj1IcXnClPV2W3iSck+Dabg=;
	b=Rit4skZ+RMX0Sr+Hqc2X0c/EfAJoALrrlLNavNIdDupvrDZ55T6HtfO2MakLThhS5J
	IsSSB+1SKu1ibbWVJz4jQCfRSA78N8BPNz2B/3lDd4uhAMYiWL6T6J1Ds/ZOu65dXHjT
	FYncQTwoZZDJ9whC0SGsNyL/9j4oJ3yKTEqy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=lnxaY2IaT/ToTCx/KvtMpj1IcXnClPV2W3iSck+Dabg=;
	b=rOcHyZVZEToJhLhsyxdibsqlpqKf/Naz8BZSvjth0dM8V+a61pMZIB+7apDM4ZmFl2
	avQglu57o1MMd5ISozTRHNLEmvKeTopkJFJOFIbQ99G4BlPT90QjTK6oq2sEf8uZNG4U
	Hyd1sSNaiote+cBTbFga+ns74Xdv62iHc+cnBnj3Md1QqyfWqxMRfEP7md4sb8lZkv/d
	GlM0GSEs/08+nZT0XqWc3Hl0Zo06rzLrsVAoFYQoT0YHNBfzppXiFcehaMThIs8ZyDso
	xuMsHAii/NnjpW1NPaXNG95p7rUtci+OcfO/l1YjqDnQcIQIIVePkgWqLxS74F96RHia
	7naw==
X-Gm-Message-State: APjAAAUUmvbHENHPpYx5SRMGGG8BCdro/XUdAjn9Adj+9E8/0is0yNPp
	ymwfQrSqlm7xTtO4K50lMwyNqpZhSJo=
X-Google-Smtp-Source: APXvYqzKTFiig6alHNmorH0lEy9b4pHpTzawOjm81fNPOUDRPzzx3/6QN59YUU2cj8rnNun2i+DLEw==
X-Received: by 2002:a5d:6242:: with SMTP id m2mr3804721wrv.310.1560242565120; 
	Tue, 11 Jun 2019 01:42:45 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o13sm22372326wra.92.2019.06.11.01.42.44
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 11 Jun 2019 01:42:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Jun 2019 09:42:43 +0100
Message-Id: <20190611084243.17135-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] cooker: Ensure mcdeps are processed even if only one multiconfig
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 11 Jun 2019 08:42:45 -0000
Content-Transfer-Encoding: 8bit

If you have no BBMULTICONFIG set but set mcdepends, they're currently
ignored. We can handle them correctly with this small tweak.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index e0cbed5378..0008c2fde1 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -638,9 +638,13 @@ class BBCooker:
             runlist.append([mc, k, ktask, fn])
             bb.event.fire(bb.event.TreeDataPreparationProgress(current, len(fulltargetlist)), self.data)
 
+        havemc = False
+        for mc in self.multiconfigs:
+            if taskdata[mc].get_mcdepends():
+                havemc = True
 
         # No need to do check providers if there are no mcdeps or not an mc build
-        if len(self.multiconfigs) > 1:
+        if havemc or len(self.multiconfigs) > 1:
             seen = set()
             new = True
             # Make sure we can provide the multiconfig dependency
-- 
2.20.1


