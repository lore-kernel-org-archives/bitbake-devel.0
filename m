Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33859C6FD1D
	for <webhook@archiver.kernel.org>; Fri, 17 Mar 2023 08:08:17 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.14324.1679040494116211985
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Mar 2023 01:08:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=nZPe6a2U;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id a32so4198137ljr.9
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679040492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4dp+t6FF1w1d0dhtj7ZFYXXkYT9FffZnaulCmc+9+Rk=;
        b=nZPe6a2Uy09O+vtay8s0XC/fPtNu56Q55iM/I8N+R6PvJbatP3mtTcvRfXMy//1ECw
         oARNwSmqg70WphVuojvOm5SVPfqRhnnP0v/8zP/6fr4ylroArIyuLBMTt/J8JzLYOvbZ
         duk+hc3Ev8bLuCFh87McKgZwECyvh1VM8QMgpr8fUB83Kd3mBd881RntqBkIciQ3s8SG
         24Sfy2/N4HTvZqVTzi5/vTochTMCqIFV7FFYM/G0XXniYPj0cF408vXNfkM5W8vHGCeN
         BDBrCAyFdy4FxnFmCdzKlQRQTTlKsG5aQBjlfB7I7C4KO/8hFjNqkcPgG0ASKtJSfGQA
         Cn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679040492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dp+t6FF1w1d0dhtj7ZFYXXkYT9FffZnaulCmc+9+Rk=;
        b=v7bNvC10I6+Ezsul82Qp4ZKUg+c54XsKnX9iTKYZoUg4X370n93uz6kFyaF1UdJRck
         9w5kQ32RxQ2JEMpmNOA8xu8ncBSFPnEkbGUMv8EAX5gQ2LyhxkvDGfJehva3Zi9Rdivx
         qg8t/cdt0W/OFSn0fmeZBwJqQTBOb+VaeNOuONYGXr19/RYvNzo2cRFudjcAq/JrSmvB
         YGgVjRgCdwExjASu9HhX2OLMEfWtdknhwONixEY+zY3VVlJDpD16khNIJhJaYxXkMkKV
         JEg2tpYlfv+OuIwXZZ/dzzt6pRaUKvMsvsFKbt9321+x6DNmzEJ+4iKcwTXrM61p2JrX
         hzog==
X-Gm-Message-State: AO0yUKXKXiZ+kUBUDaVsc5Hz+U7fOHnWWoTK6Qe8o7QiMFCpHvSFDx6S
	qtGjcwuAgA6sWv9F59+PlPyxWI7gtcp321qksEE=
X-Google-Smtp-Source: AK7set/qfgBCc+OwzNmX5JKNSzIFIXYi0QNI3gcZMfquo4FhzQX2G1LtYuTOR4vriTahG0LEGl9jy0C+9VvNFcyMdA4=
X-Received: by 2002:a2e:7316:0:b0:298:6f39:21de with SMTP id
 o22-20020a2e7316000000b002986f3921demr747310ljc.3.1679040491882; Fri, 17 Mar
 2023 01:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230316121249.28209-1-frederic.martinsons@gmail.com>
 <20230316121249.28209-2-frederic.martinsons@gmail.com> <202303162224382628594e@mail.local>
 <CA+cAkeoPQSJqV_dJB_soCsd8av0u54C6BAx0zgXMcX3wC1eHBQ@mail.gmail.com> <20230317075440fa660466@mail.local>
In-Reply-To: <20230317075440fa660466@mail.local>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Fri, 17 Mar 2023 09:08:00 +0100
Message-ID: <CA+cAkepXs-3_bGWWva8D3nQ2HFXhY1e0MWCHii02gT1Sd2cbaA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] python3-bcrypt: add crates checksums
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000150bd405f7141473"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 08:08:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14601

--000000000000150bd405f7141473
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Mar 2023 at 08:54, Alexandre Belloni <
alexandre.belloni@bootlin.com> wrote:

> On 17/03/2023 07:27:41+0100, Fr=C3=A9d=C3=A9ric Martinsons wrote:
> > Argh :/
> >
> > I tested with poky master (don't know if it was the right thing to do).
> Did
> > you apply
> >
> https://patchwork.yoctoproject.org/project/bitbake/patch/20230315131513.5=
0635-1-frederic.martinsons@gmail.com/
> >
>
> No, I don't carry this one as there were comments rejecting it
>

Ah ? It seems to me the latest comments on it was a go for applying.


> > and
> >
> https://patchwork.yoctoproject.org/project/bitbake/patch/20230316121215.2=
8151-1-frederic.martinsons@gmail.com/
> > on bitbake ?
> >
> > Sorry for that, I am not used to this workflow for submitting patches
> > through mails so I surely have made
> > mistakes and made things not clear
> > with dependencies between bitbake , openembedded-core and
> meta-openembedded.
> >
> I would have preferred one complete series for bitbake and one for
> oe-core
>

Yes, I'll resubmit a complete series to bitbake-devel, that will be cleaner=
.

--000000000000150bd405f7141473
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, 17 Mar 2023 at 08:54, Alexand=
re Belloni &lt;<a href=3D"mailto:alexandre.belloni@bootlin.com">alexandre.b=
elloni@bootlin.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 17/03/2023 07:27:41+0100, Fr=C3=A9d=C3=A9ric Martinson=
s wrote:<br>
&gt; Argh :/<br>
&gt; <br>
&gt; I tested with poky master (don&#39;t know if it was the right thing to=
 do). Did<br>
&gt; you apply<br>
&gt; <a href=3D"https://patchwork.yoctoproject.org/project/bitbake/patch/20=
230315131513.50635-1-frederic.martinsons@gmail.com/" rel=3D"noreferrer" tar=
get=3D"_blank">https://patchwork.yoctoproject.org/project/bitbake/patch/202=
30315131513.50635-1-frederic.martinsons@gmail.com/</a><br>
&gt; <br>
<br>
No, I don&#39;t carry this one as there were comments rejecting it<br></blo=
ckquote><div><br></div><div>Ah ? It seems to me the latest comments on it w=
as a go for applying.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
&gt; and<br>
&gt; <a href=3D"https://patchwork.yoctoproject.org/project/bitbake/patch/20=
230316121215.28151-1-frederic.martinsons@gmail.com/" rel=3D"noreferrer" tar=
get=3D"_blank">https://patchwork.yoctoproject.org/project/bitbake/patch/202=
30316121215.28151-1-frederic.martinsons@gmail.com/</a><br>
&gt; on bitbake ?<br>
&gt; <br>
&gt; Sorry for that, I am not used to this workflow for submitting patches<=
br>
&gt; through mails so I surely have made<br>
&gt; mistakes and made things not clear<br>
&gt; with dependencies between bitbake , openembedded-core and meta-openemb=
edded.<br>
&gt; <br>
I would have preferred one complete series for bitbake and one for<br>
oe-core<br></blockquote><div><br></div><div>Yes, I&#39;ll resubmit a comple=
te series to bitbake-devel, that will be cleaner.</div></div></div>

--000000000000150bd405f7141473--

