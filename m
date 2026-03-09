Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B73F3C26B
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:12:47 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15119.1773065565282856549
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 07:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RGCM+orR;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b94a19fdso7501123f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773065564; x=1773670364; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62vl2fSzjILu+ZTt2A0fS7ZlROKw9XyWE0/cTtQ+QXE=;
        b=RGCM+orRI9YohFLOnwTUks23JXuIkSDpqb6gibFL5sXNKrOyILj7kV88wQEjMMyIFu
         wyu/9MOoOt3Up0RoaGqt9EfxbMcTwirbvLVUxRruzliplQBLm3mUBhbmaC55rxnfoG+Z
         VerxhgJmumFhU3SNTsjDMOvgIDI/Ivy9b16NbIblFm/rJGpCI/0ADo1JbWAuwDmXj4Vb
         bHTDx2Awd4zykRo6/HzObj8pCtAxl3f0Q9FMjSj+OS0c0E6l4pEvj/u+gx9D77VZUbZ9
         Nb53+U/XDmibRSmbLumgfqp+9lYzRkiyKyGnhrNSeBOy52tmCaw57Y5g+zjZdZM/q3sR
         V5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773065564; x=1773670364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62vl2fSzjILu+ZTt2A0fS7ZlROKw9XyWE0/cTtQ+QXE=;
        b=koulpn7VNMxmdz5lcUZvzbn00pVjMnYLVmvkRUmaxMJ+TeL48VUYDdeQ5KIeySFFgQ
         +eGjfcqtVodFGgQqd8BVZfKaOBeN7N1GJIuc8/vZUlc9h0HF8ADDyQw5qrTkv6xKLV0A
         8jl4n1OlM0cGBr3s2JVmTlKswvIoaZ//mZlXaXtLqvbDNcZAlbsWsqRuR6NB4Y0HoI9G
         fTr+y9G3eAsYUt3KQsfWaR80ZpGXOf/EYUFDCbPlqBcmaFBEVRRHggW0tLHUe2C5GuyW
         ynzF06tzPmuZDc6Ycl/O2fSCuO1xGjOWUPN4FuDvaKPDHwu0nNxY5fgsQ5ERGBGTO+Jd
         C3EQ==
X-Gm-Message-State: AOJu0YyVixL1r6Y7t58JsdOQmGvlaKBmuF2Ps43CAR4MxevgqiNxBdAG
	1vd6dYunS0tn2KRmNHAGfgQQDn1qCr/4ZZZU+3wzX/soHSGPy4Z3O3phhOGZ9g==
X-Gm-Gg: ATEYQzwHY++1cwJ0RHDC37LDd3oXLWun35vt7gRh9so6JCApVH7fjjbSTd5YInnqlk8
	RxXQO6a0p2VCq7zNFSJ/Gss3qowxdZEYEdaS3omvQfVknE6v50HVtQ57MoIEzXoE2OIyn04rOO3
	Cbi3J8U1xXP4ZAKXiuQx08GqK3XXiTnlEbvMNJ6snFzhqfTph1gtIQ/IfnUm/ex3OFTCScPj//q
	Amq0/4lsuggCBJwkwDW6jBD73i+XMg7zmTX0igd8b+XWXm3DDwloRzFu50cI8BhaC3fxirxV7ae
	inLMaxr5qY7rnYbB7AYPCHNORBTGSbgoV0H2/QjcKbQVstxKwc7KLq687ZID1TF76C33koRinzQ
	R0IquU8pTz1CoTEW5Dcd5oouL0+1Nu8N46SqfCp/nDjt3p80B2ujRis4pqTx36pz+SzkQXhKTHN
	0EjbKhvka5C+uWOJjEh1vsUzAAoK9qZ4VT2JDrMh2mSqf8l21VpriW7ZTumrY=
X-Received: by 2002:a05:6000:24c7:b0:439:c5cf:fc73 with SMTP id ffacd0b85a97d-439da654252mr18650195f8f.12.1773065563381;
        Mon, 09 Mar 2026 07:12:43 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d973sm25443458f8f.3.2026.03.09.07.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:12:42 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 3/3] bitbake-setup: correctly determine latest revision in status/update when it is fixed to a commit id
Date: Mon,  9 Mar 2026 15:12:38 +0100
Message-ID: <20260309141238.1785102-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309141238.1785102-1-alex.kanavin@gmail.com>
References: <20260309141238.1785102-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 14:12:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19126

From: Alexander Kanavin <alex@linutronix.de>

The code was relying on git fetcher's latest_revision() method,
which works properly if the revision in the json config template
is set to a branch or a tag, but does not work if it is set to
a fixed revision (the method will return the latest revision on the
respective branch, and bitbake-setup will incorrectly determine
that the layer needs to be updated to that revision).

Add a guard to check if the revision is a fixed commit id, and do a
direct revision comparison if so, skipping the fetcher query.

[YOCTO #16190]

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 19a6b5373..ca4461b1e 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -742,11 +742,18 @@ def get_diff(file1, file2):
 
 def are_layers_changed(layers, layerdir, d):
     def _is_git_remote_changed(r_remote, repodir):
+        from bb.fetch2.git import sha1_re
+
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
 
         rev_parse_result = bb.process.run('git -C {} rev-parse HEAD'.format(os.path.join(layerdir, repodir)))
         local_revision = rev_parse_result[0].strip()
+        if sha1_re.match(rev):
+            if rev != local_revision:
+                logger.info('Layer repository checked out into {} is at revision {} but should be at {}'.format(os.path.join(layerdir, repodir),local_revision, rev))
+                return True
+            return False
 
         remotes = _get_remotes(r_remote)
         changed = False
-- 
2.47.3


