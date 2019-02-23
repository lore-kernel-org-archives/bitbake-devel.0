Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
	[209.85.221.42])
	by mail.openembedded.org (Postfix) with ESMTP id 637DB7C881
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Feb 2019 10:41:09 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id l5so4960432wrw.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Feb 2019 02:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=BlMVrrXNtp/YOOc36xDtxW225bCIuZxXd2nLiMbWa3k=;
	b=SgopqyecZ5tBYuU7YVveJfAAdmQU+kdejIrNpeYxbZTcNOw0WRfepvvaQK3/dAEpOL
	4hePKooQiWdB9KIpn4H95zUbk3PgZfC1rFetu3uziurEcjOfDNo3mVw/eRZPiPx2YBrQ
	90j10LP0ziJzQgiu7++NTtvz9gf3eeedlndjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BlMVrrXNtp/YOOc36xDtxW225bCIuZxXd2nLiMbWa3k=;
	b=bbeT2csHlPlfCoZYnnidSTUdOLPJdyDb8uE797lA+wzqUpjZG4IRxTshNDC/899tQF
	0j/osZraSq/nhU9ADNdnx/iOyy7pfnIcSxdIbAcRW5Y10rPEymXz04ng6BRnjjNr0huU
	Df4kI7wOGFKochhshDNCQ31CuDrmA7K/UycCuUwoc980tvrbMtDDB9CYLy7uGr/sNPy5
	yd+gZg9CSGmL6pEfUh118LaL7gzcZd7JISWXBt7Ek+U3t+lDL1HrQjRXPg2NseWsP3/M
	wG0XRCIDcdPhgw2MyeeVa8PO75PgDwJO6P+KF1YsVsRwoooV7ptpxkGbu1zhJKVmD33Z
	apng==
X-Gm-Message-State: AHQUAuaMOUMdMDhZC39OMPPc3Hvd8LLkctJSklG/hfygePCMwc5NCsF9
	TRNhiFFaJStHLsyhB75ELCGBFCLFXkI=
X-Google-Smtp-Source: AHgI3IYM12iagoJoJSePJOIHD49jDqHncbsaorYJvcpdrN+L3E7L5rJEp+4neJEkssoUM8BqH6jHfw==
X-Received: by 2002:a5d:6207:: with SMTP id y7mr5963443wru.60.1550918469811;
	Sat, 23 Feb 2019 02:41:09 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p1sm4989664wmi.9.2019.02.23.02.41.08
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 23 Feb 2019 02:41:09 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Feb 2019 10:41:04 +0000
Message-Id: <20190223104104.11201-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190223104104.11201-1-richard.purdie@linuxfoundation.org>
References: <20190223104104.11201-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/3] cooker: Tweak multiconfig dependency resolution
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
X-List-Received-Date: Sat, 23 Feb 2019 10:41:09 -0000
Content-Transfer-Encoding: 8bit

There were a couple of problems with the multiconfig dependency resolution:

- the "if mc" condition triggering this code wasn't correct, it needs
  to be "if more than one multiconfig" configured
- after adding providers we need to call add_unresolved again
  and rebuild mcdeps within the "while new" loop

By fixing these issues we allow various other combinations of multiconfig
builds to work which previously didn't.

[YOCTO #13090]
[YOCTO #13130]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 53 ++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index e6b8d880ae..1982e880ba 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -641,35 +641,30 @@ class BBCooker:
 
 
         # No need to do check providers if there are no mcdeps or not an mc build
-        if mc:
-            # Add unresolved first, so we can get multiconfig indirect dependencies on time
-            for mcavailable in self.multiconfigs:
-                # The first element is empty
-                if mcavailable:
-                    taskdata[mcavailable].add_unresolved(localdata[mcavailable], self.recipecaches[mcavailable])
-
-
-            mcdeps = taskdata[mc].get_mcdepends()
-
-            if mcdeps:
-                # Make sure we can provide the multiconfig dependency
-                seen = set()
-                new = True
-                while new:
-                    new = False
-                    for mc in self.multiconfigs:
-                        for k in mcdeps:
-                            if k in seen:
-                                continue
-                            l = k.split(':')
-                            depmc = l[2]
-                            if depmc not in self.multiconfigs:
-                                bb.fatal("Multiconfig dependency %s depends on nonexistent mc configuration %s" % (k,depmc))
-                            else:
-                                logger.debug(1, "Adding providers for multiconfig dependency %s" % l[3])
-                                taskdata[depmc].add_provider(localdata[depmc], self.recipecaches[depmc], l[3])
-                                seen.add(k)
-                                new = True
+        if len(self.multiconfigs) > 1:
+            seen = set()
+            new = True
+            # Make sure we can provide the multiconfig dependency
+            while new:
+                mcdeps = set()
+                # Add unresolved first, so we can get multiconfig indirect dependencies on time
+                for mc in self.multiconfigs:
+                    taskdata[mc].add_unresolved(localdata[mc], self.recipecaches[mc])
+                    mcdeps |= set(taskdata[mc].get_mcdepends())
+                new = False
+                for mc in self.multiconfigs:
+                    for k in mcdeps:
+                        if k in seen:
+                            continue
+                        l = k.split(':')
+                        depmc = l[2]
+                        if depmc not in self.multiconfigs:
+                            bb.fatal("Multiconfig dependency %s depends on nonexistent mc configuration %s" % (k,depmc))
+                        else:
+                            logger.debug(1, "Adding providers for multiconfig dependency %s" % l[3])
+                            taskdata[depmc].add_provider(localdata[depmc], self.recipecaches[depmc], l[3])
+                            seen.add(k)
+                            new = True
 
         for mc in self.multiconfigs:
             taskdata[mc].add_unresolved(localdata[mc], self.recipecaches[mc])
-- 
2.20.1


