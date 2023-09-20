Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CE9C04FE7
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 18:39:19 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.3656.1695235149206013188
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Sep 2023 11:39:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ShjH08by;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so8683965e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695235147; x=1695839947; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9rifnkw3Q0/SmC8ispe/CuJH9Ojz3BuLCbz12QNRv78=;
        b=ShjH08byQ0pVbUkK8Hn/zkEY+IqB1Yw5useITwyZ0nstp68dAhWtPJT/cnp4VWTXLN
         a9Q8siqeqAw3l6URKImV9POzJwVmIGIWMptXyXvEIE+3v++NoWo6mLE6i9/I35h+WE9P
         o6UMOnEiExaMB0M9ZI8YDxW2hB4QFVQNiCeE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695235147; x=1695839947;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rifnkw3Q0/SmC8ispe/CuJH9Ojz3BuLCbz12QNRv78=;
        b=eWUqjxBiGejajN3c6n5DtTtvT2rU/jOoHtLsms7mLqQRP4YCEAZK9vG6KJ2AxIInHN
         lzAo2qgFAMmaHk/cngKNMMElaGFl/CF8pnPjZbGnvzlYLTu7fA1fXrh3G0KX5V7DY6mj
         GNGtbEvXfGPCAlWUuydeIvcYCWrHXjYGgHYIEOF0/yRjbFoH51/JZb6wSSGSDhTG/MYd
         xNq3lrWWMkecqqJuBSdg5IQTLYuqc8cZ4uMTSeXJ4wHxjWaf28RhPsrN0gir/kvrD94s
         SeBrmELhS6nEsgY478nf+yDdj+6WqYhnbLg5TN6xJiQQGd8SLg5js6Bf+KbvBdRYWIad
         h6xQ==
X-Gm-Message-State: AOJu0YwnZtm8JAbarjouq5/jKJ5PwUrH6qQ27Klw+wTU5HoZ8scvt7T7
	U+bB3yPnYLFbcK8StPZ8LwwR3w==
X-Google-Smtp-Source: AGHT+IHj59cwQI3zxoGXfz1xvybOSQk0FG/+yVb7+d5X3Nt+5vGyFN/8/i1FKBKZ8Y1b50bIJNDmgA==
X-Received: by 2002:a5d:51d0:0:b0:320:6d6:315b with SMTP id n16-20020a5d51d0000000b0032006d6315bmr2770843wrv.29.1695235147571;
        Wed, 20 Sep 2023 11:39:07 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:34a6:a1c2:97a:851d? ([2001:8b0:aba:5f3c:34a6:a1c2:97a:851d])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d65c1000000b00315af025098sm19247472wrw.46.2023.09.20.11.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 11:39:07 -0700 (PDT)
Message-ID: <97ecac758fd3b771e56e32e0a6c095d0900629a3.camel@linuxfoundation.org>
Subject: Re: initial idea for hooks needed for source tracing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alberto Pianon <alberto@pianon.eu>
Cc: Bitbake Devel <bitbake-devel@lists.openembedded.org>, 'Carlo Piana'
	 <carlo@piana.eu>, Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 20 Sep 2023 19:39:06 +0100
In-Reply-To: <15196a1c207f89bfc8894f155b05cbde@pianon.eu>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
	 <fa1abc9099171f8fb26c60fd29bc4dfd15376f8a.camel@linuxfoundation.org>
	 <517df01859172566e88a239658c601be@pianon.eu>
	 <bda639e462aa9f7bfd4a04e17d953e23b99ca2b0.camel@linuxfoundation.org>
	 <6d0c953729ea7602ee09cc9238513c1b@pianon.eu>
	 <8a899d6d88c1d493d48c3a495a9671b13df6a408.camel@linuxfoundation.org>
	 <15196a1c207f89bfc8894f155b05cbde@pianon.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 18:39:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15093

On Wed, 2023-09-20 at 20:10 +0200, Alberto Pianon wrote:
>=20
> On 2023-09-20 17:58, Richard Purdie wrote:
> > On Wed, 2023-09-20 at 17:32 +0200, Alberto Pianon wrote:
> >=20
> > >       """
> > >       A class representing a generic URI, with methods for
> > > @@ -1578,6 +1607,7 @@ class FetchMethod(object):
> > >               unpackdir =3D rootdir
> > >=20
> > >           if not unpack or not cmd:
> > > +            urldata.unpack_tracer.unpack("file-copy", unpackdir)
> > >               # If file =3D=3D dest, then avoid any copies, as we alr=
eady=20
> > > put the file into dest!
> > >               dest =3D os.path.join(unpackdir, os.path.basename(file)=
)
> > >               if file !=3D dest and not (os.path.exists(dest) and=20
> > > os.path.samefile(file, dest)):
> > > @@ -1591,8 +1621,13 @@ class FetchMethod(object):
> > >                       if urlpath.find("/") !=3D -1:
> > >                           destdir =3D urlpath.rsplit("/", 1)[0] + '/'
> > >                           bb.utils.mkdirhier("%s/%s" % (unpackdir,=
=20
> > > destdir))
> > > +                        urldata.unpack_tracer.unpack(
> > > +                            "file-copy", "%s/%s" % (unpackdir,=20
> > > destdir))
> >=20
> > I'm not too happy about having two different "file-copy" callbacks with
> > different return values. Either you need the two endpoints or the
> > initial one but do you really need both?
>=20
> The information that I need here is that a file named, say, 'hello',
> whose url is 'file://examples/hello' and whose path in the corresponding
> upstream repo is something like 'meta/foo/examples/hello', gets
> copied/unpacked into '<workdir>/examples/' ("%s/%s" % (unpackdir,
> destdir)). I may get rid of the second "file-copy" callback above and
> reconstruct the same information ex post, but this would require an
> assumption on how this kind of urls are handled by bitbake. If this
> won't reasonably change in the future, I can assume it and delete the
> callback :)

In that case do you need the first call to make it work? Basically I'm
saying I'd like to see one trace call from this per run, not multiple
calls which the tracer has to then make guesses about. Having two with
the same name therefore concerned me.

>=20
>=20
> >=20
> > >                   cmd =3D 'cp -fpPRH "%s" "%s"' % (file, destdir)
> > >=20
> > > +        else:
> > > +            urldata.unpack_tracer.unpack("archive-extract",=20
> > > unpackdir)
> > > +
> > >           if not cmd:
> > >               return
> > >=20
> > > @@ -1707,6 +1742,7 @@ class Fetch(object):
> > >               if url not in self.ud:
> > >                   try:
> > >                       self.ud[url] =3D FetchData(url, d, localonly)
> > > +                    self.ud[url].unpack_tracer =3D unpack_tracer
> > >                   except NonLocalMethod:
> > >                       if localonly:
> > >                           self.ud[url] =3D None
> > > @@ -1882,6 +1918,8 @@ class Fetch(object):
> > >           if not urls:
> > >               urls =3D self.urls
> > >=20
> > > +        unpack_tracer.start(root, self.ud, self.d)
> > > +
> > >           for u in urls:
> > >               ud =3D self.ud[u]
> > >               ud.setup_localpath(self.d)
> > > @@ -1889,11 +1927,15 @@ class Fetch(object):
> > >               if ud.lockfile:
> > >                   lf =3D bb.utils.lockfile(ud.lockfile)
> > >=20
> > > +            unpack_tracer.start_url(u)
> > >               ud.method.unpack(ud, root, self.d)
> > > +            unpack_tracer.finish_url(u)
> > >=20
> > >               if ud.lockfile:
> > >                   bb.utils.unlockfile(lf)
> > >=20
> > > +        unpack_tracer.complete()
> > > +
> > >       def clean(self, urls=3DNone):
> > >           """
> > >           Clean files that the fetcher gets or places
> > > diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
> > > index 3310ed00..01d49435 100644
> > > --- a/lib/bb/fetch2/crate.py
> > > +++ b/lib/bb/fetch2/crate.py
> > > @@ -101,8 +101,10 @@ class Crate(Wget):
> > >           bp =3D d.getVar('BP')
> > >           if bp =3D=3D ud.parm.get('name'):
> > >               cmd =3D "tar -xz --no-same-owner -f %s" % thefile
> > > +            ud.unpack_tracer.unpack("crate-extract", rootdir)
> > >           else:
> > >               cargo_bitbake =3D self._cargo_bitbake_path(rootdir)
> > > +            ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)
> > >=20
> > >               cmd =3D "tar -xz --no-same-owner -f %s -C %s" % (thefil=
e,
> > > cargo_bitbake)
> > >=20
> > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > > index 4385d0b3..567943da 100644
> > > --- a/lib/bb/fetch2/git.py
> > > +++ b/lib/bb/fetch2/git.py
> > > @@ -589,6 +589,7 @@ class Git(FetchMethod):
> > >           destdir =3D ud.destdir =3D os.path.join(destdir, destsuffix=
)
> > >           if os.path.exists(destdir):
> > >               bb.utils.prunedir(destdir)
> > > +        ud.unpack_tracer.unpack("git", destdir, ud)
> > >=20
> > >           need_lfs =3D self._need_lfs(ud)
> > >=20
> > > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> > > index a87361cc..06dda48b 100644
> > > --- a/lib/bb/fetch2/gitsm.py
> > > +++ b/lib/bb/fetch2/gitsm.py
> > > @@ -218,7 +218,9 @@ class GitSM(Git):
> > >=20
> > >               try:
> > >                   newfetch =3D Fetch([url], d, cache=3DFalse)
> > > +                ud.unpack_tracer.start_module("git", repo_conf,=20
> > > newfetch.ud, ud, d)
> > >                  =20
> > > newfetch.unpack(root=3Dos.path.dirname(os.path.join(repo_conf,=20
> > > 'modules', module)))
> > > +                ud.unpack_tracer.finish_module("git", repo_conf,=20
> > > newfetch.ud, ud, d)
> >=20
> > I don't understand the need for this piece since you'd get start/finish
> > events from the tracer here for the newfetch object?
>=20
> start_module is actually like a 'pre-start' method, aimed at telling the
> "nested" start method that will be invoked inside newfetch.unpack that
> we are processing a submodule and not the main repo (and also at
> calculating the checkout dir for nested git submodules, which is not
> known to gitsm).
> The alternative would be to add parameters to the core unpack method,
> but you don't want that :)
> I don't have other ideas, what do you think about it?


My point is you don't need to do this. The main fetcher has start and
end points. If you see a new "start" point and you're already in the
middle of a "session", you can know that some fetcher has called a
submodule fetch, there is nothing else can have happened. You therefore
don't need to markup all the subfetching.

> As to finish_module. it should aggregate nested submodules data.
> I'm not sure it's strictly needed, though: I have to develop a working
> PoC of the implementation to see if data may be aggregated in another
> place.

I think the parent level "finish" pieces mean this isn't necessary
here.

>=20
> >=20
> >=20
> > >               except Exception as e:
> > >                   logger.error('gitsm: submodule unpack failed: %s %s=
'=20
> > > % (type(e).__name__, str(e)))
> > >                   raise
> > > @@ -238,6 +240,8 @@ class GitSM(Git):
> > >                   logger.error("Unable to set git config core.bare to=
=20
> > > false for %s" % os.path.join(repo_conf, 'modules', module))
> > >                   raise
> > >=20
> > > +            ud.unpack_tracer.module("git", url, module, modpath,=20
> > > d.getVar("SRCREV_%s" % module))
> > > +
> >=20
> > Again, you'd get the git unpack events for this?
>=20
> This method passes git submodule's url, name, relative checkout path and=
=20
> revision to the tracer: where do you suggest to collect the same=20
> information? Should the tracer autonomously parse all .gitmodules files=
=20
> again and use git commands to reconstruct the same information?

No, you shouldn't need to parse those. Isn't this information included
in the ud that is being passed to git unpack in the line immediately
below? That will be seen via the git unpack call the tracer will see?

>=20
> >=20
> > >           Git.unpack(self, ud, destdir, d)
> > >=20
> > >           ret =3D self.process_submodules(ud, ud.destdir,
> > > unpack_submodules, d)
> > > diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
> > > index 063e1300..cbff8c49 100644
> > > --- a/lib/bb/fetch2/hg.py
> > > +++ b/lib/bb/fetch2/hg.py
> > > @@ -242,6 +242,7 @@ class Hg(FetchMethod):
> > >           revflag =3D "-r %s" % ud.revision
> > >           subdir =3D ud.parm.get("destsuffix", ud.module)
> > >           codir =3D "%s/%s" % (destdir, subdir)
> > > +        ud.unpack_tracer.unpack("hg", codir)
> > >=20
> > >           scmdata =3D ud.parm.get("scmdata", "")
> > >           if scmdata !=3D "nokeep":
> > > diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> > > index f83485ad..15f3f19b 100644
> > > --- a/lib/bb/fetch2/npm.py
> > > +++ b/lib/bb/fetch2/npm.py
> > > @@ -298,6 +298,7 @@ class Npm(FetchMethod):
> > >           destsuffix =3D ud.parm.get("destsuffix", "npm")
> > >           destdir =3D os.path.join(rootdir, destsuffix)
> > >           npm_unpack(ud.localpath, destdir, d)
> > > +        ud.unpack_tracer.unpack("npm", destdir)
> > >=20
> > >       def clean(self, ud, d):
> > >           """Clean any existing full or partial download"""
> > > diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
> > > index 4ff2c8ff..5cab96c4 100644
> > > --- a/lib/bb/fetch2/npmsw.py
> > > +++ b/lib/bb/fetch2/npmsw.py
> > > @@ -192,6 +192,7 @@ class NpmShrinkWrap(FetchMethod):
> > >                   raise ParameterError("Unsupported dependency: %s" %
> > > name, ud.url)
> > >=20
> > >               ud.deps.append({
> > > +                "name": name,
> > >                   "url": url,
> > >                   "localpath": localpath,
> > >                   "extrapaths": extrapaths,
> > > @@ -270,16 +271,27 @@ class NpmShrinkWrap(FetchMethod):
> > >           destsuffix =3D ud.parm.get("destsuffix")
> > >           if destsuffix:
> > >               destdir =3D os.path.join(rootdir, destsuffix)
> > > +        ud.unpack_tracer.unpack("npmsw", destdir)
> > >=20
> > >           bb.utils.mkdirhier(destdir)
> > >           bb.utils.copyfile(ud.shrinkwrap_file,
> > >                             os.path.join(destdir,=20
> > > "npm-shrinkwrap.json"))
> > >=20
> > > +        for dep in ud.deps:
> > > +            ud.unpack_tracer.module(
> > > +                "npm",
> > > +                dep["url"] or dep["localpath"],
> > > +                dep["name"],
> > > +                dep["destsuffix"]
> > > +            )
> > > +
> > >           auto =3D [dep["url"] for dep in ud.deps if not=20
> > > dep["localpath"]]
> > >           manual =3D [dep for dep in ud.deps if dep["localpath"]]
> > >=20
> > >           if auto:
> > > +            ud.unpack_tracer.start_module("npm", destdir,=20
> > > ud.proxy.ud,
> > > ud, d)
> > >               ud.proxy.unpack(destdir, auto)
> > > +            ud.unpack_tracer.finish_module("npm", destdir,=20
> > > ud.proxy.ud,
> > > ud, d)
> >=20
> > Don't you get the information from the inner fetch so we no longer need
> > this markup here?
>=20
> How? As in gitsm, 'module' method passes npm module url, name and
> relative destination path to the tracer. Do you suggest that the tracer
> should autonomously parse the npm-shrinkwrap.json file again, to
> get the same information?

In the gitsm case you will see a call into the tracer from the git
unpack method with the information you need. I'd imagine something
similar happen here?

> 'start_module' here is needed for the same reason as in gitsm (avoiding
> adding and is_module parameter to the core unpack method)

I'm pretty sure you don't need this in the gitsm case. I don't know
enough about the npm fetcher to be 100% sure.

>=20
> >=20
> > >=20
> > >           for dep in manual:
> > >               depdestdir =3D os.path.join(destdir, dep["destsuffix"])
> > >=20
> >=20
> > It does feel like either you're misunderstanding the intent of why I
> > suggested some of the higher level intercept calls as they should
> > reduce the need for the internal module additions, or I'm missing some
> > key detail of why those outer tracepoints can't handle everything you
> > need :/.
>=20
> I can reduce internal module additions by externally
> recalculating/re-collecting npm/git module information, even if this=20
> will
> cause the same data/files to be processed twice.
> If you tell me, I'll do that :)
> Do you have any other solution in mind?

I think you can get the data from the ud that gets passed into the
recursive calls. You shouldn't need to parse files, that isn't my
intent. I'm not convinced we need the fetcher specific hooks though,
probably just some basic state tracing in the tracer.

Cheers,

Richard

