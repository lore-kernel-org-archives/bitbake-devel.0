Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7601C636CC
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 10:03:38 +0000 (UTC)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 by mx.groups.io with SMTP id smtpd.web10.6682.1676541808531491089
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Feb 2023 02:03:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=M7DMtiGX;
 spf=pass (domain: myneves.com, ip: 185.70.40.22, mailfrom: paulo@myneves.com)
Date: Thu, 16 Feb 2023 10:03:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1676541806; x=1676801006;
	bh=KdgEYOABSp5E4SnbgzwcnCjGrhMawIY3V0jw10bkp1s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=M7DMtiGXgKvA+WkPrXhBWCZieRIoGBJc2X1zYkZJSwlttFcRBkCuFYZjfB5mbud/M
	 fS+GcQtjXwQNxBxJ9it21omqRFsYFZxVj+8BgXpTk8ZDqvm9AJb410VJIUpM6RzrC6
	 rGQIyc0QsIBW9SK/tCFgUBzoUD6brmqnt0QEbIgDB7YxDYcGK8JQOU5JmthktS0Xi0
	 PTfDa8Mp8rYtFPlXaBWUQVcX9J58VUtpovZSf4Vo5mzR8Ui+Irny3dpx72gReebCaE
	 aU9hoSjqkwhQSfpQVJjcYChz+RlG2yq5maNX6L6qfYjQqJICoSmRoIsm0m7k618FhW
	 IHg8mgukzD3fw==
To: Martin Jansa <Martin.Jansa@gmail.com>, Richard Purdie <richard.purdie@linuxfoundation.org>
From: Paulo Neves <paulo@myneves.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH RFC] data: Evaluate the value of export/unexport/network flags
Message-ID: <5a615e10-4524-ccd8-e75c-6bfdf2d3dee5@myneves.com>
In-Reply-To: <CA+chaQcs0KVqKYA_FJnaTfmFk25F+XrxGRzofCo5eH9L-BGwfA@mail.gmail.com>
References: <20221127214934.541723-1-richard.purdie@linuxfoundation.org> <CA+chaQcs0KVqKYA_FJnaTfmFk25F+XrxGRzofCo5eH9L-BGwfA@mail.gmail.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Feb 2023 10:03:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14444

Parsing time is very different than do_compile. Almost all operations on
bitbake require parsing but I would argue very few run do_compile in
comparison.

I have reservations regarding any parse time degradation, as in my
experience parse time is one of the biggest complaints by users. A
compilation is seen as useful work while parsing, sadly, is not.

Paulo Neves

On 2/15/23 11:46, Martin Jansa wrote:
>
> Parsing time is negligible compared to do_compile times in most of my
> builds.



