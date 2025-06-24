Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375FDC7EE31
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 09:38:47 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.4651.1750757921812719144
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Jun 2025 02:38:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=bbN7mA2t;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 867B241C06;
	Tue, 24 Jun 2025 09:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750757920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=10NoUXvh24wM5KaIo5bYxpBcPY5MFwkaGgUlOKivOEc=;
	b=bbN7mA2t1beyIfa0BiigeKxMpglVk3gJmpi0gQ2w1outon6ORDmCzgjUTdZfoZfOhtcCfB
	Joh2PyhPI+l0kP3+slaHYG9a6pndfd87iKSFce5aafzYk/Q8lMPbizGYAYATNOw0ptcCqw
	sy4YXONTp5fLAN9FQQUpTre+gnVYjh2dxdHdlN5DiTccUOx0torlrSeAXE2TJ6dZRPBFEj
	5NjMwd6N/Bl2KmuNPuAnxkDPswYkTLaX+T7n57b46gtKTLyZ9KbPQDlHMhP1yGxS2hhrMR
	ZqncrSAfgn9vutt8985IRAQZ4moQ1JC3fDOzVy8S3KSPQtDkVPPimIIZZyrFbw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 24 Jun 2025 11:38:28 +0200
Subject: [PATCH] doc: bitbake-user-manual-ref-variables: document
 BB_GIT_DEFAULT_DESTSUFFIX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-git-default-destsuffix-v1-1-a0cc44734f94@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABNyWmgC/x2MQQqAMAwEvyI5W6i1WvAr4qHYtAZEpVERxL8bP
 S2zzO4NjJmQoStuyHgS07oIVGUB4+SXhIqCMBhtGt0aqxLtKmD0x/wl73zESJeqtI3eaVFqBzL
 eMkr9H/fD87wMjireaAAAAA==
X-Change-ID: 20250624-git-default-destsuffix-104fa7006237
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Alexander Kanavin <alex@linutronix.de>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=j/WnFR7rRYGLdR447Bgue5oq3d0+9nOVC+YXod1C2Y4=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoWnIfYTTasYojXEP2nK0+hlshdAvQwVWX+L5Uf
 Ry3sN4f04uJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaFpyHwAKCRDRgEFAKaOo
 Nl5zD/46xLDo5YUmG6fQeJaZ5TrqwK+CB1Sr9/Mcr2n4MhS8pX6KCRekI4UIRi3cJqcxscfNeeL
 u3PvOmn6o72+MKSugzid/2x1yb/FGOZagwHvnwbwi/sFCAq4wnp+7JRerxbX/HEJS0cScPTnn4+
 iShxjIdxHXgdLrmM2toV1Zl1i7xCYdoPqIfyjfxT1Yg/1ejj5KIs8yK5TQRWcM+NHYtXOssSd69
 W5PdYxR5oWDvJBIBRK7WXM5W14oqYAu9Y0+OUi/irbhwUxYZq6H5d5wPdQAAse5XFm29jtmc6VU
 1hWFAGWW1PaWwe57AMTd691AVOLP681dJRmnRs5zRkEa5bt5ef6YyWFGZRjVCUi5AhksVZymYxm
 TAUBLI2yBxEe8hRJn2dWAus7ofcuwKq2wWYv24UjaKO5ax2Z7EymDfuaPFHgWsRZYdMCrXG/kpy
 u5zrhsrNPlF7HrPXlQgpElobn2O38HnwQGRpAKWk7HfJ8+kW4NUMyYO9nJi943fYy8blDSs2vO1
 qAdoxgoeK5Mr0wlTCQNoYdOZqnV1PrEw1YR2zReL5iQunpLzLjA2Ixej3BaF5Z1UopEkwVtWewd
 +07E5++xiWg+UmAaQ9axJHiEdQPBCku7fhZ4jmmwL/+FrqZFpxFh69u4P/wAUlNum1Di3VrVSuQ
 1LE9TxvhyeBZ3Rg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduleehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfefhheefffejgfdvtddvfedthfeufeevtdeijedtudelgfefvdeigeefgeevvdegnecuffhomhgrihhnpehrihhpthhuthhorhhirghlrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheprghlvgigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopegsihhtsggrk
 hgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Jun 2025 09:38:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17710

This variable was recently added with 378db0fdd95f ("fetch2/git: allow
overriding default unpack directory with a variable").

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 477443e228..1069604438 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -310,6 +310,11 @@ overview of their function and contents.
 
       For example usage, see :term:`BB_GIT_SHALLOW`.
 
+   :term:`BB_GIT_DEFAULT_DESTSUFFIX`
+      The default destination directory where the Git fetcher unpacks the
+      source code. If this variable is not set, the source code is unpacked in a
+      directory named "git".
+
    :term:`BB_GIT_SHALLOW`
       Setting this variable to "1" enables the support for fetching, using and
       generating mirror tarballs of `shallow git repositories <https://riptutorial.com/git/example/4584/shallow-clone>`_.

---
base-commit: f1175778108a559e1dd0d55cb68f42816c86f393
change-id: 20250624-git-default-destsuffix-104fa7006237

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


