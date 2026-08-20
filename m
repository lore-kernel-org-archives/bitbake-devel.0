Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A74C5DF81
	for <webhook@archiver.kernel.org>; Thu, 20 Aug 2026 10:08:47 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3789.1787220524489043919
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Aug 2026 03:08:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fQAN98v2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954dff6536so17377225e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Aug 2026 03:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787220523; x=1787825323; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4gselgP+NK6i5jJoHGYb2SNoHFdenBx0hgtYRV4BKXU=;
        b=fQAN98v2e0/QyEmK07TZWDptvC1R4BSfOVxsiOeA4MLeI40izBp2T8KDOk+YILcQTl
         Sj9c3JRM4bpcKutyF8P/lEhzipLKlAa8jFi5r44dB9dgHM+dF6JxTSo8NY/Wtp/+gQQU
         l+93vmAvhqRYbc4e/CxISbs1VmNHEq4aaTEVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787220523; x=1787825323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4gselgP+NK6i5jJoHGYb2SNoHFdenBx0hgtYRV4BKXU=;
        b=iQqdweZW1H83bS8RtyG40SJYX/fOQ8bk0he9p0jsH4/O88PzZEj3CryZupm/BamVNE
         A+GtWCqoJjFp2IvaHQdr4a5G0tLh4g5vIjSxnpw/kZ8h8Bfxd57mBo/hiOd8ZTtMRsB0
         zo4y2gGbMhxjo+HiD8jJf7s3A8+fwxJkEB4zJY+Q4PctZg8Rfvkm/sSwTFQ9HkwJtGnb
         eE+YKdIJKfcFvXsz/Z+KfCR2+IxMOAyKrWXR9u57b8BtuG6gibWIPgVxNfSa5gMWKVHL
         FZv3+VRPBKWSQzAlMpWqSD/DKYpBKESkVk9sHKl1A4CEsdcKuA8fuxAkK4gOfdl3jryZ
         QQZQ==
X-Gm-Message-State: AOJu0YzA3AjXYGmttx38ademfadEkQsgLRFuyNbvaLy5v46rzQcWdKnm
	4njeTWfcawm2S2bK45cdMHUegMGmmEoTMpZHiF64Qd7+sX0LZEo0mZzUGRJ+YHtOkvdrXsCvJcV
	wBtAkLTE=
X-Gm-Gg: AR+sD11aYmEt2+/CHvXY9W4+zemZ4NjfI1npY3xnfI0NS4A/MYKiyWmgS/wUSR6Nitz
	BA096yz4hKbuypKO63WB2eS3VtNFnK5rPg+YBymEOh5ZUPTXr++TnUcjDrETFOI9muiUywKqgyU
	PVkNuOTb9X2orPvnx4uu6/ffyrYqjLWyeFTqmq2s2wmia+vFFmQ9ldXn0B7vXVoO3ufmZxMeBwZ
	hbxGw4gLkucA+1lYh2Oxj+QScWGDf4Jj/JdI9BuKzt7fRpi3oEV2yk81Cz8RmPCZubh/ev/b8gE
	eEMdT+qy88cu/kbCm88Kc+lwPNHp2lCj0rn+BpJSGO8sZlCEVDWccc2qqF0fFXRZTtEtgw2JamZ
	QvpqW8clEYovm9B58yPzUvjXVWCcgDsuV+8Pz3SLifPfjeAwfbS3/2/DjwE2ys6rlVoNqzS78Au
	JeDinbRsMioNiOGxmaEqTZHBpRkmap/iQyNWAE87rKiWiEusvOCcgSEuGlHHSjKvq6wDzfIj8OU
	9TaoE43hmEQb9FyFs/8TunbWAEH
X-Received: by 2002:a05:600c:4f54:b0:499:84fe:ca8c with SMTP id 5b1f17b1804b1-499aa16e9a9mr165642825e9.5.1787220522659;
        Thu, 20 Aug 2026 03:08:42 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9334:47ad:4624:539c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b2148727sm37221825e9.3.2026.08.20.03.08.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 03:08:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: Fix lockfile_to_exclusive to avoid deadlock
Date: Thu, 20 Aug 2026 11:08:40 +0100
Message-ID: <20260820100840.2591098-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Aug 2026 10:08:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20005

We need to drop the existing lock when trying to get the exclusive lock
else we'd deadlock with another process trying to do the same thing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index b635f68a153..37edd435350 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -587,12 +587,13 @@ def lockfile(name, shared=False, retry=True, block=False):
         if not retry:
             return None
 
+# We have to drop the existing lock to avoid deadlocks
 def lockfile_to_exclusive(lf):
     if not lf:
         return
-    fileno = lf.fileno()
-    fcntl.flock(fileno, fcntl.LOCK_EX)
-    return
+    name = lf.name
+    unlockfile(lf)
+    return lockfile(name)
 
 def unlockfile(lf):
     """

