Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE89CCD98CF
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 22:53:28 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33443.1781132005764784436
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 15:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=cALdIyNe;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so50063965e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781132004; x=1781736804; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv/H1P35AS67J8PRe85/IL92ZBNvEdqmnpHcjvdWzHM=;
        b=cALdIyNeqLw6poIOk/ojAGTzt01IulubncARxiHIQE559EVgXyhnT4T73un/YgLSu7
         ZUnAZqguYZbu4Q22LyAdwkPzT6auccwTZ2+7+aGh5x4wUlior+z+PPz9KeLdUCHkTv2I
         rI6/6AFC3Q7AZSRxMIiDtfsSDzoKTDkqenhC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132004; x=1781736804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mv/H1P35AS67J8PRe85/IL92ZBNvEdqmnpHcjvdWzHM=;
        b=B9zUMqTO4IpgfaQt3Z5IHz/dFX4cw5i1AuseaNEjNMZ+bLLhP8xCP7HjSNdOTGSrhs
         6UCs1UdviKTzEQXVeHroI4p57VC0P0F8NzOj33hfhMIDNF0KoUUCXo9XWJQ/DxpqhB4v
         U1XZRp7l/Z4Y5NAcAgWRf8VSle5HDat5wCeczkrkJugOAUz7B5If9vy6mMeZZfeg0wty
         htk58DlZk6jwhLzFGpzXzE29308Fp/cMtk1tmbjoKbgzU70hke28RpERH+N4+UVjsx6+
         dPaoe6h5ktf9KqR31bhOXwdpoIJm9qu5kNYojc/n6yUo47oH0PdU8MBGIOZJlo2pVlZw
         dVLQ==
X-Gm-Message-State: AOJu0Yy3bEbF3CmOBD3simMuCEcMyZEz9Wg/xyYipfUEsMeiiHz/Esur
	ST5cp2nfFF3HYU4EnBGQ/ItQ9LLzuuHa/uRefEXkGWJPSNL/TY27gwey24RsiLoHfZdDqMHqLl0
	LHu5G
X-Gm-Gg: Acq92OHy8AtTE4XpZnBeXrb8Qg7LRJz9nILaJ82FyI5pIYrCledadeUjRXLvPrtQeCZ
	tkRlVzywhZCU3YR9Fa/ISB4xMrC/GLHvUXAq5qhNF22jjoED87IJi2fXS1BAPqpsdUzawJsgI+F
	UBW/ij1q8FdAGUneTDL9AqI8iCIpPz+bVwNg2jDdzdlpkJp0IyS/HXgfdIei7zRMNNoF35Oc6Cx
	cuzH9yZuKhvVE6jcZfzYQWxkNTTW8rBYaWxgMmrj4sHTiPjXoQumotiOqTFAuGU2PBrGnbvJl7l
	RfbpnRrxXOEzjTSXGVtMSsdjjaeXBlJ79PpIXTxDFBX+jbs81EYmR6nKwBOlBMEtgVaqh/oJubj
	ObIysir6I9GT+sUJRx5vxNtJvxk+ymfX3UZeC4A1qbLDzHZnDrcIqjygFfvLl8RMFL2/tNii5M6
	ql2V8Szr99bXS150lm6hfAugtfL5blti38bOgUuHs8KiF6EUsdBzyLxraBjDOT4UKbVb1mQgXsF
	UHsNmIplRnYIuExwnQEAjb6pMEU505/7dY8tGI=
X-Received: by 2002:a05:600d:849c:10b0:490:b58a:e6ff with SMTP id 5b1f17b1804b1-490c26e1aeemr294521555e9.22.1781132004118;
        Wed, 10 Jun 2026 15:53:24 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00bb749f54eeb85d7b.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:bb74:9f54:eeb8:5d7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm132348771f8f.29.2026.06.10.15.53.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:53:23 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 4/6] fetch2/crate: skip yanked versions when reading cargo index
Date: Thu, 11 Jun 2026 00:53:06 +0200
Message-ID: <f457e8a4ba2b5b601c0eefa94072d69bae4d461b.1781131922.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781131922.git.yoann.congal@smile.fr>
References: <cover.1781131922.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 22:53:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19651

From: Thomas Perrot <thomas.perrot@bootlin.com>

The cargo sparse index marks yanked crate versions with "yanked": true.
Treat those the same way as non-existing versions so that version
checking never promotes a yanked release as the latest one.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0d757e8dfff7c5d338a01437960d60312e9af490)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/crate.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index b89817ab9..d84bae0bc 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -178,7 +178,8 @@ class Crate(Wget):
         response = self._fetch_index(ud.versionsurl, ud, d)
         for line in response.splitlines():
             data = json.loads(line)
-            versions.append((0, data["vers"], ""))
+            if not data.get("yanked", False):
+                versions.append((0, data["vers"], ""))
 
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
         return (versions[-1][1], "")

