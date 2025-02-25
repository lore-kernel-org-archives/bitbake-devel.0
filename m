Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDC8C021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 10:12:00 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.5021.1740478318121929024
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 02:11:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Iq0I9391;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43996e95114so35160215e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 02:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740478316; x=1741083116; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b1AJD9kbREKoAAVeTdoXdRad5r/mh1TKhQnILIMGMp4=;
        b=Iq0I9391+KIfO611OOyca/Y+u6nUGjLWZ4kzJf8gPuavNbNgo0mafhr8kourduPr97
         6r9a7bAdiFbc47LpH+DmnE7oWFjkZ0lfj+Yn1hXPx97/tboewxhDjiMPweLcbHpIrQ28
         jr+pvD8pzKP1kWSAZn/Z8NOxLr2M7WYznyjlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478316; x=1741083116;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1AJD9kbREKoAAVeTdoXdRad5r/mh1TKhQnILIMGMp4=;
        b=gGsO/NP2m609kG11l1Ps1qFRYbYVrO+7ByAz/ciYvausZbTIqVDTTaGp+s+WgvKljR
         iDwyF6xJB4DFGmN2o0V5qeq/Vm6TkcLwimqnUgXLg5g7/qG8P9v1c/yy6FGZJoBLSnmN
         tBPj7c1TFZuFF7EhfOXlIMiTPvkeheiLC41bmUUkGbDyPExDeS3oIdgxBKhvlwWRbYnH
         YC9Up2UqS6eTVJjCUIVjUbLvqYi/41jOuiheEXP4t7uIykycXW6WBjeT97dBcPu2IyN5
         W0jpRkGjU73lMDDafWLcI7UV5gkW4o/W/qfnAN3zYXLSc//dRJE0/4IHHrgQlBJCgM57
         it4g==
X-Gm-Message-State: AOJu0Yw6WeYIjIZw1QS0MVyPsbqTUSS5rk6hJaL6hxOQsNVwiSY5EDHB
	VVWJ+EjxQetzZT42dH/687BvlaO8+0A//A6cXtpfJmJO8WHIzFuS+y6HKGzmbSBfKMhm0kGlXBh
	x
X-Gm-Gg: ASbGnct1HORVRNKKeRTtjRRsk6+Z2b/dtJgyxAghjTDkglyUNtUFzE4xO3ZQkcp0lS7
	HSX43q0+N77n4zaDE52ZYNJiT3liMEN4RGcYpEwHNJCs/aQ1Zh16TBf/U/JwucVqYNjm2RUjwwf
	fdXXmRPuJf09j+NUNfxkEzDhxWxeBUVTSh+FFuvO0jXh6DrMMOA1+7BkZBceRF2wbSuseFAt8Ex
	JP9m/g/EbDOYE+54LnT+Mks2Eeeqn4CfwsGq1D+LRM8XexPOSFJ0xU/FXc+GSgqLKH4hPuEqPgj
	Tr6NtTZHA9JFsf2eaAALyVrXQwCvaBF/DHbiH8jQRFXsPw/bw4XjMZ9Oph/4RzZg7yivutM5f8Y
	30mRjtbui2j7NAN8=
X-Google-Smtp-Source: AGHT+IGOSFqOW7h4PIhzgqNxXrF9khynMG1S5yOn0m7TFDEr8neHa7XDJJQUrSYkXvFaNRwee2+3Yg==
X-Received: by 2002:a05:600c:4ece:b0:439:9a40:aa03 with SMTP id 5b1f17b1804b1-439aeae06b3mr140923665e9.2.1740478316428;
        Tue, 25 Feb 2025 02:11:56 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:92c7:7a17:f809:bc92? ([2001:8b0:aba:5f3c:92c7:7a17:f809:bc92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532d4fsm20812965e9.1.2025.02.25.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:11:55 -0800 (PST)
Message-ID: <f81c98f506e531db8b119e5b30a091d10e916aed.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, Joshua Watt
	 <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Feb 2025 10:11:54 +0000
In-Reply-To: <CANNYZj-G+j6yQXm0RCW5M2LcRxqVegsXuAPkLusO9+oueH2t=g@mail.gmail.com>
References: <20240502183501.1216856-1-JPEWhacker@gmail.com>
	 <CANNYZj8aM+mydGDSpMhrvbt8XxKDLzMywVyfKOdxdxrAPgSs2w@mail.gmail.com>
	 <416aa1661cd94d9787fec39012c4c94634a38b4c.camel@linuxfoundation.org>
	 <CAJdd5GbZh7au+VtM_ueBs4MskkJtcx0pFYJG-36nUFW+=KxD=g@mail.gmail.com>
	 <CANNYZj-G+j6yQXm0RCW5M2LcRxqVegsXuAPkLusO9+oueH2t=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 10:12:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17310

On Tue, 2025-02-25 at 09:22 +0100, Alexander Kanavin wrote:
> On Fri, 21 Feb 2025 at 17:07, Joshua Watt <jpewhacker@gmail.com>
> wrote:
>=20
> > I agree the error message could be better, and also that buildtools
> > should not be on by default. Perhaps something as simple as:
> >=20
> > =C2=A0=C2=A0 bitbake-setup --buildtools
> >=20
> > could enable it automatically? I think if there is such a simple
> > option like that it will make it pretty easy for the end users to
> > do
> > the right thing.
>=20
> How do I put this politely? Such an option is not simple or easy for
> the end users, and I'm strongly against this sort of 'solution'. The
> problem is that you, me, RP and everyone else here are suffering from
> 'yocto experience bias', and such suggestions come from that bias. We
> know what to do when we see an error that can be resolved by
> installing buildtools and putting them into PATH.

There is a tricky balancing act here as you also have to give users a
reasonable expectation.

We're not a point and click GUI where every possible choice is going to
work, in fact the more you deviate from the tested paths, the larger
the number of issues you're going to have to handle yourself.

I therefore worry that setting an expectation of everything working,
just means when something does fail, users are going to more
surprised/upset.

Hiding host contamination issues behind the scenes means you could end
up with a generation of patch submitters who simply don't
test/know/care about that set of problems and I'm not sure the project
would benefit from that in the long run.

So whilst I do see your point, we do have to draw a line somewhere and
I'm not convinced always using buildtools is the right one as a
default, particularly if we want every day developers using the tool
too (which we do).

I'd also note that buildtools isn't "free", it does have download time,
space use and installation time.

Cheers,

Richard


