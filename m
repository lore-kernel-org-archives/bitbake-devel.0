Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1625CE68155
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 09:37:05 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8548.1771321014008713035
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 01:36:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=QkS1ki6A;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1A2301A103F
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 09:36:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E50EA606D1;
	Tue, 17 Feb 2026 09:36:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 858AF103688DC;
	Tue, 17 Feb 2026 10:36:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771321011; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dB2GQRYeOmkWvWplc89rb1kCpCpPaQnlvAKsc2xemr4=;
	b=QkS1ki6AVkNdzdFI+3fZ5N8/DPxYG3FU+BCVRyEW0TDPYkYf2wvtWGngBMRC/zWrBtiDMG
	CqYvSvbQtAa+ya7tQ5Xo5rh27DH+G/0iKfXi66MGt2hX3hDbo63bI9tWrEMrGKKHfLbpmH
	quvPA7DfW1o3DG2nzevv34JFhVW64EilXqo82PnelS6wCivSX6EG/3S5AHnKddMnNZwEWn
	YDir32KuT6CcHFDhlm6q4t2eJIeLHZ6UFwhPVWNJjbEDjshMLMyiJE/RDB05qpQqeSUWkj
	MgStEQaXnhcr1OIc586yXoeTUu2rbZEHmqYwhJavtB8P+bieaFf26yKftUaITg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 10:36:49 +0100
Message-Id: <DGH4W65QBJ7Q.3NRH3Z4SBANMN@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 3/4] bitbake-setup: print plain messages
 in quiet mode
Cc: <bitbake-devel@lists.openembedded.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>
References: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com> <20260213-improve-bbsetup-readability-v1-3-41cec3b06992@bootlin.com> <1894D252853C99A9.200918@lists.openembedded.org> <CANNYZj94DXwkDaucq4Du2Pnvv+PD084SmHU+URb6djKFuUf4Pg@mail.gmail.com>
In-Reply-To: <CANNYZj94DXwkDaucq4Du2Pnvv+PD084SmHU+URb6djKFuUf4Pg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 09:37:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19045

Hi,

On Mon Feb 16, 2026 at 9:03 PM CET, Alexander Kanavin via lists.openembedde=
d.org wrote:
> On Mon, 16 Feb 2026 at 20:56, Alexander Kanavin via
> lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
> wrote:
>> > At the moment, plain messages are not printed when --quiet is passed o=
n
>> > the command line. This makes no sense since bitbake-setup prints most =
of
>> > the essential information with the logging.PLAIN level. Raise the quie=
t
>> > logger level to logging.INFO + 1, which corresponds to the PLAIN level
>> > in the BBLogFormatter class.
>>
>> Can you provide an example of e.g. 'init' before and after the change
>> please? The idea is that quiet mode is indeed quiet, e.g.
>> bitbake-setup really says nothing unless there's an error or warning
>> that the user should know about.
>
> Or to put it another way, does the quiet mode do anything with this
> change? Is there a difference between the quiet and regular mode?

Actually, when I was testing things I was in interactive mode. Previously,
passing --quiet in interactive mode would just leave you with nothing print=
ed
on the console (only warning and errors), which is strange for an interacti=
ve
progem. However I forgot than in non-interactive mode you may want that to
happen (nothing printed).

So maybe, we should look at the --non-interactive option value and print no=
thing
(i.e. leave the current state, only warnings and errors are printed) when T=
rue,
but raise the loglevel to have at least PLAIN messages when True? Or give t=
he
user a warning that running the init command shouldn't be run with --quiet?

Antonin

