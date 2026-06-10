Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C35CD98D0
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 22:53:29 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33616.1781132004887825265
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 15:53:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=3+Jt8DJK;
 spf=pass (domain: smile.fr, ip: 209.85.221.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-460662fcb4eso128775f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781132003; x=1781736803; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bJTm+x7gsnTZIqc/fMU92sr9KNTqmmtFPtCs2sPVEo=;
        b=3+Jt8DJKV/0E+FN1u2bwhL+xvuF0h9y5Q2gkDLIHgR8xKUbdN/SKt66U+HiIoe3PpS
         +i3VG+EWdLuqJVCQEzM1PSOCHA/6PdeFPCtOWb0fmzaFy9Zp/AWtNg5SpLNFtS/DpM12
         MeRuXHnNzC3FtRFVyFscGzvTqiwuEwMBS+J1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132003; x=1781736803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1bJTm+x7gsnTZIqc/fMU92sr9KNTqmmtFPtCs2sPVEo=;
        b=V1hTE8Z3Pxni/tYuvN9yw7NDQ2IC9t+l3AIVa8Qvjhd1URhR3Y+a9FWnNGLvvLmxke
         dP+/j27cCRO7/5XN5unxbOxMv52S+rfGcjgntPyO8J9eVMUsGYzTS73J6w1h8di91m4s
         sFO9N/zbR1CXXsXMF/DToITSdfY82ERpqWrLy+jXpay8+Q0muSPy7bdTQQieNQRiCDH8
         FLHSJM8eYrRWlRLbpHa/KPOJgktS5zqZrQJT189vC5+vOSrdbVBIVsY1p0EzzAPhvOr3
         JGNquOudwdAESXs5z+k112vYXslyf1EriMYv3bp8+or8f38SDHFZbD+aw9mvrOayRbRE
         b3/A==
X-Gm-Message-State: AOJu0Yx0MWYUybLJBv6Wdsz0P62o+I/KnN+KjXmXcloVXMBHWU2KlIdR
	u/yKf5flNRF1DFGB/gDxzQ6IfsnylWFEt5IpVmkE3q1D4VPDMq+XHwQzSN1HbUMlZMu0Ncpo6fx
	39q4a
X-Gm-Gg: Acq92OHyOV9kbAxugZ/Zk4EoG3zwWeQFjgkWeURSFo6+PM6bET+MyOe3n4aGg3Fh0iT
	mqZ+sm4TI4S206dvN0zYmihaGyrdU5oZK0/lZwHZRHP8fttpAMhMKry9t/DPUY3VlWP2z4wHjZA
	nZ/I8LyrcIgoUYHmPljxxSHrftjJ0JrUt0R6LkCtEZ+ujEFdMHfjDIL8i/GQly9Oh0r4UGjvP2t
	/eZmuF2mf1k0TrHKbh76xvOtw/qhd5rJut9g+Q/oKhzY/57ldIj1pr0qUwHgAAaWGA8yaoRgOdq
	1kxN1BGKiWiDiQSV42J9/KcPczlYm9+kSQNDn+HyYAo9vm3SWOyAMLmLD/oPQ59F1nvsvBKIVh2
	vSiflHUs3SO6C7C23MT4XktBYCPvU4x+U79i2WHEFUSg58Xemr/llpINMb4vS1t42YDR4UCKYyb
	QyBNLSDJaPta45/z69D5qtOHpHc5tHGnR8oCgH/WRS2bUs610+dGivG1K1uxWPPKGKXmsBt4mar
	krUr2KBDslb6ARMaRvvn/PdM4jlM19g8E/SEt0=
X-Received: by 2002:a05:6000:43d6:20b0:45e:f271:5019 with SMTP id ffacd0b85a97d-4606759c68emr203883f8f.14.1781132003194;
        Wed, 10 Jun 2026 15:53:23 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00bb749f54eeb85d7b.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:bb74:9f54:eeb8:5d7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm132348771f8f.29.2026.06.10.15.53.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:53:22 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 2/6] bitbake: fix issue with varflag exclusion
Date: Thu, 11 Jun 2026 00:53:04 +0200
Message-ID: <ddb97b7c5e40bf4f375f2dcf46ceb9f36e7b1584.1781131922.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781131922.git.yoann.congal@smile.fr>
References: <cover.1781131922.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 22:53:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19649

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
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 5fdcdb04a..b12972c03 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -378,7 +378,7 @@ def generate_dependencies(d, ignored_vars):
     mod_funcs = set(bb.codeparser.modulecode_deps.keys())
     keys = set(key for key in d if not key.startswith("__")) | mod_funcs
     shelldeps = set(key for key in d.getVar("__exportlist", False) if bb.utils.to_boolean(d.getVarFlag(key, "export")) and not bb.utils.to_boolean(d.getVarFlag(key, "unexport")))
-    varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
+    varflagsexcl = (d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS') or "").split()
 
     codeparserd = d.createCopy()
     for forced in (d.getVar('BB_HASH_CODEPARSER_VALS') or "").split():

