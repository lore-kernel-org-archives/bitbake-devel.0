Return-Path: <ukleinek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CB4CCA471
	for <webhook@archiver.kernel.org>; Mon,  6 Oct 2025 14:02:59 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.34608.1759759376894396490
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Oct 2025 07:02:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=F1n4zgCW;
 spf=pass (domain: baylibre.com, ip: 209.85.128.50, mailfrom: ukleinek@baylibre.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e5b7dfeb0so20577155e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Oct 2025 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759759375; x=1760364175; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8XCj4vO5dFQ8x1sGstKOTe3LB3wdlgk10Zy+68hv4o=;
        b=F1n4zgCWlv2OT6b/Osy7QJjI1cjL+HSV9LAtTLhdxrSP5f5EWjNXNIGo6rdwffzQub
         lImdoiBIXJ2++ubFHy58wON+de0sweK0s2iuyFQfwp+aLb3Ggg6np4loGRNRhYJQOaFe
         ADsh3NMB3qlRXFvsJUUh5DnvV6/38ko3FqVc5D2781CeaM5YnGTZMEqx7YpaP+oJ1Rwe
         E2G1fiCLMpl3dfingK2ul/SogO5frtj2cfOukq9gaH1ZUPh/hPOM9/Hj0nIsUdQy9S3l
         W51fA+Et2+CXCFjB79GSa3pp4QYEMpgLbJNcpY3GaZn2RAzcO0oJ7TjcNcrISugZLu3L
         Cg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759759375; x=1760364175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8XCj4vO5dFQ8x1sGstKOTe3LB3wdlgk10Zy+68hv4o=;
        b=wXZ4N3VbqFNIN1jM094umvnTdt2BOzXES3mqgNu2T/uvQ+t4KrI9I36Jez3UYlWbPD
         eosmSCC/PWiGZJC6bKnlaY1XKOWMdjvjhpSd0ckl3hZNpy58ZzbDBuUpJ/7w9kUwu3Rp
         4ZPmClc5PP8+GfRrQTwu4RZq5hnnM4g81Thuxbe2nnDS/t1hnjmBIo8J1f0F+qLX5Z5J
         qiopOtY4BScIV3ePdmi+fWHHlgPGvXt41CcUN057+CIycEJI4i6HEQGXcp2WSK8VxhmA
         hoREZH0yUOIk1MreQbtxGdz5RVjl2k3l5SEkm63oE/mcmIkrTseXhBJq6rORJcCS2csw
         5c1A==
X-Gm-Message-State: AOJu0YwkVcHYVe9zA1OJgapwCkamnsD/r1XDi7Xf9G110n9nSn/nhIT3
	2RszoUBOqZBMSYcK/DiJRdm6k8AGsffmkucZRQTqIhqCnt5a3UsfMGd0ZzRbzFN6ubsljCwJOkh
	0BPJY
X-Gm-Gg: ASbGnctuxAkFbbhzqRs3Cjp/MyExConpmngDdJxGQxqUNL2Q4FqpeiBvOctxS2iqrsm
	jA9qAEr5j10HG9offyprC3+hoMGFQrE9qAI80By6C2Wo7oMkc64ynlHkwSpZytFRUKdMc3aCRcX
	lBdUu3XgQibxAwromohhzrFW1cS99PHoE5HTjU1VwkDlahHOGFtBFZxUFTcFjabG7nn5fQ1Exr0
	F26Mu6O9+RE5ARJqkrC2KKiHrkm+12yint748TO7yUzTQKSysJk39JDF2CF5jSupcD35buovt6K
	0hljKxfGETlwv9qwebio77WNKro5puWlE/OI+QajxY0gzmMRvSzbDtJSpF18VlGRHe08OJ9fuWd
	6yLKzBGYHh+6+MZ5b75XVswcHAOKRRcWlKD/dWJfWAO3Kn6Lg0f/qsDyllHoNq0iBbm1mw9OBnO
	iBLNDy8f/XkIK0DEeIgHUNF0s=
X-Google-Smtp-Source: AGHT+IGoHe6bWWY7VE+KaBKpfrHQT2APuxwrTUEyhlf1WgO/rBmYbMErf/UqrTteJ906eArugsK8hQ==
X-Received: by 2002:a05:600c:8b41:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-46e71102767mr74865755e9.13.1759759375171;
        Mon, 06 Oct 2025 07:02:55 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e7234e5fdsm161438365e9.6.2025.10.06.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:02:54 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake/bzr: Drop check for unset .revision after .setup_revisions()
Date: Mon,  6 Oct 2025 16:02:47 +0200
Message-ID: <20251006140246.2459639-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=SZmMXk6ecJas6iNnEOtAIirZglQbgadAM4O10v9t9Bs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBo48wG6jNhxSGPY6kXHzCDpjKgmVuJ2sSl3rXEw 3UhzT/sP/+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaOPMBgAKCRCPgPtYfRL+ TgF+B/kBjOzeV0+Lc4qc3kzzzCihKR2FjICMiEmMdAa1TxF54cIj5fbGKcReQICknqW3PA7Kitb /jspr0LHLSro8HpG3uNq1lfNwwqNhIWDQ9OcePTiyRimnPUFLtqX+Hok6koeIQdtjr3ufLI81GN 02OyLe6EJCbk5H9OzQVu2D25VcolhzEFlRi+5zpS7JSCG7/yPWCuvxGZ34ZCZuLj2t+mVoYILFz VCBhF6fyAaeoS4cUjcOFminKWVrEHSGGa3Bk0z8tXzsETA0vXX8uIVMvj306z/XRclGgMAieTu3 RfNTjCHtpi28DAFtunBNYJ3OoJZRKiby+K+aza22SJh4B5r3
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Oct 2025 14:02:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18137

FetchMethod.latest_revision() expects three parameters, so the call
`self.latest_revision(ud, d)` triggers an exception.

Drop that error path that obviously isn't used.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I didn't hit this exception and only noticed that problem during
research for another problem. I'm unsure if deleting is really the right
thing to do (i.e. if .setup_revisions() always returns something that
evaluates to True when interpreted as Bool), but it seems nobody hit
that error path since commit 7b7a4517c600 ("fetch2: Allow multiple src
rev to be used in one src_uri").
(Hmm, maybe the author of commit 7c94ca56b2fd ("fetch2: Correct a few
calls to latest_revision()") should have noticed ....)

There is a similar issue in lib/bb/fetch2/hg.py. I'll postpone sending a
patch for that until we agreed on what to do here.

Best regards
Uwe

 lib/bb/fetch2/bzr.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
index fc558f50b047..443195fa00bc 100644
--- a/lib/bb/fetch2/bzr.py
+++ b/lib/bb/fetch2/bzr.py
@@ -35,9 +35,6 @@ class Bzr(FetchMethod):
 
         ud.setup_revisions(d)
 
-        if not ud.revision:
-            ud.revision = self.latest_revision(ud, d)
-
         ud.localfile = d.expand('bzr_%s_%s_%s.tar.gz' % (ud.host, ud.path.replace('/', '.'), ud.revision))
 
     def _buildbzrcommand(self, ud, d, command):

base-commit: 7bd36f6c6d33211bb2a6b6fc6d40bdbd83b8b7c3
-- 
2.51.0


