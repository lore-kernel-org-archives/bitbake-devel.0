Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web10.13733.1612653319736630257
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:15:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=UiQiVu2q;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id df22so13895031edb.1;
        Sat, 06 Feb 2021 15:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CB9+SiuxdXELzvu1uDRjoLOYRs6lBKK3YQuJ68gcR6g=;
        b=UiQiVu2qxbWde7UUZKlhuajvjSlqrhSjY1OwDk21aJg/nJ0rhdcA6ZLE/lCTrJOA45
         aGjJEYl65kCnytM5Zs/M+09ugk4qTIeFXCksZ2J0XyLmuDGlHItaI3H7MoN1aRjjCMcC
         4pOzK1jRx1y7N1ngPkhkGk2qdqXMo///Qlv3pFNcFRv38/N32etnVDskWzl0YgNBI/6Q
         X0i4PsBsHC6XBxmV0p2uLeNdaj6VH4wvj1UmAo6mbe+3zrAIlaVTBdyS3VC9qnokdoBx
         2y+Ar2rt/gkGX8hSxrI+yDVSwz0qVxRYIeCfmdqKjWbfED8238bIzIqSBehJ53YXacyd
         sHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CB9+SiuxdXELzvu1uDRjoLOYRs6lBKK3YQuJ68gcR6g=;
        b=WLVASZCHWvKRp9tFD3EcAGeKLPr/CHkBQPKxg0tkE1JF+PFnhYVG3C1kFWQoHzaHNF
         AT6g4uXt/8H5tN3IMIsig1KHSq1cRK2nudt0Xxo16FDaHWqUr5XZmXOcGoV8nal7RyWc
         qkTVYa4YxXTNvduG3W9CNf2p3+mk4jlbetq2HO7xAan4Zp9TMY1lvs4RmK+YmQD7EdmP
         MObPtoCXE03Jmn8TpwzdS1Jym3T795CezgiVG90laO9BvQ6Mmd1y9+P/j0vqscmHUGEk
         4pJno4eWxiVS28chik+XpzrkE5hzqRjmWA8eiCDj1+ki8IkFi3bfSxiP8flIw/Ab32Tp
         hRJA==
X-Gm-Message-State: AOAM532w5u/X1uqskkDzAoMH+qv3xwddmIs6p4UndBXyDwdOyo8eWDbl
	xpKAA8p0U0noVUULEE3TNEqKPx7IFmj6qc5H+EU=
X-Google-Smtp-Source: ABdhPJwiF6Dhn+TSHoXnY08VfmUtOMrrRbQdxZBLiF3IyvXUdCOmhhOovuA+uDSsT6pic0Xs7Ea1vuqS6yxE9OeLZgo=
X-Received: by 2002:a05:6402:524a:: with SMTP id t10mr10271016edd.270.1612653318158;
 Sat, 06 Feb 2021 15:15:18 -0800 (PST)
MIME-Version: 1.0
References: <17b543581ffb421b812323891405dcfb@XBOX03.axis.com>
 <CA+chaQc0anOg2E=o1ouEca-QJDGqKxDoXm6aPVXzsc8TELW3zA@mail.gmail.com> <d9185d19-1f09-a1b6-2926-f54309190b24@gmail.com>
In-Reply-To: <d9185d19-1f09-a1b6-2926-f54309190b24@gmail.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Sun, 7 Feb 2021 00:15:07 +0100
Message-ID: <CA+chaQdT4zVNw26kkdV+A2_qRZYtt-LvPzaYtm2pZCurOB_Zbw@mail.gmail.com>
Subject: Re: [bitbake-devel] Backport changes for _PYTHON_SYSCONFIGDATA_NAME to Gatesgarth and Dunfell
To: akuster808 <akuster808@gmail.com>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Steve Sakoman <steve@sakoman.com>, 
	"Mittal, Anuj" <anuj.mittal@intel.com>, 
	"OE Core (openembedded-core@lists.openembedded.org)" <openembedded-core@lists.openembedded.org>, 
	"OE Development (openembedded-devel@lists.openembedded.org)" <openembedded-devel@lists.openembedded.org>, 
	"BitBake Development (bitbake-devel@lists.openembedded.org)" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000002cbe0905bab31cc7"

--0000000000002cbe0905bab31cc7
Content-Type: text/plain; charset="UTF-8"

On Sat, Jan 16, 2021 at 6:52 PM akuster808 <akuster808@gmail.com> wrote:

>
>
> On 1/16/21 9:44 AM, Martin Jansa wrote:
> > Aren't the missing spaces in appends fixes also needed for meta-oe
> > recipes?
>
>
> >
> > I think at least top 5 commits from:
> >
> https://git.openembedded.org/meta-openembedded/log/?qt=grep&q=space.*append
> > were also follow-up from these changes in oe-core.
> >
> Do you mean something beyond the meta-openembedded commits mentioned
> near the bottom of the email?
>

Yes I mean these 5 commits at least.

with c99bb790 DEPENDS variable doesn't end with a space, so the missing
leading space in these appends (which was fine until now because of
trailing space from DEPENDS set in bbclass) is now causing wrong dependency
(should be easily reproducible with the patches backported, just by parsing
the recipes).


> I need clarity so I can open an issue in gitlab for tracking purposes as
> I am sure I will forget this
>

we're using gitlab?

--0000000000002cbe0905bab31cc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Jan 16, 2021 at 6:52 PM akuster80=
8 &lt;<a href=3D"mailto:akuster808@gmail.com">akuster808@gmail.com</a>&gt; =
wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><br>
<br>
On 1/16/21 9:44 AM, Martin Jansa wrote:<br>
&gt; Aren&#39;t the missing spaces in appends fixes also needed for meta-oe=
<br>
&gt; recipes?<br>
<br>
<br>
&gt;<br>
&gt; I think at least top 5 commits from:<br>
&gt; <a href=3D"https://git.openembedded.org/meta-openembedded/log/?qt=3Dgr=
ep&amp;q=3Dspace.*append" rel=3D"noreferrer" target=3D"_blank">https://git.=
openembedded.org/meta-openembedded/log/?qt=3Dgrep&amp;q=3Dspace.*append</a>=
<br>
&gt; were also follow-up from these changes in oe-core.<br>
&gt;<br>
Do you mean something beyond the meta-openembedded commits mentioned<br>
near the bottom of the email?<br></blockquote><div><br></div><div>Yes I mea=
n these 5 commits at least.</div><div><br></div><div>with c99bb790 DEPENDS =
variable doesn&#39;t end with a space, so the missing leading space in thes=
e appends (which was fine until now because of trailing space from DEPENDS =
set in bbclass) is now causing wrong dependency (should be easily reproduci=
ble with the patches backported, just by parsing the recipes).</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
I need clarity so I can open an issue in gitlab for tracking purposes as<br=
>
I am sure I will forget this<br></blockquote><div><br></div><div>we&#39;re =
using gitlab?=C2=A0</div></div></div>

--0000000000002cbe0905bab31cc7--
