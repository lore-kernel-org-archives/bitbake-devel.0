Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E87D185EF
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 12:48:41 +0000 (UTC)
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5608.1767876515924860413
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jan 2026 04:48:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=Ela5rsqn;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=BfpfEOrE;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.151, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 26B9B1D000EA;
	Thu,  8 Jan 2026 07:48:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 07:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1767876515; x=1767962915; bh=L/
	ammPK4Erq8xEYRblAI7EnBNktAJHv9gvz0w7ge4S0=; b=Ela5rsqnuKZlklTIvU
	s74NRIni/rPfV7U/XNVSuccRRvdAZu4wRTePsucprFDHwjkib2qkx14kcKCFVfWp
	IYmZzyMHnLqaREY61i8U12yZvXAzqnV4KW1bRez0PV4OKez3xO2dc0I4jIGEaJs7
	H/98+W0K8Z0Yr7AkiUuLa3VdA6Vl0APqAIcjSA4lO/IPrPNg0ylpb+Av79+g2OyE
	CDizyruVg71M/PLS4eKg32e7xE47GXpK99MUUuf9kN6a++abtR9A5IFtggP/o+7m
	lRkFnjMWwGJ/BfLuihakBoZ4cBPPousBbl5WA7wqKlnwQVqFeBJ1dSoMntj86BT7
	DT6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1767876515; x=1767962915; bh=L/ammPK4Erq8xEYRblAI7EnBNktA
	JHv9gvz0w7ge4S0=; b=BfpfEOrEgZb0pZ3ZQjtAVIZTV52jb9RQ3QfEf4sFC+RV
	Jld5deYyMcv68jMh2Ej3ZlnJz7PVGP9xonbza6yTbVVkyKIDhfwOoxEpMnzarW+a
	bwuVa2QzAC4HzAlR2ybZZHCuFvAQvUi6fNZhDXz8I6mY2SYUJqilmfBlY4IejqLe
	Y/Xr5GBKjEUwMTnEjRDlNqbQXoPK4xoD4SWB1UTYM+lpIuOiJBqViZq1RZKMLZDT
	uz1hZcPmCB2joami0txAWB9fxa9IWZy2oYCK5aNbVRlaCUt1P6hSdhNKZaocaEnH
	aLb0SleM0FrTN1Lnta9WgfognlHKCzIpx8rxgRoEuw==
X-ME-Sender: <xms:oqdfaZL0cWJ_bcc0Yor97Mxbd2k8gEJnknuZDUd3jvJV_zD0aNq35g>
    <xme:oqdfaclFqhCujKyYFZiYEInyonf_pWUnbb3KYqU7g8SJnJVRO5i-H91QwxDuYBNtc
    4oUGBkcwfAdWHRWXI9VlwgEsoQJfm82BuBbWT2-BbCN1e7n0bR6>
X-ME-Received: <xmr:oqdfafFU_OqwOFJS9YxVcqFitJmwwPE3GJbMSI9VVsXaVkauMTC6Ko_MQcIzx1bEE_3ozXyH1NVRbep5Ah5fYz8W4a66t6E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    efuddvudektdejfedtgeeljeefffekvddtieffgfefffeikeejgffggfektddttdenucff
    ohhmrghinhepphihshhhthgrsghlvghsrdhphienucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghithgsrg
    hkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghp
    thhtoheprghlvgigrdhkrghnrghvihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gruhhlsehpsggrrhhkvghrrdguvghv
X-ME-Proxy: <xmx:oqdfaUE0t_Z8Iws_-Pk78pz6aeUNi-xI7Q301oYcMo56sobFLP7ukQ>
    <xmx:oqdfaUMhQZkdk4USpFB58hHykAHsmqQzBHL2CfM5s39hOKi9w13lqw>
    <xmx:oqdfabHc8pI8qpV2MjUqQVARpkor314K6C67PoLvQ3s9FwxLr9erSA>
    <xmx:oqdfaTMHriIUQ99A3GSiCsrlMOh_KIR5BvrFnNTM2e0g35psiGjHWg>
    <xmx:o6dfabG-sIJ380LsBKxM1mwjJbdRKlLmw3FESU8I-avbyvKetBn9LiK5>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 07:48:34 -0500 (EST)
From: Paul Barker <paul@pbarker.dev>
Date: Thu, 08 Jan 2026 12:48:31 +0000
Subject: [PATCH v2] gitignore: Ignore bitbake-builds directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-ignore-bitbake-builds-v2-1-a70cdbbb6d6c@pbarker.dev>
X-B4-Tracking: v=1; b=H4sIAJ6nX2kC/4WNQQ6CMBREr0L+2pq2BqGuvIdh0dJf+MEA+cVGQ
 3p3KxdwNXkzmZkdIjJhhFu1A2OiSMtcQJ8q6Ec7DyjIFwYt9VUq2Qoa5oVRONqcnYq+6Omj8H1
 bQmycrB2U7soY6H3sPrrCI8Vt4c9xk9TP/beYlFAiNNaYCxpZm3BfneUJ+ewxQZdz/gLF4nnPv
 AAAAA==
X-Change-ID: 20260108-ignore-bitbake-builds-dc8108e7b05b
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
 Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=781; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=POhsUiKzoTSGv2085FhAmqARj5RjOSMO8lm2CMzGFeE=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWTGL190y19lYlGHtLfEBTYP391ffv9Sfu4fVfWb+cKN1
 sObjnx81lHKwiDGxSArpsiyuefr/ae9jrwZIbcUYOawMoEMYeDiFICJHGllZFhgsb5mt6Hb11em
 nxsSM0P63Kebbv76kmfryRun9mW4nnZl+KdWdUJ4U82BkDml/hHp+pKVL3V67kl/DakQ3t+93nC
 /FBsA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 12:48:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18710

Running `./bin/bitbake-setup init ...` in the bitbake directory with the
default bitbake-setup configuration creates a bitbake-builds directory.
Add this to .gitignore with a wildcard so that any such directory is not
tracked.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
Changes in v2:
- Use a wildcard as suggested by Alex.
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index fbf9eb2031c8..a6a256b2c6b9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,7 @@
 *~
 pyshtables.py
 /doc/manual/html/
+**/bitbake-builds/
 /build/
 /bin/bitbakec
 *.swp

---
base-commit: 6e511d035a3d1e4129dab7b0dfbf216bd8e99b47
change-id: 20260108-ignore-bitbake-builds-dc8108e7b05b

Best regards,
-- 
Paul Barker


