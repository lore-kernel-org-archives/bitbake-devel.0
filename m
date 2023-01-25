Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4CCC27C76
	for <webhook@archiver.kernel.org>; Wed, 25 Jan 2023 15:52:37 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by mx.groups.io with SMTP id smtpd.web11.48627.1674661953745150821
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Jan 2023 07:52:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=iW/Ef1hH;
 spf=pass (domain: myneves.com, ip: 185.70.43.23, mailfrom: paulo@myneves.com)
Date: Wed, 25 Jan 2023 15:52:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1674661951; x=1674921151;
	bh=uijgPXiSaImv/mOqpNt1Q1ibaKDJtB+mc87z451S/ys=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iW/Ef1hHupA67NzkgiUFa3NZoqLgeHZqCBbxvUvw9bcNSa+7i3jUEqxEVqktAj0DB
	 t3dfjaRFeyDau5lTcMXJG6amXW6Xwdl8CzsRMDEru2AnIhBxsF5wfkOclHuAxkfiXR
	 v0sFYf6682awRbFz7gFdUI9+iEKHFAIcycJKJWMvRrtGUXDjYqYRg/vk6/HCik51IF
	 4n+mMziHfK2I87QJQ2PZROmqwINsfh6DNDpbTr6knJwsLYa5K3cWOBC8WNV5UHg6lf
	 Enf3wUZ+NiII4sRYJrG9Omjw6CvG+X1x5Ir6wC7nFYP6WoYbcTHa6ZQiBQ1Vj5tYl9
	 FZ2XJqnCHkr8w==
To: richard.purdie@linuxfoundation.org
From: Paulo Neves <paulo@myneves.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 5/6] data: Add sup0port for new BB_HASH_CODEPARSER_VALS for cache optimisation
Message-ID: <b3c51ad7-da76-db80-d2ed-a2fa2df60518@myneves.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Jan 2023 15:52:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14341

Perhaps BB_HASH_CODEPARSER_VALS could contain a list of flag names that
could then be iterated and the values retrieved safely.

The current implementation will break if any forced value has a white
space or a '=3D' sign. If this variable is to appear in the manual at
least these constraints should documented.


