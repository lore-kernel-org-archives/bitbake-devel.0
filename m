Return-Path: <antoningodard@pm.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D3C25B78
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 01:53:08 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by mx.groups.io with SMTP id smtpd.web10.5134.1715651579878885954
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 May 2024 18:53:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pm.me header.s=protonmail3 header.b=V0735Tqh;
 spf=pass (domain: pm.me, ip: 185.70.43.22, mailfrom: antoningodard@pm.me)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1715651577; x=1715910777;
	bh=YBZTns0hjsWSyB8pMGcK3ILkLd5I3lIp06sg+v3TsEI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=V0735TqheRYBpkKHFKakMipL6POifuoYVImQZIWY19yvb2ESzNtXFJJatJ39fxZYB
	 SwVAyQUoI8XksyoZPnKmJgsI/l0c5L1nX3uCo7y4OBWFMTfaH6Wkf7556oVXaxE7o4
	 c90PU3bR9GGGdwazlm/FGfD1HIIfj8KuunH8Jy19j383AT0KblojnauSnK0oVt/XGh
	 ebqsfjqzNX8+rH7psL9JL17DG6ZEwMjR1fuLJyQ7Zlb7xSnblcj0518kDYcGcZU1He
	 Iex/upimuLWE5f+AFU+znGZFp+81Z8P1m5SyV2B2vhPXWRZG7pPyAyvtJk0V30VXeL
	 UCGf9UwtWZxlQ==
Date: Tue, 14 May 2024 01:52:52 +0000
To: bitbake-devel@lists.openembedded.org
From: Antonin Godard <antoningodard@pm.me>
Cc: Antonin Godard <antoningodard@pm.me>
Subject: [PATCH 0/3] Support codeparser shell expansion between quotes
Message-ID: <20240514015234.67318-1-antoningodard@pm.me>
Feedback-ID: 17651652:user:proton
X-Pm-Message-ID: 1b8a083baf46c2fc188d7a43d469cf95c95b7a62
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 May 2024 01:53:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16211

Hi,

This patch series adds support for shell expansions to be included do_* tas=
ks
when they are done between quotes. Previously, these shell expansions were
limited to a syntax without quotes.

A series of tests are added to show/test the different use cases of the
backticks and $() syntax. An extra commit also remove the redundant list
conversion done in process_words().

-Antonin

Antonin Godard (3):
  codeparser: support shell substitutions in quotes
  codeparser: remove redundant list conversion
  tests.codeparser: add tests for shell expansions

 lib/bb/codeparser.py       | 31 +++++++++++++++++++++--------
 lib/bb/tests/codeparser.py | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 8 deletions(-)

--
2.44.0


