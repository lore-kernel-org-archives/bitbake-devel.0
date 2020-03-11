Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com
	[209.85.166.181])
	by mail.openembedded.org (Postfix) with ESMTP id 303C561BDE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2020 23:28:50 +0000 (UTC)
Received: by mail-il1-f181.google.com with SMTP id l14so3737352ilj.8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2020 16:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=g3/hByNRdYRwoBcgd/CWX8cmBrW2T1FMaTwb0ROakFw=;
	b=ER0hHvcevwCuHYWSq4HHO9KCjNyPXxZNf2wLFbgx6AVYF4I1SbH3TYFNaZXZkr6ai/
	kQyIT/U1dxXnCOxtcVoKMTmr19/n+kgiv2ZFw6tg/IisEKoh3D4SvACqK9ovNNadgFsH
	yWP4zVY19Ww33smyvNUDjg0IC0V1fo36/Jt2TyB4QURGHXRub4SnRWzrC9URNKUZnor3
	BZIQahdi0FMHYuXwEyMELyGh/Va6753KuL4lZY7EyFPfAgJM+9t6kvj+/puqwc6jRzEE
	+oqks8ftajPcnNFxUq3f/23y9nfLiRQViDzrpuWYd6aFDIWeA8jnFwoZIpVL6rZrGTWm
	X2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=g3/hByNRdYRwoBcgd/CWX8cmBrW2T1FMaTwb0ROakFw=;
	b=akPFNWHKGO6HBNYCOm4Pf+b+XLQLDsAMfV8KDCnBoNNII26KN/7HUumb/LuHGZIHiD
	u8Pu4XZOIBgmm3jmuElkPUriTKxV7wmS/ejhyIimU4ueFc6AOg9Vtt60pu3AlImPsIaR
	lOXaiZK6fVKPzNkeRbi7z56xwHao2+w2P/unpBXbWkcxb2TAQdn7ExIev51qnAx4+hKA
	WVhjlR+G+MSj/Xx7GdKcj8jq10XnRfyDNXEnyhnKSnVMlvZCUs5+ibUxnRam/cd27srU
	ZI+rk7RFATyolwbaC6YSqJeR705JaLIvD9xk8o9D0S3UnNy/O/wREdbnCo0VqVEBD2Ux
	2jAg==
X-Gm-Message-State: ANhLgQ20By0Kb4T8Fhn1sfWZVLhp6AcBy6PMdGjrpLl4TPBmZGUiH0mA
	w9Sn3tchoTnctLJerLKPgGjb5/RCOoQ=
X-Google-Smtp-Source: ADFU+vtdAb4jmb6pjtiG5JF2WrDxS/o7OH6LDn//cF0k+XX6SN+UmZaGW4kemIKLCezin1lfXoR2hQ==
X-Received: by 2002:a05:6e02:10d4:: with SMTP id
	s20mr5497560ilj.85.1583969331668; 
	Wed, 11 Mar 2020 16:28:51 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id w3sm3297603ior.55.2020.03.11.16.28.50
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 11 Mar 2020 16:28:51 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Mar 2020 18:28:43 -0500
Message-Id: <20200311232847.2874-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 0/4] More Bitbake logging improvements
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 11 Mar 2020 23:28:51 -0000

Supplemental patches to improve logging in bitbake by using python
structured logging. Fixes up some ResourceWarnings and improves the
flexibility of the console and consolelog.


Joshua Watt (4):
  bitbake: knotty: Add logging cleanup
  bitbake: msg: Add helper to merge logging configs
  bitbake: knotty: Update hash equivalence logging
  bitbake: runqueue: Lower setscene complete logging level

 bitbake/contrib/autobuilderlog.json |  18 +----
 bitbake/lib/bb/msg.py               | 100 ++++++++++++++++------------
 bitbake/lib/bb/runqueue.py          |   2 +-
 bitbake/lib/bb/ui/knotty.py         |  70 ++++++++++++++++---
 4 files changed, 124 insertions(+), 66 deletions(-)

-- 
2.17.1


