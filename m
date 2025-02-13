Return-Path: <louis.rannou@syslinbit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FC4C3DA4A
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 15:06:02 +0000 (UTC)
Received: from 3.mo561.mail-out.ovh.net (3.mo561.mail-out.ovh.net [46.105.44.175])
 by mx.groups.io with SMTP id smtpd.web10.13150.1739459153197121662
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Feb 2025 07:05:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@syslinbit.com header.s=ovhmo4479509-selector1 header.b=QqVHQ/P4;
 spf=softfail (domain: syslinbit.com, ip: 46.105.44.175, mailfrom: louis.rannou@syslinbit.com)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.108.25.136])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4Ytz5W2GtTz1WB8
	for <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 15:05:50 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-tfz7l (unknown [10.110.178.109])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 56F1E1FDEA;
	Thu, 13 Feb 2025 15:05:50 +0000 (UTC)
Received: from syslinbit.com ([37.59.142.104])
	by ghost-submission-5b5ff79f4f-tfz7l with ESMTPSA
	id MQGMAE4Krmfl8AAAvMEkeg
	(envelope-from <louis.rannou@syslinbit.com>); Thu, 13 Feb 2025 15:05:50 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-104R0054d6b78e9-7a05-459b-811b-5f0541f55738,
                    A3E930DA2C8C0F3093FF869A1907ED10BC64B092) smtp.auth=louis.rannou@syslinbit.com
X-OVh-ClientIp: 45.81.62.9
From: Louis Rannou <louis.rannou@syslinbit.com>
Subject: [PATCH v2 0/2] bitbake: fix ??= operator for variable flags and
 test
Date: Thu, 13 Feb 2025 16:05:41 +0100
Message-Id: <20250213-varflags-v2-0-884794e84e55@syslinbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEUKrmcC/23MQQ6DIBCF4auYWZcGMUDsqvcwLqYUdBKLDWNIj
 eHupa67/F9evgPYJ/IMt+aA5DMxrbGGujTgZoyTF/SsDUoqLVWrRMYUFpxYWK9NsB12vTFQ7+/
 kA31Oahhrz8TbmvZTzu1v/YPkVkjRodXGWcReuzvvvFB80HZ16wvGUsoX8eLuxKQAAAA=
X-Change-ID: 20250212-varflags-7e56f73a3966
To: bitbake-devel@lists.openembedded.org
Cc: Louis Rannou <louis.rannou@syslinbit.com>, pascal.eberhard@se.com, 
 yoann.congal@smile.fr, Louis Rannou <louis.rannou@non.se.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739459150; l=1218;
 i=louis.rannou@syslinbit.com; s=20230614; h=from:subject:message-id;
 bh=dUDC9XNd8AqIWwWbFO7K6L1mbggjMX2GKcTuTXpqZjg=;
 b=QffYs2NwLB1vSHaldfdJRDYaXkDz/eN28R4ZTfCJTviWmyceKQoHBB/282VERuw/v38SwlA1h
 A+568awq8CkDLZGhWq7KiKSkGNbc0IBQHiG0YGs2kGSx78hxHZy/oHF
X-Developer-Key: i=louis.rannou@syslinbit.com; a=ed25519;
 pk=QLSK64UNeqThVe2CiH917a68zTpexYuA7iXw6WQ0bbI=
X-Ovh-Tracer-Id: 742530990807637381
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjedtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucftrghnnhhouhcuoehlohhuihhsrdhrrghnnhhouhesshihshhlihhnsghithdrtghomheqnecuggftrfgrthhtvghrnhepleegfefffefgtedufefggefhkeevfeejffduffdvudeiveevteefiefhvedutedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpgeehrdekuddriedvrdelpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehlohhuihhsrdhrrghnnhhouhesshihshhlihhnsghithdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdpoffvtefjohhsthepmhhoheeiudgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=rIpGTKmbQyTIrXDXvS4bLgZh3+h20WBXCLdj3gm45yw=;
 c=relaxed/relaxed; d=syslinbit.com; h=From; s=ovhmo4479509-selector1;
 t=1739459151; v=1;
 b=QqVHQ/P4a9wa6AvVf3ocY+5WtN2zeGCZcEkxe2sFC83Ky0wiUpQZSNEIHlABPAm6zAgl0jph
 bP3+DvfXhrV5CPbveI7S3njrPqDHGwBdd5bAXcjgNGy4W7jp95QvCgZoJXvxGj3lZUziD1WzZ34
 kMS1Yx9DHU7KJ306siTZwvgWjGsEPrXu++zuWCPJvrfmGQSTwBQbjwMMcKEIdpZkYVvb4Fr5dNM
 JGEa0CN0NCeSE3Z5K7lcUWd7wn0HptfD2IYvcrxLu+HlNKummiO5+Rtvuxp5DTcfZT3+ln13eIQ
 e3HMYbex/+IR738UAPOiZaFcLHz7ljWnZKwbjhFBK5ISQ==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 15:06:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17213

Since commit 0329a7e3ac694737f2d2c1861f65492551360663, weak default values are
omitted in getVarFlags while they were only incorrect before. They were also not
removed by delVarFlag.

The first patch fixes the issue, the second adds some tests around getVarFlags,
delVarFlag en delVar.

Note that delVar blows all flags. Please check that is expected.

Fixes [YOCTO #15685]

Signed-off-by: Louis Rannou <louis.rannou@syslinbit.com>
---
Changes in v2:
- update first patch for a prettier solution
- change the place for tests to data.py as it is not testing parsing
- add tests for internalflags, delVarFlags and delVar
- Link to v1: https://lore.kernel.org/r/20250212-varflags-v1-0-3a756c7aa95c@syslinbit.com

---
Louis Rannou (2):
      bitbake: data_smart: fix ??= operator for variable flags
      bitbake: tests/data: add tests for variable flags

 lib/bb/data_smart.py | 15 +++++++++++----
 lib/bb/tests/data.py | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 5 deletions(-)
---
base-commit: bcf090ed631bbd523a5341baebba0765f1a847f8
change-id: 20250212-varflags-7e56f73a3966

Best regards,
-- 
Louis Rannou <louis.rannou@syslinbit.com>


