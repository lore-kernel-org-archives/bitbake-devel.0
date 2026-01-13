Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5F5D2F34D
	for <webhook@archiver.kernel.org>; Tue, 13 Jan 2026 17:52:24 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65086.1768326739603645983
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Jan 2026 09:52:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NDYrQBlS;
 spf=pass (domain: konsulko.com, ip: 209.85.214.180, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0833b5aeeso77342325ad.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Jan 2026 09:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768326738; x=1768931538; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HI62A5A5xOk1uGxBZLdL8aBpy0M6ai6dQvk5rY85d1s=;
        b=NDYrQBlSsSex6ukL6iNVmHE4LAL2sr4q/XrGQ8NCNFVmHK0SwXoOUtwsDwRq2vuW0q
         zyzjrWMmk5t8t8Uyl0uf9qM0yNulKfggMCyK0arkB1+q5k2LNxSWsUNjdBtnoD0zanTz
         mjjo+qtx4oaRe9PJKz46wWxqOgLmEG+7dvD78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768326738; x=1768931538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI62A5A5xOk1uGxBZLdL8aBpy0M6ai6dQvk5rY85d1s=;
        b=ViO8QFiLHFJ65VUjDlYHEPLBL/mfjv5jM1FWr+3a9paN9dYBV7/rPcEF56QsG5s8T3
         diduZo9EolvosRF5vkZfHYarxDH9Vaws2+Pth4t0g2imSH2m2vgbhTYNAs/jQuC3UHzF
         +FnHLXtZQfgHH3yYhBEOBIKwrO5RomJJkHmdwyFhSXvHNRQlKanbxTLIAFwZhxhhYcoE
         I4+zfjDKwgn7wt8ZjdCXmy5A+5dbp5iB0O/gxXVmoK1BdhA7pBX8WWT4dwq4e1e0TyeZ
         ePKQsX06VlsJPsoaMe2pyGrE8rs62cH/xHG2CG1TKSYAQ9Hv/OxFXu6nRl5OI23XKhGc
         KrVw==
X-Gm-Message-State: AOJu0YwMETCjRdI2G7fEWmmEvEpZJn1i+bOVeef4vACHXsNazOcVE+hk
	B3Gsjr2Y+UTJ7nSMKEdQI8KDSqbnrQYSLaRLQHNxw0vC2x8Eco7+5VRtZX9fRAfItMfDG751WcM
	5GPef
X-Gm-Gg: AY/fxX4XakdPMnlROIjDX8YpsI5r8q4nIrXx9MFNLNqIQN4XfUThzf+o2BYfK2zYy7P
	Ed6/lLwdzsZWhslJsynE9L/ow+EZrGBzrZ84AWMMn6ISFNZYpLLb/SwzfH+xkGmDYI/mdoA1tmU
	w3pjrfPJQdXKK8qvBPdU5DmAzjEZm4dDa0ktLrMhto7GqV/EmvNepEuaUsOai/UvRByfa4Uo2Nd
	KAmcOAqAe3VM5z5GdzQYUQjFIvmv5AavPoNbQy/RiEdgCtG8vAuKdbiv5XJcam1/iF6ws2OkH55
	cEQKsDa6VTGqWZezi82Q50/3KxVbUs7NYeM5MW3jIw7C/rYU8cq+Tjiq5webI7/FTzaHtPKBb/1
	qLGdiMjyMShsQjYq6UT8kS0AH+T3a84zL+COdPDMRAVCEbmRUm62aBPc+uBfecxJb1c2GIKjitL
	dfldNlB5Vjrx6XbNGYcE8j/BhE0DhQnEafda7Zii6/sJDmQeGryg==
X-Google-Smtp-Source: AGHT+IG3YeL+JhHnyBhc5eRR+uICKIn/7zCNdvtuwo4FUdakVvD3Sjo+xlDRfg9PrdvM+1JwAfKsyg==
X-Received: by 2002:a17:903:15ce:b0:295:62d:5004 with SMTP id d9443c01a7336-2a3ee456360mr203023065ad.26.1768326738343;
        Tue, 13 Jan 2026 09:52:18 -0800 (PST)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2b4dsm210625015ad.54.2026.01.13.09.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:52:17 -0800 (PST)
From: tim.orling@konsulko.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH] doc/bitbake-setup: add example of ssh:// uri
Date: Tue, 13 Jan 2026 09:52:14 -0800
Message-ID: <20260113175214.2570644-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Jan 2026 17:52:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18745

From: Tim Orling <tim.orling@konsulko.com>

For private git repositories, we often need to use the ssh git fetcher;
add a hypothetical example to Generic Configuration Files Reference.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .../bitbake-user-manual-environment-setup.rst        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index ec1bdeecd..635e0c76a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -687,6 +687,18 @@ They contain the following sections:
                  "local": {
                      "path": "~/path/to/local/openembedded-core"
                  }
+             },
+             "meta-private": {
+                 "git-remote": {
+                     "remotes": {
+                         "origin": {
+                             "uri": "ssh://git@git.example.com/meta-private"
+                         }
+                     },
+                     "branch": "master",
+                     "rev": "master"
+                 },
+                 "path": "meta-private"
              }
          }
       }
-- 
2.43.0


