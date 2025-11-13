Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFE0CCFA18
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 05:13:25 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16953.1763010800295860351
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 21:13:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fdpaBG2A;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88242fc32c9so4608776d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 21:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763010799; x=1763615599; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kIv95pW82Q+L4BjKI4hXGYshi+LE8kMYBXU/21jVe78=;
        b=fdpaBG2ABYf26080Splxan7QI98t/bo1G6FDX0P7j9XnhczDg01Ikr0bgQwcSWPScA
         4NverlXbgQN7HSdy9Y5HLrLydxBbIhFu1aesCAsRPgrMGBAHpE6sQFXZlQdh5N5fhVFZ
         YZ/dtDXUiURny8ECX2gP1nRX/oqo2qedBtU0eddoDNDPVJqHwh9cIuKqipDjPV5lnjO4
         2DsTlo6T6Wx+rS2oJOeQLU9yfn4QLOoyTG4f8gkxfouEjNtaSJZb1QmMcHoeyMuimCQn
         ozrpK6icYlIaKw5hOxzLRXdoNZj/OC2XPXsM+gXaTMI46FrQuV68ary4G/YlOmCNsocg
         tVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763010799; x=1763615599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIv95pW82Q+L4BjKI4hXGYshi+LE8kMYBXU/21jVe78=;
        b=h+WsFnZvk09AC2s473Tf0PgAUSuwJaEhmyrY7d9wsYre6BrtMzNcrlekuVEnk5hpiU
         yv0o/8/ygrnFWvM7Z9Bs7BePrXJAFmHdIVnN+4piG7q9JpaPhUdB/zYxajGe9WuTBc7B
         GgmA0VqlLAbLP9Xz3i2/++oUn92c4tYm0UdnfUZEPfDlicWE294MAnVsbarra83mJkeT
         XByCgyxgyILJKxx4RqRe4bukbboU9ybdBt8kf65wlPNV0ALZLJw1CZFOcFz2F1y715t4
         KMphTI7M+HmMlGRFdGl7MOKi7TLXeKRQVOPyILhWO2kWa4YL6gplEgmO7/OaN4+mKQwd
         pBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV++JA0gdrwBXg998lOt+2k9TOq2TshXDFTBTdtgEm0pT7EW5GRvZB6HyZIB5fxlQEdZMboeRquEn2/iVvj@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywln6GipTdTm8F5BPe6jdknYkQcjsj8Loh915ULkq+QnB0wIu8z
	8idpAAV3VhnZWwZfFo6LJXZIJ2GcbvEtMi1aWW176/f9iZ+FY03wSTLeh379bd+3ynUpfUm9pSM
	Lo4AtStruVWi+pBLBRaYZiKYkyIGzqg8=
X-Gm-Gg: ASbGncsIzgLFXFNaJ4yPCrjQYm3u86wtuTo17f9YVscUCiihhstrFx3hKDNQagRLJrG
	etzZACat8kMeiKcVZpk4zBw1Vg7lqlAwRQIKiRphgVHNVlNHyzZh2jnxbLdbJDk8Bam2k9q1yJ3
	cNnHegVDRwvB6hEeZO13He9fUTTRWIfcD5SY66RjDHps9sJ4JsOPTX65+DQVgiUfs+TnlutU64R
	o3mRIsI8hBLAt0HbSuydnJr5NYFGjN2ghMOOd26+VuFKNFcwYy1Da6wngqbmn8ERtx9gNrw8qJO
	DVRrxbFcUJdNHnDKnU15NFiTMtFL
X-Google-Smtp-Source: AGHT+IF7NtUDbLWRyL2NN3FYAvwERalxMVlvXddoMcKb+iu4sxr510NM8vr4QbMvvtr4IMHDIWZMiD+9yiUbJ8wWYrQ=
X-Received: by 2002:a05:6214:21a8:b0:880:8843:1f91 with SMTP id
 6a1803df08f44-88271914f29mr82414946d6.22.1763010799157; Wed, 12 Nov 2025
 21:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20251112055736.3078776-1-Qi.Chen@windriver.com>
 <df39c2e5ee59060f170ae7e4904a72acceb73e57.camel@linuxfoundation.org> <CO6PR11MB5602B41B30DBB7A223F58822EDCDA@CO6PR11MB5602.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5602B41B30DBB7A223F58822EDCDA@CO6PR11MB5602.namprd11.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 13 Nov 2025 06:13:08 +0100
X-Gm-Features: AWmQ_bkmbILdTcLGQAgk4c95mmKxSuiWnEq16mntxY6WV0rRi6eeXIkAm4cOJ3o
Message-ID: <CANNYZj9WOBX0fbJdBr8pqUbpsiwcW4JFKGefS7Eci_Ndk+GR5A@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] lib/bb/parse/ast.py: treat internal
 fragment setting as default value
To: "Chen, Qi" <Qi.Chen@windriver.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000006b4563064372f036"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 05:13:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18367

--0000000000006b4563064372f036
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For what it=E2=80=99s worth I agree with Chen. Priority order should be
environment, local.conf and only then toolcfg.conf. Yes it will lead to
confusion in legacy local.conf driven setups, but overriding machine on the
command line is a common use case and it should work.

Alex

On Thu 13. Nov 2025 at 4.17, Chen, Qi <Qi.Chen@windriver.com> wrote:

> Thank you for the explanation.
>
> My major concern is about the behavioral change in a project setup by
> bitbake-setup.
>
> When I was trying out bitbake-setup, the OE_FRAGMENTS are automatically
> generated in conf/toolcfg.conf. And I got an "empty" local.conf. So at th=
at
> time, I felt it natural that user configuration (local.conf) should take
> priority over the automatically generated one (toolcfg.conf). The logic i=
s
> like /etc and /usr in Linux systems.
>
> It's a little counter-intuitive that local.conf does not override setting=
s
> in toolcfg.conf. I mean, people have to  edit toolcfg.conf to change
> MACHINE in a project setup by bitbake-setup. And they can't use
> "MACHINE=3Dxxx bitbake <pkg>".
>
> Regards,
> Qi
>
> -----Original Message-----
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
> Sent: Thursday, November 13, 2025 12:01 AM
> To: Chen, Qi <Qi.Chen@windriver.com>; bitbake-devel@lists.openembedded.or=
g
> Cc: alex.kanavin@gmail.com
> Subject: Re: [bitbake-devel][PATCH] lib/bb/parse/ast.py: treat internal
> fragment setting as default value
>
> On Wed, 2025-11-12 at 13:57 +0800, Chen Qi via lists.openembedded.org
> wrote:
> > From: Chen Qi <Qi.Chen@windriver.com>
> >
> > In this way, users can continue to override settings such as MACHINE
> > via local.conf and env vars with plain '=3D' setting.
> >
> > Fixes [YOCTO #16060]
> >
> > Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> > ---
> >  lib/bb/parse/ast.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py index
> > e6ff1ff76..f9d93aa0f 100644
> > --- a/lib/bb/parse/ast.py
> > +++ b/lib/bb/parse/ast.py
> > @@ -373,7 +373,7 @@ class AddFragmentsNode(AstNode):
> >                          loginfo["detail"] =3D f"{value}
> ({self.fragments_variable} contains \"{fragment}\")"
> >                          break
> >                  # parsing=3DTrue since we want to emulate X=3DY and al=
low
> > X:override=3DZ to continue to exist
> > -                data.setVar(builtin_fragments[prefix], value,
> > parsing=3DTrue, **loginfo)
> > +                data.setVarFlag(builtin_fragments[prefix],
> > +'_defaultval', value, parsing=3DTrue, **loginfo)
> >                  return True
> >              return False
> >
>
>
> This is a tough one. I've thought about the two sides to this and you can
> argue it both ways.
>
> If we do this, we will get questions of "I set this fragment, why didn't
> it actually do that?".
>
> I think if you specify a fragment and it should override the conf files..=
.
>
> Cheers,
>
> Richard
>
>
>
>
>

--0000000000006b4563064372f036
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">For what it=E2=80=99s worth I agree with Chen. Priority o=
rder should be environment, local.conf and only then toolcfg.conf. Yes it w=
ill lead to confusion in legacy local.conf driven setups, but overriding ma=
chine on the command line is a common use case and it should work.=C2=A0</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Alex</div><div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Thu 13. Nov 2025 at 4.17, Chen, Qi &lt;<a href=3D"mailto:Qi.Chen@wi=
ndriver.com">Qi.Chen@windriver.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)"=
>Thank you for the explanation. <br>
<br>
My major concern is about the behavioral change in a project setup by bitba=
ke-setup.<br>
<br>
When I was trying out bitbake-setup, the OE_FRAGMENTS are automatically gen=
erated in conf/toolcfg.conf. And I got an &quot;empty&quot; local.conf. So =
at that time, I felt it natural that user configuration (local.conf) should=
 take priority over the automatically generated one (toolcfg.conf). The log=
ic is like /etc and /usr in Linux systems.<br>
<br>
It&#39;s a little counter-intuitive that local.conf does not override setti=
ngs in toolcfg.conf. I mean, people have to=C2=A0 edit toolcfg.conf to chan=
ge MACHINE in a project setup by bitbake-setup. And they can&#39;t use &quo=
t;MACHINE=3Dxxx bitbake &lt;pkg&gt;&quot;.<br>
<br>
Regards,<br>
Qi<br>
<br>
-----Original Message-----<br>
From: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.o=
rg" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt; <br>
Sent: Thursday, November 13, 2025 12:01 AM<br>
To: Chen, Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.com" target=3D"_blank"=
>Qi.Chen@windriver.com</a>&gt;; <a href=3D"mailto:bitbake-devel@lists.opene=
mbedded.org" target=3D"_blank">bitbake-devel@lists.openembedded.org</a><br>
Cc: <a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank">alex.kanavi=
n@gmail.com</a><br>
Subject: Re: [bitbake-devel][PATCH] lib/bb/parse/ast.py: treat internal fra=
gment setting as default value<br>
<br>
On Wed, 2025-11-12 at 13:57 +0800, Chen Qi via <a href=3D"http://lists.open=
embedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org</=
a> wrote:<br>
&gt; From: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.com" target=3D"_=
blank">Qi.Chen@windriver.com</a>&gt;<br>
&gt; <br>
&gt; In this way, users can continue to override settings such as MACHINE <=
br>
&gt; via local.conf and env vars with plain &#39;=3D&#39; setting.<br>
&gt; <br>
&gt; Fixes [YOCTO #16060]<br>
&gt; <br>
&gt; Signed-off-by: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.com" ta=
rget=3D"_blank">Qi.Chen@windriver.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/parse/ast.py | 2 +-<br>
&gt; =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py index <br>
&gt; e6ff1ff76..f9d93aa0f 100644<br>
&gt; --- a/lib/bb/parse/ast.py<br>
&gt; +++ b/lib/bb/parse/ast.py<br>
&gt; @@ -373,7 +373,7 @@ class AddFragmentsNode(AstNode):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 loginfo[&quot;detail&quot;] =3D f&quot;{value} ({self.fragments_variable} =
contains \&quot;{fragment}\&quot;)&quot;<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 break<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 # parsing=3DTrue since we want to emulate X=3DY=
 and allow <br>
&gt; X:override=3DZ to continue to exist<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data.setVar(builtin_fragments[prefix], value, <br>
&gt; parsing=3DTrue, **loginfo)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data.setVarFlag(builtin_fragments[prefix], <br>
&gt; +&#39;_defaultval&#39;, value, parsing=3DTrue, **loginfo)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return True<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return False<br>
&gt; <br>
<br>
<br>
This is a tough one.=C2=A0I&#39;ve thought about the two sides to this and =
you can argue it both ways.<br>
<br>
If we do this, we will get questions of &quot;I set this fragment, why didn=
&#39;t it actually do that?&quot;.<br>
<br>
I think if you specify a fragment and it should override the conf files...<=
br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
<br>
</blockquote></div></div>

--0000000000006b4563064372f036--

