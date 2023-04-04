Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61921C6FD1D
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 21:35:54 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.115048.1680644153708204528
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Apr 2023 14:35:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20210112 header.b=XoY45/qL;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so22279017wmq.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 14:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680644152; x=1683236152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh6JtgJH1rXJ8TqrK+acbA5aBm+CNsXYM3nvFZp2JiM=;
        b=XoY45/qLPqjOuXbySXaJptRAGe4XdrNVWPLobHLVFJtOVnaKbu0LRTLHhmVF0yMNFF
         it3kYB1Mfs10/23uz2PAIXgjJX9zsRNCa8jq3BtIc8GdbeoAimpjelGydAHGhJWRzofc
         DDphTc1XP/2t3vUdlPjoB4pTzjkGJnSOY8YQXQ0cPNjKT7+Mkz9viJuemOSYD0mvkvU2
         /JGBiUpJvulE598KEsFxSyB4x/JBdqiyPSzsoqSWL0C4slSkmfGd7RMSsXOzdDRuDnVk
         yY3Yio2R63nXfrgV34qxiL2VJKEiZEvLA8knSwK4f7WsYxS72FJExZvY8RBSALoH4eam
         jzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680644152; x=1683236152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zh6JtgJH1rXJ8TqrK+acbA5aBm+CNsXYM3nvFZp2JiM=;
        b=2eh8BkglIcFl+BXGuRVroOhgEN4l7VwGtMMM83KEMzI43ieMGWQLr1zjyhAOEaFReG
         wCz8UmfCQpbygvr1EfDZokAlQS33LUIzK1sTnSoh1EQ8apxA4PV48hpieUZhOx+b4mXT
         4j/q1fVmqFuqDwpuWnLVbsJUf8cA1xM44iMPpIL012j5/qPKxtcTJb5S+k2ZK0vDfwK2
         jbLlZPCjDASw9dgCzasWq+moiJ36Ul1LSXTbbG+NGyicC06wNouGHXdRxpWaj1vVVhIf
         XZobC3GQAgkUUQydeqzPN68q/VkP/EVdYEkufnuauXLSSNezxeX1rfj+haSqJUm57jxa
         9uKw==
X-Gm-Message-State: AAQBX9ciFdGO16qLru7uWT8OhaSzLVty1w2CFwBMJr/EqTFaP7kWfO50
	wAQDyDjSwgiYLnvKoJ8w/L7yH4GLtj4fn0ZE71w=
X-Google-Smtp-Source: AKy350YnHiRuCpAIC2aUSjAztaIGBIiuvEFttMJn65h6j49OOHOB5Er04BhHJllm50DxPycrCziEw2ptnPgC4oibz/Q=
X-Received: by 2002:a1c:ed02:0:b0:3f0:5beb:6d8 with SMTP id
 l2-20020a1ced02000000b003f05beb06d8mr1028463wmh.3.1680644151915; Tue, 04 Apr
 2023 14:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
 <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com> <CA+chaQcWaafMWnok=q+3SUcEj-+R99wxdC4JXpaM+rAGYCWhkg@mail.gmail.com>
 <68045681-5481-80f5-30f4-e15616503dcd@mvista.com>
In-Reply-To: <68045681-5481-80f5-30f4-e15616503dcd@mvista.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 4 Apr 2023 23:35:33 +0200
Message-ID: <CA+chaQead2PQ4yn7XSp-dejU+66kzROBOkAAeAJA42h=BSRLHg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at once
To: akuster <akuster@mvista.com>
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000ab380605f8897574"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 21:35:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14637

--000000000000ab380605f8897574
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 4, 2023 at 11:08=E2=80=AFPM akuster <akuster@mvista.com> wrote:

>
>
> On 4/4/23 1:07 PM, Martin Jansa wrote:
> > On Tue, Apr 4, 2023 at 6:50=E2=80=AFPM akuster <akuster@mvista.com> wro=
te:
> >
> >
> >
> >     On 4/1/23 11:21 AM, Frederic Martinsons wrote:
> >     > From: Frederic Martinsons <frederic.martinsons@gmail.com>
> >     >
> >     > Instead of only display the first and stop.
> >     > For recipe (crago based) that can contains several artifacts
> >     > to fetch with their checksum, it will particularly handy
> >     > to display all of missing one.
> >     >
> >     > An example of error message would be
> >
> >     I am confused. Is this patch supposed to add the pkg version or
> >     not?  I
> >     am not seeing any. Any ideas?
> >
> >
> > name parameter with pkg version was added to bbclass in:
> >
> https://git.openembedded.org/openembedded-core/commit/?id=3D1795e98a04ad0=
9b011afcc7cc3bf6dc49475b19a
> >
> > this change only allows all missing/incorrect checksums to be showsn
> > at the same time, instead of one checksum per do_fetch failure.
>
> I get multiple hashes for the same package.
>
> SRC_URI[wasi.sha256sum] =3D
> "1a143597ca7c7793eff794def352d41792a93c481eb1042423ff7ff72ba2c31f"
> SRC_URI[wasi.sha256sum] =3D
> "cccddf32554fecc6acb585f82a32a72e28b48f8c4c1883ddfeeeaa96f7d8e519"
>
> so why no version info after the pkg name?
>

Did you regenerate the SRC_URIs with updated bbclass? It works for me as in=
:
https://github.com/shr-project/meta-webosose/commit/84dc9f3cc3dd85facde07cc=
ddce0b9f2bcd90d39

--000000000000ab380605f8897574
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Apr 4, 2023 at 11:08=E2=80=AFPM a=
kuster &lt;<a href=3D"mailto:akuster@mvista.com">akuster@mvista.com</a>&gt;=
 wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>
<br>
On 4/4/23 1:07 PM, Martin Jansa wrote:<br>
&gt; On Tue, Apr 4, 2023 at 6:50=E2=80=AFPM akuster &lt;<a href=3D"mailto:a=
kuster@mvista.com" target=3D"_blank">akuster@mvista.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 4/1/23 11:21 AM, Frederic Martinsons wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; From: Frederic Martinsons &lt;<a href=3D"mailt=
o:frederic.martinsons@gmail.com" target=3D"_blank">frederic.martinsons@gmai=
l.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Instead of only display the first and stop.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; For recipe (crago based) that can contains sev=
eral artifacts<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; to fetch with their checksum, it will particul=
arly handy<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; to display all of missing one.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; An example of error message would be<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I am confused. Is this patch supposed to add the pk=
g version or<br>
&gt;=C2=A0 =C2=A0 =C2=A0not?=C2=A0 I<br>
&gt;=C2=A0 =C2=A0 =C2=A0am not seeing any. Any ideas?<br>
&gt;<br>
&gt;<br>
&gt; name parameter with pkg version was added to bbclass in:<br>
&gt; <a href=3D"https://git.openembedded.org/openembedded-core/commit/?id=
=3D1795e98a04ad09b011afcc7cc3bf6dc49475b19a" rel=3D"noreferrer" target=3D"_=
blank">https://git.openembedded.org/openembedded-core/commit/?id=3D1795e98a=
04ad09b011afcc7cc3bf6dc49475b19a</a><br>
&gt;<br>
&gt; this change only allows all missing/incorrect checksums to be showsn <=
br>
&gt; at the same time, instead of one checksum per do_fetch failure.<br>
<br>
I get multiple hashes for the same package.<br>
<br>
SRC_URI[wasi.sha256sum] =3D <br>
&quot;1a143597ca7c7793eff794def352d41792a93c481eb1042423ff7ff72ba2c31f&quot=
;<br>
SRC_URI[wasi.sha256sum] =3D <br>
&quot;cccddf32554fecc6acb585f82a32a72e28b48f8c4c1883ddfeeeaa96f7d8e519&quot=
;<br>
<br>
so why no version info after the pkg name?<br></blockquote><div><br></div><=
div>Did you regenerate the SRC_URIs with updated bbclass? It works for me a=
s in:</div><div><a href=3D"https://github.com/shr-project/meta-webosose/com=
mit/84dc9f3cc3dd85facde07ccddce0b9f2bcd90d39">https://github.com/shr-projec=
t/meta-webosose/commit/84dc9f3cc3dd85facde07ccddce0b9f2bcd90d39</a></div></=
div></div>

--000000000000ab380605f8897574--

