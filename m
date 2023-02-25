Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC0BC64EC7
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 16:50:19 +0000 (UTC)
Received: from a11-79.smtp-out.amazonses.com (a11-79.smtp-out.amazonses.com [54.240.11.79])
 by mx.groups.io with SMTP id smtpd.web11.47285.1677343010501331949
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Feb 2023 08:36:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@richelberger.com header.s=5u2mht5g5nbgnd5xxu4iibla5zobc5bd header.b=nneLkN79;
 spf=pass (domain: amazonses.com, ip: 54.240.11.79, mailfrom: 01000186896f2981-96e1cb88-396f-45d3-adb6-386dacf207ce-000000@amazonses.com)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=5u2mht5g5nbgnd5xxu4iibla5zobc5bd; d=richelberger.com;
	t=1677343009;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=b18VPZfHSp7xcbYVksIYKqrXz3i/WDpLzbC3t2NyV0s=;
	b=nneLkN79Rp/33s9VOmzMlwE+QkWUbVwxflHJ27Yz/52/UucGvaWusQagnHK8qDbX
	YBr3UURHCkUMTXsSmT8fZ6Ok4JJ+PTJKUQxahD3CMFudMyyl01Q7TPQKH12imWcaza5
	UvCAdmxRTqzSKuBL+sd2HW34qng2xoOzvIzhveng=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1677343009;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=b18VPZfHSp7xcbYVksIYKqrXz3i/WDpLzbC3t2NyV0s=;
	b=KHj79T3uYLGPcWwuzyLFOj3KLIclCQBTIiFTxwcURdoX6rloO0xwHYBMum9C9yEZ
	PBl/3/BDVLMZwuinZT+vicmUgfQBxeSVuj6qGS+mJDm6XfXqgBjpocdDa7LfBP/CvcT
	DuUjQhVX9TAh6JJPTa8EeGnpQ4Lo4qHBa4ZdYc7o=
Subject: Re: [docs] [PATCH] documentation: bitbake: add file-checksums to varflags section
From: "Richard Elberger" <rich@richelberger.com>
To: =?UTF-8?Q?Richard_Purdie?= <richard.purdie@linuxfoundation.org>, 
 =?UTF-8?Q?bitbake-devel=40lists=2Eopenembedded=2Eorg?=
  <bitbake-devel@lists.openembedded.org>
Cc: =?UTF-8?Q?docs=40lists=2Eyoctoproject=2Eorg?=
  <docs@lists.yoctoproject.org>
Date: Sat, 25 Feb 2023 16:36:49 +0000
Mime-Version: 1.0
In-Reply-To: 
 <8ddacda7563bc605bae4686733d3e8bf72f0f9ed.camel@linuxfoundation.org>
References: <20230224201426.357606-1-rich@richelberger.com> 
 <010001868510232c-5929cc94-ce2e-4817-b311-3ea6f58a267c-000000@email.amazonses.com> 
 <8ddacda7563bc605bae4686733d3e8bf72f0f9ed.camel@linuxfoundation.org> 
 <169ccc6a-513e-88a0-b2e8-1c74b3aa2b5d@richelberger.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHZSIyaIxX+jF56Q0uWGR6i9QqucAACxEWBACqwIsI=
Thread-Topic: [docs] [PATCH] documentation: bitbake: add file-checksums to
 varflags section
X-Wm-Sent-Timestamp: 1677343008
Message-ID: <01000186896f2981-96e1cb88-396f-45d3-adb6-386dacf207ce-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.02.25-54.240.11.79
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Feb 2023 16:50:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14492

Hello Richard, I have added this, amended the commit, and sent through 
another patch.

On 2/24/23 16:33, Richard Purdie wrote:
> It is important to record any paths which the task looked at and which
> didn't exist. This means that if these do exist at a later time, the
> task can be rerun with the new additional files. The "exists" True or
> False value after the path allows this to be handled.

