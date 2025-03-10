Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9A4C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 21:00:09 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
 by mx.groups.io with SMTP id smtpd.web10.49832.1741640408698083542
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Mar 2025 14:00:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZU43q9jm;
 spf=pass (domain: gmail.com, ip: 209.85.161.50, mailfrom: raj.khem@gmail.com)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fc447b03f2so1057216eaf.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741640408; x=1742245208; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4jOyaz9MPFyFFarqrl2gDM/ltlDfx8D6ynxF45PWh4=;
        b=ZU43q9jmva2LMNgxQKed4h1w6JjVjJS52vGqXlEkgNrHH4lYCr/JylE+tViSR5p2dx
         Xk6bzyQNLlxsTnpQJeDOk0L2+IbD2UHDEIjSqczDPxo4RjGmkat5czATC0isKxSNH9+7
         MB8bM8Fc2xLgwkm33VZ1Wsc2robkOhK1B7GkKxYba5vt9YdYY12Y29XxgzIu78mbD6cH
         f0vqe9AwepsbUePOueRR3H8Ww7B1AP2RAhi5BoebTVP9jvzlQhIu6hB2VHcgiTfTSzf+
         SDUC5Ohlub2wT7U689TKjWFCKBtK8gZhKMgSqSKk2TnSuHwofxF49Nn+0nsQosa1xi0j
         mBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741640408; x=1742245208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4jOyaz9MPFyFFarqrl2gDM/ltlDfx8D6ynxF45PWh4=;
        b=bR5yFk1klJZ08n26F2CvryzM/XA+MPIR8Jt+gcoh+ZfzhBrUKaqxgUQt2GniYgqfcB
         c5103ZMMx1/00uYZxrBjCY5I8JXMvSew6rLvDk44mxaTFoYxR/Ih0orCjwxubPOs39UC
         WdhdX2LO+PT0EWAdhtBpcwt37ziVxOFh/BTx5enEz8wKCFhnHqfP75/eLJQMsXHJa44B
         rNB/NT3yxYf+Je9jxZ4Gs77mwcHDVPOcHn4IIwYmV5m/OrDYII426Ivaj6wQwyFfNC19
         gTHqqeTxLlBYpxmaCuMjXf0YZKmB2dIrJCBKDqTeyJ0ngewLrxvpRPwOjgqGkEas+oKt
         k4uA==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZBuAgrp4Te/2aR8d16JwQC6bEuQf87oo9BQDCwJGga8/94w4K+gMMMfg3loy4hcdLvay7ZOSIn5fi5/1@lists.openembedded.org
X-Gm-Message-State: AOJu0YwROfC20az6jjtALubBvplNQ0V5XAHWqlOe7hH/mklBVb6v2Wgn
	fNaeIdeLOKz7m0dLLP64O9y+4hE2HEG3ZZXTIJuav2oIU1CR2wz1IxAwxPpaZNvwEJD53dsPz4R
	3IGN+ZJyc0/9HBmJL/X+ueWCEPYs=
X-Gm-Gg: ASbGncsMM7tuGCAIMUkQe8cflEg0ycHqOyNr7OavhRd9VXQuorfIKeRZrA82Fdixg2z
	KhC9Y1L/lloAUV+i0rpHK8HJIoKpJQFS/Nu09qehaHc1XCtgkD8z3zdMcN+Yi8MG+upe4FoUyqm
	oTR0dl6lKRL1w3LQREPoPV8kom6nt4g+6Y2JxWfGsT88qQ7WSQpx6LDaM=
X-Google-Smtp-Source: AGHT+IFYZ3FVaT/cEQ//H5m/E65Lm0T6c3fBTwYCSLk9lfIx4xmtyxpDGAZsYOb6xPISLASjTd58SE5md6fQPAFmlAk=
X-Received: by 2002:a05:6808:1922:b0:3f6:8fa2:1c51 with SMTP id
 5614622812f47-3f697b69d1dmr6694304b6e.19.1741640407761; Mon, 10 Mar 2025
 14:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250307120055.1816436-1-l.goehrs@pengutronix.de> <00f1f0d807758da4bf11c78de652f6d4b6ad1863.camel@linuxfoundation.org>
In-Reply-To: <00f1f0d807758da4bf11c78de652f6d4b6ad1863.camel@linuxfoundation.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 10 Mar 2025 13:59:41 -0700
X-Gm-Features: AQ5f1JrJJvzaMxtghOwuAxyHWIKUJdwWZq_pmchPqCw1skfJ1c7BBhZw2NjdhYA
Message-ID: <CAMKF1sr-86m+4zWfek+yg4tXrv3H2H4c6T+MbMUPM+2s3PPaxA@mail.gmail.com>
Subject: Re: [docs] [PATCH v3 0/5] fetch2/github_release_artifact: fetcher for
 (private) release artifacts
To: richard.purdie@linuxfoundation.org
Cc: lgo@pengutronix.de, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org, yocto@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 21:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17427

On Mon, Mar 10, 2025 at 9:53=E2=80=AFAM Richard Purdie via
lists.yoctoproject.org
<richard.purdie=3Dlinuxfoundation.org@lists.yoctoproject.org> wrote:
>
> On Fri, 2025-03-07 at 13:00 +0100, Leonard G=C3=B6hrs via lists.yoctoproj=
ect.org wrote:
> > This fetcher enables downloading artifacts attached to GitHub releases
> > in private repositories.
> >
> > Authentication is provided using tokens via the `BB_FETCH_GHRA_TOKEN`
> > variable.
> >
> > Changes from v1 to v2:
> >
> >   - Provide examples on how to provide the `GH_TOKEN` more securely tha=
n
> >     just hardcoding it in the recipe in the commit message.
> >     E.g. via the `local.conf` or environment variables.
> >   - Indent the code example in the documentation `.rst` using three
> >     spaces instead of two.
> >   - Document the `token=3D` URI parameter along with the `GH_TOKEN`
> >     variable.
> >
> > Changes from v2 to v3:
> >
> >   - Rename `FetchData.headers` to `FetchData.http_headers` and do not s=
et
> >     a default. Use `getattr` with a default instead.
> >   - Rename the token variable from `GH_TOKEN` (the de-facto default in
> >     GitHub actions) to `BB_FETCH_GHRA_TOKEN` (makes it more obvious whe=
re
> >     the variable is used).
> >   - Remove support for supplying the GitHub token as SRC_URI parameter
> >     to make it less likely that they are accidentally leaked, when e.g.
> >     sharing the recipe.
> >   - Do not use `dict_a | dict_b` to merge the header dicts,
> >     as that feature is not available in Python 3.8 used on Ubuntu 20.04=
.
> >     Use `dict(**dict_a, **dict_b)` instead.
> >   - Explicitly state in the documentation that access tokens should hav=
e
> >     minimal scope.
> >
> > Alexander Kanavin and Peter Marko have voiced some security concerns ab=
out
> > the token handling in bitbake variables that have not been adressed in
> > this v3.
> >
> > The security of the current solution should be on par or better than
> > what we have for `http` URLs that include basic auth usernames and
> > passwords. I consider this acceptable.
> >
> > A generic way to store these kinds of fetcher secrets outside of the
> > normal bitbake variables would be desirable though.
>
> I've been giving this patchset a lot of thought. I'm a bit concerned
> about creating a new "fetcher" namespace for something that is fairly
> niche, particularly when as Peter points out, the same thing can be
> achieved with a bbclass.
>
> If there were no other way to do this, I think I'd be leaning to taking
> the patches but since there is another way which isn't too difficult, I
> think that we should promote that approach instead.

I think, the bbclass abstraction approach would also make it expandable
to other git infra's which might be used in private settings e.g. github et=
c.
so if it was possible, I would incline towards the bbclass approach.

>
> One of the reasons for this is that by merging the new fetcher, it
> would complicate potential future changes to the wget fetcher and I'd
> prefer not to further limit our options there if we can help it.
>
> Unless I see other people saying they need this new fetcher, I'm
> therefore likely going to decline it in favour of the bbclass approach.
>
> Cheers,
>
> Richard
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6524): https://lists.yoctoproject.org/g/docs/message/=
6524
> Mute This Topic: https://lists.yoctoproject.org/mt/111566036/1997914
> Group Owner: docs+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/docs/unsub [raj.khem@gmail.=
com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

