Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A078C021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 16:08:05 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web10.26712.1740154079929056301
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 08:08:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CVmASoE6;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5452c29bacfso2487751e87.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 08:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740154078; x=1740758878; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7e2LX3W0lhOGF3NykJPeAwznRQ+2JHErc/WOPlA2Q0=;
        b=CVmASoE6vKAkFITYH4HSrIumd2xM5sl+1oXH8eNdeuOud1tmwuZiXbzJwLijp/brdI
         PL4YwvsimuQ0Bh8AtYZKO33yxD6TEQHrmUR9xK843cHeABjG+80swDv6xVEH3+qiY0R7
         7U4VSBqlXgNs7YiCxD52SrXI009s350zOn4DXFwkXybWPkcKHMQUymfSnXB4l/ndzqNx
         Y764bYMVF8y/LFnr2tk2PSkTete8n7nG+n4LvsEvPNW9fgyv/qnHbC9qkj0GmhSp/Dxd
         +o0T1UMptf0MKUYPV8QXxD5V6SyvKucREY3e6mn+zcI3itqi3dr8VlafE6n2ihuY7tee
         x3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740154078; x=1740758878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7e2LX3W0lhOGF3NykJPeAwznRQ+2JHErc/WOPlA2Q0=;
        b=reqGw39t2bcF1qkySqgg9mS3WJS02sxWvrLvICUurBmqgh7dBTFbGuzbK1RIOlKz+6
         f42R52wbFi4jH8CgJ00d5TaS2lULlIB2l6GumSA9zrcLCQJLp9tJjDuONSAD6bqZ1bKQ
         m7ou0dFNSUqWaoCmjlAjQwcyAebArSbiEsuvfdfBxLRYKM27l1gmIxzEFv1qats3IeiZ
         G3p8t3LyuTShpRgU4RDu5ayxnd1o2aPH5kPXHriPUou16LXlGqrr+Eetxo/xmFZ5xE5R
         r/PQ22H17Aq0IMecvd4pz1lM9iiXZUEHXYG283LY2C5gYIjJVN9QjwzbNNsCXpjQeqZm
         hvUg==
X-Forwarded-Encrypted: i=1; AJvYcCWMEWE32bwbgq58/bqvydSYxDLqCo9wyZGRm/W4K0rJj6N7rA6llkDoV10inZf3toDH49spQGGxzzCWglTd@lists.openembedded.org
X-Gm-Message-State: AOJu0YyrhtOc+//3M0iS4FRS6KRiD6RJkKvOQAhMCu//WndwgOtOeahd
	CBysia4uShtidI+J28zJHy6cPjOjLQ4wiRYXTP2NvOut60ZMENS+S6ZKO0sAGRf0zOYGeUIM8ef
	JuP0BEUT8BSYsElo0aaTTcPA6HjE=
X-Gm-Gg: ASbGnctzLNpjU9ziCz3Nj7t7W4g3DOfIpmklcR7hj2uzif78zwDZjRYL2YIFxuZo6k0
	L1JmuTPL/aWk9h3MLdhWKB4krEfvK6YRWP+HdAlVh7lQX2TGrt9Ji/oc/ihR4CaYZU1hGJD0nLd
	WoUYoK5I0=
X-Google-Smtp-Source: AGHT+IHidtjp5wJmMO5NG/Ql6GFdxK4k8Gdfq1hJ9Lyd/iS0+jUsAxY1qBI6BwIJU8DVMjKLzEv1vBsDV+b+999PMAU=
X-Received: by 2002:a05:6512:2204:b0:545:2300:924d with SMTP id
 2adb3069b0e04-5483913b648mr1391121e87.22.1740154076413; Fri, 21 Feb 2025
 08:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20240502183501.1216856-1-JPEWhacker@gmail.com>
 <CANNYZj8aM+mydGDSpMhrvbt8XxKDLzMywVyfKOdxdxrAPgSs2w@mail.gmail.com> <416aa1661cd94d9787fec39012c4c94634a38b4c.camel@linuxfoundation.org>
In-Reply-To: <416aa1661cd94d9787fec39012c4c94634a38b4c.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 21 Feb 2025 09:07:42 -0700
X-Gm-Features: AWEUYZmMcvF0fpD9CgaAOZi4Qdu-YpZUQNnF6kwhVIO7LLBHoQIfeYAUOmor5f8
Message-ID: <CAJdd5GbZh7au+VtM_ueBs4MskkJtcx0pFYJG-36nUFW+=KxD=g@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 16:08:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17277

On Fri, Feb 21, 2025 at 2:16=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Thu, 2025-02-20 at 17:05 +0100, Alexander Kanavin wrote:
> > On Thu, 2 May 2024 at 20:35, Joshua Watt via lists.openembedded.org
> > <JPEWhacker=3Dgmail.com@lists.openembedded.org> wrote:
> > > -                    except ConnectionError as e:
> > > +                    except (ConnectionError, ImportError) as e:
> > >                          bb.warn("BB_HASHSERVE_UPSTREAM is not valid,=
 unable to connect hash equivalence server at '%s': %s"
> > >                                   % (upstream, repr(e)))
> > > +                        upstream =3D None
> >
> > I'm setting up a bitbake-setup configuration that uses
> > BB_HASHSERVE_UPSTREAM and the official yocto sstate cache on the cdn,
> > and I think we have a usability issue here.
> >
> > Specifically, if the user does not have websockets python module
> > installed, then they will only get a warning:
> >
> > WARNING: BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash
> > equivalence server at 'wss://hashserv.yoctoproject.org/ws':
> > ModuleNotFoundError("No module named 'websockets'")
> >
> > without a suggestion about how to resolve it. Worse yet, the build
> > will proceed, but fail to use any sstate, resulting in rebuilds from
> > source, and a bad first experience for yocto newcomers.
>
> I think we should split that exception handler to catch ImportError
> separately and mention in the message websockets was missing, if wss://
> is in the url.

I agree the error message could be better, and also that buildtools
should not be on by default. Perhaps something as simple as:

   bitbake-setup --buildtools

could enable it automatically? I think if there is such a simple
option like that it will make it pretty easy for the end users to do
the right thing.

>
> Cheers,
>
> Richard

