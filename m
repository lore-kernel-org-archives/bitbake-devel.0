Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1A4C433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 10:28:37 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by mx.groups.io with SMTP id smtpd.web10.43134.1636367316668548449
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 02:28:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=jgIkd4ON;
 spf=pass (domain: gmail.com, ip: 209.85.222.41,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f41.google.com with SMTP id q13so30483295uaq.2;
        Mon, 08 Nov 2021 02:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvpOOjvbUDMt7yg623YyHzyTJnSyhZTLnCIzK/K91TU=;
        b=jgIkd4ONEzZbmzcUwInCiF3HgJCJ1cMOBif0bLQ4Eqny5odOozx/jPkIZuqed9TGPU
         vgH8JD+yvrGy+K4H/qHG4sZ+nzIJVtph/tBz0RpE/DwFBaNlqrTQElyN87UYVTdsUnYV
         SsaPYRIqwDjB3j2+kHlFiM78qg0FFbwCh0+tFRhWp4YNFEf1f5ya3o52aZ2LFlUzjFxc
         r/tmuyHx8VahL5qZhrcodb5u+Vow1hS2QRlyEWnynzrGrveQnLJIQBR2PW8ubFH//yRz
         TrCwBEbLFSekHGJ6e7mNm0dQtuBW+02lT8oTMEoaMSLybnbFzREoQZCtGMUFiRZbnT3p
         rEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvpOOjvbUDMt7yg623YyHzyTJnSyhZTLnCIzK/K91TU=;
        b=vQc2coWpnGm9nCBVYQPjfSZIj8cx9BO2eh1iQ72w8TpN+C3C3nq+aDkuB63WFNkKk3
         L4V8hq9bfRzNrfpWZdOsWzgCJsHjE4E06CGfxqwaxNjC3PkgkOTLvhD72NGhmaBCVJ+d
         PFYIzjKe/uLYwVy4ntST5lsx4Mz7yT3lk0GXOZn6aLMP4Wi8+NpwBsFWRQ9UcaM105kp
         kjxJF0GWAAWI9S7VVeZ65V7W55LAdyf1LPVcPhlvIU7cUATQckPptdp75ykTVSsGbUyF
         sHJ7Jl+ZUSXw59ujEesZUtUFN2qBizu/VH54FT+LVAUsyaoVM1xDoLRO4P7W6pjAowed
         0Nsg==
X-Gm-Message-State: AOAM532n85Ukv6nVxhdAymwQrWTvzC2eoMXjkI3nITgTWecgs8EzHunV
	NUw+LN8OnuDNp3/7OwiZoQssxRbfXjDwxmstdeY=
X-Google-Smtp-Source: 
 ABdhPJw3rdr7nTXE/qzBZWbxCWas6Tm9IzVMvArH5VIXEZyCzNbfIkBIQUrr3dwWvVhVXseVcn9z0mxiPbD0gfPBSSQ=
X-Received: by 2002:a67:ca8f:: with SMTP id a15mr49788669vsl.18.1636367315646;
 Mon, 08 Nov 2021 02:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20211105133048.19879-1-jasper@fancydomain.eu>
 <20211105133048.19879-2-jasper@fancydomain.eu>
 <cf04f6c310491ca861ce5073dc14554bcba99ebc.camel@linuxfoundation.org>
 <5538dd6d-94df-af1f-8141-4d6b63f119d1@mko.dev>
In-Reply-To: <5538dd6d-94df-af1f-8141-4d6b63f119d1@mko.dev>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 8 Nov 2021 11:28:24 +0100
Message-ID: 
 <CANNYZj8vpBCLhaUywM-EOSkCMgh0968WbS7BND9U-jHbO4Q=og@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch2: Fix race condition in
 latest_revision
To: Martin Koppehel <martin@mko.dev>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
 Daniel.Baumgart@iris-sensing.net,
	OE-core <openembedded-core@lists.openembedded.org>,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Content-Type: multipart/alternative; boundary="000000000000923d7c05d04474a2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 10:28:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12934

--000000000000923d7c05d04474a2
Content-Type: text/plain; charset="UTF-8"

It helps if you can provide a specific example/test case for this.

Alex

On Mon, 8 Nov 2021 at 11:26, Martin Koppehel <martin@mko.dev> wrote:

> -- snip
> > I'm afraid I don't understand why this is a race condition? Where is the
> timeout
> > that stops one being set?
>
> The commit message is misleading here, will change that. It is actually
> not a race condition as we originally thought, but more a problem of
> recursive calls to _latest_revision.
>
> The git fetcher does something similar in _lsremote, where the git
> lsremote would be called recursively to populate the environment, and
> there's code in place to prevent that.
>
> In our case, since we persist the revs, we have to filter out empty revs
> because otherwise the next repo fetcher invocation would also try to
> populate the environment but then revs[key] would already be set to an
> empty string, causing a metadata mismatch later.
>
> Therefore we only populate the revision cache if _latest_revision
> actually returns a valid value.
> We did reproduce this with multiple recipes that used up the same
> SRC_URI and therefore influencing each other, this case works fine now.
>
> Cheers,
> Martin
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12933):
> https://lists.openembedded.org/g/bitbake-devel/message/12933
> Mute This Topic: https://lists.openembedded.org/mt/86840265/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000923d7c05d04474a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>It helps if you can provide a specific example/test c=
ase for this.</div><div><br></div><div>Alex<br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 8 Nov 2021 a=
t 11:26, Martin Koppehel &lt;<a href=3D"mailto:martin@mko.dev">martin@mko.d=
ev</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">-- snip<br>
&gt; I&#39;m afraid I don&#39;t understand why this is a race condition? Wh=
ere is the timeout<br>
&gt; that stops one being set?<br>
<br>
The commit message is misleading here, will change that. It is actually <br=
>
not a race condition as we originally thought, but more a problem of <br>
recursive calls to _latest_revision.<br>
<br>
The git fetcher does something similar in _lsremote, where the git <br>
lsremote would be called recursively to populate the environment, and <br>
there&#39;s code in place to prevent that.<br>
<br>
In our case, since we persist the revs, we have to filter out empty revs <b=
r>
because otherwise the next repo fetcher invocation would also try to <br>
populate the environment but then revs[key] would already be set to an <br>
empty string, causing a metadata mismatch later.<br>
<br>
Therefore we only populate the revision cache if _latest_revision <br>
actually returns a valid value.<br>
We did reproduce this with multiple recipes that used up the same <br>
SRC_URI and therefore influencing each other, this case works fine now.<br>
<br>
Cheers,<br>
Martin<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12933): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12933" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12933</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86840265/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86840265/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000923d7c05d04474a2--

