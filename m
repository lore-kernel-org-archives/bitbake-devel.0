Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web11.3479.1619419077652212468
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Apr 2021 23:37:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=oKfxuano;
 spf=pass (domain: linaro.org, ip: 209.85.218.53, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-ej1-f53.google.com with SMTP id r12so82735176ejr.5
        for <bitbake-devel@lists.openembedded.org>; Sun, 25 Apr 2021 23:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLovVTY16QglgPkoWoF06W5i5xXR473DNLSh7yqVhBA=;
        b=oKfxuano9v8RhbysEcmhFnOYxac0rMrsS/xcCyntVLEuNk3kzSsDBlk902ULLuiS3S
         Ru4wNfbJxdxE6O5LN/XLDFcMYDlLrfJXxJVWvvMZPMAYTszcrqMwa7hmfcdkcazWtsK4
         LnQYU6y6CEX3hhKV0G5JBe1Kk/0EuMEJf3aPrfaeW56prxFYoOWFmaYL67C4eUmEkWsF
         2qJHI3B1E5ddqDxSSUz1HUz9vvRgv4kznCiVGrG0J9eevIQqQkYsTGKViHbkxq9ZseAY
         Nr39w94/vdX0ahvQtlPpDPkAI1PWbsCCnZXDv4vqOVk8A1vkW3CXDbOYNkleHktR2nA3
         kEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLovVTY16QglgPkoWoF06W5i5xXR473DNLSh7yqVhBA=;
        b=j/yS8IulFifyZexsM/m/r5Eyz3XoEl7uA5jSd1qZa0upKcQPr6N5KIcoTJFR5EToAn
         ZIA8MMqc+hT2+t0q7yKf4t2dXTwrWocjsN/a8vUB/ioK2C4bQnXqWj6NISNP0bhDnIoa
         VepodlI2tIKFRy1LHBiP7K1QsLrQzIwZzuMCcFiOrMIQtxxz4K89/EHayYI6FEVwCcdL
         VfPG8Cv19FICZMs+DeQTaUbFhTArm+6rLSb/UTi4b+1yQ6LOSF2AAlgwkpZN++kISDIl
         Xnq+1qAdRtZMBmXrp43Bb1nb3qGt80MocSrLLdRPoYV8uBeYdmrjISAgkXeWgi087s3o
         0soQ==
X-Gm-Message-State: AOAM533sSlUAMS0d3BzZ9zWT5dYxJ+xp57eVPecqi6BaNxNmYOM4EVuU
	RzdJpgg446wqwDpK3PgvI+gO0exx+PmO7B5m0mqgCw==
X-Google-Smtp-Source: ABdhPJwytNCK4VULIBC3IoNn7sdpoICj199uOgt+xMGk0W7MGBwalEJhxBRoJrglENi/H3S84yNsTylHfVsIReGQuZY=
X-Received: by 2002:a17:907:760a:: with SMTP id jx10mr17397841ejc.126.1619419076087;
 Sun, 25 Apr 2021 23:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210423163108.338904-1-michael.opdenacker@bootlin.com>
 <167889E551A803AE.3436@lists.openembedded.org> <20210423164117.xf4qafojdrqrezll@jama>
 <5d9240f6-d837-609b-5344-6f1bcf038d7b@bootlin.com>
In-Reply-To: <5d9240f6-d837-609b-5344-6f1bcf038d7b@bootlin.com>
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
Date: Mon, 26 Apr 2021 08:37:52 +0200
Message-ID: <CAP71WjzG0CEGZiqCNdSVOhvdg=urMj_LgSdbkbZFZmaeO935HA@mail.gmail.com>
Subject: Re: [docs] [bitbake-devel] [PATCH] README: update/fix contribution guidelines
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	YP docs mailing list <docs@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="000000000000c5e5d305c0da623c"

--000000000000c5e5d305c0da623c
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 23, 2021 at 8:00 PM Michael Opdenacker <
michael.opdenacker@bootlin.com> wrote:

> Hi Martin,
>
> On 4/23/21 6:41 PM, Martin Jansa wrote:
> > On Fri, Apr 23, 2021 at 06:34:41PM +0200, Martin Jansa via
> lists.openembedded.org wrote:
> >> On Fri, Apr 23, 2021 at 06:31:08PM +0200, Michael Opdenacker wrote:
> >>> - Ask to CC the docs@lists.yoctoproject.org mailing list
> >> it adds 2nd --to
> >>
> >> which is probably fine, just doesn't match with commit message
> > And more surprisingly this e-mail to docs@lists.yoctoproject.org was
> > rejected with:
> >
> >
> > Message not delivered
> > Your message couldn't be delivered to docs@lists.yoctoproject.org
> > because the remote server is misconfigured. See technical details below
> > for more information.
> > LEARN MORE
> > WarningThis link will take you to a third-party site
>
> Oops, that's ugly indeed.  Unfortunately, our lists are hosted on
> Groups.io, so our ability to fix this is limited.
>
> >
> > The response from the remote server was:
> > 510 5.1.1 Your email address, martin.jansa@gmail.com, is not subscribed
> > to that group. To subscribe, send an email to
> > docs+subscribe@lists.yoctoproject.org, or visit
> > https://lists.yoctoproject.org/g/docs
>
>
> This is also a bit uncomfortable to ask people to do us a favor and CC a
> list that only accepts post from members...
>
> Thoughts anyone?
>

The list was misconfigured. For all our open lists we typically enable all
registered members to post, which wasn't done for the docs@lists.yp.org
list. I've now changed it. That means that anyone registered on
lists.yoctoproject.org will be able to post. It still means that if someone
is only registered on lists.openembedded.org, but not on
lists.yoctoproject.org , then their message will be bounced.. but that
should be fine for most of our users.


> Cheers,
>
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>
> 
>
>

--000000000000c5e5d305c0da623c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 23, 2021 at 8:00 PM Micha=
el Opdenacker &lt;<a href=3D"mailto:michael.opdenacker@bootlin.com">michael=
.opdenacker@bootlin.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Hi Martin,<br>
<br>
On 4/23/21 6:41 PM, Martin Jansa wrote:<br>
&gt; On Fri, Apr 23, 2021 at 06:34:41PM +0200, Martin Jansa via <a href=3D=
"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.=
openembedded.org</a> wrote:<br>
&gt;&gt; On Fri, Apr 23, 2021 at 06:31:08PM +0200, Michael Opdenacker wrot=
e:<br>
&gt;&gt;&gt; - Ask to CC the <a href=3D"mailto:docs@lists.yoctoproject.org=
" target=3D"_blank">docs@lists.yoctoproject.org</a> mailing list<br>
&gt;&gt; it adds 2nd --to<br>
&gt;&gt;<br>
&gt;&gt; which is probably fine, just doesn&#39;t match with commit messag=
e<br>
&gt; And more surprisingly this e-mail to <a href=3D"mailto:docs@lists.yoc=
toproject.org" target=3D"_blank">docs@lists.yoctoproject.org</a> was<br>
&gt; rejected with:<br>
&gt;<br>
&gt;<br>
&gt; Message not delivered<br>
&gt; Your message couldn&#39;t be delivered to <a href=3D"mailto:docs@list=
s.yoctoproject.org" target=3D"_blank">docs@lists.yoctoproject.org</a><br>
&gt; because the remote server is misconfigured. See technical details bel=
ow<br>
&gt; for more information.<br>
&gt; LEARN MORE<br>
&gt; WarningThis link will take you to a third-party site<br>
<br>
Oops, that&#39;s ugly indeed.=C2=A0 Unfortunately, our lists are hosted on=
<br>
Groups.io, so our ability to fix this is limited.<br>
<br>
&gt;<br>
&gt; The response from the remote server was:<br>
&gt; 510 5.1.1 Your email address, <a href=3D"mailto:martin.jansa@gmail.co=
m" target=3D"_blank">martin.jansa@gmail.com</a>, is not subscribed<br>
&gt; to that group. To subscribe, send an email to<br>
&gt; <a href=3D"mailto:docs%2Bsubscribe@lists.yoctoproject.org" target=3D"=
_blank">docs+subscribe@lists.yoctoproject.org</a>, or visit<br>
&gt; <a href=3D"https://lists.yoctoproject.org/g/docs" rel=3D"noreferrer" =
target=3D"_blank">https://lists.yoctoproject.org/g/docs</a><br>
<br>
<br>
This is also a bit uncomfortable to ask people to do us a favor and CC a<b=
r>
list that only accepts post from members...<br>
<br>
Thoughts anyone?<br></blockquote><div><br></div><div>The list was misconfi=
gured. For all our open lists we typically enable all registered members to=
 post, which wasn&#39;t done for the <a href=3D"mailto:docs@lists.yp.org">d=
ocs@lists.yp.org</a> list. I&#39;ve now changed it. That means that anyone =
registered on <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.=
org</a> will be able to post. It still means that if someone is only regist=
ered on <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a=
>, but not on <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.=
org</a> , then their message will be bounced.. but that should be fine for =
most of our users.=C2=A0</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
Cheers,<br>
<br>
Michael.<br>
<br>
-- <br>
Michael Opdenacker, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https=
://bootlin.com</a><br>
<br>
<br>
<br>
<br>
</blockquote></div></div>

--000000000000c5e5d305c0da623c--
