Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3287ECCA470
	for <webhook@archiver.kernel.org>; Wed,  1 Oct 2025 15:05:09 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.20298.1759331108636562539
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Oct 2025 08:05:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A6ZFbFmU;
 spf=pass (domain: gmail.com, ip: 209.85.208.47, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so6928247a12.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Oct 2025 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759331107; x=1759935907; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jxUUr+1pRH141D3QB1RSxp1uVEgqVdeyC3ebhDUBLTg=;
        b=A6ZFbFmU4bZvMs5qB9gbpQPlKBIhemGPkFRcl0xx9qQvTNHmEqof5g6n+Dpc6WjZfM
         aQyN+I8ssVK6QeBly0AO2Sq5Kks8H8RjzVPAIc0C3n7Kh7Rma2bHPIKf49uCVvsgm9JB
         vF29qNXieSpO7Urw1deopOrWFzHSIm3E91sBIVAOUGv2U2wTul8vcP/RDD5S6+VM4WIB
         QrjD33xG+geDOJh0eup0fKThoXpoy8mEj7MAzPqR7vkV7vHX3ZM86nuxovkWqV+m8bHu
         htvn4izkbvsHx5tb6f2e4pddvPgKIsq5cbK8yEjoYvKl6xi6ZUVTjBtPwTJIaXEtVa6D
         H8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759331107; x=1759935907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxUUr+1pRH141D3QB1RSxp1uVEgqVdeyC3ebhDUBLTg=;
        b=LzxR50bDk4s3KevROElQK7s06S/mlTa05rgxB9oCI0eNcVwYNecMw8RrUZjzQW7JC3
         G0y95u6HjDSs/luzOrvDBxb/qjdudBwq5g1zm82MmzhBg4tP3y2NmLJ+PoeHm4Vo82Ik
         NFjft7G6tyrS8BCIzhHZ1YkcP3SiJ4ryGG85I2ebVy1wUoeHl++lGd0jpLZtrCXVBNgu
         HXH4vu3Ixm+3pZ6tVi+zTwLMTiYveJ9tKEwKqENB6NedfQ7muAe2je+OKAQKngBURCzj
         Qzm52VpJX/r11JXsxMJB3tQz2A525RERTNIx5WxEZdMGcIXZI4rihMXxxk/21d6Hp7uW
         Sapw==
X-Gm-Message-State: AOJu0YxS/M2BBttylgSy3pVgaFM17PYOwANxEieFxyIA+lCNJN13Qyxb
	6o5Ge6IfbBJ6M29gYAh/xfsg3BnMDIrywpe8jIxpPeRib8xvtltIszFWBFsRkHrgMCUx6OmA/0M
	VdyEtTdVJyX9+I0xR7hV0alzv7U/0Xls=
X-Gm-Gg: ASbGncslswBGH6OaLMj4X3Viu8sLvvsizHoAq6bbtIn+74sOoIxZk0NQjmHJY0O+/Xb
	d+PGhJz1jk351FP6Cr6VzXoRCJJhj0zW/7EHxhwfjdV2Cucu1zFUnsM/Fc9EDgs3qjdn+0pXoah
	4OqQHeq9ijPXOuYj5sHYDFlb7U9hsyXYaR/f8UE6I1EXepK771JbO4cPDEcB5tTA62c+jASD/ZJ
	y5vs+TzThUgulsaRK1sujz4T8LLzRyEWmYb2a2oxdI=
X-Google-Smtp-Source: AGHT+IHI2eSGajxg6Bk6bXO8t/FXMFGefk4I+BdWvLJoPiuj2dYJBDpCQ1WaOSPKCbYYgU7f/BIJWGuSU+ej2nEtMtk=
X-Received: by 2002:a17:907:944e:b0:b3e:5f40:9894 with SMTP id
 a640c23a62f3a-b46ea31d2abmr506278166b.62.1759331105559; Wed, 01 Oct 2025
 08:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <18683160554EF259.24570@lists.openembedded.org>
 <CANPvuRk2n7t9YHThXATOT+zD9DYrzV36rU4r+Ku50Wy9y9Q=7g@mail.gmail.com>
 <CANNYZj9om4Ki1X9+91uDaf8WoR1z7USnbG++9qUmp-wUELai1Q@mail.gmail.com>
 <CANPvuRkpq1M_AEs7J5+pvo6F1SR8srEiPV=SZVGM4knqLD5OJQ@mail.gmail.com> <CANNYZj85dxnKQKQsSjqtF5dsmLzUCW5uAmK6AZgcn2v=mzhy8A@mail.gmail.com>
In-Reply-To: <CANNYZj85dxnKQKQsSjqtF5dsmLzUCW5uAmK6AZgcn2v=mzhy8A@mail.gmail.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 1 Oct 2025 16:04:52 +0100
X-Gm-Features: AS18NWCcny2lyHEcbc8Wr3mIlj2wdCWdN95bY4zhuIBfdcg1lOaxLqENA21NOXM
Message-ID: <CANPvuRnpooqGnnC9xP-uvcnF5dCjgci2+P6ccUJDpWPgwg3PFQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] cooker: add support for more than one
 server in BB_HASHSERVE_UPSTREAM
To: Alexander Kanavin <alex.kanavin@gmail.com>, Joshua Watt <jpewhacker@gmail.com>, 
	Michael Halstead <mhalstead@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="00000000000096dd5706401a31b8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Oct 2025 15:05:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18111

--00000000000096dd5706401a31b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Added Josua and Michael on cc

Alexander Kanavin <alex.kanavin@gmail.com> escreveu (quarta, 24/09/2025
=C3=A0(s) 12:11):

> On Wed, 24 Sept 2025 at 13:06, Jose Quaresma <quaresma.jose@gmail.com>
> wrote:
> >> > BB_HASHSERVE_UPSTREAM =3D "wss://hashserv.yoctoproject.org/ws
> hashserv.yoctoproject.org:8686"
> >>
> >> I'd like Joshua and Michael to comment on this ^^^
> >> Specifically, are there performance implications in using one or the
> >> other? Are both officially supported and maintained?
>

Added Josua and Michael on cc.

Could you please give your opinion, if possible, on the above questions?

Jose

>
> >
> > AFAIK the two are still supported because kirkstone only supports the
> raw sockets.
> > We will still prefer the first one and fallback only on hosts that don'=
t
> have the python-websockets
> > I think with time they will become available widely and we can also add
> it as a mandatory dependency of bitbake.
>
> The problem is that once you have the fallback, no one will bother to
> install websockets, and they will not become available widely. I'd
> rather adjust bitbake/yocto dependency lists in yocto manuals,
> together with all other bitbake-setup tweaks.
>
> Alex
>


--=20
Best regards,

Jos=C3=A9 Quaresma

--00000000000096dd5706401a31b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Added Josua and Michael on cc</div><br><div class=3D"=
gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Al=
exander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kanavin@=
gmail.com</a>&gt; escreveu (quarta, 24/09/2025 =C3=A0(s) 12:11):<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 24 Sept 2025 at 13=
:06, Jose Quaresma &lt;<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; BB_HASHSERVE_UPSTREAM =3D &quot;wss://<a href=3D"http://hashs=
erv.yoctoproject.org/ws" rel=3D"noreferrer" target=3D"_blank">hashserv.yoct=
oproject.org/ws</a> <a href=3D"http://hashserv.yoctoproject.org:8686" rel=
=3D"noreferrer" target=3D"_blank">hashserv.yoctoproject.org:8686</a>&quot;<=
br>
&gt;&gt;<br>
&gt;&gt; I&#39;d like Joshua and Michael to comment on this ^^^<br>
&gt;&gt; Specifically, are there performance implications in using one or t=
he<br>
&gt;&gt; other? Are both officially supported and maintained?<br></blockquo=
te><div><br></div>Added Josua and Michael on cc.<br class=3D"gmail-Apple-in=
terchange-newline"><div><br></div><div>Could you please give your opinion, =
if possible, on the above questions?<br>=C2=A0</div><div>Jose</div><div><br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt;<br>
&gt; AFAIK the two are still supported because kirkstone only supports the =
raw sockets.<br>
&gt; We will still prefer the first one and fallback only on hosts that don=
&#39;t have the python-websockets<br>
&gt; I think with time they will become available widely and we can also ad=
d it as a mandatory dependency of bitbake.<br>
<br>
The problem is that once you have the fallback, no one will bother to<br>
install websockets, and they will not become available widely. I&#39;d<br>
rather adjust bitbake/yocto dependency lists in yocto manuals,<br>
together with all other bitbake-setup tweaks.<br>
<br>
Alex<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></=
div></div></div>

--00000000000096dd5706401a31b8--

