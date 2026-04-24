Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46109FED3C3
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 12:47:47 +0000 (UTC)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20379.1777034858494153688
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Apr 2026 05:47:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=HOQgVSoO;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=p5XD4j0b;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E6ECF7A00D4;
	Fri, 24 Apr 2026 08:47:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 24 Apr 2026 08:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777034857;
	 x=1777121257; bh=YfY5vWaRgDLyqDGAZ6g0ij+cU2VEJ0blDqLODZ4NKTI=; b=
	HOQgVSoOyLqIULlOQsuiHrQ7T/xeonY1Z0wQIsP23pAgEC3TA9R2M1RpHm7JS9a4
	jsig8Nd2Rw+rKVEJxHN7aoYW7eATx5Sy4XVCen9zRUhhwsadafbdQ7Fq6nuiSYpu
	Z3N0jjHOuxymYoAJuLd6aJe99seEaLkqRblQ0Tr1xjB9FW8ehjtgO9Ph2TQikNoq
	jvbNq6jwJC3pRphicJHbXVki2QL6c+Pg2375HEJL1Ib89JUI8XuiGmQpIDgIMl0D
	wQgrpi6oBsh4q4U/7oD21SyD+QNQ25GGxAxN3i9SoEgbPVAPebEgLFPlY5PwIdqo
	LROz0SBMrugJ+09dAJGBCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777034857; x=
	1777121257; bh=YfY5vWaRgDLyqDGAZ6g0ij+cU2VEJ0blDqLODZ4NKTI=; b=p
	5XD4j0bZnGrfYzunV0O5GS3dS4D9+3qC+JfhrD02tRKI13rXY6bcau07vMFREjz0
	2y2RP7l13A8oRvo3apRyCq9mogP9H92KLDUvxk84falH7XJ0IMEH/64PlCVgoCC9
	TbX0ClMFHq/6dgIN/th25uR8tgUbsa6kXwcDm1G11AhrhDq3oDDUcV6h2bwMsarz
	W2+lYoNWg6DjhiwBf9sSM2U4jwWZ+sP2FpRSxuPnRca6gRIu5E3QiO9VHh0xV6P2
	x1ejztInKcb6xCuLi3OvS/vy/2YhAd/d2VeI+Bf+L8SuwE0M1shf2ERms1ty2IuN
	pgUSt2glfLr3JVjKFMhPw==
X-ME-Sender: <xms:aWbraUb21gMXAHJl-Ww-a_CooU3Viw_TF7JyVZXdXA7s0uQTzDE27g>
    <xme:aWbraXJDHGnIr799E4sNb5IxLFTkBodmn5_nnhFfEZ4fl-2EnIMTAI6DG_gfhEJ6j
    y8BAJGvnTiRcJI5yBWuaY4W6MIVJmwSl55lNC5kSmOLCDI_Fn2ocbw>
X-ME-Received: <xmr:aWbraSCfGpm3VIZJtpv0P0fYlXi8da7xpMvqIySHR3X7CGWPjTjM4WIsxjGnsaDI8jg4tQ-WqEN97js4UouS3RBQiJHkBBE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghulhcuuegrrhhkvghruceophgruhhlsehpsggrrhhkvghr
    rdguvghvqeenucggtffrrghtthgvrhhnpeehudetuedtuefhhfeuffdvtedvieffvedvff
    dtffejkeefiefhveeljeegtddvieenucffohhmrghinheprhhiphhtuhhtohhrihgrlhdr
    tghomhdpohhpvghnvghmsggvugguvggurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulh
    esphgsrghrkhgvrhdruggvvhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehl
    ihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopeguohgtsheslh
    hishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-ME-Proxy: <xmx:aWbracoBXpfXLOzM_m_zKXDm-U31dHKD8lGfhCbyCS8oqTR8RpoiOw>
    <xmx:aWbradhIrSgJRQN7_D_YgUxpZI06WgRRH_PwPJQ7qD0SsP_K0Ml5TQ>
    <xmx:aWbraZDUiNsKK1YVO0jlIwDARcShtaJz6lWoZODQDNysLdMOJviQ4A>
    <xmx:aWbraSHv5arpl4ZxPhyYzZ4tTU8Ku36gWQ1Y63GdOwSMbX4UGZEyKA>
    <xmx:aWbraX0JcLv3GCeVx4nOh9GqDGF5z0wQDTrK3h4tB6mTe-ok6NWYIKgh>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 08:47:37 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Fri, 24 Apr 2026 13:47:26 +0100
Subject: [PATCH 2/2] doc: Fix description of git shallow mirror tarball
 creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-make-shallow-v1-2-fc06b12ca344@pbarker.dev>
References: <20260424-make-shallow-v1-0-fc06b12ca344@pbarker.dev>
In-Reply-To: <20260424-make-shallow-v1-0-fc06b12ca344@pbarker.dev>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=CNMF6aAMu0D4gTxqeqFakkyecIxVcPrhzjtwsBc3nas=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWS+TktTP3HecHkSU99KsdBXxZLuzD/n635TctlQMn22y
 9lLD6WVO0pZGMS4GGTFFFk293y9/7TXkTcj5JYCzBxWJpAhDFycAjCRU1GMDJd/GsTMUT1l+35f
 5bH71/acmMtvt5ep1NzueEH2/n+M5+UZGW5abPre1Vr9Wi39RmlRhf2/V0Lr/XrlUpOuTWHZfaR
 DgB0A
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Apr 2026 12:47:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19389

The method used to create shallow tarballs was changed back in 2024, but
the associated documentation was not updated.

Fixes: a5a569c07522 ("fetch2/git: Use git shallow fetch to implement clone_shallow_local()")
Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 8d8e8b8b912d..9824b58ef274 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -349,8 +349,9 @@ overview of their function and contents.
    :term:`BB_GIT_SHALLOW`
       Setting this variable to "1" enables the support for fetching, using and
       generating mirror tarballs of `shallow git repositories <https://riptutorial.com/git/example/4584/shallow-clone>`_.
-      The external `git-make-shallow <https://git.openembedded.org/bitbake/tree/bin/git-make-shallow>`_
-      script is used for shallow mirror tarball creation.
+      A git shallow fetch is used for shallow mirror tarball creation (i.e.
+      ``git fetch --depth <depth> ...`` or
+      ``git fetch --shallow-exclude=<revs> ...``.
 
       When :term:`BB_GIT_SHALLOW` is enabled, bitbake will attempt to fetch a shallow
       mirror tarball. If the shallow mirror tarball cannot be fetched, it will

-- 
2.43.0


