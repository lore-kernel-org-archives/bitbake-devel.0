Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98093E7716D
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 20:33:46 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.25351.1733344426135564011
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 12:33:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=1OGA3IzZ;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.43, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so178440a91.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 12:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1733344425; x=1733949225; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqIdPLA4RHcPNLEI0a3AjzGF2QGUHUpEvH9zTA7OstA=;
        b=1OGA3IzZEt4mALNsvLZlmSzj46c6nWlbDTaS/Yf2GkH6CvLPKvKiJJvB1yRVjKeVUG
         16iNLGUD234CxdVomstCjtudXzU7uqKaAwjTPJ/vNavA1GJlK+svyKEwis+DfSxDlvHx
         i28+a5X8+5r1J8v2ARlz84c8HvxRrS62ESD1h09jqHLoovkSbc/8gXIq0jgYN9K7LuHf
         u9e/np6TcgoAM9rIbca2Y6NIkdUpsrkRuBau6G64y6iHPlc3hlPkfhvud4+uvw6/4cO3
         VQMjddYX/T27jnLQdpT836YUP5cBRaSW86e+JdPxjLz3plmKPrTpv9KKvL+bXh6pvGAS
         SWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344425; x=1733949225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqIdPLA4RHcPNLEI0a3AjzGF2QGUHUpEvH9zTA7OstA=;
        b=rhtUzhoI74eEG2q0yjYuqVE5T8HbikWl85q0TlkL4mA2qTYu1GqVorMS0uI6OAxjpM
         KF6Pp4THbhLFykEl2kFlsKED4rvGut4m/vADl8sWC7UlpYKJ2AJRI+SnPDjH3wLwq7mU
         fIxIbOfUh8lMqwgjdqgHzVVl9ygLo+2tWo58t/A9lKp9aUteXdWfGNUcDPq+zE/284sx
         2U2rSvjgUpMo/Y+0aTMJrCETPnZTMqDRG2pdBsR53xJjrEOZaWKfdcvxlx2CeNBezHKR
         qRb0Llda1g/T0lscW4j1Vhv3vL5enSdmhaEvXU5N8aaYJKI4TeapTN4GEcpFOnrMZ1o6
         zyXw==
X-Gm-Message-State: AOJu0YzXau1fFD6wBC86uwfN5nMOQV972xs3m11JJxVKR/8viCqyeLDj
	N9Cmh/WyapQMoe6uGyq8fp1VaUXOQp2a7k7ZAdczYnmWUHiHjeyzp2VCbqBLyjEmuMQ14G4QrZN
	o
X-Gm-Gg: ASbGnctP90ENFZlbuhpt8RfQWyAvfX7CAR/oJdHGaV55dmxWW6jO7Llz1BHptjMsK8M
	OLU/9H9TeQ8Q2GnHjqznm7b1LkgJusscFNpwo7kcOTm75AKbzgNDscB46hQ6l0C4pV44XtcLQKG
	vkXz5MxEBGHV7DDvNuWcwqF0+ZK4v53fv46y4BrPnQEu0AZgK3szDiiWRbwJj0+h1urL7y+FtUK
	4sfIDv3GPa7ouiTF2VPVHmoYv+zlKRIYe01vZQ=
X-Google-Smtp-Source: AGHT+IG3rqE7Dolwwg7luHKcZZgSpBDw+pYNcI5Vz6ku5YS9OxvlKwHU0XNKn/DYLkRII6Ed7p7/bw==
X-Received: by 2002:a17:90b:3d10:b0:2ea:7fd8:9dc1 with SMTP id 98e67ed59e1d1-2ef1ce964eemr7615659a91.18.1733344425370;
        Wed, 04 Dec 2024 12:33:45 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27062fa1sm1873984a91.45.2024.12.04.12.33.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:33:44 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/3] Patch review
Date: Wed,  4 Dec 2024 12:33:37 -0800
Message-Id: <cover.1733344286.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 20:33:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16869

Please review this set of changes for scarthgap/2.8 and have comments back
by end of day Friday, December 6

Passed a-full on autobuilder:

https://valkyrie.yoctoproject.org/#/builders/29/builds/582

The following changes since commit 6c2641f7a9e92c1b82e306f59ddd3c1249c52cbf:

  fetch2: use persist_data context managers (2024-11-28 13:59:58 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

Richard Purdie (3):
  runqueue: Fix performance of multiconfigs with large overlap
  runqueue: Optimise setscene loop processing
  runqueue: Fix scenetask processing performance issue

 lib/bb/runqueue.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.34.1


