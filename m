Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4764ED25B4F
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 12:34:52 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12191.1769603690165104167
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 04:34:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GhCQ/OKr;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-501506f448bso42472581cf.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 04:34:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769603689; cv=none;
        d=google.com; s=arc-20240605;
        b=PbKGuYbrB9R1Nn+u2G8ny5XYHpLzCqhaM+DicxBvdN7oJGkw4WMsYAQyLlT8LraPe/
         LNNI7K9AsZOekyeJejkwBnR5vNVqpC5v/zId/T89F9kwn9iA//ZgD6XLhkMvCrHbVA/y
         IsFbEYYbN054O/yvl/1D35EcqkDPWZa+0G5Bwf2alsuZHtLLb0banHNmyScd+d0mYZtw
         5uUGu1POsCQvDP2EhFWgqj69/w/bAtv08c8iBDY1tem+ea27rI2jETiKDNbCLdtgnUV1
         4ExrITTkzKV6c+gvxU6pBVOWdSgAuobL9rX9lkSH+zRVW+kWsAynZswmomALYbiPo8Cg
         hpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6dihtSfdPMTK2KLVBDVV95Apd1lfoz6kgOJwIlHg0IE=;
        fh=UE10PYN5Ol1xW10b+X3G7oEfzeWzDDuB3sXtcsBXyK8=;
        b=jWHCF3R+7l+YkjHCooaWupcAZfbv30rOzwJisX7ZMKbRLDKDOm/ULf1p5pyMxh78ib
         dnASlmxDAzPpIhqW5j6281SfZwsqBGI9Z3IQ4A39O+NXT6UZCW793ju3sYtXBexIVbi5
         ay+zsQok6hE9KYscnS7yq50c4712Ojzf6bGJg1GJEJT4cGvXvflmCfZQdGzz0Qoc1CTN
         ++Sg4iMGEoN+TLN8eccHLdxFl3Y54sEnNgQH0wEJ0JdxGDgoE9dUZjJNMsfSo8j6Ons/
         2m27ADzA+2+TGaJb6MlgI5pbnXoXES8JjaJJAr7zaOmtoZBF4lgJPI8IZ0a+EEXvSUeN
         xzFw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769603689; x=1770208489; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6dihtSfdPMTK2KLVBDVV95Apd1lfoz6kgOJwIlHg0IE=;
        b=GhCQ/OKrYlg1gVV3Q5qs3HJyrldzzJU91sI7xYGjFYvX0ZxjWnoj8VKy/UVdh0QmdF
         2HibX4bxV5ugCQroCsT07IDj65xxSb/LurMVq6LKjSiRLC0K4rsn0YoQKrVLjrsjvAic
         47dGu6uKKd3P4tuzrA/jUy7lP0e7J+AhBur1JUqdU51WfeIooZAcC/FEi/V9nya1GFxG
         Ylsy63VNGHi4jktGCDJgm82qPFwCZzQFrcb4gb/qFoV8HQ2U4qxzV2NpJbjZwATC5TOS
         hdUqrTe8YfIPhA3Me8Qjr9n5TrZ0tJxnLPsO1KzMN7P6n7QH5y+iIPCOyEiETSE8tK5M
         SDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769603689; x=1770208489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dihtSfdPMTK2KLVBDVV95Apd1lfoz6kgOJwIlHg0IE=;
        b=RQED61+5iLmN7EjwxCyFn4U+JHcvCeV0HI5BdzQ1WNR2OVowEpeqtiBbr73iayfcn4
         xsexPOK5vQuXemjv0Rl9et+Zs/wvpRuiHsmEMTHczy/DCwJECgHfgepQCMYYKrHuxBJn
         GV/QSieJBEfTfKQCdzR1x2ljmTidBjrordJ2+mzyY/2wYmscTVkOJHkvFR6ZpGvRfBuP
         JunsOdihzEw7ZW/TM3jiMyNASlhtdlf3KltNl4yjooUS8xaDUpetrKrC+hQ9lam7bBzK
         eBKMldI0dxeeKEN3w8qqoZg08SsNndFsRsOZf/jF8jDKZaz3Kp2tCoj/L6p9nHatWZNY
         r/WA==
X-Forwarded-Encrypted: i=1; AJvYcCXm8UDzF8//jrn1i0T3//1IlEMRQpIY2P/mASJdtXdKoJlTLhJKBEYJMA3cIRbattNRO8fdkWJP5sDhxEkX@lists.openembedded.org
X-Gm-Message-State: AOJu0YygwzTWppXXT5oNc473WFF9UkzT85cQx/fBh6S08IlSgHEhN25i
	m+ESJ4GzP1rvXAFU1mfOGv2tA/Ba+lK7CxUqNfcS8Gz8L+mnvTZr37mmvGglj6bB9diFe2nakNO
	woBxaExI/riXOaP906SNPyZ29nObLLFk=
X-Gm-Gg: AZuq6aI/KeK2CRROPB2HXc0tJTtSU1wrmI9Qaf90AC0FlOBAXP2JHQHSfchJl4dkXzP
	OHxolj1o3jvwn5MXZ47r29c9JwZOYr5/KPkF1YxfV6QUu0+L6pU7JNEt+hT2nDONXVpqby9TQ0e
	VyBTevoJ2SVMHTNMVhnOQ/d29y7D5xOq2gOhzTCQ7Blw0UE6yna+ZxsZXnc+2dziSNnDos+BxEj
	iZBa5N1tB/1rMQ3xiQP/bbo1iFXmPJuwXzxSrdp1maS4YEbMtKeGAzLrGNt078IndfunXrAZcmS
	KEP0KXkJ+ISl1Tx9SnRy+SmXcbzZJA==
X-Received: by 2002:a05:622a:48b:b0:4ee:1903:367b with SMTP id
 d75a77b69052e-5032f74dedamr66014021cf.5.1769603689087; Wed, 28 Jan 2026
 04:34:49 -0800 (PST)
MIME-Version: 1.0
References: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
 <CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com>
 <1dc33b07-759f-499f-82cb-84e5c20f77ec@gmail.com> <1883858B93EFC423.1614991@lists.openembedded.org>
 <188385EDFF4B6429.1342979@lists.openembedded.org> <18870377D56AF168.1986633@lists.openembedded.org>
 <CANNYZj8+msix6SFiCH=4UcLogt-+zA6=keGtXtBPbTE8vKTqoA@mail.gmail.com>
 <df05a1fd-23ba-45be-886e-886e4a79cb74@gmail.com> <DB5PR02MB10213E60D96F5D4AE9C5DBB93EF89A@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB10213E60D96F5D4AE9C5DBB93EF89A@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 28 Jan 2026 13:34:38 +0100
X-Gm-Features: AZwV_Qjw3_GCe7mOG0eT6RcOOBpIOh_PNMSpOUAB8oxfmNONISD1492ZQWkS6as
Message-ID: <CANNYZj_ETQ8Nk+etYBU9fTaX2vH3uMwPSFp_AzK9_PCbqez0SQ@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup update problem
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	Adrian Freihofer <adrian.freihofer@siemens.com>
Cc: "uvv.mail@gmail.com" <uvv.mail@gmail.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, Yoann Congal <yoann.congal@smile.fr>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 12:34:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18912

On Tue, 20 Jan 2026 at 14:48, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:

> I'm not sure why you are pointing at repo here, because this is actually
> a use case that repo handles extremely well. We have been using repo for
> over ten years to maintain the manifests for all our builds, and (AFAIK)
> we have not had a single case of repo loosing any data due to doing an
> update.
>
> What repo does is first, if there are uncommitted changes, then it will
> not update that specific repository until those changes have either been
> removed or committed. Second, it rebases all local commits during the
> update. This can of course result in a conflict, which then needs to be
> handled manually, just like any other Git conflict resolution. What's
> more, repo also handles a repository being removed and later readded
> without loosing any metadata. This is because repo actually does not
> keep most of Git's metadata in the .git directory for each repository,
> but rather in its own .repo directory. This allows for going back and
> forth in manifest revisions even when there are changes to which
> repositories are being checked out, without fear of losing any data.

There was some discussion at the yesterday's tech call: basically
adding a 'non-destructive unpack' feature to bitbake's git fetcher
would be most welcome, and then bitbake-setup could use it, and then
the restriction on making commits could be reverted. Such a feature
probably would work like the description above.

Unfortunately right now I'm swamped with some high priority
autobuilder issues (and there's a large backlog of other bitbake-setup
improvements to be reviewed and possibly adjusted from feedback that I
would really want to get in before the freeze), so can't promise where
and how it'll happen if it's left to me to implement.

Alex

