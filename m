Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEB5C6FA99
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 20:42:01 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.30752.1678480916976809601
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Mar 2023 12:41:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=pKwdRB8p;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id q16so6195976wrw.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 12:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678480915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tlasyCFO3zXWmCqOBttev7uxw6W3S1tgTPmoUulX6U=;
        b=pKwdRB8p6Vj6MBHgdd6YaEgLIIQehsyL1dw3X8GnPbpYOSg05Cdy/3jLDAXvvDeXoI
         8qFVOBd+d3WAXMkBco9+xJvy7qVoOTgl9M8OgL+Ib6pczrS6+fEnA4STwum4ighF7Zbv
         a+g7HAxGTu0h0FyxBHXeNGj9ifvVweAwOQJlqsIJsDAmLG/88Cx+jtdzCzJ57w106mxz
         V1/J89fxilDCNTMJ0TrVvccnXINkQDhXE+wT3Ym1H80qinBjt/y/F1vTHZbLkE7KsmkM
         azGb+HetrCIKWPNBQGPTi0/h3zZ3+85dlKRjDiXTkbZY50lztwbBxfvsV/9uRB+iWlvi
         BeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678480915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tlasyCFO3zXWmCqOBttev7uxw6W3S1tgTPmoUulX6U=;
        b=yD5HcgH7Jvk0Wvi3Aoe0YR+SMAxzWNG9zy98kuJGwL8XENdCSY+Dp2v7SBK9MSUgFy
         wDYLqUFDAdvNq8f3gbYSFG7H3mmcDs9YZjGXkyrgSAmqWX68LFIX7dpHI6LPgbNlkhy2
         zz+6kiFZYrjkDW/mfT0xVD8KR8SDT/+IilZvcBdQOLd+KzS3N8MC4jh+/gnVUL+F73NE
         lPRZiegb+p+bKZ5teZPcs/3G89YXJaFKQh6kM4UXVF5LEwYAI8FIWPB/VSvGNpPQuQ1W
         wnfJ31yPw3rzSqn1ZlX97M18U6MrzCqRyhwkqhBLJbBe2HX1hsfHLFskV0+ErWZ5VznF
         VnHA==
X-Gm-Message-State: AO0yUKWmB1je1N0O0DEw8VPQldF1hb9TcpczYYCsSrrgLVAF1Kc3WfeO
	UDaqLcBJJaXDVPqNKeuh4jT+dp7Cm7+H/FsEF3c=
X-Google-Smtp-Source: AK7set8p1U4RMM4OqEflW3k7/bCvu4OhwNTf8DaD8YApFZvHwD4jVAbgtZq4O413fGeqk4d/MkrhQMeKice6jCKa9So=
X-Received: by 2002:a5d:5601:0:b0:2ce:a0b9:b422 with SMTP id
 l1-20020a5d5601000000b002cea0b9b422mr35123wrv.3.1678480915326; Fri, 10 Mar
 2023 12:41:55 -0800 (PST)
MIME-Version: 1.0
References: <CA+chaQcSZDgrbeZjOU+THvNTrQt+VzCUGg3p1FMVG9qiP4QDAw@mail.gmail.com>
 <dc9bfbf315b36243781e012ac8117fb8acd59711.camel@linuxfoundation.org>
In-Reply-To: <dc9bfbf315b36243781e012ac8117fb8acd59711.camel@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 10 Mar 2023 21:41:41 +0100
Message-ID: <CA+chaQctmc_scgZfXuJ6poiM8mgPTKSQh0zw2yh=30GQZ3G+kw@mail.gmail.com>
Subject: Re: [bitbake-devel] Bitbake repo using the same tag name as branch
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Lee Chee Yang <chee.yang.lee@intel.com>, Michael Halstead <mhalstead@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000b86cee05f691cafe"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 20:42:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14539

--000000000000b86cee05f691cafe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Michael: can you please recreate/rename the tags as suggested by RP?

On Fri, Feb 24, 2023 at 2:41=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2023-02-24 at 12:09 +0100, Martin Jansa wrote:
> > Is there some reason why bitbake started to use tag name identical as
> > branch name from 2.0?
> >
> > It happens only with 2.0 and 2.2, because previous 1.52 branch had
> > first release named 1.52.0 not 1.52:
> > commit c78ebac71ec976fdf27ea24767057882870f5c60 (tag: yocto-3.4, tag:
> > 2021-10-honister, tag: 1.52.0)
> >
> > bitbake $ git show 1.52.0
> > tag 1.52.0
> > Tagger: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
> > Date:   Mon Oct 25 15:16:54 2021 -0700
> >
> > Tagging for 1.52.0 (yocto-3.4)
> >
> > This new scheme has small disadvantage:
> >
> > bitbake $ git push github 2.0
> > error: src refspec 2.0 matches more than one
> > error: failed to push some refs to 'github.com:shr-
> > distribution/bitbake.git'
> >
> > I can work around it by using refs/heads/2.0 and refs/tags/2.0 to
> > distinguish between them, but that's still a bit unusual and
> > unfortunate.
> >
> > Adding Chee Yang Lee who authored these 2 tags (see another warning
> > there):
> >
> > bitbake $ git show 2.0
> > warning: refname '2.0' is ambiguous.
> > tag 2.0
> > Tagger: Chee Yang Lee <chee.yang.lee@intel.com>
> > Date:   Mon Apr 25 22:27:04 2022 -0700
> >
> > bitbake $ git show 2.2
> > warning: refname '2.2' is ambiguous.
> > tag 2.2
> > Tagger: Chee Yang Lee <chee.yang.lee@intel.com>
> > Date:   Sun Oct 23 20:33:14 2022 -0700
>
> We should probably drop the 2.0 and 2.2 tags and put 2.0.0 and 2.2.0
> tags in place instead.
>
> Cheers,
>
> Richard
>
>
>

--000000000000b86cee05f691cafe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Michael: can you please recreate/rename the tags as sugges=
ted by RP?</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Fri, Feb 24, 2023 at 2:41=E2=80=AFPM Richard Purdie &lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundat=
ion.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Fri, 2023-02-24 at 12:09 +0100, Martin Jansa wrote:<br>
&gt; Is there some reason why bitbake started to use tag name identical as<=
br>
&gt; branch name from 2.0?<br>
&gt; <br>
&gt; It happens only with 2.0 and 2.2, because previous 1.52 branch had<br>
&gt; first release named 1.52.0 not 1.52:<br>
&gt; commit c78ebac71ec976fdf27ea24767057882870f5c60 (tag: yocto-3.4, tag:<=
br>
&gt; 2021-10-honister, tag: 1.52.0)<br>
&gt; <br>
&gt; bitbake $ git show 1.52.0<br>
&gt; tag 1.52.0<br>
&gt; Tagger: Vineela Tummalapalli &lt;<a href=3D"mailto:vineela.tummalapall=
i@intel.com" target=3D"_blank">vineela.tummalapalli@intel.com</a>&gt;<br>
&gt; Date: =C2=A0 Mon Oct 25 15:16:54 2021 -0700<br>
&gt; <br>
&gt; Tagging for 1.52.0 (yocto-3.4)<br>
&gt; <br>
&gt; This new scheme has small disadvantage:<br>
&gt; <br>
&gt; bitbake $ git push github 2.0<br>
&gt; error: src refspec 2.0 matches more than one<br>
&gt; error: failed to push some refs to &#39;github.com:shr-<br>
&gt; distribution/bitbake.git&#39;<br>
&gt; <br>
&gt; I can work around it by using refs/heads/2.0 and refs/tags/2.0 to<br>
&gt; distinguish between them, but that&#39;s still a bit unusual and<br>
&gt; unfortunate.<br>
&gt; <br>
&gt; Adding Chee Yang Lee who authored these 2 tags (see another warning<br=
>
&gt; there):<br>
&gt; <br>
&gt; bitbake $ git show 2.0<br>
&gt; warning: refname &#39;2.0&#39; is ambiguous.<br>
&gt; tag 2.0<br>
&gt; Tagger: Chee Yang Lee &lt;<a href=3D"mailto:chee.yang.lee@intel.com" t=
arget=3D"_blank">chee.yang.lee@intel.com</a>&gt;<br>
&gt; Date: =C2=A0 Mon Apr 25 22:27:04 2022 -0700<br>
&gt; <br>
&gt; bitbake $ git show 2.2<br>
&gt; warning: refname &#39;2.2&#39; is ambiguous.<br>
&gt; tag 2.2<br>
&gt; Tagger: Chee Yang Lee &lt;<a href=3D"mailto:chee.yang.lee@intel.com" t=
arget=3D"_blank">chee.yang.lee@intel.com</a>&gt;<br>
&gt; Date: =C2=A0 Sun Oct 23 20:33:14 2022 -0700<br>
<br>
We should probably drop the 2.0 and 2.2 tags and put 2.0.0 and 2.2.0<br>
tags in place instead.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div>

--000000000000b86cee05f691cafe--

