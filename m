Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40329EDEC6B
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 14:43:09 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.354.1694616181110235398
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 07:43:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FVPBiMJw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-31fa666000dso3404694f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694616179; x=1695220979; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tq4hIbAoWYqGzNob77SogkKuPKGaU0bsSh2h39om67s=;
        b=FVPBiMJwv5wozOzGMHyEpqlt10Gi48FbAqGmf3Qux7GiOox7K4I60BM87lxpoymVP7
         lzqaXqx1kxLYMAaL6cY4hfus+Sx93+VzXdjKZzQDWaWv+1h0IvL1u/qCO0nF1a7tEI52
         47KZWKTIzBnuj5UR/TSUBmnxKbvw78I9Sel74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694616179; x=1695220979;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tq4hIbAoWYqGzNob77SogkKuPKGaU0bsSh2h39om67s=;
        b=XC4VWa2L0Qm2QKv7Y+tvyKJTiQZ5ZCuLQlaks7XVRcH36vfPvnwQuIiMwGP4k8MF5k
         twi+adg5glZpys9EiJBSGCRmys5/JGazDrwSF7votOpqxvk2OVS4b+xo7tbP37cgVTbJ
         Mr/2OB+tKmfWWlFf3biFLb8jgbrnFRynQePsXtXFr0L/47UZBON5TX/l/qEupmvkYHWK
         HsT5/iTMvkTqRK8lMrgJc2P6ouYOAprHtc6vbZnGFM66lBtgdXDX5Gx5bZMCKBQbDIbj
         y6inhTi1QgKKHVk/5kgsJ9GOEYtZsep9tLD4pPEODYXp6Dxm1rcsPWidIoRYffZyB6vr
         lYGQ==
X-Gm-Message-State: AOJu0YwBgVJGQqHSS3GC0yA5ek4iNzeFFD2M35JRKGQu/SwnQETD3I73
	IqgbL1PC2cAIkMsNpsY1+yGd+g==
X-Google-Smtp-Source: AGHT+IGZS6cYnrLxSAMx4O2ElryMXODvIy1kyN/PxFbAhkNuV9wbboWumXaLZOKEfTMD9Ym8t2JEpw==
X-Received: by 2002:adf:ee07:0:b0:31a:e972:3601 with SMTP id y7-20020adfee07000000b0031ae9723601mr2266031wrn.54.1694616179478;
        Wed, 13 Sep 2023 07:42:59 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2a8:4888:9029:4207? ([2001:8b0:aba:5f3c:2a8:4888:9029:4207])
        by smtp.gmail.com with ESMTPSA id y17-20020adff151000000b0031c5dda3aedsm15787572wro.95.2023.09.13.07.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 07:42:59 -0700 (PDT)
Message-ID: <bda639e462aa9f7bfd4a04e17d953e23b99ca2b0.camel@linuxfoundation.org>
Subject: Re: initial idea for hooks needed for source tracing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alberto Pianon <alberto@pianon.eu>
Cc: Bitbake Devel <bitbake-devel@lists.openembedded.org>, 'Carlo Piana'
	 <carlo@piana.eu>, Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 13 Sep 2023 15:42:58 +0100
In-Reply-To: <517df01859172566e88a239658c601be@pianon.eu>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
	 <fa1abc9099171f8fb26c60fd29bc4dfd15376f8a.camel@linuxfoundation.org>
	 <517df01859172566e88a239658c601be@pianon.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 14:43:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15050

On Wed, 2023-09-13 at 16:32 +0200, Alberto Pianon wrote:
> On 2023-09-13 14:12, Richard Purdie wrote:
> > On Tue, 2023-09-12 at 22:55 +0200, Alberto Pianon wrote:
> > > as I said at today's meeting there is no hurry, but right after the
> > > meeting I had an idea and I wanted to fix it in my mind and test it
> > > before losing it :)
> > >=20
> > > It's just a temporary/WIP patch, but it should not be too far from a
> > > working implementation of the hooks we were talking about:
> > >=20
> > > http://cgit.openembedded.org/bitbake-contrib/commit/?h=3Dalpianon/src=
trace4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8
> > >=20
> > > There is no interference nor modification to the unpack process any
> > > more, just collection of needed metadata through the urldata object.
> > > Modifications to the core unpack function are minimal and (I hope!)
> > > straightforward, and there is no fetcher-specific logic in it ant=20
> > > more.
> > >=20
> > > When you find some time, could you please have a look and tell me if
> > > this may be the right direction?
> >=20
> > I think what we should do for now is something like the code below,
> > basically to instrument the unpack process but not change it's code.
> >=20
>=20
> I thought I had to avoid putting unpack tracing methods in individual
> fetchers so I moved them in the core unpack method, but of course
> it would be much better to put them into fetchers' code in the "right"
> place (i.e. where the unpack actually happens). That would simplify
> the logic needed on the backend side, too.

I think we can do something as long as they're generic calls to a
"proper" tracer API rather than backend specific ones.

> I had tried a similar solution at the beginning; your proposal is much
> cleaner though, I'll try to follow it and come back to you.
>=20
> >=20
> > This leaves all the "messy" state engine pieces you need to your own
> > backend where you can develop them as needed.
> >=20
> > Obviously you'd need to implement something to swap unpack_tracer to
> > your own module but that shouldn't be too difficult to do. I don't
> > really like globals but for this particular situation, it is probably
> > inevitable. I am limiting the use of the global to __init__.py
> > deliberately.
> >=20
> > I only converted crate.py as an example but I think this approach
> > should work for the other modules too.
>=20
> gitsm and npmsw are the tricky ones, so let's start with them :)
> I will try to implement the same approach there and then ask you
> to quickly review it, but I have some questions, see inline in your
> patch below
>=20
> >=20
> > Some general thoughts on various things:
> >=20
> > * destdir is a problematic name to have in the urldata object as it is
> > easily confused with a concept used in do_install tasks. "unpackdir"
> > would have been more accurate and less confusing. Obviously it could
> > easily be renamed in your patches and it is following naming within the
> > fetchers but I think it is better to use a clearer name. Something to
> > keep in mind in the tracing code in general.
>=20
> I reckon I chose destdir just because it was already used in git and
> gitsm fectchers, so I added it also to the other fetchers, but actually
> it may be confusing, so I will switch to "unpackdir", which is
> straightforward
>=20
> >=20
> > * I don't like the parameters that were being added to unpack()
> > (checkout_destdir and is_module) as their meaning is unclear and appear
> > fetcher module specific. The intention of a generic "tracer" module
> > pointer is clear.
> >=20
> > * As we discussed, the unpack to a temp location and move into position
> > seemed like a good idea but the implementation is too complex
> > unfortunately. Sorry to point in the wrong direction on that one.
>=20
> If we didn't try it, we would never know :)
>=20
> >=20
> > * Adding any kind of unpackdir derived directory to urldata in general
> > seems like it is a bad idea as it is only valid for the life of the
> > unpack() call. When I suggested poking into ud, I had something like
> > the patch below in mind where we can use it to help the tracing without
> > adding more parameters, instead using function calls.
> >=20
>=20
> OK, I just have one doubt about how to handle that in gitsm and npmsw,
> that internallly create new Fetch and FetchData (urldata) instances to
> recursively call the core unpack method. See inline in your patch below
>=20
> > * Ultimately we may need to have some basic tracer by default, mainly
> > to get a idea of the end result of the fetching. I remain unconvinced
> > we need to map every file back to a specific entry in SRC_URI though.
> >=20
> > * Ideally the "unpack_type" parameter to DummyUnpackTracer might not be
> > needed, or becomes optional.
> >=20
> >=20
> > Cheers,
> >=20
> > Richard
> >=20
> >=20
> > diff --git a/bitbake/lib/bb/fetch2/__init__.py=20
> > b/bitbake/lib/bb/fetch2/__init__.py
> > index 0ead303ca16..2b8de4da10b 100644
> > --- a/bitbake/lib/bb/fetch2/__init__.py
> > +++ b/bitbake/lib/bb/fetch2/__init__.py
> > @@ -139,6 +139,25 @@ class MissingChecksumEvent(bb.event.Event):
> >          self.checksums =3D checksums
> >          bb.event.Event.__init__(self)
> >=20
> > +class DummyUnpackTracer(object):
> > +
> > +    def start(self, unpackdir, urldata, d):
> > +        return
> > +
> > +    def start_url(self, url):
> > +        return
> > +
> > +    def unpack(self, unpack_type, destdir):
> > +        return
> > +
> > +    def finish_url(self, url):
> > +        return
> > +
> > +    def complete(self):
> > +        return
> > +
> > +unpack_tracer =3D DummyUnpackTracer()
> > +
> >=20
> >  class URI(object):
> >      """
> > @@ -1591,6 +1610,8 @@ class FetchMethod(object):
> >                      if urlpath.find("/") !=3D -1:
> >                          destdir =3D urlpath.rsplit("/", 1)[0] + '/'
> >                          bb.utils.mkdirhier("%s/%s" % (unpackdir,=20
> > destdir))
> > +
> > +                ud.unpack_tracer.unpack("extract", destdir)
> >                  cmd =3D 'cp -fpPRH "%s" "%s"' % (file, destdir)
> >=20
> >          if not cmd:
> > @@ -1707,6 +1728,7 @@ class Fetch(object):
> >              if url not in self.ud:
> >                  try:
> >                      self.ud[url] =3D FetchData(url, d, localonly)
> > +                    self.ud.unpack_tracer =3D unpack_tracer
>=20
> maybe you mean this? Or am I getting it wrong?
>=20
>                         self.ud[url].unpack_tracer =3D unpack_tracer

I do indeed mean that :)

> In any case, Gitsm and npmsw fetchers create internal Fecth and
> FetchData (urldata) objects to unpack (sub)modules by recursively
> calling the core unpack method, so the unpack_tracer object needs to be
> passed through in some way... Did you already think about a clean way
> to handle that?

Python passes by reference so they should all see the same
unpack_tracer object. This means if you see a new urldata within the
tracer code, you know you're now working on a new url.

You will have to have some kind of state inside the tracer to handle it
but I think you should be able to make something work?

> I'm also concerned about npmsw modules, because it may (and it does)
> happen that the same module, unpacked from the same url, may get
> unpacked more than once into different locations in the same root dir,
> because of the way npm works (...). Probably start_url and final_url
> methods should take also unpackdir as an argument, what do you think?

I think if you have the right tracking inside the tracer, you shouldn't
need those extra arguments. I'm not 100% sure on that but I'd at least
see what is possible first.

Cheers,

Richard

