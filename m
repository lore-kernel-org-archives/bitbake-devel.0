Return-Path: <simon.eu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12518C433F5
	for <webhook@archiver.kernel.org>; Mon, 28 Feb 2022 09:32:05 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web09.18280.1646040719634712046
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Feb 2022 01:31:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=N0Oyr5qW;
 spf=pass (domain: gmail.com, ip: 209.85.214.179,
 mailfrom: simon.eu@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id z2so10185988plg.8
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Feb 2022 01:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0hBE6kpPAfCxanGEwgCSOxYQWLQkrIltDsqEJ+xxKE=;
        b=N0Oyr5qWYGiQ7qCFCaN4rKzfj7pqPjaRnMOrjvQ/QX26qGMC/jcSH1KlMY8+CxMi+z
         QNuSB/yDBPbFowl+lMCQgNeqqSjk5aNWT5fKsvbSv5PulEU4raoo97fMIT/1rx+LmJTc
         ilaCuBSsAd8X2jI7racHehrwBGMuilSmKPpxBDbWCxSfw06OEZp4w0niO9kZjwWRRsAN
         JiSRMGLGREr/GUcXOn7zNItRRAMn4Kqhjk1dfsnx5DcVqs6fi3oIo/qEgeb3NRFVC8PS
         KeOCpOjczpEhm+153oYutE8OxK7afOhzDUTpErstHtvoOKzjqSk1Ye/BsWqrwOvgzEx8
         NVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0hBE6kpPAfCxanGEwgCSOxYQWLQkrIltDsqEJ+xxKE=;
        b=kEMJZqY70QDk6NrJyGfUeU/S9tu+ujdJeeP9BXUXXjyDtqrjUoC6TlPE7s5YOpCEnz
         Xu/9mLjzNQuQhpmX3lDBjF8o6SdrAhDMp4W7Zx+VLWn8eQQr9fu35gnXZbYuldFppJRO
         y3dkpGCXwB04u+0V5c1asb6lkkKAT7hOn/bqhQi+UoQ0JR5BwtwHvWL/h4DeTkgoLdcI
         sMX6a0rAXr/gGUiu9dehDXGQ1/cQg5X7AUaySUScnmTmXzeFOzBT8Gea19+M6URZ4HPG
         8OXeHV46doQL1um4FcpJmcZ9oDlPf8VrOxPKoHs0jwaT+ndjr2PASl9roJBlHBROGMEi
         LItw==
X-Gm-Message-State: AOAM5319ggcfrz2SYl9q/OjtgnrifHuu/P492FgKh393tzOS6VgxWK5I
	iw1L6eos0YM6etH+nvya71+Cmi6d9TzQ+iR1tLk=
X-Google-Smtp-Source: 
 ABdhPJw/IV3kWzuJQA8EAuEqnP9HLssIZqISDPKJXH5rRCEIffEvfEQZ0gONieUvuhktTmpp+uCus/XHKAPRb8l6qC4=
X-Received: by 2002:a17:902:7407:b0:14f:b5f4:6537 with SMTP id
 g7-20020a170902740700b0014fb5f46537mr19524988pll.32.1646040718987; Mon, 28
 Feb 2022 01:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20211215092509.60979-1-simon.eu@gmail.com>
 <42d3ff93-33a1-e751-b0ff-974c8ecb4858@bootlin.com>
 <CAO8d5BY0R2d4Ufvk9cWwx=t95sOcQXs-5NGquP-3AAH8xG-RAg@mail.gmail.com>
 <9e458156-8a40-ce06-986a-8ce39b546712@bootlin.com>
In-Reply-To: <9e458156-8a40-ce06-986a-8ce39b546712@bootlin.com>
From: Simon Eugster <simon.eu@gmail.com>
Date: Mon, 28 Feb 2022 10:31:47 +0100
Message-ID: 
 <CAO8d5BYN7g0oEoPG=CrTt99pQ1-fYkx5bq-RiB_j9E3OBu4K2w@mail.gmail.com>
Subject: Re: [docs] [PATCH] bitbake: doc: bitbake-user-manual: Add more
 explanations to OVERRIDES
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000057570905d910b8c4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Feb 2022 09:32:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13401

--00000000000057570905d910b8c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 5, 2022 at 5:02 PM Michael Opdenacker <
michael.opdenacker@bootlin.com> wrote:

> Hi Simon,
>
> Thanks for your answers...
>
> On 1/5/22 11:11 AM, Simon Eugster wrote:
> > Hi Michael,
> >
> >     >
> >     > +.. note::
> >     > +
> >     > +   Before Honister (3.4), override style used ``_`` instead of
> >     ``:``, so you will
> >     > +   still find a lot of documentation using =E2=80=9C_append=E2=
=80=9D,
> >     =E2=80=9C_prepend=E2=80=9D, and
> >     > +   =E2=80=9C_remove=E2=80=9D.
> >     > +
> >
> >
> >     I don't have anything about this text, but I wonder whether we shou=
ld
> >     mention the old syntax in the current docs.
> >     Thoughts anyone?
> >
> >
> > I added this because I (as a new user) found it very confusing to find
> > all the _ style syntax in guides online and no mention of it in the
> > docs. I would have expected such a note.
>
>
> This makes sense, but so far we just mentioned the old syntax in the
> migration guides. That's why I was asking for other opinions...
>

Looks like there are no other opinions on that topic.
In that case, do you want me to continue with the MR and apply your
suggestions, or discard the MR?

Simon

--00000000000057570905d910b8c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Wed, Jan 5, 2022 at 5:02 PM Michael Opdenacker &lt;<a href=3D=
"mailto:michael.opdenacker@bootlin.com">michael.opdenacker@bootlin.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Si=
mon,<br>
<br>
Thanks for your answers...<br>
<br>
On 1/5/22 11:11 AM, Simon Eugster wrote:<br>
&gt; Hi Michael,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +.. note::<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0Before Honister (3.4), override =
style used ``_`` instead of<br>
&gt;=C2=A0 =C2=A0 =C2=A0``:``, so you will<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0still find a lot of documentatio=
n using =E2=80=9C_append=E2=80=9D,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=E2=80=9C_prepend=E2=80=9D, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0=E2=80=9C_remove=E2=80=9D.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t have anything about this text, but I wo=
nder whether we should<br>
&gt;=C2=A0 =C2=A0 =C2=A0mention the old syntax in the current docs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thoughts anyone?<br>
&gt;<br>
&gt;<br>
&gt; I added this because I (as a new user) found it very confusing to find=
<br>
&gt; all the _ style syntax in guides online and no mention of it in the<br=
>
&gt; docs. I would have expected such a note.<br>
<br>
<br>
This makes sense, but so far we just mentioned the old syntax in the<br>
migration guides. That&#39;s why I was asking for other opinions...<br></bl=
ockquote><div><br></div><div>Looks like there are no other opinions on that=
 topic.<br></div><div>In that case, do you want me to continue with the MR =
and apply your suggestions, or discard the MR?</div><div><br></div><div>Sim=
on<br></div></div></div>

--00000000000057570905d910b8c4--

