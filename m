Return-Path: <brennan.coslett@bluerivertech.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73C1CF6D3E
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 16:57:12 +0000 (UTC)
Received: from mx0a-000e4101.pphosted.com (mx0a-000e4101.pphosted.com [67.231.152.47])
 by mx.groups.io with SMTP id smtpd.web10.830.1727888224895750807
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Oct 2024 09:57:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bluerivertech.com header.s=google header.b=dNDLtygS;
 spf=pass (domain: bluerivertech.com, ip: 67.231.152.47, mailfrom: prvs=2005319c66=brennan.coslett@bluerivertech.com)
Received: from pps.filterd (m0202935.ppops.net [127.0.0.1])
	by mx0a-000e4101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492FQHGD011203
	for <bitbake-devel@lists.openembedded.org>; Wed, 2 Oct 2024 11:57:04 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-000e4101.pphosted.com (PPS) with ESMTPS id 42185try10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 02 Oct 2024 11:57:03 -0500 (CDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e06c9217bcso53827a91.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Oct 2024 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluerivertech.com; s=google; t=1727888223; x=1728493023; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BrD4d51gwRmFoy4GDadKjXLoI3+2zaPQa32lCnFEcKA=;
        b=dNDLtygSo7tYoCmO/A6sQx5rdc+kq7vnOgNxt+WNgnmUWTNFCyJnFZqcQ/5ekfUs/T
         Ivo2VQ8HNizMp/F0Lx4DWWZUBA0x0NH6WgP5RTLJwahG5NVhuAi3GWszY7NqMyVXju29
         QakItgFVzN+As8MxsIya9d9jg8ygDQr5hhH7KShn21d1pzIN1OkgjR4JJQowQRzQnyH/
         FMDsAY1xh+WGoVENynY/rUnS2Rdt9YWmhzke9x65k/Irfbw7RSAnIFVV9lgosdgdoGTa
         oWACfbI4qsUpT06xr1N2ek/2sg9WzWCfu/JcNR6xpmbUZbd3KFG+J1hF7jiSzgv6Rt1n
         aCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888223; x=1728493023;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrD4d51gwRmFoy4GDadKjXLoI3+2zaPQa32lCnFEcKA=;
        b=HkOlVgCRBTzdqrHFOWVzshP1kAZ/EPY616vkfIhA/tT4kH1+q9hWkxS43BLE/V5c5b
         0l49Tca98nNmLFFu6wy5hVJvvc9mNgKls+RbvX0dtV2G5IZ3Ija2dLBcAsTGjzAd2jmy
         tRwEbSnCzlau9vUKlOcXeMUCgZNQf87vXY8SCyDfqRMWHbvqWPkC4xJ8jNysyI0ZdUUh
         13q6EafGwUWkaPLNQlzDIoat72E1wEr9gpidCmMrIe1+ZEMlAnhvo50Zv3F9UDPtUmv6
         EbAr0oSL8YgnjoYiB96RovQTmejjDdGuoeXyslrnM02hsF4HWP2bJzMZGwEYU7y1OPTB
         1QPg==
X-Forwarded-Encrypted: i=1; AJvYcCXvKKSzbbC6luhyw+olFlhYQ7EEHzRXLAa1t6D68dBvQrUWiaAe47Nlq/00hhkeBcu4gM2PFqO1NbZLkC1N@lists.openembedded.org
X-Gm-Message-State: AOJu0YxtQEZKTREwpSGRD/M9J0pL7EP5qk03OvRRZR5UP8GcIWTc5qdi
	bPY5MIXHLs1p94bi4Y8fOJGPpVK+nG39TbMdFhJhBKFzog6IzK143nd+beFtu2yY6C6Z/y0r35s
	hE3NSM3s5zHHanoLVrRjjDVqk9Lolcxsu6mLR1pJxwDatUghWtctVEhxE61J19n2yuIlF3v4VoQ
	CnRXasc+uOq/7S+k/MDEj1f86qOWSV5mRHALeAkS3KFJ/3L74=
X-Received: by 2002:a17:90b:4c03:b0:2d8:8681:44ba with SMTP id 98e67ed59e1d1-2e18466e353mr4801630a91.15.1727888222658;
        Wed, 02 Oct 2024 09:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFakr1OVcHFKJxhh3Ak/ucs3Go7bu4hIrc0oJ3TpxxInP6G3GipTRJGaDoON1KmZgx9WtmVUttSsfx0uRnnnCc=
X-Received: by 2002:a17:90b:4c03:b0:2d8:8681:44ba with SMTP id
 98e67ed59e1d1-2e18466e353mr4801613a91.15.1727888222248; Wed, 02 Oct 2024
 09:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAAc_J+_bjkedrH1kj2+qHi=OiEnC9TPxCqpZAVSLiqBs7Xsp6g@mail.gmail.com>
 <6732.1727883773132320625@lists.openembedded.org> <15815bbb3b9518dbd9cee9df627e24de74482a17.camel@linuxfoundation.org>
In-Reply-To: <15815bbb3b9518dbd9cee9df627e24de74482a17.camel@linuxfoundation.org>
From: Brennan Coslett <brennan.coslett@bluerivertech.com>
Date: Wed, 2 Oct 2024 11:56:51 -0500
Message-ID: <CAAc_J+_nSKHeZ13Gt0ONCPpi9dJjKJAc553gVuDWWDkmrRy50Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake: fetch2: Fix systemd template
 file parsing
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000b2fa190623815309"
X-Proofpoint-GUID: GpoY1kmly9X8nod7yQENpRtiirYDFtbi
X-Proofpoint-ORIG-GUID: GpoY1kmly9X8nod7yQENpRtiirYDFtbi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410020121
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Oct 2024 16:57:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16624

--000000000000b2fa190623815309
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The decodeurl part is the only part that was needed to actually solve the
problem
(I was able to verify that the missing files ended up in the archiver
output dir, the
encodeurl part was just to make the existing test format happy because it
has
asserts that the value was exactly identical. If you have thoughts on a
better way to
change that, idk if doing that substitution in the test before it checks
for equivalency
but somehow that feels more gross to me? It seems like maybe we should use
the
https://docs.python.org/3/library/urllib.parse.html#urllib.parse.quote safe
arg instead
and just set that to include basically everything when encoding local files?

Thanks,
Brennan

On Wed, Oct 2, 2024 at 11:42=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2024-10-02 at 08: 42 -0700, Brennan Coslett via lists.
> openembedded. org wrote: > Anything more I should do with this if no one
> has any comments? Do I > need to convert this to a non-RFC PATCH? >   It
> wasn't an easy patch to review
>=20
>
> On Wed, 2024-10-02 at 08:42 -0700, Brennan Coslett vialists.openembedded.=
org wrote:
> > Anything more I should do with this if no one has any comments? Do I
> > need to convert this to a non-RFC PATCH?
> >
>
> It wasn't an easy patch to review without looking at the context of the
> file. The decodeurl piece looks ok.
>
> I'm more worried about the encodeurl part and am left wondering what
> other character encoding issues we might have there. Special casing %40
> seems a bit worrying.
>
> I appreciate the patch solves your immediate problem with that
> character but I wonder what other issue remain waiting to catch us out.
>
> Cheers,
>
> Richard
>
>

--000000000000b2fa190623815309
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The decodeurl part is the only part that was needed to act=
ually solve the problem<div>(I was able to verify that the missing files en=
ded up in the archiver output dir, the</div><div>encodeurl part was just to=
 make the existing test format happy because it has</div><div>asserts that =
the value was exactly identical. If you have thoughts on a better way to<br=
></div><div>change that, idk if doing that substitution in the test before =
it checks for equivalency</div><div>but somehow that feels more gross to me=
? It seems like maybe we should use the</div><div><a href=3D"https://docs.p=
ython.org/3/library/urllib.parse.html#urllib.parse.quote">https://docs.pyth=
on.org/3/library/urllib.parse.html#urllib.parse.quote</a> safe arg instead<=
br></div><div>and just set that to include basically everything=C2=A0when e=
ncoding local files?</div><div><br></div><div>Thanks,</div><div>Brennan</di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, Oct 2, 2024 at 11:42=E2=80=AFAM Richard Purdie &lt;<a href=3D"mai=
lto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div class=3D"msg3589125424839560640"><u></u>


<div style=3D"font-size:1px;color:rgb(255,255,255);line-height:1px;height:0=
px;max-height:0px;opacity:0;overflow:hidden;display:none">
On Wed, 2024-10-02 at 08:=E2=80=8A42 -0700, Brennan Coslett via lists.=E2=
=80=8Aopenembedded.=E2=80=8Aorg wrote: &gt; Anything more I should do with =
this if no one has any comments? Do I &gt; need to convert this to a non-RF=
C PATCH? &gt; =C2=A0 It wasn&#39;t an easy patch to review</div>



<div style=3D"font-size:1px;color:rgb(255,255,255);line-height:1px;height:0=
px;max-height:0px;opacity:0;overflow:hidden;display:none"></div>








<div><pre style=3D"font-family:sans-serif;font-size:100%;white-space:pre-wr=
ap">On Wed, 2024-10-02 at 08:42 -0700, Brennan Coslett via
<a href=3D"http://lists.openembedded.org" target=3D"_blank">lists.openembed=
ded.org</a> wrote:
&gt; Anything more I should do with this if no one has any comments? Do I
&gt; need to convert this to a non-RFC PATCH?
&gt; =C2=A0

It wasn&#39;t an easy patch to review without looking at the context of the
file. The decodeurl piece looks ok.

I&#39;m more worried about the encodeurl part and am left wondering what
other character encoding issues we might have there. Special casing %40
seems a bit worrying.

I appreciate the patch solves your immediate problem with that
character but I wonder what other issue remain waiting to catch us out.

Cheers,

Richard
</pre></div>
</div></blockquote></div>

--000000000000b2fa190623815309--

