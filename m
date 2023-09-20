Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7712C04AA9
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 15:59:03 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.43699.1695225535974103444
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Sep 2023 08:58:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=POkLu7hA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3215f19a13aso2966879f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695225534; x=1695830334; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zRXjJjCQxh9Jlag8IW+bfOGCoObaICD8OsnK+HIyXk4=;
        b=POkLu7hA4tVNWqjNNnVcdRBwmuIVXsmF7wtjISu1RfgB5VbjSg00wbGNgcHUr2D/Lq
         A2N5KvrVD6NWmpqGs534+mO/tHwq4OiH30B1VDiZ2cNwRJ+h3YS99hhSFcjhf2H1s73q
         nw99dirSRULJObiz/rvFx5gLW2VEMyVNnhJU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225534; x=1695830334;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zRXjJjCQxh9Jlag8IW+bfOGCoObaICD8OsnK+HIyXk4=;
        b=ZpztE75NeTUDXJyCD11utfZUhiOeMuIVCUmGdyG6dN0JM43NkobK5+CRifZrSJMkKn
         gtNydPNfZOP9vNsAlRZjre5w/13Y8eBn9oPfJmqNgRvCngHZ2EP2rbU1zpnZuz4QZ9SF
         6pKCRmwJoDvgddDcuqkXf9nyhHKU8wWS3743X1/TMvsH2p3PoTgt3mKDM64i4QVQh/Nl
         jhoszr73IELa0uWUKEQain1aN1rZ2nWNB2vu0IkLwKgxjN7Fy6nQ3loHSoQtxhXDuq0E
         jM3RVGvR0BpJuET0R34BrumrPnaxtYwuRvOvYSbube8qzB6n3PBolC+18ifprAy1v7OG
         nM7Q==
X-Gm-Message-State: AOJu0Yww2XVt+XbCRsazPzP4+d9c+d10L9bMSN01KX4ZZUww67yBcR0S
	skP+pYnuuuhPXutKqfPZFtN37w==
X-Google-Smtp-Source: AGHT+IHseWScY5zOlUzQ2U0b9KIMTXSE+Pe4AA33MBhQa0s3o8lby1Kq+xzr8/qLYsA+cGCEyn+nZA==
X-Received: by 2002:a5d:4e92:0:b0:321:4790:bb5e with SMTP id e18-20020a5d4e92000000b003214790bb5emr2562479wru.38.1695225534361;
        Wed, 20 Sep 2023 08:58:54 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:34a6:a1c2:97a:851d? ([2001:8b0:aba:5f3c:34a6:a1c2:97a:851d])
        by smtp.gmail.com with ESMTPSA id c3-20020a056000104300b003197869bcd7sm18908328wrx.13.2023.09.20.08.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:58:53 -0700 (PDT)
Message-ID: <8a899d6d88c1d493d48c3a495a9671b13df6a408.camel@linuxfoundation.org>
Subject: Re: initial idea for hooks needed for source tracing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alberto Pianon <alberto@pianon.eu>
Cc: Bitbake Devel <bitbake-devel@lists.openembedded.org>, 'Carlo Piana'
	 <carlo@piana.eu>, Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 20 Sep 2023 16:58:53 +0100
In-Reply-To: <6d0c953729ea7602ee09cc9238513c1b@pianon.eu>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
	 <fa1abc9099171f8fb26c60fd29bc4dfd15376f8a.camel@linuxfoundation.org>
	 <517df01859172566e88a239658c601be@pianon.eu>
	 <bda639e462aa9f7bfd4a04e17d953e23b99ca2b0.camel@linuxfoundation.org>
	 <6d0c953729ea7602ee09cc9238513c1b@pianon.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 15:59:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15091

Hi Alberto,

On Wed, 2023-09-20 at 17:32 +0200, Alberto Pianon wrote:
> I started playing a little bit with a possible implementation handling
> also gitsm and npmsw fetchers, and I came up with the draft below, based
> on your proposal (the draft does not include the implementation, just
> the API).

I'll comment below. Your code was line wrapped so it isn't entirely
pretty but i've tried to clean it up a bit in my reply to make it
readable.

> I'm not sure that all arguments are needed, but this is roughly how the
> API should look alike. Before I go on with the implementation, could you
> please tell me if this time we are on the right track?

I would like to reduce some of the arguments being passed around if we
can.

> Moreover, do you have any idea on how and where we may dynamically load
> the user defined class instead of the dummy one, based on some config
> parameter, like 'TRACER_UNPACKCLASS =3D=3D "mytrace.unpack.UnpackTracer"?

I don't have anything offhand, I'd have to experiment with some code to
come up with something. I can try and find some time to do so but that
problem is definitely one we can solve as we do this elsewhere.


> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 765aedd5..a8b44a4f 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -140,6 +140,35 @@ class MissingChecksumEvent(bb.event.Event):
>           bb.event.Event.__init__(self)
>=20
>=20
> +class DummyUnpackTracer(object):
> +
> +    def start(self, unpackdir, ud_dict, d):
> +        return
> +
> +    def start_url(self, url):
> +        return
> +
> +    def unpack(self, unpack_type, destdir, ud=3DNone):
> +        return
> +
> +    def finish_url(self, url):
> +        return
> +
> +    def start_module(self, module_type, unpackdir, ud_dict, parent_ud, d=
):
> +        return
> +
> +    def module(self, module_type, url, name, path, revision=3DNone):
> +        return
> +
> +    def finish_module(self, module_type, unpackdir, ud_dict, parent_ud, =
d):
> +        return
> +
> +    def complete(self):
> +        return
> +
> +unpack_tracer =3D DummyUnpackTracer()
> +
> +
>   class URI(object):
>       """
>       A class representing a generic URI, with methods for
> @@ -1578,6 +1607,7 @@ class FetchMethod(object):
>               unpackdir =3D rootdir
>=20
>           if not unpack or not cmd:
> +            urldata.unpack_tracer.unpack("file-copy", unpackdir)
>               # If file =3D=3D dest, then avoid any copies, as we already=
 put the file into dest!
>               dest =3D os.path.join(unpackdir, os.path.basename(file))
>               if file !=3D dest and not (os.path.exists(dest) and os.path=
.samefile(file, dest)):
> @@ -1591,8 +1621,13 @@ class FetchMethod(object):
>                       if urlpath.find("/") !=3D -1:
>                           destdir =3D urlpath.rsplit("/", 1)[0] + '/'
>                           bb.utils.mkdirhier("%s/%s" % (unpackdir, destdi=
r))
> +                        urldata.unpack_tracer.unpack(
> +                            "file-copy", "%s/%s" % (unpackdir, destdir))

I'm not too happy about having two different "file-copy" callbacks with
different return values. Either you need the two endpoints or the
initial one but do you really need both?

>                   cmd =3D 'cp -fpPRH "%s" "%s"' % (file, destdir)
>=20
> +        else:
> +            urldata.unpack_tracer.unpack("archive-extract", unpackdir)
> +
>           if not cmd:
>               return
>=20
> @@ -1707,6 +1742,7 @@ class Fetch(object):
>               if url not in self.ud:
>                   try:
>                       self.ud[url] =3D FetchData(url, d, localonly)
> +                    self.ud[url].unpack_tracer =3D unpack_tracer
>                   except NonLocalMethod:
>                       if localonly:
>                           self.ud[url] =3D None
> @@ -1882,6 +1918,8 @@ class Fetch(object):
>           if not urls:
>               urls =3D self.urls
>=20
> +        unpack_tracer.start(root, self.ud, self.d)
> +
>           for u in urls:
>               ud =3D self.ud[u]
>               ud.setup_localpath(self.d)
> @@ -1889,11 +1927,15 @@ class Fetch(object):
>               if ud.lockfile:
>                   lf =3D bb.utils.lockfile(ud.lockfile)
>=20
> +            unpack_tracer.start_url(u)
>               ud.method.unpack(ud, root, self.d)
> +            unpack_tracer.finish_url(u)
>=20
>               if ud.lockfile:
>                   bb.utils.unlockfile(lf)
>=20
> +        unpack_tracer.complete()
> +
>       def clean(self, urls=3DNone):
>           """
>           Clean files that the fetcher gets or places
> diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
> index 3310ed00..01d49435 100644
> --- a/lib/bb/fetch2/crate.py
> +++ b/lib/bb/fetch2/crate.py
> @@ -101,8 +101,10 @@ class Crate(Wget):
>           bp =3D d.getVar('BP')
>           if bp =3D=3D ud.parm.get('name'):
>               cmd =3D "tar -xz --no-same-owner -f %s" % thefile
> +            ud.unpack_tracer.unpack("crate-extract", rootdir)
>           else:
>               cargo_bitbake =3D self._cargo_bitbake_path(rootdir)
> +            ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)
>=20
>               cmd =3D "tar -xz --no-same-owner -f %s -C %s" % (thefile,
> cargo_bitbake)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 4385d0b3..567943da 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -589,6 +589,7 @@ class Git(FetchMethod):
>           destdir =3D ud.destdir =3D os.path.join(destdir, destsuffix)
>           if os.path.exists(destdir):
>               bb.utils.prunedir(destdir)
> +        ud.unpack_tracer.unpack("git", destdir, ud)
>=20
>           need_lfs =3D self._need_lfs(ud)
>=20
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index a87361cc..06dda48b 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -218,7 +218,9 @@ class GitSM(Git):
>=20
>               try:
>                   newfetch =3D Fetch([url], d, cache=3DFalse)
> +                ud.unpack_tracer.start_module("git", repo_conf, newfetch=
.ud, ud, d)
>                   newfetch.unpack(root=3Dos.path.dirname(os.path.join(rep=
o_conf, 'modules', module)))
> +                ud.unpack_tracer.finish_module("git", repo_conf, newfetc=
h.ud, ud, d)

I don't understand the need for this piece since you'd get start/finish
events from the tracer here for the newfetch object?


>               except Exception as e:
>                   logger.error('gitsm: submodule unpack failed: %s %s' % =
(type(e).__name__, str(e)))
>                   raise
> @@ -238,6 +240,8 @@ class GitSM(Git):
>                   logger.error("Unable to set git config core.bare to fal=
se for %s" % os.path.join(repo_conf, 'modules', module))
>                   raise
>=20
> +            ud.unpack_tracer.module("git", url, module, modpath, d.getVa=
r("SRCREV_%s" % module))
> +

Again, you'd get the git unpack events for this?

>           Git.unpack(self, ud, destdir, d)
>=20
>           ret =3D self.process_submodules(ud, ud.destdir,=20
> unpack_submodules, d)
> diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
> index 063e1300..cbff8c49 100644
> --- a/lib/bb/fetch2/hg.py
> +++ b/lib/bb/fetch2/hg.py
> @@ -242,6 +242,7 @@ class Hg(FetchMethod):
>           revflag =3D "-r %s" % ud.revision
>           subdir =3D ud.parm.get("destsuffix", ud.module)
>           codir =3D "%s/%s" % (destdir, subdir)
> +        ud.unpack_tracer.unpack("hg", codir)
>=20
>           scmdata =3D ud.parm.get("scmdata", "")
>           if scmdata !=3D "nokeep":
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index f83485ad..15f3f19b 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -298,6 +298,7 @@ class Npm(FetchMethod):
>           destsuffix =3D ud.parm.get("destsuffix", "npm")
>           destdir =3D os.path.join(rootdir, destsuffix)
>           npm_unpack(ud.localpath, destdir, d)
> +        ud.unpack_tracer.unpack("npm", destdir)
>=20
>       def clean(self, ud, d):
>           """Clean any existing full or partial download"""
> diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
> index 4ff2c8ff..5cab96c4 100644
> --- a/lib/bb/fetch2/npmsw.py
> +++ b/lib/bb/fetch2/npmsw.py
> @@ -192,6 +192,7 @@ class NpmShrinkWrap(FetchMethod):
>                   raise ParameterError("Unsupported dependency: %s" %
> name, ud.url)
>=20
>               ud.deps.append({
> +                "name": name,
>                   "url": url,
>                   "localpath": localpath,
>                   "extrapaths": extrapaths,
> @@ -270,16 +271,27 @@ class NpmShrinkWrap(FetchMethod):
>           destsuffix =3D ud.parm.get("destsuffix")
>           if destsuffix:
>               destdir =3D os.path.join(rootdir, destsuffix)
> +        ud.unpack_tracer.unpack("npmsw", destdir)
>=20
>           bb.utils.mkdirhier(destdir)
>           bb.utils.copyfile(ud.shrinkwrap_file,
>                             os.path.join(destdir, "npm-shrinkwrap.json"))
>=20
> +        for dep in ud.deps:
> +            ud.unpack_tracer.module(
> +                "npm",
> +                dep["url"] or dep["localpath"],
> +                dep["name"],
> +                dep["destsuffix"]
> +            )
> +
>           auto =3D [dep["url"] for dep in ud.deps if not dep["localpath"]=
]
>           manual =3D [dep for dep in ud.deps if dep["localpath"]]
>=20
>           if auto:
> +            ud.unpack_tracer.start_module("npm", destdir, ud.proxy.ud,=
=20
> ud, d)
>               ud.proxy.unpack(destdir, auto)
> +            ud.unpack_tracer.finish_module("npm", destdir, ud.proxy.ud,=
=20
> ud, d)

Don't you get the information from the inner fetch so we no longer need
this markup here?

>=20
>           for dep in manual:
>               depdestdir =3D os.path.join(destdir, dep["destsuffix"])
>=20

It does feel like either you're misunderstanding the intent of why I
suggested some of the higher level intercept calls as they should
reduce the need for the internal module additions, or I'm missing some
key detail of why those outer tracepoints can't handle everything you
need :/.

Cheers,

Richard


