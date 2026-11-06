Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5060.1793969057063692251
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2026 04:44:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=knVJasor;
 spf=pass (domain: gmail.com, ip: 74.125.224.48, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67c08c7adadso431819d50.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Nov 2026 04:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793969056; cv=none;
        d=google.com; s=arc-20260327;
        b=behexp65EQ/m9f6GVMjwQfV2LKKpgYGduTXDiKsaLNlysvDqX4hiG6CqEulgO9Y2QU
         vFknwHCiqfLAwnHZQ6d4XnA3zeTxL3zHtxTn/CHK8ZV2vWERzQdxxmliQzdxuFBVROUR
         KVnVwB2xxolbStaYFrNuBcU8PoNlq8JXlZF89d5Gvk2B8gzYAiDXlAsLhPAheX7uLUbZ
         QdNyNebi8ai/08rmbhoTry1nzkZwCiZbz+uR8jKCD1jLFBMAyf4hZoHEDs6ZFDUwR+3s
         yPh9z7EnTgK0z8FADnCGZqd96Bs6w+VFXsMMpYbG8aEtIFVYBVsdJahP2WKYJnOLrB/G
         f/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=McVrsBTO8WLNKm93q4DSMPs6Le/XPZEOc6RwTjkX/q4=;
        fh=l+C8mVZfKwXW6sMMJ9OeuuqNxJHmx/+P8xPrmJ7NaHg=;
        b=rV1J6iSUJKynGR9d96uc7IqLcUOeWJCNKXjbIPDwyeb7hDbDlKvlPdskqoreY+B9gk
         tRfrFNjKkNuXO1x4OQwavHk3JUHhe26KLK96GwLgaPIXhCaR1vi6QR3KAhrQqTflR33f
         ddqmyC9iEDWj00rU1vYSgCwO6Oq9JTIxPxpG0tHtBet5GoFImtUobHFNHrPTg9uj2sXI
         5blvPZTYJuQsk0xf1wLR0g0SivXT8V8anB+vKymErx7IWKxEOycLYO6O5HpCIww2w+p5
         5ocJCiazIOM/kGoFepqNf3HVNsIwFRzN6Xu3qaz2Q4PM7WjvMBFzw9EBFHlLkmIwaFi4
         5YGw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969056; x=1794573856; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=McVrsBTO8WLNKm93q4DSMPs6Le/XPZEOc6RwTjkX/q4=;
        b=knVJasor7naqNoHAEmuYtlRADUvEzh9tfGsqXmQ3zSHrHycktAhVi+nCLFrlw/gHtp
         vpRyGEry1C3/J65Oqk4+WEmOZseosjU0tfiyfAnvjRRNTmpeNmqq1CgdjkxWd2rMRS/K
         SZ+BneI8XA0W8J6Jtuk2X9Sl3VZ2Ci025PMIlsA9PFHnthX5Pjmz4ybPfHmmLhIYDQBk
         mPJCWWmuD5WuFuwFLWRS1GLKujfa2+pPAF8ETU7Li+aGbkKB3TCGI+EZokotjUAKau/o
         JBYyPRsqeFpe9BPKzObyERy6J4DLbXRruYdH4QfYocXedVlMZwMjKafKFZQOhFC+Vbfh
         GlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969056; x=1794573856;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=McVrsBTO8WLNKm93q4DSMPs6Le/XPZEOc6RwTjkX/q4=;
        b=FAJQrGcpVhmZZgCqi+toPshGl/316cJFK8/hJdN6O35gIXkf6HhoqobpdpPNJCGe83
         EdypTA1KVN2ZBFfe2ZXE+g8ygAjAL8xOzdjCAKQJZymr7W6zyLH/4HdaIHoy9NYWO1JR
         Oww8Wnv/7+eo4m4LInzM3HOq7bpI2+egC3uEUVvJzQY9Jy0K/VAIQxewGz+USDLg5wyr
         EcTfigOUdXZ+mIxFB1Re/5e+IulEXbplRxMBsNJypoXia+5XmP6wInejgvO5cgeU2TEv
         9LXh1wayfVc4woNXzEVPRZJzKRVrW5noVVT3CuNY7t8w741IcjrPo27a36DwU1MEaQoD
         jJIw==
X-Forwarded-Encrypted: i=1; AL+hErGSOFpHbhsSdxZ3g6Bd+h9K/EkdiAnmcaKIq6p57T0JufhVRQth/METqvPVmcOPtAbiFZdiQizb/kdwNBwo@lists.openembedded.org
X-Gm-Message-State: APuU4Z+5SmI3z/WFPJkpm4TGnMbEZJb7xJPqoYlnjYoaFlNAaLnZf3WH
	3dJO4GMgS2QZKw3DSELtoyFMOiwq/tn1EmrEg23ymvAbdTw9zdjfr6zr28emD8a4XPq6dpB7x9Y
	irw47tDpnWIKmY+exqaX3NoyYXCvVVfUR6bFM
X-Gm-Gg: AYBFou3xfuDhMOATW9EkPZwdRb0LTfTbllsPHm9/jqEBApE+Lx3RgETWVRaks4aFNOE
	WF9sCRU/w0GIeB1ntGwD8xGyDsEm6pJPYdZX61c/w5WMUp/Wr3sCTxYwcPu1maLLNXlM8j3V0cW
	hxWHAEK/Y3W5Dic2165u/tiHPV2HEJWkIQcKu1Kcc1/wO0dj4koOTBLUVmnQU+kivfeVcrK2xpO
	PS+JBkFyrDR5NBj98K7hI8G9UvXIk8xBE/u8r5Qkt80kG0Okod5dBO3dyApYc9CyNcZOMQYzvab
	1A+keKsiuGGVJZi9H5XIh2YPEkxypgdBWYWt+AWhr8sXMn3B3hB2rARCLO1ov105O/LrxSUtzbb
	8bPLSZhQZyXhHtlyd1weP5ouzSjq9nMdYRnpzuDyZ4nhYXUDGqRJMH6P1i/gQOfvu8DNy3S0=
X-Received: by 2002:a05:690e:1306:b0:676:2dce:8e95 with SMTP id
 956f58d0204a3-67c140db6dcmr1136062d50.13.1793969055103; Fri, 06 Nov 2026
 04:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20261105012522.878275-1-kpoduval@lab126.com> <20261105012522.878275-2-kpoduval@lab126.com>
 <A62B91DA-FE71-4D0B-9672-1AFCF0C0A2CA@arm.com> <EA3PR18MB205973294DDF2131E43CC49172F1762@EA3PR18MB205973.namprd18.prod.outlook.com>
In-Reply-To: <EA3PR18MB205973294DDF2131E43CC49172F1762@EA3PR18MB205973.namprd18.prod.outlook.com>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Fri, 6 Nov 2026 07:44:03 -0500
X-Gm-Features: AclHuK8zA1NpYfAEhnwBLdn2G6wF6_HR9e3Q-BtnHCbBLbgJkP2jw7WaumgNRm4
Message-ID: <CAGAhMBx_oCwz24qzoJUjbD3EwKVndyUdfN0gfCHsQx=_KecZmg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch/s3: fetch via boto3 by default,
 falling back to the AWS CLI
To: kpoduval@lab126.com
Cc: "ross.burton@arm.com" <ross.burton@arm.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	"armccurdy@gmail.com" <armccurdy@gmail.com>, 
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>, 
	"stefan.herbrechtsmeier@weidmueller.com" <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: multipart/alternative; boundary="000000000000448050065f9af81d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 06 Nov 2026 12:44:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20404

--000000000000448050065f9af81d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Glad to see work being done in this area.

I have been using the S3 boto3 work done by OE4T.  Are you aware of their
work?
https://github.com/OE4T/tegra-demo-distro/tree/master/layers/meta-demo-ci/l=
ib/oeaws

One of the benefits of their approach is that results get mirrored
incrementally rather than at the end so you can use it with spot instances
that get reclaimed in the middle of a build.

Let me know if I can help test it.

Regards,
Rob

On Thu, Nov 5, 2026 at 9:14=E2=80=AFPM Karthik Poduval via bitbake-devel <k=
poduval=3D
lab126.com@lists.openembedded.org> wrote:

> Thanks for the comments Ross, let me rework the patch as you suggested.
>
> --
> Regards,
> Karthik Poduval
>
> -----Original Message-----
> From: Ross Burton via bitbake-devel <ross.burton=3D
> arm.com@lists.openembedded.org>
> Sent: Thursday, November 5, 2026 5:55 AM
> To: Poduval, Karthik <kpoduval@lab126.com>
> Cc: bitbake-devel@lists.openembedded.org; armccurdy@gmail.com;
> richard.purdie@linuxfoundation.org; stefan.herbrechtsmeier@weidmueller.co=
m
> Subject: RE: [EXTERNAL] [bitbake-devel] [PATCH 1/1] fetch/s3: fetch via
> boto3 by default, falling back to the AWS CLI
>
> CAUTION: This email originated from outside of the organization. Do not
> click links or open attachments unless you can confirm the sender and kno=
w
> the content is safe.
>
>
>
> Hi Karthik,
>
> I have no problem with the choice of using boto over the CLI,  the
> performance gains you=E2=80=99re shown are not insignificant. However=E2=
=80=A6
>
> On 5 Nov 2026, at 01:25, Karthik Poduval via bitbake-devel <kpoduval=3D
> lab126.com@lists.openembedded.org> wrote:
> > +try:
> > +    import boto3
> > +    import botocore
> > +    HAVE_BOTO3 =3D True
> > +except ImportError:
> > +    HAVE_BOTO3 =3D False
>
> Instead of respecting HAVE_BOTO3 in each of the functions, resulting in
> quite a lot of complex code, I suggest a slightly different approach.
> Instead of having the conditional in the methods, have two implementation=
s
> of the S3 fetcher (sharing code via a common parent, if needed), and then
> pick what one is used on the fly.  Something like this:
>
> class S3Common(FetchMethod):
>   # common methods can go in this class
>   def supports(self, ud, d):
>     return ud.type in ['s3=E2=80=99]
>   # etc
>
> class S3CLI(S3Common):
>   # concrete implementation using the CLI
>   def download(self, ud, d):
>     # download using the cli
>
> class S3Boto(S3Common):
>   # concrete implementation using boto
>   def download(self, ud, d):
>     # download using boto
>
> try:
>   import boto3
>   S3 =3D S3Boto
> except ImportError:
>   S3 =3D S3CLI
>
> This should result in neater code as there=E2=80=99s a clear split betwee=
n the two
> backend implementations.
>
> Cheers,
> Ross
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20401):
> https://lists.openembedded.org/g/bitbake-devel/message/20401
> Mute This Topic: https://lists.openembedded.org/mt/122104157/556952
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> rob.woolleywr@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000448050065f9af81d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Glad to see work being done in this area.<div><br></div><d=
iv>I have been using the S3 boto3 work done by OE4T.=C2=A0 Are you aware of=
 their work?=C2=A0<a href=3D"https://github.com/OE4T/tegra-demo-distro/tree=
/master/layers/meta-demo-ci/lib/oeaws">https://github.com/OE4T/tegra-demo-d=
istro/tree/master/layers/meta-demo-ci/lib/oeaws</a><br><br>One of the benef=
its of their approach is that results get mirrored incrementally rather tha=
n at the end so you can use it with spot instances that get reclaimed in th=
e middle of a build.<br><br></div><div>Let me know if I can help test it.<b=
r><br>Regards,<br>Rob</div></div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 5, 2026 at 9:1=
4=E2=80=AFPM Karthik Poduval via bitbake-devel &lt;kpoduval=3D<a href=3D"ma=
ilto:lab126.com@lists.openembedded.org">lab126.com@lists.openembedded.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Th=
anks for the comments Ross, let me rework the patch as you suggested.<br>
<br>
--<br>
Regards,<br>
Karthik Poduval<br>
<br>
-----Original Message-----<br>
From: Ross Burton via bitbake-devel &lt;ross.burton=3D<a href=3D"mailto:arm=
.com@lists.openembedded.org" target=3D"_blank">arm.com@lists.openembedded.o=
rg</a>&gt; <br>
Sent: Thursday, November 5, 2026 5:55 AM<br>
To: Poduval, Karthik &lt;<a href=3D"mailto:kpoduval@lab126.com" target=3D"_=
blank">kpoduval@lab126.com</a>&gt;<br>
Cc: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blan=
k">bitbake-devel@lists.openembedded.org</a>; <a href=3D"mailto:armccurdy@gm=
ail.com" target=3D"_blank">armccurdy@gmail.com</a>; <a href=3D"mailto:richa=
rd.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfounda=
tion.org</a>; <a href=3D"mailto:stefan.herbrechtsmeier@weidmueller.com" tar=
get=3D"_blank">stefan.herbrechtsmeier@weidmueller.com</a><br>
Subject: RE: [EXTERNAL] [bitbake-devel] [PATCH 1/1] fetch/s3: fetch via bot=
o3 by default, falling back to the AWS CLI<br>
<br>
CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.<br>
<br>
<br>
<br>
Hi Karthik,<br>
<br>
I have no problem with the choice of using boto over the CLI,=C2=A0 the per=
formance gains you=E2=80=99re shown are not insignificant. However=E2=80=A6=
<br>
<br>
On 5 Nov 2026, at 01:25, Karthik Poduval via bitbake-devel &lt;kpoduval=3D<=
a href=3D"mailto:lab126.com@lists.openembedded.org" target=3D"_blank">lab12=
6.com@lists.openembedded.org</a>&gt; wrote:<br>
&gt; +try:<br>
&gt; +=C2=A0 =C2=A0 import boto3<br>
&gt; +=C2=A0 =C2=A0 import botocore<br>
&gt; +=C2=A0 =C2=A0 HAVE_BOTO3 =3D True<br>
&gt; +except ImportError:<br>
&gt; +=C2=A0 =C2=A0 HAVE_BOTO3 =3D False<br>
<br>
Instead of respecting HAVE_BOTO3 in each of the functions, resulting in qui=
te a lot of complex code, I suggest a slightly different approach.=C2=A0 In=
stead of having the conditional in the methods, have two implementations of=
 the S3 fetcher (sharing code via a common parent, if needed), and then pic=
k what one is used on the fly.=C2=A0 Something like this:<br>
<br>
class S3Common(FetchMethod):<br>
=C2=A0 # common methods can go in this class<br>
=C2=A0 def supports(self, ud, d):<br>
=C2=A0 =C2=A0 return ud.type in [&#39;s3=E2=80=99]<br>
=C2=A0 # etc<br>
<br>
class S3CLI(S3Common):<br>
=C2=A0 # concrete implementation using the CLI<br>
=C2=A0 def download(self, ud, d):<br>
=C2=A0 =C2=A0 # download using the cli<br>
<br>
class S3Boto(S3Common):<br>
=C2=A0 # concrete implementation using boto<br>
=C2=A0 def download(self, ud, d):<br>
=C2=A0 =C2=A0 # download using boto<br>
<br>
try:<br>
=C2=A0 import boto3<br>
=C2=A0 S3 =3D S3Boto<br>
except ImportError:<br>
=C2=A0 S3 =3D S3CLI<br>
<br>
This should result in neater code as there=E2=80=99s a clear split between =
the two backend implementations.<br>
<br>
Cheers,<br>
Ross<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#20401): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/20401" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/20401</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/122104157/556=
952" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/122104157/556952</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:rob.woolleywr@gmail.com" target=3D=
"_blank">rob.woolleywr@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000448050065f9af81d--
