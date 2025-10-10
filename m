Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888ABCAC5BB
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 06:37:14 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.2926.1760078226567457153
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 23:37:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=bG5ff5Ir;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso9381855e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 23:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760078225; x=1760683025; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dkIDXLar2L6rzmntHNUWKrZ02GddPUslQUJMqzEFrAw=;
        b=bG5ff5Ir8ZP9Tiinaz7qZoFTgBYRn8uiVeMT4j9gJy4qapKYjvuzrCiIZyp+9L7QwG
         a+eYUdHJDar0DaZRw5cGueoz60JKSkhhciaMFDfiQrt6+aQvW+JKj6gM7diZMhZPTUUs
         hlyhnprwV3WLX0XQpUH0Kvs2uUfDy6oUM3d9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760078225; x=1760683025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkIDXLar2L6rzmntHNUWKrZ02GddPUslQUJMqzEFrAw=;
        b=MM33qrOSqV80o/ooPDvyXuXNEp8xqCyPXLwqSm4XwEJp5AeihzVjVYUiAee21kii1e
         xdQZi3PCeLDTEHQLKbD8oraSEtCmALrrGhMl0kqxpKOE/f3d4r4tuf3v1sVOvO7jTh/u
         F14/irJcplyA1vNH90OX8F2+nAq/UxqYAx6ibp383OoXeZGY9LndITEIeu/6IXQQ8X9t
         k8ewEy4S/p1dmVvRbURQIKv5//eQtKFjIDUvit63XgV+N4YVIXwripce8FkC24IS4vYR
         qT4VaLyQeVLzWdGGFg4qqYjCg9pZgiA8vsnzLtN325v9feiwMpqguMxbpMxdHqk2vEHr
         9YLg==
X-Gm-Message-State: AOJu0YwJSeNH0c+q9Mt0ovifobA0Jbx5Xu01uD523t0BR6YvBmKoWmzb
	R+wgHvZ0gwg5ir3bViB8hWFjol+PisqOxGCzE8JTpiKyEvsIQNfMDD10/k7XFjGH+wo0OnPxlSR
	NuSN/1j/EpYB2IKneeuPq2UDJOFCjOlAMjXkEafu/mg==
X-Gm-Gg: ASbGnctTjIA5yWYz4pDD9VWqFICbvqCIYZw5gyaInfX5vtBx7dkXhN1TwaMm13q0N9X
	hkVlN9D0SfTxNeH+1x85bLQmfn2SjpTOzE2rmGXjz8OdEofeB/lA+evL6suIMAAmqxiM6BaK8kv
	4u1NI1vQUyY7OOjCoFPktxxtQE7b/gfwteE9xueZfKbm9P1d7mDBVg1hCPwkVLIaQ7fFfG6j2he
	/5YUijbaB4kOpv3BCptUjKYc4L88cvUDWDEJbChXUe7yTXhkqY7shFvx9EH
X-Google-Smtp-Source: AGHT+IE2SBZjBxYumtyztpC/NTsOzrDqp5RIemN9VZLD5U8FYyYVC61qTE6Jz8hfUge+v1wbJwBR20w9iQCXMGt5fCE=
X-Received: by 2002:a05:600c:4752:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-46fa9aa48d7mr74035305e9.15.1760078224876; Thu, 09 Oct 2025
 23:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251009160717.2527351-1-yoann.congal@smile.fr>
 <CANNYZj-NPGrWypiuh8hU-BB+fM5pVsTh=4ZPOJt6seu-AKN=Cg@mail.gmail.com>
 <CAMSfU+5=K4oe1P8udCcJG728Nv1VtiCzFmOJzRL5DKi885GFNA@mail.gmail.com> <CANNYZj_aaEUzAOZboOzbWcmZ0X21dQvJMPc3G17xEp00-Y0MPA@mail.gmail.com>
In-Reply-To: <CANNYZj_aaEUzAOZboOzbWcmZ0X21dQvJMPc3G17xEp00-Y0MPA@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Fri, 10 Oct 2025 08:36:38 +0200
X-Gm-Features: AS18NWCk78VnKfmPCVBVcPrYVY623qL35FOjkFaErJIB2PQnPu9YIlNfxcvz7uI
Message-ID: <CAMSfU+66tW443Yzbt2YefAM1TL-ynBR=2JViXCXFQeQcyX0Usg@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] ast: Better variable history for
 builtin fragments
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000005ef8050640c82505"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 06:37:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18161

--0000000000005ef8050640c82505
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 9 oct. 2025 =C3=A0 19:19, Alexander Kanavin <alex.kanavin@gmail.com=
> a
=C3=A9crit :

> On Thu, 9 Oct 2025 at 19:12, Yoann Congal <yoann.congal@smile.fr> wrote:
> >> and if users end up setting the same built-in fragments multiple times
> >> some other way, that's a misconfiguration on their part.
> >
> >
> > Should we think about displaying a warning in this case (multiple value=
s
> for the same fragment) ?
>
> I think so, yes.
>

Patch sent here:
[PATCH] ast: Warn on multiple builtin config fragments for the same variabl=
e
https://lists.openembedded.org/g/bitbake-devel/topic/patch_ast_warn_on_mult=
iple/115680515


>
> Alex
>


--=20
Yoann Congal
Smile ECS

--0000000000005ef8050640c82505
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 9 =
oct. 2025 =C3=A0=C2=A019:19, Alexander Kanavin &lt;<a href=3D"mailto:alex.k=
anavin@gmail.com">alex.kanavin@gmail.com</a>&gt; a =C3=A9crit=C2=A0:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 9 Oct 2025 at =
19:12, Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=3D"=
_blank">yoann.congal@smile.fr</a>&gt; wrote:<br>
&gt;&gt; and if users end up setting the same built-in fragments multiple t=
imes<br>
&gt;&gt; some other way, that&#39;s a misconfiguration on their part.<br>
&gt;<br>
&gt;<br>
&gt; Should we think about displaying a warning in this case (multiple valu=
es for the same fragment) ?<br>
<br>
I think so, yes.<br></blockquote><div><br></div><div>Patch sent here:</div>=
<div>[PATCH] ast: Warn on multiple builtin config fragments for the same va=
riable<br><a href=3D"https://lists.openembedded.org/g/bitbake-devel/topic/p=
atch_ast_warn_on_multiple/115680515">https://lists.openembedded.org/g/bitba=
ke-devel/topic/patch_ast_warn_on_multiple/115680515</a></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alex<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000005ef8050640c82505--

