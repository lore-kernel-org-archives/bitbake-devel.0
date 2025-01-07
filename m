Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8E0E77197
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 11:01:17 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.17934.1736247670501193396
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 03:01:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gWDainoC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso156063725e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 03:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736247669; x=1736852469; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gKuk5JDws+iXGNFlaS37te8wvgCaClwdqgcsN1FwY0E=;
        b=gWDainoCuELWG6l/sauxXC9LgzrMEJOY67PcBGwFRFl+ph6lPvYG7t4sY+8obi+2pC
         MAsucLE2q8rDx9VvMWjB1FYJ8z0bZjfiBzF4CyJX8VM8Zkelf83Z3Up5pRVINCgZz1CE
         vZ2HmIUklQJW3oQeRDWs0xROCPDMg2lI7e2jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736247669; x=1736852469;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKuk5JDws+iXGNFlaS37te8wvgCaClwdqgcsN1FwY0E=;
        b=ah3uYHUp+UsgppxlkI4XwSl6NSUMxNMW4YTBGLKMzSbVi80XPp/OuN4nn5BgsRxkkj
         lR7lClGd1UDRTSuef9V/30L7z/13Ftp9A9zydPNK2gGjEJeO57oND/RIy0Qjq2q8zTbF
         FLJ3JEdlgnq0QNi7M51zMqYNPs/1UaJYpAjjJcEAs4hkXKsk+cKLZDBTfrYYsZxqhIaF
         7PXUNJm3ytaT7PTMUNbDlXWGPELahP21Rsg0OcSFsZco9eaQiWZUGFtq4jR96uYSwKpn
         tjI0ONCxl0SfF00XzazshIq3GstNuOmMGZUdKWkNYNoOoqRDLTLkkOfSjlTRBYf4kG0Q
         OEsA==
X-Forwarded-Encrypted: i=1; AJvYcCUMoTNMdaL8zxR3tQIIskF+boN6OuILvfmVgUqxqB6yuRjvkY0uZtDLuI5imhQaFUVk6hPhuKhopnMjdQIr@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywscr5IZU9f0u8LHki9+BzkKD5TjKe9IYFk7J0q3wGthUvsPDPO
	e/0gtJkvyNva4u2ItfxU76Bp/a4THZ+5hkqzOM1sD0eNVqsR7cJqkMLQW/1sHwc=
X-Gm-Gg: ASbGnctkXlGMOWLHCeDzjYw8+IvranHIUiDS7ULKWQK23ptsMhCk7MvVuq2j/kQ7EHU
	zxvAf4cDFE/CqpnEubr2x0qf1GrflApQn6n1uTc2X+hTLpYtlWItwPt8uVZ+Ylqcn4UD0R2cdmu
	URCCezKCY1J3AALkfx4WOApNfX1BTe9XqMdl3ERSZbI+N4r87q2sIEpisxJAx6bkWINhwq3KN5b
	ZjpKji0MeS1ub9EeLN5XY6mO52MpHZfsRQ2/RobK7nhMVxWXlmA/JvXb4a2Fhst5s6ax/sTLX5l
	84s9vmLkW+ty9BQDoxCHQindLAAYtCyP7PDdQ8nVJSl1vg==
X-Google-Smtp-Source: AGHT+IGez1BhOT4JHuuk4wAmFg67TGDdw3nSjcQWxC3/mZYwWGyS4siNDwA8VXn8PWux1r4dZOKJSg==
X-Received: by 2002:a05:600c:1986:b0:434:edcf:7461 with SMTP id 5b1f17b1804b1-43668b78823mr539028375e9.30.1736247668442;
        Tue, 07 Jan 2025 03:01:08 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:a621:21b2:eb2a:5bdb? ([2001:8b0:aba:5f3c:a621:21b2:eb2a:5bdb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b0145csm629517345e9.15.2025.01.07.03.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:01:07 -0800 (PST)
Message-ID: <bcd35f1d1c60c1d96f9dac36b0284186e57b598c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Tue, 07 Jan 2025 11:01:06 +0000
In-Reply-To: <2a8d0393-800c-40b3-86fb-a5ab5e6f52f9@weidmueller.com>
References: 
	<20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org>
	 <578ed107-1a04-48db-ac2e-1dc9cdab60d0@weidmueller.com>
	 <84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org>
	 <2a8d0393-800c-40b3-86fb-a5ab5e6f52f9@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 11:01:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16977

On Tue, 2025-01-07 at 10:47 +0100, Stefan Herbrechtsmeier wrote:
> Am 06.01.2025 um 16:30 schrieb Richard Purdie:
> > On Mon, 2025-01-06 at 15:35 +0100, Stefan Herbrechtsmeier wrote:
> > > > =C2=A0I'm a little bit worried about how easily you could sneak a
> > > > "floating" version into this and make the fetcher non-
> > > > deterministic. Does (or could?) the code detect and error on
> > > > that?=C2=A0
> > > > =C2=A0=C2=A0
> > > We could raise an error if a checksum is missing in the
> > > dependency specification file or make the checksum mandatory for
> > > the dependency fetcher.=C2=A0 Furthermore we could inspect the
> > > dependency URLs to detect a misuse of the file like a latest
> > > string for the version.
> > > =C2=A0
> >=20
> > I think adding such an error would be a requirement for merging
> > this.
> > =C2=A0=C2=A0
> Should the dependency fetcher (ex. npmsw) or the language specific
> fetcher (ex. npm) fail if the version points to a latest version?

I think right now it has to error to try and reduce complexity. It is
possible to support such things but you have to pass that version
information back up the stack so that PV represents the different
versions and that is a new level of complexity.

I guess we should consider how you could theoretically support it as
that might influence the design. With multiple git repos in SRC_URI for
example, we end up adding multiple shortened shas to construct a PV so
that if any change, PV changes. We also have to add an incrementing
integer so that on opkg/dpkg/rpm operations work and versions sort.

> > > > Put another way, could one of these SRC_URIs map to multiple
> > > > different combinations of underlying component versions?
> > >=20
> > > If you mean the extracted SRC_URI for a single dependency from
> > > the dependency specification file (ex. npm-shrinkwrap.json) it
> > > could use special URLs to map to the latest version. But this is
> > > a missus of the dependency specification file and could be
> > > detected. The tools generate files with fixed versions always
> > > because a floating version with a fixed checksum make no senses.=C2=
=A0
> >=20
> > Even if it shouldn't happen, we need to detect and error for this
> > case as it would become very problematic for us.
> >=20
> Okay. Should we disallow a dynamic version for package manager
> downloads generally or do you see a reasonable use case?

See above.

> > >=20
> > > =C2=A0I also thought it would make sense to generate recipes from the
> > > dependency specification files and therefore worked on the
> > > recipetool
> > > previous. But it looks like the tool isn't really used and I'm
> > > afraid
> > > nobody will use the recipe to fix dependencies. In most cases it
> > > is
> > > easy to update a dependency in the native tooling and only
> > > provide an
> > > updated dependency specification file.
> > > =C2=A0
> > =C2=A0
> > I think people have wanted a single simple command to translate the
> > specification file into our recipe format to update the recipe. For
> > various reasons people didn't seem to find the recipetool approach
> > was working and created the task workflow based one. There are pros
> > and cons to both and I don't have a strong preference. I would like
> > to see something which makes it clear to users what is going on
> > though and is simple to use.
> >=20
> > People do intuitively understand a .inc file with a list of urls in
> > it. There are challenges in updating it.
> >=20
> > This other approach is not as intuitive as everything is abstracted
> > out of sight.
> >=20
> > One thing for example which worries me is how are the license
> > fields in the recipe going to be updated?
> >=20
> > Currently, if we teach the class, it can set LICENSE variables
> > appropriately. With the new approach, you don't know the licenses
> > until
> > after unpack has run. Yes it can write it into the SPDX, but it
> > won't
> > work for something like the layer index or forms of analysis which
> > don't build things.
> >=20
> > This does also extend to vulnerability analysis since we can't know
> > what is in a given recipe without actually unpacking it. For
> > example we
> > could know crate XXX at version YYY has a CVE but we can't tell if
> > a
> > recipe uses that crate until after do_unpack, or at least not
> > without
> > expandurl.
> > =C2=A0
> =C2=A0
> The main question is if the meta data should contain all information.
> If yes, we shouldn't allow any fetcher which requires an external
> source. This should include the gitsm fetcher and we should replace
> the single SRC_URI with multiple git SRC_URIs.


If we had tooling that supported that well we could certainly consider
it. It isn't straight forward as you can have a git repo containing
submodules which then themselves contain submodules which can then
contain more levels of submodules. There are therefore multiple levels
of expansion possible.

> We can go even further and forbid specific package manager fetchers
> and use plain https or git SRC_URIs. The python and go-vendor fetcher
> use this approach.
> =C2=A0
> =C2=A0Alternative we allow dependency fetchers and require that the meta
> data be always used via bitbake. In this case we could extend the
> meta data via the fetcher.
> =C2=A0
> =C2=A0In both cases it is possible to produce the same meta data. It
> doesn't matter if we use recipetool, devtool, bbclasses or fetcher.
> In any case we could resolve the SRC_URIs, checksums or srcrev from a
> file. The license information could be fetched from the package
> repositories without integrity checks or could be extracted from the
> individual package description file inside the downloaded sources
> (ex. npm). We should skip the license detection from license files
> for now because they generate manual work and could be discuses
> later.

That was the reason the current task based approach doesn't use them,
yet! I mention it just to highlight that it can be solved either way,
the approach doesn't really change what we need to do. The bigger
concern is having information available in the metadata which I think
we need do to some level regardless of which approach we choose.

> The recipe approach has the advantage that it uses fixed licenses and
> that license changes could be (theoretical) reviewed during recipe
> update.=C2=A0

FWIW that is an important use case and one of our general strengths. We
can only do that as the license information is written in recipes and
can be compared at update time.

> In contrast the fetcher approach reduces the update procedure to a
> simple file rename or SRCREV update (ex. gitsm). Furthermore, the
> user could simply place a file beside the recipe to update the
> dependencies. Could we realize the same via devtool integration and a
> patch?

This is effectively what the task based approach is aiming for
currently. I think the idea was that we could have devtool/recipetool
integration around that update task, a task was just a convenient way
to capture the code to do it and get things working without needing the
tool to be finished.


> =C2=A0We have different solutions between the languages (ex. npmsw vs
> crate vs pypi) and even inside the languages (ex. go-vendor vs
> gomod). I would like to unify the dependency support. It doesn't
> matter if we decide to use the bitbake fetcher or a bitbake / devtool
> command for the dependency and license resolution.

I do very much prefer having one good way of doing things rather than
multiple ways of doing things, each with a potential drawback. I'm
therefore broadly in favour of doing that as long as we don't upset too
much existing mindshare along the way.


> > > =C2=A0
> > > =C2=A0I have a WIP to integrate the the dependencies into the spdx .
> > > This
> > > uses the expanded_urldata / implicit_urldata function to add the
> > > dependencies to the process list of archiver and spdx.
> > > =C2=A0
> > > https://github.com/weidmueller/poky/tree/feature/dependency-
> > > fetcher
> > >=20
> > > Regarding the license we could migrate the functionality from
> > > recipetool into a class and detect the licenses at build time.
> > > Theoretically the fetcher could fetch the license from the
> > > package
> > > manager repository but we have to trust the repository because we
> > > have no checksum to detect changes. Maybe we could integrate
> > > tools
> > > like Syft or ScanCode to detect the licenses at build time. At
> > > the
> > > moment the best solution is to make sure that the SBOM contains
> > > the
> > > name and version of the dependencies and let other tools handle
> > > the
> > > license via SBOM for now. Therefore I propose a common scheme to
> > > define the dependency name (dn) and version (dv) in the SRC_URI.
> > > =C2=A0
> > =C2=A0
> > We could compare what licenses the package manager is showing us
> > with
> > what is in the recipe and error if different. There would then need
> > to
> > be a command to update the licenses in the recipe (in much the way
> > urls
> > currently get updated).
> > =C2=A0
> =C2=A0
> Either we request the licenses from the package manager during
> package update or during fetch. I wouldn't do both. Instead I would
> analyze the the license file during build and compare the detected
> license with the recipe or fetcher generated licenses. But the
> license detection from files is an other topic and I would like to
> postpone it for now.

Agreed, I mention it just to highlight that supporting them does have
impact on the design so any solution needs to ultimately be able to
support it.

> > > > You're using DL_DIR for that which I
> > > > suspect isn't a great idea for tmp files.
> > >=20
> > > =C2=A0Take over from gitsm.
> >=20
> > Probably not the best fetcher and I'd say gitsm should be fixed.
>
> I don't see a reason why the gitsm fetcher shouldn't handled like the
> other dependency fetcher. We could update the handler after we have a
> decision for the dependency fetchers.


In principle perhaps but as mentioned above, gitsm has its own challenges.

> > > > The url scheme is clever but also has a potential risk in that you
> > > > can't really pass parameters to both the top level fetcher and the
> > > > underlying one. I'm worried that is going to bite us further down
> > > > the
> > > > line.
> > >=20
> > > At the moment I don't see a real problem but maybe you are right. The
> > > existing language specific fetcher use fixed paths for there
> > > downloads.
> > > =C2=A0
> > > =C2=A0What do you propose? Should the fetcher skip the unpack of the
> > > source or should we introduce a sub fetcher which uses the download
> > > from an other SRC_URI entry. The two entries could be linked via the
> > > name parameter. This approach could be combined with your suggestion
> > > above. The new fetcher will unpack a lock file from an other
> > > (default) download.
> > =C2=A0
> > I'm not really sure what is best right now. I'm trying to spell out the
> > pros/cons of what is going on here in the hope it encourages others to
> > give feedback as well. I agree there isn't a problem right now but I
> > worry there soon will be by mixing two things together like this. The
> > way we handle git protocol does cause us friction with other urls
> > schemes already.
>=20
> The dependency fetcher could simple skip the unpack. In this case the
> user needs to use a variable to pass the same URL to the git and
> dependency fetcher or we could provide a python function to generate
> two SRC_URI with the same base URL.
>=20



I'm starting to wonder about a slightly different approach, basically
an optional generated file alongside a recipe which contains "expanded"
information which is effectively expensive to generate (in computation
or resource like network access/process terms). We could teach bitbake
a new phase of parsing where it generated them if missing. There are
some other pieces of information which we know during the build process
which it would be helpful to know earlier (e.g. which packages a recipe
generates). I've wondered about this for a long time and the fetcher
issues remind me of it again. It would be a big change with advantages
and drawbacks. I think it would put more pressure on a layer maintainer
as they'd have to computationally keep this up to date and it would
complicate the patch workflow (who should send/regen the files?). I'm
putting the idea there, I'm not saying I think we should do it, I'm
just considering options.


> =C2=A0=3D Open questions
> > > > >=20
> > > > > * Where should we download dependencies?
> > > > > ** Should we use a folder per fetcher (ex. git and npm)?
> > > > > ** Should we use the main folder (ex. crate)?
> > > > > ** Should we translate the name into folder (ex. gomod)?
> > > > > ** Should we integrate the name into the filename (ex. git)?
> > > > > =C2=A0
> > > > > =C2=A0
> > > > =C2=A0
> > > > =C2=A0
> > > > DL_DIR is meant to be a complete cache of the source so it would
> > > > need
> > > > to be downloaded there. Given it maps to the other fetchers, the
> > > > existing cache mechanisms likely work for these just fine, the open
> > > > question is on whether the lock/spec files should be cached after
> > > > extraction.
> > > =C2=A0
> > > You misunderstand the question. Its about the downloadfilename
> > > parameter. At the moment some fetcher use sub folder inside DL_DIR
> > > and others use the main folder. It looks like every fetcher has its
> > > own concept to handle file collision between different fetchers. The
> > > git and npm fetcher use there own folder, the crate fetcher use its
> > > own .crate file prefix, the gomod fetcher translate the URL into
> > > multiple folders and the git fetcher translate the URL into a single
> > > folder name.
> >=20
> > That makes more sense. The layout is partially legacy. The wget and
> > local fetchers were first and hence go directly into DL_DIR. git/svn
> > were separated out into their own directories with a plan to have a
> > directory per fetcher. That didn't always work out with each newer
> > fetcher. Each fetcher does have to handle a unique naming of its urls
> > as only the specific fetcher can know all the urls parameters and which
> > ones affect the output vs which ones don't.
> > =C2=A0
> =C2=A0This doesn't explain why the npm but not the gomod and crate fetche=
r
> use a sub folder. All fetchers are based on the wget fetcher.

That is probably "my fault". Put yourself in my position. You get a ton
of different patches, all touching very varied aspects of the system.
When reviewing them you have to try and remember the original design
decisions, the future directions, the ways things broke in the past, a
desire to try and have clean consistent APIs and so on. I have tried
very hard to move things in a direction where things incrementally
improve, without unnecessarily blocking new features. It means that
things that merge often aren't perfect. We've tried a few different
approaches with the newer programming languages and each approach has
had pros and cons. The inconsistency is probably as I missed something
in review. Sorry :(.

I only have finite time. There are few people who seem to want to dive
in and help with review of patches like these. I did ask some people
yesterday, one told me they simply couldn't understand these patches.
I'm doing my best to ask the right questions, try and help others
understand them, ensure my own concerns I can identify are resolved and
I don't want to de-motivate you on this work either, I think the idea
of improving this is great and I'd love to see it. Equally, I'm also
the first person everyone will complain to if we change something and
it causes problems for people.=C2=A0

So the explanation is probably I just missed something in review at
some point. The intent was to separate out the fetcher output going
forward (unless it makes sense to be shared).

FWIW there are multiple things which bother me about the existing
fetcher storage layout but that is a different discussion.

> > > > >=20
> > > > > * Where should we unpack the dependencies?
> > > > > ** Should we use a folder inside the parent folder (ex.
> > > > > node_modules)?
> > > > > ** Should we use a fixed folder inside unpackdir
> > > > > =C2=A0=C2=A0 (ex. go/pkg/mod/cache/download and cargo_home/bitbak=
e)?
> > > > =C2=A0
> > > > This likely depends on the fetcher as the different mechanisms will
> > > > have different expectations about how they should be extracted (as
> > > > npm/etc. would).
> > >=20
> > > =C2=A0
> > > It depends on the fetcher but the fetcher could use the same
> > > approach. At the moment every fetcher use a different approach. The
> > > crate fetcher use a fixed value. The gomod fetcher uses a variable
> > > (GO_MOD_CACHE_DIR) and the npm fetcher uses a parameter (destsuffix).
> > > Furthermore the gomod fetcher override the common subdir parameter.
> >=20
> > I think we really need to standardise that if we can. Each new fetcher
> > has claimed a certain approach is effectively required by the package
> > manager.


> > =C2=A0What would be your desired solution? Is the variable okay or do y=
ou prefer a self contain SRC_URI?

I suspect we need a default via a variable and then the option to
change the default via parameters. The default value should be a
bitbake fetcher namespaced control variable.

I'm wary of making a definitive statement saying X if that isn't going
to make sense for some backend though. I simply don't have enough
knowledge of them all, which is why you see me being reluctant to make
definitive statements about design.

> > > > > * How should we treat archives for package manager caches?
> > > > > ** Should we unpack the archives to support patching (ex. npm)?
> > > > > ** Should we copy the packed archive to avoid unpacking and
> > > > > packaging
> > > > > =C2=A0=C2=A0 (ex. gomod)?
> > > > > =C2=A0
> > > > If there are archives left after do_unpack, which task is going
> > > > to unpack those? Are we expecting the build process in
> > > > configure/compile to decompress them? Would those management
> > > > tools accept things if they were extracted earlier? "unpack"
> > > > would be the correct time to do it but I can see this getting
> > > > into conflict with the package manager :/.
> > > =C2=A0
> > > Most package manager expect archives. In the npm case the archive is
> > > unpack by the fetcher and packed by thenpm.bbclass to support
> > > patching. The gomod fetcher doesn't unpack the downloaded archive and
> > > the gomodgit fetcher create archives from git folders during unpack.
> > > It would be possible to always keep the archives or always extract
> > > the archives and recreate archives during build. It is a decision
> > > between performance and patchability.
> > > =C2=A0
> > > =C2=A0At the moment it is complicated to work with the different fetc=
her
> > > because every fetcher use a different concept and it is unclear what
> > > is the desired approach.
> > =C2=A0
> > This is a challenge. Can we handle the unpacking with the package
> > manager as a specific step or does it have to be combined with other
> > steps like configure/compile?
> > =C2=A0=C2=A0
> It looks like this is possible:
> =C2=A0cargo fetch
> =C2=A0go mod vendor
> =C2=A0npm install
> =C2=A0
> =C2=A0I suspect you're thinking about using the package manager in
> do_unpack to unpack the archives and patch the unpacked archives
> afterwards?

I'm wondering about it, yes. I know we've had challenges with patching
rust modules for example so this isn't a theoretical problem :/.


> > > > I did wonder if patches 1-5 of this series could be merged
> > > > separately too as they look reasonable regardless of the rest
> > > > of the series?=C2=A0
> > > =C2=A0
> > > Sure. Should I resend the patches as separate series?
> >=20
> > Yes please, that would then let us remove the bits we can easily
> > review/sort and focus on this other part.
> > =C2=A0=C2=A0
> Done.

Thanks.

> I will also resend the go h1 checksum commit separate because it
> could be useful for the gomod fetcher.

Yes, I was waiting for a new version of that one with the naming tweaked.

> Should I also move the dn / dv parameter patches to a separate series
> because it could be useful without the dependency fetcher. I could
> add the parameters to the fetchers in a backward compatible way.

I need to think more about that one...

Cheers,

Richard




