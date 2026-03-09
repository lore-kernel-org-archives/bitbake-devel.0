Return-Path: <michael.siebold@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106B4FCA191
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 21:21:59 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25784.1773091311081217488
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 14:21:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=atD04Z6+;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: michael.siebold@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50919fc3a14so18002251cf.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 14:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773091310; x=1773696110; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wv9Mh7vxSWPXnxM2Wgjm7Jr1OYMYU6bLY2rw53KpFOA=;
        b=atD04Z6+BHcjO5J8S3WaZHwTz2yRhLZ0XvO/heLtLDt25HWIpGXGmkVkcl1FakdEca
         BrCX6Z0sRyUPGJL2/Q9K2p09rMXSzG8pinRiJc5oF98e8bdQ4srt2ki7joGP8Ahkp23G
         nwppqR0rbJe7YwuUxq3g3wm1aOP4IfkbhGKm3M3ngUF5as6NqvpO1nbPpr0zMj0+UiLS
         lUfabKJjbOpM0c1v8gczMkeCZ1ZEYFc6cYjYQgbSr7uglsfHQqHbvxlPRI0/hzvqXRSJ
         PxUALCKPNYEZs9/zTk2aTQIWwqkInypk9O5TqSMv0X/5IY94rVbFIr2hIK//cyOZsr/T
         aqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091310; x=1773696110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wv9Mh7vxSWPXnxM2Wgjm7Jr1OYMYU6bLY2rw53KpFOA=;
        b=LNkBKoM2/vPb0oQZ1fLskdjVIIcK6p7RL86FLqJWFlLW0b/kPsjpSmLXHRziPz4psW
         uWgeQI39TG/OwZkDZJB4gH37Ya4oZTJH5H8P7v3Q00kzAJZqh5vVUfMeY5XBLmPADArW
         75XOTUDjj8oPxlpvHdT21bTFSvffoAhfv4z+dG9L9DtrFf2VpKoSeNElanE7k9H/tb4t
         /h/8iQk1zQr3k3mfyBmv6I7ZCs4IJGKQH/IKJOypn/2T/vPBYl1ViOG000W67V8KsiH2
         0XZY5VHFQbzVkNe41LT2H9WECnFHp9C8iYpBp2KsNB8v1w4W17hZM92sRzxCCBKDC8pw
         Hlfw==
X-Gm-Message-State: AOJu0Yw4LdbgaJsfT281klqEKeSA3l796ve7AZIpkso0cCezSuxU4Frn
	hmYJIWkXOOLdgT2cDPtA+CoM8WukG+cONUXgAtASEi3TL1XlYlva5F8skjMHGCC3
X-Gm-Gg: ATEYQzyc/Dpf81Smm39LySOnGYFxsLqNHUSShMGSPDHxm2hDuR+aroFfy5fbLqBlCKl
	FIv0AjnLZdKtxrtLXvNWqYVsqANCXXgWfTaxm3mFak5Op0eGNgU0D5A8JyNkCQVWX7Idc78akNU
	k1toV78Xe5TCX0MFaqVN0xG4n6RsEtOT+wR0kwtu+L0gA0YftmQ1VHw1GReO0jn5XziaTpI9tgO
	MS0MCbNaF2P4HFeZd4iPqOquuAzzVWtiwpqWaMhuoz7LFviks0GYO6fer4HMOMIFTwtZHlbx+3T
	RfpMo1Lwicn73eB520Vx3u477w6aPt4apXgQfcMVzRSTS+TxcKkuSaWUDkOwROmnfRyjND4jfO/
	dz3HqOIW5DiR4PFd0AuRZvFaHr3as/YVkhGWeqm8k6Ay7y7uE7y9733YvGM57ttctxyyPIbpVES
	d1PhrxbnU7o+Dl66Hy3rG7HZ7EPC4FoTZxWQ+Fvv75X2NN274=
X-Received: by 2002:a05:622a:14c6:b0:509:1d55:6367 with SMTP id d75a77b69052e-5091d556a77mr47729701cf.36.1773091310111;
        Mon, 09 Mar 2026 14:21:50 -0700 (PDT)
Received: from beeblebrox.pc.cognex.com ([143.170.79.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50924937718sm8522881cf.29.2026.03.09.14.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:21:49 -0700 (PDT)
From: Michael Siebold <michael.siebold@gmail.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org,
	Philip Lorenz <philip.lorenz@bmw.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Siebold <michael.siebold@gmail.com>
Subject: [PATCH 3/3] bitbake: fetch2: Fix LFS object checkout in submodules
Date: Mon,  9 Mar 2026 14:21:25 -0700
Message-Id: <20260309212125.3172717-4-michael.siebold@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309212125.3172717-1-michael.siebold@gmail.com>
References: <20260309212125.3172717-1-michael.siebold@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 21:21:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19130

From: Philip Lorenz <philip.lorenz@bmw.de>

Skipping smudging prevents the LFS objects from replacing their
placeholder files when `git submodule update` actually checks out the
target revision in the submodule. Smudging cannot happen earlier as the
clone stored in `.git/modules` is bare.

This should be fine as long as all LFS objects are available in the
download cache (which they are after the other fixes are applied).

(Bitbake rev: d270e33a07c50bb9c08861cf9a6dc51e1fd2d874)

Upstream-Status: Backport [from commit 3eeac69385]

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3eeac69385e8f29a08d022a17b28b5d504deed66)
Signed-off-by: Michael Siebold <michael.siebold@gmail.com>
---
 bitbake/lib/bb/fetch2/gitsm.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index 5c98991480..ef19053330 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -243,12 +243,11 @@ class GitSM(Git):
         ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
 
         if not ud.bareclone and ret:
-            # All submodules should already be downloaded and configured in the tree.  This simply
-            # sets up the configuration and checks out the files.  The main project config should
-            # remain unmodified, and no download from the internet should occur. As such, lfs smudge
-            # should also be skipped as these files were already smudged in the fetch stage if lfs
-            # was enabled.
-            runfetchcmd("GIT_LFS_SKIP_SMUDGE=1 %s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+            cmdprefix = ""
+            # Avoid LFS smudging (replacing the LFS pointers with the actual content) when LFS shouldn't be used but git-lfs is installed.
+            if not self._need_lfs(ud):
+                cmdprefix = "GIT_LFS_SKIP_SMUDGE=1 "
+            runfetchcmd("%s%s submodule update --recursive --no-fetch" % (cmdprefix, ud.basecmd), d, quiet=True, workdir=ud.destdir)
     def clean(self, ud, d):
         def clean_submodule(ud, url, module, modpath, workdir, d):
             url += ";bareclone=1;nobranch=1"
-- 
2.34.1


