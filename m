Return-Path: <jeremy.rosen@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F17CD98D6
	for <webhook@archiver.kernel.org>; Fri, 12 Jun 2026 14:29:21 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71952.1781274552634350572
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2026 07:29:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=seFDiR9n;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: jeremy.rosen@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so9001045e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781274551; x=1781879351; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0Z9TvutmATWhB1qNkQCVGtADFUfHQCY8ceIrNTEnOk=;
        b=seFDiR9nUNRqA4u6rVfr0IAXRiubCCkNYuhx03/XSNuVZKBfIzbbfspBg2QmwCRWqE
         RPepBVXW4DlDOjrazYckpsTj9PdAk3MAjcRLvxj434VEfNxk+Y7oiUJEVfnkM4y6dKy9
         7biy1Ab17HvKuvhMZZdpD/t6EQUBBkDKtL1R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274551; x=1781879351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s0Z9TvutmATWhB1qNkQCVGtADFUfHQCY8ceIrNTEnOk=;
        b=UbAxUIPCXsPQnChlwgtjsND4IDdwDhPuzA6li7c5lrf03aMBrHp29rgFEman87NLTf
         js8EIqW3tYrv9X7p+w+2bQuUzHYhaVUhzw2tmFzKUOJS5rH88C10CL0BYIGebS40RzSX
         iLqTxFqKW1m99a23d9IZ6TrInPUBTHtGs4/MvX4r59OV4ai8UwsJ94T0Em8nFD2BghV7
         MbsvqbKyYmG1rZsmK942fiUKMdy619Hsv8kmJ1aeWgvdRkgxQXnmx1aX1Pdl0y9rjd6j
         HFn+JvP/62NE7nwSgpKAYHz5OXdG9kPl2oHbJGglYQk8KJRfkvqWILCjBSYBmcti9iMJ
         7CyQ==
X-Gm-Message-State: AOJu0YxYrjOWhV5Qqq7Dl3DNIpPBE5yd5PNLnhRh7hDVqaIy9WSdkiFz
	wMEmYf40MFG82umK0NEDuPcsYCLx/G6tmBU7NkKQC0ktar7fn5vXfKHKM5SEfqfWhMaASxU072C
	5LQxEcw==
X-Gm-Gg: Acq92OGQ3t8CYyNCPEZ/8rkznCd/xUNE53Y8a5RGJk8ZvbAca3dHMrOnem47eoUribP
	ntXrvlZ/JO0gwj0xhMDVZl/L6EpGUBhxaDGIQH7NtbWV/wUArUXcMKxRnT53KqtZOMi3+MOmnJa
	HR3TM5497tzdKM8ztr32+ahNAQeCiAhVIL/Jrn0wQUUeQ8J0Wu8ICRZVZpcpDT+1wyv0+Wcae5R
	PHvp7GyAzTgzYDr/wad1ZVan3jcedNYIrA8pmxFMe7U3OK12pBn75Rhr8AGdgw4G5ENn8kYBpk7
	kzu7Z7WhSEBv++JhSwqXiia1y0zdBe49T3Yyt6rWyKBZy+o9bA9oIVdHVBTJSyRdOdW3azxneiE
	Ubec6CiUo+1Cn+8kkhnuys3IskE+EQxuNS1Pu6co/AYUsgsKjBvBHJOKetYNfK2X/bKd7iGSDdF
	fYdyZHPibtdGP3eW7KpHfm3TE=
X-Received: by 2002:a05:600c:4685:b0:490:e190:3b50 with SMTP id 5b1f17b1804b1-490ec4d4f7cmr45377365e9.9.1781274550981;
        Fri, 12 Jun 2026 07:29:10 -0700 (PDT)
Received: from Logrus.lan ([2001:861:560f:240:8dd0:2c2:7492:641b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-490ea8123e1sm74072065e9.0.2026.06.12.07.29.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:29:10 -0700 (PDT)
From: Jeremy Rosen <jeremy.rosen@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 4/4] data: fix issue with varflag exclusion
Date: Fri, 12 Jun 2026 16:29:03 +0200
Message-ID: <0880963fea4d91a034e4a6e007d23f98658ab986.1781271084.git.jeremy.rosen@smile.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1781271084.git.jeremy.rosen@smile.fr>
References: <cover.1781271084.git.jeremy.rosen@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 14:29:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19679

From: Marcio Henriques <marciohenriques84@gmail.com>

This patch fixes an issue when checking if a varflag
can be safely excluded.

BB_SIGNATURE_EXCLUDE_FLAGS lists variable flags that
can be safely excluded from checksum and dependency
data for keys in the datastore.

When bitbake checks if a varflag must be excluded it
checks if the varflag name is part of the string stored
in BB_SIGNATURE_EXCLUDE_FLAGS.

As an example, if the varflag 'filename' is in
BB_SIGNATURE_EXCLUDE_FLAGS, the varflag 'name'
will also be excluded because the check will return 'True'
when checking if the varflag is part of the string with
the varflags to exclude.

To fix this issue the string from BB_SIGNATURE_EXCLUDE_FLAGS
is converted to a list before checking if a varflag is part of it.

Signed-off-by: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8ab71d0ce302521da6a7e18c887cd85d9a94e8ee)
Signed-off-by: Jeremy Rosen <jeremy.rosen@smile.fr>
---
 lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index f672a8445..53a7a092a 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -377,7 +377,7 @@ def generate_dependencies(d, ignored_vars):
     mod_funcs = set(bb.codeparser.modulecode_deps.keys())
     keys = set(key for key in d if not key.startswith("__")) | mod_funcs
     shelldeps = set(key for key in d.getVar("__exportlist", False) if bb.utils.to_boolean(d.getVarFlag(key, "export")) and not bb.utils.to_boolean(d.getVarFlag(key, "unexport")))
-    varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
+    varflagsexcl = (d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS') or "").split()
 
     codeparserd = d.createCopy()
     for forced in (d.getVar('BB_HASH_CODEPARSER_VALS') or "").split():
-- 
2.53.0


