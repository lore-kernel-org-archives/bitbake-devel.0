Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAA5C61DA4
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 15:21:22 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.16072.1678375279958765898
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Mar 2023 07:21:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AZL4cjjh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id c18so1403776wmr.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678375278;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KdDgm4tUNeFRDn43Ftlae8BQs0N2Hr1RYd5DxXE0GE=;
        b=AZL4cjjhux+4+fY8YD7gc/9/zKeKN6CVTvVzQ1bzAD7uoyxhZ4Vh/hgdJbmRSA5mtZ
         3rPuMAeVAt28elstTjHWf55420LASD+ieo5nF5weydBKiffUGwxfxttFu7Z1LV6EIDHU
         FrRMCdmDev3D3PmQEUze9g/L8vgECtyl1dov0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678375278;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KdDgm4tUNeFRDn43Ftlae8BQs0N2Hr1RYd5DxXE0GE=;
        b=q4gM6W3MBN4LPJ1I7V0nWN/6ee4sOZa+aYh0FJjjLnCZjQilC9TWvN5is+dd+gNBjJ
         emEHUBUdaie6Nek3okijlRQPdKRcvmi6nMXR/CquIV8JUctxEe6XUD1qWVb+QNXzjHZ7
         RqPD/ge0t++R/R0SA8hd3HvAP/cRi9rq4kKurH/RAuchgmNBa/6NAL0OtlFjftM7viD7
         GbKBnLhGPbElSFsVGeG3laxZDh23zqj0p2oA50LJB9k2Gsoj/lLFBgiycx8spXNWDMp5
         XwiacrHmPGHoxDgtSiKoWw/gp+DUhsHXrEnkrMS9vu0STeNlgNzxTwAxAMGhK8+iu/N2
         6b5g==
X-Gm-Message-State: AO0yUKU0Jy/KDrUQREVCCmFqDn4Cfr3TVjvvb/z9cn3WpVWnVyVmgHgq
	C35G28rxXqNOR/kxMZ/d/OLb3WMFYh6QiXrgpCc=
X-Google-Smtp-Source: AK7set8jyrFZ8J73Rh8gGbXG9jWkusPW1cTMcj5e/zZidpCSMOaq9Opjs0a1U7XqlJtvazLegK1trg==
X-Received: by 2002:a05:600c:4449:b0:3df:e659:f9d9 with SMTP id v9-20020a05600c444900b003dfe659f9d9mr18617738wmn.34.1678375278393;
        Thu, 09 Mar 2023 07:21:18 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7e05:8348:1f1a:b973? ([2001:8b0:aba:5f3c:7e05:8348:1f1a:b973])
        by smtp.gmail.com with ESMTPSA id s4-20020adff804000000b002c705058773sm18719308wrp.74.2023.03.09.07.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 07:21:18 -0800 (PST)
Message-ID: <257c4d74707feb15feff212722b8ae46f6413f88.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] data_smart: fix library name contains
 special word cause do_package failed
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 09 Mar 2023 15:21:17 +0000
In-Reply-To: <e6214745-8bb1-b504-0823-0aa2dc0b6c69@windriver.com>
References: <20230308095539.651015-1-xiangyu.chen@eng.windriver.com>
	 <9492b64c0e41f32dfe9afb8bf8e06f4e9e331c48.camel@linuxfoundation.org>
	 <e6214745-8bb1-b504-0823-0aa2dc0b6c69@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 15:21:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14530

On Thu, 2023-03-09 at 08:46 +0800, Xiangyu Chen wrote:
> Hi Richard,
>=20
> Thank you for your prompt response.
>=20
>=20
> On 3/8/23 18:49, Richard Purdie wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
> >=20
> > On Wed, 2023-03-08 at 17:55 +0800, Xiangyu Chen wrote:
> > > From: Xiangyu Chen <xiangyu.chen@windriver.com>
> > >=20
> > > When the package library name contains like _append/_prepend words
> > > and the pkg-config added those libraries to requires, the do_package
> > > would report an error message:
> > >=20
> > > "Variable xxxx contains an operation using the old override syntax.
> > > Please convert this layer/metadata before attempting to use with a
> > > newer bitbake"
> > >=20
> > > This was found on latest version abseil-cpp package due to there is
> > > a library name called "absl_log_internal_append_truncated"
> > >=20
> > > So discard to check a variable with "Requires" header in setVar()
> > >=20
> > > Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> > > ---
> > >   lib/bb/data_smart.py | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> > > index c597dbad..fc33d34c 100644
> > > --- a/lib/bb/data_smart.py
> > > +++ b/lib/bb/data_smart.py
> > > @@ -539,7 +539,7 @@ class DataSmart(MutableMapping):
> > >       def setVar(self, var, value, **loginfo):
> > >           #print("var=3D" + str(var) + "  val=3D" + str(value))
> > >=20
> > > -        if not var.startswith("__anon_") and ("_append" in var or "_=
prepend" in var or "_remove" in var):
> > > +        if not var.startswith("Requires") and not var.startswith("__=
anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
> > >               info =3D "%s" % var
> > >               if "file" in loginfo:
> > >                   info +=3D " file: %s" % loginfo["file"]
> > "Requires" seems like a really strange name for a variable to start
> > with, where is that coming from? I don't think we should be hardcoding
> > OE-Core specific datastore usage inside bitbake. We're definitely not
> > merging that as is.
> >=20
> > Is this from the pkgconfig code in do_package? If so we should probably
> > take a closer look at what that is doing as it doesn't sound good.
>=20
> Yes, indeed, the word of "Requires" is coming from pkg-config .pc file[1]=
.
>=20
> When do_package read the .pc file, it would pass the "Requires"=20
> parameters to setVar in data_smart.py.
>=20
> The setVar has a variable checking, when the variable contains=20
> "_append/_prepend/_remove", it would report an error and exit.
>=20
> Coincidentally,the abseil-cpp has a library named=20
> "absl_log_internal_append_truncated" and declared at "Requires" section=
=20
> in a .pc file, it would hit the variables checking in setVar and this=20
> cause the latest version abseil-cpp cannot compile successfully. The=20
> packages(e.g. latest version protobuf) which depends latest version=20
> abseil-cpp also cannot update.
>=20
> [1] https://people.freedesktop.org/~dbn/pkg-config-guide.html

I had a quick look at the pkgconfig code in do_package and I can't see
where this setVar is coming from. Can you point to the code which is
setting this?

As I said, we need to look at why this is happening. I'm very reluctant
to add special cases to generic code.

Cheers,

Richard



