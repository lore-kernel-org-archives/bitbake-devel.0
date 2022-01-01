Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671DDC433F5
	for <webhook@archiver.kernel.org>; Sat,  1 Jan 2022 11:29:21 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.24168.1641036560119751990
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Jan 2022 03:29:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=leXdgCe0;
 spf=pass (domain: gmail.com, ip: 209.85.221.51,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id k18so23418882wrg.11
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Jan 2022 03:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVN6kmvl2Xv0svDBV7ReQ6kf+RIw03oW7+wxvJyjrAk=;
        b=leXdgCe0FCpA3d6BiaBNla8IOoqMI1qLbHk6+Gg1M+OupN0xuYk7Po+KlykqMeNzn7
         /QZRlQhJcJL5GbSkzzyYnoFTpxEEmH4JyMk+c/18cwqJ9CCHz4nCO7+vdQAcVM4UQPde
         lvuvs1jo6X634XanhLksoOOpIUqgxGS9SUnZiEK56/Yzckmb3PNX4y7l4/cOvovzMV86
         3fjHcUS2nwD7IkLhmIonSMRBWASmZ/r6iCduDS1mQCH7E+nrJANEoOecMqhH/8zbsQtq
         l6OXfGovczjeryW9xko+DIe58ke9W5rrWQFjbVKB1ApZ96AeFrKh0CqzfdYKgn49lq/q
         xpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVN6kmvl2Xv0svDBV7ReQ6kf+RIw03oW7+wxvJyjrAk=;
        b=xXXPE+urdgD0r5rdTLQn2z2q/MRVMhhI1v+kosQ85uEa7uh9Vmyjy/uZNIFJGl0JD9
         4Jj2svI3e4yMqVu8xyY9hErhhoeK7xHQDh9rdtmNn30lrsnh+Eal3VxbO22AI63hgRUU
         u2WyW7wgCqOGk9ZNUu9KcpaZuq2hvUBsc8zjm9r9dzytwqmomi3DleccqqM87Dx5XeN5
         VfiPJyrJqpQRVHmPpARgwDTym77GTHu3U3BrffHUWfEdkgytJF9yOu+26l7ZpHshYty6
         3TzdJTWBNJaEaQhQYY9JbgJlhwpdEIFVnpUKPoeh+hMY6YZv72pKDV5yYbDKcqzj8IMQ
         g6Tw==
X-Gm-Message-State: AOAM531OvF0A9JVJINV0/UTm43GGUQx7X+GRZE+l1cTuqbEZZQLQoch1
	gM4MRZPfzJD8qzg6g4ZCN6jVm9k9qrk=
X-Google-Smtp-Source: 
 ABdhPJzjP4whXzvg3YJXCc39cgMg5X2xiY/niAzo3aLz6caMWj12mAHM1M8BJc00uRuEjFTLUPdz0A==
X-Received: by 2002:a5d:5988:: with SMTP id n8mr32643469wri.309.1641036558515;
        Sat, 01 Jan 2022 03:29:18 -0800 (PST)
Received: from nereus.lab.linutronix.de. (b2b-109-90-143-203.unitymedia.biz.
 [109.90.143.203])
        by smtp.gmail.com with ESMTPSA id
 a22sm28799057wme.19.2022.01.01.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 03:29:18 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] providers.py: do not skip recipes providing 'virtual/x' in
 world builds
Date: Sat,  1 Jan 2022 12:29:11 +0100
Message-Id: <20220101112911.1866500-1-alex@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Jan 2022 11:29:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13209

This is very old code pre-dating 2005, and the reasons are probably lost in
history.

Doing this skipping means that anything providing 'virtual/x' is excluded
from populating packages to deploy/ in world builds, and thus, from reproducubility
and packaging tests.

This issue has been largely masked until 'package_ipk/deb/rpm: Drop recursive do_build task dependencies'
as previously recipes without virtual/x provides would pull in the dependent rpms instead of the world target
doing that directly.

I have noticed the issue by observing that go-runtime is no longer reported as
non-reproducible when it should be.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/providers.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 8c1c31a5c5..3c4462fbdd 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -429,10 +429,6 @@ def buildWorldTargetList(dataCache, task=None):
             terminal = False
 
         for p in dataCache.pn_provides[pn]:
-            if p.startswith('virtual/'):
-                logger.debug2("World build skipping %s due to %s provider starting with virtual/", f, p)
-                terminal = False
-                break
             for pf in dataCache.providers[p]:
                 if dataCache.pkg_fn[pf] != pn:
                     logger.debug2("World build skipping %s due to both us and %s providing %s", f, pf, p)
-- 
2.20.1


