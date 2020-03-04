Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
	[209.85.166.49])
	by mail.openembedded.org (Postfix) with ESMTP id 347076021B
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Mar 2020 20:02:28 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id h3so3810642ioj.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Mar 2020 12:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=eZsIdKG0Kab7MNgDa/Coj+hRm5TWxEhHb1YwRBf8VbI=;
	b=VyetLWeNNubK5Wj45DvjqfnlSv53yHw+/iV+gstLYNKOiMN+3krFEDqcIKNVh5MtRB
	ygCP1XOvqOR8bcNXNA4XWY9gjbg0AtJkhhaOwUhKunXiHEV088LL0KCjWvGca199oDFY
	TA5cfBYUOaGMMfOTmzGaNzYfe03U6yBolKXFcx1qHf+5wbhEwpale9ADQm26cqdlUDy+
	Z+K/bEFCdDk3af8RhaadcOax8ZAnNMsCBQu46kIOYrlpyDH1vDWEKHg1LRXiZK/40ugZ
	7hOnab1KXYXOZaPRDZ/lmO9M++4Kg6NQd7aue2z31pLKnGAbmFTDPNCx6mOUs6ny1v8c
	cjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=eZsIdKG0Kab7MNgDa/Coj+hRm5TWxEhHb1YwRBf8VbI=;
	b=kElu7a45aaG3PIjVF9YjcxfrisLX+GoH0fS/8LODLm6G2aasvkKQ15ErCCim+vmhO/
	cMDe/gOAfs9DwF6G1wRGSoVu8TAO/mgk//QDDbPCozFOHqTfsdra2iBke84d7Dp50ZTy
	aWfqSn4hnKbL188fvN3jMHeOrj8tedHo3HFh/bREpid7JtpG4e2sRyOwFnl1j4m1LYV2
	1nOF3o5Nn5zDi2rD5IRtBa9nfc226l4vrR+c9q93nESaUMra0JL87iBoZoJY+NhBgqjE
	N0p5NqAt3f5Wz/JlDMr/NphT49v9WzjzB4AcXvb4Xqxua9irQzG/rIx5n4pqcJnCxzJ8
	tlHg==
X-Gm-Message-State: ANhLgQ1iqU8/l2etPB4YTq4FePahkeUuJI0cXivkXpjEaQqoW7dyqy3d
	cfPrCA6mOG9h9Gyoxkf81HxVsF/r6bQ=
X-Google-Smtp-Source: ADFU+vsFwrIbdb20xEc4O6jnmwHi5rWpEcQex3uvdtE2Sgry9fOZm2RUDG83h+byRybgGjzMI2ocyw==
X-Received: by 2002:a05:6638:38b:: with SMTP id
	y11mr1030218jap.81.1583352149528; 
	Wed, 04 Mar 2020 12:02:29 -0800 (PST)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id j4sm7310626ilf.21.2020.03.04.12.02.28
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 04 Mar 2020 12:02:28 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Mar 2020 14:02:22 -0600
Message-Id: <20200304200226.23771-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 0/4] bitbake: Add multiconfig to 'bitbake-layers show-recipes'
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
X-List-Received-Date: Wed, 04 Mar 2020 20:02:29 -0000

Implements support for specifying a specific multiconfig to use when
running 'bitbake-layers show-recipes'. This required fixing up some of
the multiconfig support in tinfoil and the cooker.

Joshua Watt (4):
  bitbake: command: Add mc parameter to findProviders command
  bitbake: cooker: Respect multiconfig parameter
  bitbake: tinfoil: Add multiconfig support
  bitbake: bblayers: query: Add multiconfig option

 bitbake/lib/bb/command.py     |  6 +++++-
 bitbake/lib/bb/cooker.py      |  6 +++---
 bitbake/lib/bb/tinfoil.py     | 38 ++++++++++++++++++-----------------
 bitbake/lib/bblayers/query.py | 20 +++++++++++-------
 4 files changed, 41 insertions(+), 29 deletions(-)

-- 
2.17.1


