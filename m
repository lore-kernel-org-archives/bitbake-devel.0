Return-Path: <pbarker@konsulko.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 3FF5361653
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 20:16:34 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id c9so11950468wrw.8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2020 12:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=/hGATcWZvAQmQo03ab64kjbFTuuH8pPUdL1YuHK4CpU=;
	b=oX0EbVmOTS8IP+JZde3TIzrlRcMC5OHCIY9vgxOH62ZxJbtqN8GJmR9r3fhWi5C+13
	OkLI7pi+D1J5nrHIjmgD2jgpxpSjwHRz2ObFiQ4nxEgkMCwpAIIeWbhsE5Ubb6H8Dn+U
	dzW5Wo7VNcCbBHKGvaEWISYLXn38CjNzqQ9wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=/hGATcWZvAQmQo03ab64kjbFTuuH8pPUdL1YuHK4CpU=;
	b=GdB8Y7BZV2b/iAozHqzs94PSvYwFgEqXBQmhNGhJq+KGOQiREXMn/ZW+gGnFQb+a2U
	D+aqmwloDG8R+AmW8Tq5ROOMVAXumDIBCAaiNUWnnmsf4EuHITGNxusHGwmO6g2U1evX
	1dyptyYzpOKNlBQUNrpP7umTM4jYVja4pkBnssaLHheuJA9HLfSC0BGi2qyzweWw3T2v
	Bl4eOVKs0RiPUMp+p/f8QNgtrgSzPmV4x9b7hOtpitBHG+8jWtdkz1OZWnDy15inAm7X
	UJEWvpjbJYcml4aivWvPGGSKEaDa1yZpjuby6bovolt2yyt8kUdafmJZu+eN9sA4Bv2z
	Oo8w==
X-Gm-Message-State: APjAAAVa/T3lFaFxMeYYmaVrkipblMDHh2fdiGlHsEPy5Eal3unNC2Mk
	KaODdWXMSD87hdV7kNpB0zpiTneQQcOEvg==
X-Google-Smtp-Source: APXvYqzdm4uS8bUSe2WxbfAm/v8WPBmHqpNwfyqr8w8INl1QmhtsHgD/18pANQ8OA38gR3oeL/Y/Zw==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr72223406wru.57.1582575394708; 
	Mon, 24 Feb 2020 12:16:34 -0800 (PST)
Received: from ub1910.Hitronhub.home ([213.48.11.149])
	by smtp.gmail.com with ESMTPSA id z19sm715452wmi.35.2020.02.24.12.16.33
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 24 Feb 2020 12:16:34 -0800 (PST)
From: Paul Barker <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Feb 2020 20:16:29 +0000
Message-Id: <20200224201629.13774-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] fetch2/gitsm: Unpack shallow mirror tarballs
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
X-List-Received-Date: Mon, 24 Feb 2020 20:16:34 -0000
Content-Transfer-Encoding: 8bit

When a shallow mirror tarball is used to satisfy a gitsm URI it needs to
be unpacked so that the .gitmodules file can be examined.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/fetch2/gitsm.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index aa121cbe..98f5dae5 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -169,6 +169,12 @@ class GitSM(Git):
                 raise
 
         Git.download(self, ud, d)
+
+        # If we're using a shallow mirror tarball it needs to be unpacked so
+        # that we can examine the .gitmodules file
+        if ud.shallow and os.path.exists(ud.fullshallow) and Git.need_update(self, ud, d):
+            bb.utils.mkdirhier(ud.clonedir)
+            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=ud.clonedir)
         self.process_submodules(ud, ud.clonedir, download_submodule, d)
 
     def unpack(self, ud, destdir, d):
-- 
2.20.1


