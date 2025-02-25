Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C5AC021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 10:52:20 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.5552.1740480737282307401
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 02:52:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aSMhGCqz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439a2780b44so34017745e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 02:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740480735; x=1741085535; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oneYmO/njpvF5fhA9TOcHnasFym3l+ipNR0Wkpl1I1g=;
        b=aSMhGCqzy4F+gaWkKuehf1lHC3rHQYYpM0JsW6LxliI5qO+Rs5+zsqaz+K9AYmecET
         VpJNRMn1HlX5lehVWWb5jPr6ugJsiP6Vkn+/Whm8w+krEPU/6jO9ZvDdGblBrFDs1VOT
         8doZwLamYmIE7UYXF5KlSzGc0pioLIxRKkIrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480735; x=1741085535;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oneYmO/njpvF5fhA9TOcHnasFym3l+ipNR0Wkpl1I1g=;
        b=V7rcOAqAgZ5ZAXjRgcX1UFpP9WzW0i+vD9WpPqv4+1eHF3laUhP2OmEWwdSFC+BGAO
         k1B4yBroekc/JsR1OPmW4e2h6ZgXBAk92yQJQO01mvHdSbocrb6ctoaUb4XjQNCZEGd2
         8RE/FjRyDuMuDSkixhYisETJZcOHSgM4ysh2QLS6A6koiij6EO/A/0NoDgXqWL4nfCac
         nkvbovZwnQBf6Z4aTP2F6iWKGAw1dxxUZSh2Edf5QEBb1/1A6E5DCZ2aA2Q6JM4ylWbI
         eCq/BZxvR0IHjL+k0AV1mBav+vgJsEhfXsJ6ZoVQih6bp22A4xJrcmQXPeUohfXvFhpU
         t81w==
X-Forwarded-Encrypted: i=1; AJvYcCVMXi4YF+z1sFGEKqvFxC0v9O2eRXvNsvxUVNzGj0lD9m99nq1hh6XWrzWG5lM4naBKaZv2hRv6ghIUkqrx@lists.openembedded.org
X-Gm-Message-State: AOJu0Yyyd3KUt8SXn63NbfeF2REf7wbvwxE8ozzuv1MEf1yclEbA/8vV
	1dyJvc8l+X10V8d2t4kzhauCJ4OZZqxlnNVyla++OVW6rDLV96fv9euw3GkQ8hA=
X-Gm-Gg: ASbGncvIaI+Y1cFP42E0Ob5lEvk0Jshy8YIgTQQYUNL1x8+UzZLslQRWMBitn20YhBD
	w/u0FQpkPRvrSeZegWMSzLq458mXEJdaZxi8cadbqLkL6PCCX1CF2M1dCDLVZV263cHz0ovld67
	bKdAuV/qyVS5U7YjBcwBsVZvpmX1B8YmTrVxmoLv9bVSw/TuvK6TiSnbpLFV98256940VBekl25
	t3IGH4qJfZA/R18B0VXN3FO3YcdHUUBFJeoDizfdNlBriESi3/CDfaMmiWHAcwvH6s9jFSVtAso
	GGiafpayTYgb4u7Npj4FFiGgqehDi3kyyIB+nEhDRAfJLFDbWm0EhVVJUsMcwOGk4FrNhBCR9oT
	7qpikdretL/PT8K4=
X-Google-Smtp-Source: AGHT+IHhq5CySi6AoyFv2eXFofDDhWg5DE4/xq+GaTgdzGYmZ8oFbKF6tedRtRDQZXZ+xcCEmRrBXg==
X-Received: by 2002:a05:6000:4009:b0:38f:286c:9acc with SMTP id ffacd0b85a97d-38f6e97a0b1mr10828021f8f.32.1740480735557;
        Tue, 25 Feb 2025 02:52:15 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:92c7:7a17:f809:bc92? ([2001:8b0:aba:5f3c:92c7:7a17:f809:bc92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fbcabsm1823939f8f.86.2025.02.25.02.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:52:14 -0800 (PST)
Message-ID: <bdc5729820853195b796dc21444eadee95c8c0c2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 25 Feb 2025 10:52:14 +0000
In-Reply-To: <CANNYZj9nsLOLGMoH9WykwuETM7U5wen-KWbqFnPSVgN--U_Yag@mail.gmail.com>
References: <20240502183501.1216856-1-JPEWhacker@gmail.com>
	 <CANNYZj8aM+mydGDSpMhrvbt8XxKDLzMywVyfKOdxdxrAPgSs2w@mail.gmail.com>
	 <416aa1661cd94d9787fec39012c4c94634a38b4c.camel@linuxfoundation.org>
	 <CAJdd5GbZh7au+VtM_ueBs4MskkJtcx0pFYJG-36nUFW+=KxD=g@mail.gmail.com>
	 <CANNYZj-G+j6yQXm0RCW5M2LcRxqVegsXuAPkLusO9+oueH2t=g@mail.gmail.com>
	 <f81c98f506e531db8b119e5b30a091d10e916aed.camel@linuxfoundation.org>
	 <CANNYZj9nsLOLGMoH9WykwuETM7U5wen-KWbqFnPSVgN--U_Yag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 10:52:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17312

On Tue, 2025-02-25 at 11:40 +0100, Alexander Kanavin wrote:
> On Tue, 25 Feb 2025 at 11:11, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>=20
> > So whilst I do see your point, we do have to draw a line somewhere and
> > I'm not convinced always using buildtools is the right one as a
> > default, particularly if we want every day developers using the tool
> > too (which we do).
>=20
> I'm no longer proposing always using buildtools by default. The point
> of my message was something else: should we direct bitbake-setup users
> to buildtools if they get a fail that can be addressed with them, and
> if so, how? I'm pretty sure a lot of first timers are going to get the
> 'missing python websockets module' problem, and they will find a hint
> about buildtools helpful=C2=A0 (and something that is already installed a=
nd
> ready to run even more so). I'd rather think about it now, and not
> when bitbake-setup, standard configs and associated CDN sstate cache
> go 'live'.
>=20
> There were several options proposed in my previous message, and they
> were all skipped in response :(

I'd stand by the idea what failure messages should be good in general
and standalone. We have worked on sanity.bbclass in the past to try and
ensure that the messages are understandable and give pointers to users.

What might be missing is documentation in the quick build docs saying
"if you run into host problems, you could use buildtools?"

Perhaps if sanity.bbclass is failing the build, there could be a
message in there mentioning buildtools as possibly helping/

Could bitbake-setup actually run the sanity tests before the build and
wrap the result with a message about buildtools?

Cheers,

Richard

