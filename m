Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBEDC636D4
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 16:28:19 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.19772.1676478490523396372
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 08:28:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LDqz6guy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso2049665wms.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 08:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z3n26oOjQNQslaJRdF+HyWpE4p8uJ2yJxmx0p3HnMks=;
        b=LDqz6guyD2l2qcuULD1Q+F4sMuPCAKQeV+KmXAl+4jwlmxT8fsh6bFvZsocly69yZU
         mSzrNqH/Q8ia6kjys6c7WtstIiubwoPVry7YPSdyHzf1Rva8aT9Y7HvDXdoTQ+7wdK/J
         nbC8Y4MYDi6ZOQjLIllJo8HMZgXqAK1pD75vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3n26oOjQNQslaJRdF+HyWpE4p8uJ2yJxmx0p3HnMks=;
        b=46RuSmDQOK9nYX0+ijqIBcVw9OaiUinvR5i5jzJNcA2pktbx2EyOr7Daj+qpUxz8Sn
         XfZQ39mhvNPivWwflTBwqi/mMZH8ngLyjck3xvsHC6OutMAKuxWxENZWfQACFLpk0c56
         7Eej4z8zQd3F5wuXP2NXHRswZzDfeuhZChAQyCvG0QwQNoPKf4Jcb0ixP5t9Ra2xrPb6
         VGjJhQ/l/8p1xf11L4akRg841njFAq9oE6N0vI+bY65YchCzAxV3StFWc4Vxw8/MMnxm
         qqtPSPTeMYaUV2w1Zbui8rv9VX03ev2id9lG7b96btztbE1UvCzWEGp8AIDjs8e09HxE
         1Tbw==
X-Gm-Message-State: AO0yUKWEwY8C1pK9FH4qWqZIomYuTAwN4ccKJ/DSvSuBfn7uNU509LuJ
	mseUXzF+wugGjaM1UwK0GhMcQA==
X-Google-Smtp-Source: AK7set+KNLcoSVyGmS0DMkYhLI3Fcx9fGhsB632A5ijr+zW4ZyKb/D5cUx5IB18lZp16WmI9XekTyw==
X-Received: by 2002:a05:600c:4aa7:b0:3dc:54e9:dfd7 with SMTP id b39-20020a05600c4aa700b003dc54e9dfd7mr2647664wmp.25.1676478488662;
        Wed, 15 Feb 2023 08:28:08 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:fcb8:24dc:acf7:61c1? ([2001:8b0:aba:5f3c:fcb8:24dc:acf7:61c1])
        by smtp.gmail.com with ESMTPSA id p1-20020a7bcde1000000b003e1f2e43a1csm2446737wmj.48.2023.02.15.08.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:28:08 -0800 (PST)
Message-ID: <1256aaa44ee27adace8686a37393d68d75cab1f9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] ast/data/codeparser: Add dependencies
 from python module functions
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 15 Feb 2023 16:28:07 +0000
In-Reply-To: <CA+chaQdrzVxHjKGPGSaoWxkr_pYShj5z9o8QFV5b585cG-9Z7g@mail.gmail.com>
References: <20221212160334.54431-1-richard.purdie@linuxfoundation.org>
	 <CA+chaQdrzVxHjKGPGSaoWxkr_pYShj5z9o8QFV5b585cG-9Z7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 16:28:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14436

On Wed, 2023-02-15 at 16:19 +0100, Martin Jansa wrote:
> On Mon, Dec 12, 2022 at 5:03 PM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > Moving code into python modules is a very effective way to reduce
> > parsing
> > time and overhead in recipes. The downside has always been that any
> > dependency information on which variables those functions access is
> > lost
> > and the hashes can therefore become less reliable.
> >=20
> > This patch adds parsing of the imported module functions and that
> > dependency
> > information is them injected back into the hash dependency
> > information.
> >=20
> > Intermodule function references are resolved to the full function
> > call names in our module namespace to ensure interfunction
> > dependencies
> > are correctly handled too.
> >=20
> > (Bitbake rev: 605c478ce14cdc3c02d6ef6d57146a76d436a83c)
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> >=20
>=20
> ...=C2=A0
> > diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> > index 862087c77d..375ba3cb79 100644
> > --- a/lib/bb/parse/ast.py
> > +++ b/lib/bb/parse/ast.py
> > @@ -290,6 +290,18 @@ class PyLibNode(AstNode):
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0toimport =3D getattr(bb=
.utils._context[self.namespace],
> > "BBIMPORTS", [])
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for i in toimport:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.=
_context[self.namespace] =3D
> > __import__(self.namespace + "." + i)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod =3D getatt=
r(bb.utils._context[self.namespace],
> > i)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D getattr=
(mod, "__file__")
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 funcs =3D {}
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in dir(m=
od):
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if f.startswith("_"):
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 continue
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
fcall =3D getattr(mod, f)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if not callable(fcall):
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 continue
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
funcs[f] =3D fcall
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.codeparser.=
add_module_functions(fn, funcs,
> > "%s.%s" % (self.namespace, i))
> > +
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except AttributeError as e:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.error("Error importi=
ng OE modules: %s" % str(e))
> >=20
>=20
>=20
> Hi,
>=20
> a while ago I've mentioned that after making syntax error in metadata
> I got no output at all from bitbake.
>=20
> I've narrowed it down to this chunk and the issue is that my syntax
> error was in qa.py and it was failing in:
> bb.utils._context[self.namespace] =3D __import__(self.namespace + "." +
> i)

Was there a traceback in bitbake-cookerdeamon.log for this before your
patch?

Cheers,

Richard

