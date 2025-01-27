Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A5DC02188
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 21:06:33 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
 by mx.groups.io with SMTP id smtpd.web11.2397.1738011983483531672
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jan 2025 13:06:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E2PMTM3z;
 spf=pass (domain: gmail.com, ip: 209.85.166.49, mailfrom: chuckwolber@gmail.com)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844e55a981dso126384339f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 13:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738011982; x=1738616782; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iZ+8YYH+TwiDN7rL0pezDrEsrVIbeyCvAf8IeMeUgh8=;
        b=E2PMTM3zp0qc3LfuHY0trqwRI9hix42qXK44sSHuugaUMDqY6eTuk0AoLJmq88KxOo
         KXV91cxj/NxG74ZDzCYSDa0D4UNKwd+SvcuR7cTLCp6hj7RkuegcqBRm8U2xLkEVzkBg
         HUcbSO+wUaRU/pXycbfYJvtoFhB2BQ73E6KIqU0ZWQP0OwOnuHwiIW1tYW4Pp30xZyjl
         BM0Y0hnd7koxwGwU1EXLg127NwezMNmjxzQ2stvEowt8JZ+MK0yL8l6Cu+8iI9RAm4a+
         n//PRPPud2b5CnozdF3MzuL17JESwopWJd9Ome+v4EIumEO195DVh5aPDl6yOD0DdzpT
         6zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738011982; x=1738616782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZ+8YYH+TwiDN7rL0pezDrEsrVIbeyCvAf8IeMeUgh8=;
        b=shmdf6QVZcAkXCSXenIkt6mrJVoUAR8T8WzuJYylo6sWHXmrGzMQMXu+tVb6Ly52Sg
         QLB4uZNniEg1q7AKrbtxJr78xYzMbdVSZf6BWqnX5dZctmp9KOH/ll8+D2FnebxCNwCt
         vpBX0tgxpMcBharOmfpo5xI4+ilhDcXpYzzjan+JYekjELmXU/SjVOcAQYr05oIrXiGz
         hqoYlvJvPbp3H3KTXo6zY42t8aig0pnJUrLbqSfdxWovjicCv7hyQYQCSZk+gKrZVwPe
         OQ+3TDuSt/0zolBGUbxU3sAKVY4XeGJZC1qbnsJiw7v+vPDrllFgaYhxqZteP9dxcr5g
         zeVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjYZKrJOsv+XOSXXVNYYCro3XGc9HVHrTFLK2njzNG6r3MzhYNMceHKqlWPu4exKZX1aQ1o3Tm1P7dqOKv@lists.openembedded.org
X-Gm-Message-State: AOJu0YxOB9nHiLGmzoj1H8kuhqGN8kMwCFFGJzbWhfb4krF4t1IuP4fr
	adI1U+lbMCUBt0ue9Wc/LFHvwI5hOUR9vcQbwSSi+Tr8lc089IIQRB0GhXzTQjRi+x7VRc/Gkia
	A3/e+KXsaQbQDHBi8vMJcMA37el4=
X-Gm-Gg: ASbGncsIazba1IWIShGMZDTXg6d8k2xP0gmz/O/M1hB/Qeo/GJwNsj7LXIIFT5Jo/8f
	gx5tO1gJJEONGbhqGJhp0TlmgfIEA7lyrAddFC1/Owc7RoeDOTQaCHKmO+im2VN/EkHRSetbloR
	xvBIFbv+1/gzcS0W8IsvVtB+PdBER3
X-Google-Smtp-Source: AGHT+IELt5g10vCAylGmC6JFhIRfioSQSpEZFcd7a7bIz/T+EzjM5pHEMPIEhPHLntRVQAxlRkbwwWA7aV5qdOZGh/E=
X-Received: by 2002:a05:6e02:fc6:b0:3cf:c17d:5cba with SMTP id
 e9e14a558f8ab-3cfc17d5ebemr92589545ab.9.1738011982582; Mon, 27 Jan 2025
 13:06:22 -0800 (PST)
MIME-Version: 1.0
References: <20250127142918.163-1-eric.meyers@arthrex.com> <CANNYZj-d4EXpM30v+DgY6p=3NjVZG7ThKTBTPSGX70CXh+rjPA@mail.gmail.com>
 <CA+cKJ+HEK9d-tvf-Srz=NwHCrkyikb-ws1u8Bn9kD--EiDF5zQ@mail.gmail.com> <CANNYZj8jjBpFrix4mwYG2SJ1JuvX6MHSmvcrO70WNmuEs=x0rQ@mail.gmail.com>
In-Reply-To: <CANNYZj8jjBpFrix4mwYG2SJ1JuvX6MHSmvcrO70WNmuEs=x0rQ@mail.gmail.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Mon, 27 Jan 2025 13:06:05 -0800
X-Gm-Features: AWEUYZltLat0e2vhtWXF-NUIYIo3aef7anTOiu2yRFgf-4Ho5UwvHUXndJK2cwc
Message-ID: <CAB=6tBR1y2Xzpy0MK1uW2TLV7O1opcW_UP_LGd-t=yYg+SAL2Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/3] NPM/NPM Shrinkwrap Basic
 Authentication Credential Support:
To: alex.kanavin@gmail.com
Cc: Eric Meyers <eric.meyers15310@gmail.com>, bitbake-devel@lists.openembedded.org, 
	"eric.meyers@arthrex.com" <eric.meyers@arthrex.com>
Content-Type: multipart/alternative; boundary="000000000000d66257062cb6721a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 21:06:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17106

--000000000000d66257062cb6721a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 10:01=E2=80=AFAM Alexander Kanavin via
lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
wrote:

> On Mon, 27 Jan 2025 at 16:44, Eric Meyers <eric.meyers15310@gmail.com>
> wrote:
> > Are you suggesting that instead of username=3D and password=3D paramete=
rs
> > in the npm/npmsw SRC_URI, it should be an "npmrc" parameter that
> > effectively the user can point to the location of their .npmrc file
> > for authentication on an NPM registry? Then, within a user's
> > associated recipe, they would need to create the npmrc file in a
> > do_fetch:prepend() step that that corresponds to the path passed into
> > the SRC_URI?
>
> The only acceptable solution would be one that takes passwords written
> in plain text out of layers and local.conf altogether. And the way to
> do it is to write these things into ~/.npmrc and ~/.netrc in a secure
> manner (e.g. pass in to users via encrypted email with instructions
> that the file must not be readable by anyone but the user), and ensure
> that npm and wget are able to pick them up from those files (wget does
> this already, npm I'm not sure).
>

Could this also be solved by letting the end user decide, sort of like the
way FETCHCMD_*
works?

A CREDENTIALCMD_npm variable in local.conf could be saddled with exporting
the
namespace, password, and username values into whatever environment needs
them in a
"Just in Time" fashion to lower (but not completely eliminate) exposure.

An identity agent, like the 1P or vault CLI would be an obvious choice
here, but one could
just as easily tie it to a script that devolves down to looking in ~/.npmrc
if they wanted to.

..Ch:W..

--=20
*"Perfection must be reached by degrees; she requires the slow hand of
time." - Voltaire*

--000000000000d66257062cb6721a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 27,=
 2025 at 10:01=E2=80=AFAM Alexander Kanavin via <a href=3D"http://lists.ope=
nembedded.org">lists.openembedded.org</a> &lt;alex.kanavin=3D<a href=3D"mai=
lto:gmail.com@lists.openembedded.org">gmail.com@lists.openembedded.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mo=
n, 27 Jan 2025 at 16:44, Eric Meyers &lt;<a href=3D"mailto:eric.meyers15310=
@gmail.com" target=3D"_blank">eric.meyers15310@gmail.com</a>&gt; wrote:<br>
&gt; Are you suggesting that instead of username=3D and password=3D paramet=
ers<br>
&gt; in the npm/npmsw SRC_URI, it should be an &quot;npmrc&quot; parameter =
that<br>
&gt; effectively the user can point to the location of their .npmrc file<br=
>
&gt; for authentication on an NPM registry? Then, within a user&#39;s<br>
&gt; associated recipe, they would need to create the npmrc file in a<br>
&gt; do_fetch:prepend() step that that corresponds to the path passed into<=
br>
&gt; the SRC_URI?<br>
<br>
The only acceptable solution would be one that takes passwords written<br>
in plain text out of layers and local.conf altogether. And the way to<br>
do it is to write these things into ~/.npmrc and ~/.netrc in a secure<br>
manner (e.g. pass in to users via encrypted email with instructions<br>
that the file must not be readable by anyone but the user), and ensure<br>
that npm and wget are able to pick them up from those files (wget does<br>
this already, npm I&#39;m not sure).<br></blockquote><div><br></div>Could t=
his also be solved by letting the end user decide, sort of like the way FET=
CHCMD_*</div><div class=3D"gmail_quote gmail_quote_container">works?<br><br=
>A CREDENTIALCMD_npm variable in local.conf could be saddled with exporting=
 the</div><div class=3D"gmail_quote gmail_quote_container">namespace, passw=
ord, and username values into whatever environment needs them in a</div><di=
v class=3D"gmail_quote gmail_quote_container">&quot;Just in Time&quot; fash=
ion to lower (but not completely eliminate) exposure.<br><br>An identity ag=
ent, like the 1P or vault CLI would be an obvious choice here, but one coul=
d<br>just as easily tie it to a script that devolves down to looking in ~/.=
npmrc if they wanted to.<br><br></div><div class=3D"gmail_quote gmail_quote=
_container">..Ch:W..<br></div><div class=3D"gmail_quote gmail_quote_contain=
er"><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><b><span style=3D"=
font-family:monospace">&quot;Perfection must be reached by degrees; she req=
uires the slow hand of time.&quot; - Voltaire</span></b></div></div></div><=
/div>

--000000000000d66257062cb6721a--

