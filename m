Return-Path: <antoningodard@pm.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9978DC25B79
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 01:53:28 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by mx.groups.io with SMTP id smtpd.web10.5145.1715651599863402152
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 May 2024 18:53:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pm.me header.s=protonmail3 header.b=FbFSLaVd;
 spf=pass (domain: pm.me, ip: 185.70.43.16, mailfrom: antoningodard@pm.me)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1715651598; x=1715910798;
	bh=6G2tecOUMlA6iupAKncgNxcXujwvcn/b+8F6FU27I6w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FbFSLaVdnxaTqDV4eJOEtYgX7ntexd2jXkDnZqCNpbUMQvghad54EF7L1ccg8EboM
	 BGjYHMbAlJ3lRuAqIHadR6LcTF0pDrFU8a1OIaICkql7KhrU9mWInAgVXCB3Jd6/qM
	 nJlbb2qoNJXxTQxdAi6LUNMICn4P1kDiSDtTXPJ0zN4ZFqz9zk4yRHait7SP0OlJeF
	 7L5vVh5HqG6CUpKqPSgd5SyxjdC78wZodhHm2lzR/Llm9XDbXhMp2O14i8E59LKrpY
	 SzVqVOCo96bpeXzvTqH9OxUv+ZgVYACTJ2yon+nTkPR696158tbyEWMlq1yYGeOIce
	 xPPvOYTkZDoCw==
Date: Tue, 14 May 2024 01:53:13 +0000
To: bitbake-devel@lists.openembedded.org
From: Antonin Godard <antoningodard@pm.me>
Cc: Antonin Godard <antoningodard@pm.me>
Subject: [PATCH 2/3] codeparser: remove redundant list conversion
Message-ID: <20240514015234.67318-3-antoningodard@pm.me>
In-Reply-To: <20240514015234.67318-1-antoningodard@pm.me>
References: <20240514015234.67318-1-antoningodard@pm.me>
Feedback-ID: 17651652:user:proton
X-Pm-Message-ID: 55658fdcdbdbf05119c8bca3f94066189cc0188f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 May 2024 01:53:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16213

Signed-off-by: Antonin Godard <antoningodard@pm.me>
---
 lib/bb/codeparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index c613806c8..691bdff75 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -484,7 +484,7 @@ class ShellParser():
         """
=20
         words =3D list(words)
-        for word in list(words):
+        for word in words:
             wtree =3D pyshlex.make_wordtree(word[1])
             for part in wtree:
                 if not isinstance(part, list):
--=20
2.44.0



