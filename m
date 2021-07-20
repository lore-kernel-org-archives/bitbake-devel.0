Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
 by mx.groups.io with SMTP id smtpd.web08.150.1626801396226289670
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jul 2021 10:16:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=LAFBVxIS;
 spf=pass (domain: pbarker.dev, ip: 64.147.123.24, mailfrom: paul@pbarker.dev)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 5A02B3200932;
	Tue, 20 Jul 2021 13:16:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 20 Jul 2021 13:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=fm1; bh=rhs76dq+A1WOwUhWMCkrEMmyrK
	xjMu3xBnzcBWuZquU=; b=LAFBVxISvnBOeY+Z9QOB+QILEJhJ2aDSQ/255u11PZ
	D2dEywVWaJZuGCzvKW66J/ELJjBvlkSqmHJ81vqxBYFE3tyPKMUXrF4h3tY1yyBC
	8MNoFS9tSSm6yQRJYdqxwWCTN/MLIa5jpAbuHUurYFkkfdH68o/WTkjbdaj9INLe
	jUkWtkSuzqU7Lq9T/yEEqa3zMPaYIoGN/ixEY+r3FZyEKY1sgj6YY3qmepRGuErP
	0ioA6QNicy50F6ruWh60NZbQ8Qnr5r38p0U9WCbUgFpgj/gppyBuysCPajCJhjYl
	KJGs4WiDOl3zwI9K1KdwJN2uHzGI9KGgcKQVunquRNKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rhs76dq+A1WOwUhWM
	CkrEMmyrKxjMu3xBnzcBWuZquU=; b=saX8Ze0+T67YbD72a7g/GGo0yDMrzhPlx
	DexYG9yJD+9suAx9iQUJtK5jIcePkaTKlUVdgZ/fSvgj0RaEQlF2zY/89mRqmopH
	UKackppl51qvk0Y6ZfimBWnMt5udzWY9wua42D8Es8Ju0Y8bTQbp16TlSD7h4qt5
	riuaUXKakz8soLld9iFYUw4sQjLwSG1zGgbRA1ZY/Hy0FjrmBwP05wqP1SUxO0Cj
	pLp3r+pl3m5WsCgwRDd/w9wT7wU9g8gKLKRTQgUthi9PPlXksglkKfso/gCsJ0AB
	w4UN05vRrg8b0aa4dcwbwQ7+OML97INbD1NBqtr879N6Qnb+zugug==
X-ME-Sender: <xms:8gT3YLAeqR-kA2fuvgnz79Orw6keb_OqRJ9eq6h7oByWU32n6vwpZQ>
    <xme:8gT3YBhNyp56mJpENe4pgupinzQdjB0YLiI4UGmLSI9P6mNcerMyBSHeTTKGGfGdK
    jPGMDJLsff9h8Ei4Hs>
X-ME-Received: <xmr:8gT3YGm75jbbNFXsaEkTLYHXrh59J6i3S2A2HGR5hYoZWCcVDOj84jd-ng0Mro83U1xwNNSS4yoedJHeM6Rl6yK496CpgWU0fnYL1Z39YKIm5WbxvK-s5rA0ZaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhepteefleelheeugeejudegiedttddvffdvleefgf
    dvudegkeduleegudeihfeijedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghv
X-ME-Proxy: <xmx:8gT3YNyNTcS2yPZYjrmfVfr3jdea0CK1pIU5tahS26rXy7mzDl4CIw>
    <xmx:8gT3YATTjA1jBUwwInkoHLLZz_SWF5f7r0fAgAHnwUb9l09EQmcNpA>
    <xmx:8gT3YAYNIsv8EgV7T5G6QUxs9gM3FwBIJap3IhdwgwgWMg2vyJkpGw>
    <xmx:8gT3YJ58ntctWFUuNDhHQY3pIZiWcxm1CR1hTRGefoFarQzy64HkKw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 13:16:34 -0400 (EDT)
From: "Paul Barker" <paul@pbarker.dev>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <paul@pbarker.dev>
Subject: [PATCH 0/1] Substitute '~' when naming anonymous functions
Date: Tue, 20 Jul 2021 18:16:27 +0100
Message-Id: <20210720171628.23394-1-paul@pbarker.dev>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When looking at meta-linux-mainline in the layer index I realised that the
recipe version shown were out-of-date. The most recent update log [1] showed
that the layer had failed to parse. Looking at the log it was obvious that this
was due to the path in which the layer had been cloned, not due to any issue in
the layer itself. As git repositories on sourcehut use '~' as a prefix to the
username in the URL, this character ended up in the local path to the layer.
When bitbake parsed the recipes in this layer, the '~' character ended up in the
function name generated for an anonymous Python function. Since '~' isn't a
valid character in a Python function name we got a pile of errors.

We already have a translation table to handle characters which aren't valid in
Python function names, we just need to add '~' to the table.

Paul Barker (1):
  parse/ast: Substitute '~' when naming anonymous functions

 lib/bb/parse/ast.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.26.2

