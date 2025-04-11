Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D3C369AE
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 14:46:31 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.28161.1744382786934445978
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Apr 2025 07:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=VWF31Jbz;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD92B43ACA;
	Fri, 11 Apr 2025 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744382785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xmwo8IWbAg1DJKF79MwXV/+QKW/6nezSczTiSNtMu8Y=;
	b=VWF31JbzXDpr9i8l0vMhD7QMJITStgs8swx/JZYuaFtva8NCU5AZa6MiRlpG2iAZOPvzJz
	eFOqwkNcsWscmWr8D7ucLvBrArTrS/+MmU0dG/BDf5HJfMejQXvUJmApcPZkde2fT/DUcE
	UIr0JnSXNln1VjJcK0qXCyFyiQFWY2DqV5g+4zgSyTbapiai16Mgot2wj70AmXUO0zxOKo
	beuDuqr7C/FRI1OZzkO9EjlAfUVKq+e0v9McaXAacrKtgK/yvaSFEY9ANgS/7yEYsHdnLj
	1E7kqcC8c5z6y+m2AA04QtevGw0lw8+ZuCYu/BxMMFbm+VWTjVGbpMgsJ5jz1A==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/2] Improvements around BB_PRESSURE_* variables
Date: Fri, 11 Apr 2025 16:46:08 +0200
Message-Id: <20250411-bb-pressure-improvements-v1-0-7d9e3593167f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADAr+WcC/x2MQQ5AQAxFryJdm0TFJLiKWJhRdGFIi0jE3TWWL
 //994CSMCm02QNCFytvyQDzDOIypJkcj8ZQFqUvKkQXgtuFVE+xad1lu2ildKjzODbR1zVOEcH
 uZk18/+muf98PwyAtEmoAAAA=
X-Change-ID: 20250411-bb-pressure-improvements-51d9c5881fc1
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=C1znro2PGmbWRfH1GQG7XAQ2XjoyZFr+ikUj3tvdMZY=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBn+StARz+SYcAbm9SKQOdnNGVSm+EwYGWyxvPRG
 TCXe1C5HLiJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ/krQAAKCRDRgEFAKaOo
 Nlw3D/0fyNJCCh7ynwLU2PQURq2NroBAT+c51RR0nVg01wA/CLdE028R1DDu8EBhg6NN0SI7nxS
 qOEv9mxCl1V1DlJnb1wMZ97DzE7eBw+oQFW6hrK/Zr8519FRSu6+/U9IlMGzgF6X9jUmrCU/yrx
 ZRa3LQf4x7sSfzq+kDi2fUjqHZxye5h7PH3fTL5b2W8e5ds6Mrw8cTCjbvf6xKiKU91PvTiOEnd
 ESljZ6rOivZt4Qj04P4meezN0eftILD/O1bIyNYf4lvRpXo8hQuuE8Y/JT+RRX5n5R3GOmrQGHd
 vmaUqO2DLgVpsnHNGtV5vaNJf2oG6qFHxSBiLGGhlKVhybLhLemPT/k21ehdAz8nKC5ygRcchfm
 5Fnfs1rW+xPDoSNE4CMHp4a3vliVIafc3o/Y3KMEUfzDjkOEw75xcV6Es50l+coXlN1vVt57Yos
 UK5oc53kamBWQ4l9LvW4HVQvlQJBNa+eYK27Mjip/DCmPFLdtz6rjQAO4InnjFmw0U4PcAyKCgh
 Npxlt9BZ6j/nL8kUxk/9MIXUk/y/ckKZ22kuIZPTpKKg30QIzUskZuJsH997+L/0QM5deAfFTcq
 pOm8hca5VovSWmDUoN5Monw6dyTYW8NLtgq8jhTSPJYAuGPRCqV2KbT3M8NjSITOby/S+osB9tx
 BzEp3EFGUXyPlmA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduvdefkeffteeluedvgffhjeegffduveegfffghfejteejkedvgfeuvedtudejkeenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeisgelleemvghfheegmedvtdgrfeemiehfgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeisgelleemvghfheegmedvtdgrfeemiehfgedvpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtr
 giiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Apr 2025 14:46:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17526

First patch makes the BB_PRESSURE_* variables not spam the log with
messages by default, unless -D is passed on the command line.

Second patch improves the documentation for these variables. The current
default value is really low and 15000 seems like a better default, at
least from my tests, it prevents too many tasks from being executed in
parallel.

Mention that these variables should be tweaked depending on the need.

This is a first step to providing better information on how to control
the resources used by bitbake. Later, this information could be reused
in a more general guide on how to do so - in fact, setting BB_PRESSURE_*
variables only do not impact how many threads a single task can use
(that would be done with PARALLEL_MAKE, probably).

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      runqueue: decrease the verbosity of pressure messages
      doc: bitbake-user-manual-ref-variables: improve BB_PRESSURE_* doc

 .../bitbake-user-manual-ref-variables.rst          | 37 +++++++++++++++++++---
 lib/bb/runqueue.py                                 |  2 +-
 2 files changed, 33 insertions(+), 6 deletions(-)
---
base-commit: 874c607f475f3d60677d2720b80a28d0c2e963c6
change-id: 20250411-bb-pressure-improvements-51d9c5881fc1

Best regards,
--
Antonin Godard <antonin.godard@bootlin.com>


