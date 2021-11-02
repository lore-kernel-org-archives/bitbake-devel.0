Return-Path: <dl9pf@gmx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FD9C433EF
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 14:51:54 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by mx.groups.io with SMTP id smtpd.web12.829.1635864713098117526
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmx.net header.s=badeba3b8450 header.b=RtmvlYXQ;
 spf=pass (domain: gmx.de, ip: 212.227.15.19, mailfrom: dl9pf@gmx.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1635864711;
	bh=ELMAyUrjtYZdeS++x95GxBs3BAAfnFbU28ANqbuiuso=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=RtmvlYXQcDNuhJvEvrhUnNIjuuY1ki6WIZhpqrdeMrUmnYdy9FkkSBfhgg5eMqYqf
	 aViDbSqLC1JWJwqvWHohmYwGaaKj3+oCfn2qskbobwYq64OEzC8pAI7p5ynKdnUxf8
	 0uB9dNrGzLjC2IzR7l/rYfjhRg55YQymdvfScgik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from monster.localnet ([95.88.57.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSc1L-1nADfj4B5d-00SsSZ for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 15:51:51 +0100
From: Jan-Simon Moeller <dl9pf@gmx.de>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
Date: Tue, 02 Nov 2021 15:51:50 +0100
Message-ID: <3740438.x7lg0THAfG@monster>
In-Reply-To: 
 <7930bb9f4875fdc32c4fa43395da68bae76a24c0.camel@linuxfoundation.org>
References: <20211102124500.3542952-1-richard.purdie@linuxfoundation.org>
 <AM9PR09MB4642729BBF86DB48FCA16DFCA88B9@AM9PR09MB4642.eurprd09.prod.outlook.com>
 <7930bb9f4875fdc32c4fa43395da68bae76a24c0.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:gfCMkygPMjf14Ft+BSz58lcUWUXSMkFrcZGGyAaoJmOpDQmhL/M
 963lCFMCfNsLIFB4rizmckV5fMDAiicmFkJ1BUhJFa2it5uay+2VhgnQZ90YB3J357mvQIE
 AMMmTVRnTJz6oES0m4f8KhqzLkMeTbBzFE9Y+26psPpypmuM3gtzXMuKt2A0zhsk51Aa8EC
 S6zsOX08FbgH0HigrGuQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lZYINqSabNE=:uYreRx6IrGqhDJTr8SxSMU
 Ug6r4t9FeH/DjiLZQHMItBM8ygjJTmOQRLL9thrYALnS9BFo7XASxcNOBUu8fyZYgdTFey3Ng
 LQiY68YEaTYnzGcvgvA4o2LdCDMK5RjweFiGymFZYgfIk2m4jVIuXoHYbPRxORdnuXeankli0
 P6YS8wVxJT2IAICGuZaQeu+8t92F2AE3l892wVhd8ouOKtlefwDb3Vzw8dYjmorNHrCfcYdDC
 4fqYS8BloPA47bmKRTDTUq3f+su1nJjNZeiuYsMzbGmtILChTkmzqvNGhZGmTLCkyt0dEthD9
 u9TxXILQAc1lXJBqCVEFEeRUWoM0NI5j1i43EZAdUFT3KA811b9GQwXuRQs8jzQU2fbTP/NnL
 9ABX1dqqwaueolhnPM9eYLx3DWmtvLWmZ5pFYaUbRHunUsJW3bxTrQoAPRul5JH3qJYO5kZnD
 oYGqpODF1tG6mL0816s8u0BmHcaEx7uo7n1BLNIGYm+ZSoIiac7KHobYnwF7Ft9x0CikwMVOR
 qI2tfBChmTcuWidDhRWRgojYNSOJB3wUTEQq8yPRw4+ANigNhoIvoyxQJo8UDh0MvXYVaB7nN
 5IQwBrqR5YmknXlvg+gMVt0bJ0B+ATDXJReWQ/Ps5m1v6MoVX2khNXdXq2OMXlTKJ4VwX6KZg
 KRdBTBoAxXGrEX8371L1L29gFxJz/scWAbzSqdohfzBO04J1lgOWTN//8/jH7yxigk0+TvMRe
 xxPrCs8XO31SDBGiTLfjhvbaDDe66PFgRpOrvcwiknSy40Tn1IiiEqAP5SZwtIhD8/baqnHnM
 sji5AjkvGEpxUak4A7IUXvmd9/qn2K4bszlszubY8PiJ++X0u9ZZRh0voT1CqH/49FRFP641Z
 kZbZ8PrUk6jI7GuFPg7cFMibtGOkpEW0qCUClLXZeMdJm6MrnbA618kZuQe1sBGSLJMaOFctj
 rcqZL4nh/V21iulhdUHg9noJCZhlR6ukzfGdzSCvS53Vn7d809EdCPBuOC4XkBbpQ2SkOE4/J
 TbvyTE3CSVOTkgGxfWwrIvWVFnXybGg7E6+3gzcxVaSsagSF1SixnPDmhrtwfjkwBQ==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 14:51:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12861

Am Dienstag, 2. November 2021, 14:27:58 CET schrieb Richard Purdie:
>
> With 15 years of legacy branches and recipes out there, this change is
> intended to be backported to older bitbakes to at least give some suppor=
t
> to people stuck on older versions. This is why this commit and the warni=
ng
> are separated.
>
> The warning is being added as we're not at 11.1.22 yet and people have
> previously said they don't like instant hard breaking error messages. We=
'll
> therefore give people some time to update, then change master to an erro=
r.

I think this is a good plan.

Best,
JS



