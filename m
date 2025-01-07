Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49FBE77199
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 16:58:59 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.25776.1736269131839661786
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 08:58:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZIA4XKJZ;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21669fd5c7cso236243645ad.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 08:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736269131; x=1736873931; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t0QqXDXsik/zT9g5suLqHMeZKw/Jy9Udf3cA7XnBtEk=;
        b=ZIA4XKJZC1ki/J8BMX45Y24ObhAkKyGAPYm+1KAhDwJuiHSr5SdhaOivQale1zm3D1
         bH77C7U8VqJ3uctY01gteCx37XQlAG9N1xUIPJkMJhY7r7/H9ep8CPoqX4weCC6eoIGk
         FDGdb8I6taXYjMQOByRcxySwFdt0GgnjihQij39YBl4KvPq5E1+iDpdCMBvq4chlaXIe
         NUylteXFjyPoJmShIvVl9TYPINbQPqKJgRmOF39rtcwQnLOPDFcSMKYf3mWUnZMwITaj
         Os0+A9AlmY9KyTh6PRcHM7n0dYF1QSSj8E8ZL3m42YUnq60owaU1xhUC4mGqqOEykFZd
         06eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736269131; x=1736873931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0QqXDXsik/zT9g5suLqHMeZKw/Jy9Udf3cA7XnBtEk=;
        b=CgEy4uZrZfcpQ7rS5NaUa8HEhUd31e9NKWTalPv7b0hadVs/xFdXLkVmOVEuKMdlRs
         GDAGYSaFyawIIk1SprkOLUoGkliziTpys445z6pyQnHlACL0HYWCe3qFWAcUtpP/nmrZ
         7OddNpYhxcebnws/rxlcb9FSODWqxkjNuNj6Gri6M16HVgW+Z4tJmKK42wpU833gJ5ic
         vGVB8/RCKcVaDA4BtQE/2tU1Z0YepWvsnjhvNiecJxRLLIGy+yumdLIPD1Rs4nGVBqdf
         wm1e20pWCOJfkoWXnwFaSDSBwr5A5G2SXKns+lfxedp+SFqYzwgtdL9L0DEA0kBQhEDy
         /U6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4QL9O+CaoqfuG7h2r5j96lqmrGSrEgpCND2wCAq+DD6wLjzQuAH0q8u84v55ZI2Ugx83t7c3XSL6O45Zr@lists.openembedded.org
X-Gm-Message-State: AOJu0YypuHAQVfj2gLPjL6PhGYbzVQgmUb4/Nxe3l7SP43dJFeu6qPas
	iFFA/jemwxCZMJqL+f///wbaexCdF73rEM0/kRy19upTLUXG+odhCGhCwRGr9B0q1wo6wPEkxq6
	Q9w4WDZioWTUxP3ntIiq1nipsSlU=
X-Gm-Gg: ASbGncsvIMnAliWIIvaTbi6UzaMh7+1xi0WQG68FzmwB9DfDGI76Jwm5DJaR2cwIrSx
	qyuPqui1/5HkwUsNRx9T2h40Y7h4RQL8LMohWCys=
X-Google-Smtp-Source: AGHT+IEgyzZtSjBV1syugZXdX2EEV5JBuIFkEPGlUP2H01UK4gmrCDxdSnGVHciX9msruv5MEi9SYx2nLBI2YU8Ry+Q=
X-Received: by 2002:a05:6a21:1693:b0:1e0:d89e:f5cc with SMTP id
 adf61e73a8af0-1e5e04605a0mr101489000637.11.1736269130916; Tue, 07 Jan 2025
 08:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org>
 <578ed107-1a04-48db-ac2e-1dc9cdab60d0@weidmueller.com> <84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org>
 <2a8d0393-800c-40b3-86fb-a5ab5e6f52f9@weidmueller.com> <bcd35f1d1c60c1d96f9dac36b0284186e57b598c.camel@linuxfoundation.org>
 <bb35634c-b725-4f6f-a0bb-9b10d43f2c6e@weidmueller.com>
In-Reply-To: <bb35634c-b725-4f6f-a0bb-9b10d43f2c6e@weidmueller.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Tue, 7 Jan 2025 11:58:39 -0500
X-Gm-Features: AbW1kvZt25r-CiMzU67zrTJ31_cWnSV8zM-OyP6MPVFcK30HWGKC9ZD8rWk8mls
Message-ID: <CADkTA4OqeMu9sv2VohLHj3VJ_b96147K6NiGp4gicSb0SrBi1A@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: stefan.herbrechtsmeier-oss@weidmueller.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: multipart/alternative; boundary="000000000000c86a6a062b20a8fa"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 16:58:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16982

--000000000000c86a6a062b20a8fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm going to reply at this point in the thread to at least let everyone
know that I've been reading along, but honestly can't say if a few
questions that I have have been asked (and answered).

The biggest use case that I have for the layers and recipes that I maintain
is about being able to both "easily" patch or update vendor/dependencies of
the main application build.

It was unclear to me how I'd do that with these changes.

For the copied/extracted dependencies, I can see that you'd just be able to
figure out where they were extracted (and I see the discussions on where to
extract/store some of the files) and then write a patch as you would with
any recipe. But would there be a way to patch the dependency "lock file" ?
I definitely don't see a way that I'd be able to tweak a source hash and
have an updated dependency pulled in .. but I could have easily missed that=
.

Those are the primary reasons why I'll stay with explicitly listed /
visible dependencies, unless something similar is available in a re-worked
/ unified fetcher.

I prefer the translation to git, so I have debug source for vendor
dependencies as well as a well travelled path to mirror and archive the
source, but something like the update task of rust is at least explicit and
visible to me, so I can also use it without too many issues.

Bruce


On Tue, Jan 7, 2025 at 11:13=E2=80=AFAM Stefan Herbrechtsmeier via
lists.openembedded.org <stefan.herbrechtsmeier-oss=3D
weidmueller.com@lists.openembedded.org> wrote:

> Am 07.01.2025 um 12:01 schrieb Richard Purdie:
>
> On Tue, 2025-01-07 at 10:47 +0100, Stefan Herbrechtsmeier wrote:
>
> Am 06.01.2025 um 16:30 schrieb Richard Purdie:
>
> On Mon, 2025-01-06 at 15:35 +0100, Stefan Herbrechtsmeier wrote:
>
>  I'm a little bit worried about how easily you could sneak a
> "floating" version into this and make the fetcher non-
> deterministic. Does (or could?) the code detect and error on
> that?
>
>
> We could raise an error if a checksum is missing in the
> dependency specification file or make the checksum mandatory for
> the dependency fetcher.  Furthermore we could inspect the
> dependency URLs to detect a misuse of the file like a latest
> string for the version.
>
>
> I think adding such an error would be a requirement for merging
> this.
>
>
> Should the dependency fetcher (ex. npmsw) or the language specific
> fetcher (ex. npm) fail if the version points to a latest version?
>
> I think right now it has to error to try and reduce complexity. It is
> possible to support such things but you have to pass that version
> information back up the stack so that PV represents the different
> versions and that is a new level of complexity.
>
> I guess we should consider how you could theoretically support it as
> that might influence the design. With multiple git repos in SRC_URI for
> example, we end up adding multiple shortened shas to construct a PV so
> that if any change, PV changes. We also have to add an incrementing
> integer so that on opkg/dpkg/rpm operations work and versions sort.
>
> Okay. In this case we should add the checks to the dependency resolution.
> Thereby we prohibit dynamic versions for the dependencies and allows user=
s
> to add support for it to the fetcher of the package manager.
>
> Put another way, could one of these SRC_URIs map to multiple
> different combinations of underlying component versions?
>
> If you mean the extracted SRC_URI for a single dependency from
> the dependency specification file (ex. npm-shrinkwrap.json) it
> could use special URLs to map to the latest version. But this is
> a missus of the dependency specification file and could be
> detected. The tools generate files with fixed versions always
> because a floating version with a fixed checksum make no senses.
>
> Even if it shouldn't happen, we need to detect and error for this
> case as it would become very problematic for us.
>
>
> Okay. Should we disallow a dynamic version for package manager
> downloads generally or do you see a reasonable use case?
>
> See above.
>
>
>  I also thought it would make sense to generate recipes from the
> dependency specification files and therefore worked on the
> recipetool
> previous. But it looks like the tool isn't really used and I'm
> afraid
> nobody will use the recipe to fix dependencies. In most cases it
> is
> easy to update a dependency in the native tooling and only
> provide an
> updated dependency specification file.
>
>
>
> I think people have wanted a single simple command to translate the
> specification file into our recipe format to update the recipe. For
> various reasons people didn't seem to find the recipetool approach
> was working and created the task workflow based one. There are pros
> and cons to both and I don't have a strong preference. I would like
> to see something which makes it clear to users what is going on
> though and is simple to use.
>
> People do intuitively understand a .inc file with a list of urls in
> it. There are challenges in updating it.
>
> This other approach is not as intuitive as everything is abstracted
> out of sight.
>
> One thing for example which worries me is how are the license
> fields in the recipe going to be updated?
>
> Currently, if we teach the class, it can set LICENSE variables
> appropriately. With the new approach, you don't know the licenses
> until
> after unpack has run. Yes it can write it into the SPDX, but it
> won't
> work for something like the layer index or forms of analysis which
> don't build things.
>
> This does also extend to vulnerability analysis since we can't know
> what is in a given recipe without actually unpacking it. For
> example we
> could know crate XXX at version YYY has a CVE but we can't tell if
> a
> recipe uses that crate until after do_unpack, or at least not
> without
> expandurl.
>
>
>
> The main question is if the meta data should contain all information.
> If yes, we shouldn't allow any fetcher which requires an external
> source. This should include the gitsm fetcher and we should replace
> the single SRC_URI with multiple git SRC_URIs.
>
> If we had tooling that supported that well we could certainly consider
> it. It isn't straight forward as you can have a git repo containing
> submodules which then themselves contain submodules which can then
> contain more levels of submodules. There are therefore multiple levels
> of expansion possible.
>
> Okay. That makes the git submodule special in compare to the other
> dependency fetcher.
>
> We can go even further and forbid specific package manager fetchers
> and use plain https or git SRC_URIs. The python and go-vendor fetcher
> use this approach.
>
>  Alternative we allow dependency fetchers and require that the meta
> data be always used via bitbake. In this case we could extend the
> meta data via the fetcher.
>
>  In both cases it is possible to produce the same meta data. It
> doesn't matter if we use recipetool, devtool, bbclasses or fetcher.
> In any case we could resolve the SRC_URIs, checksums or srcrev from a
> file. The license information could be fetched from the package
> repositories without integrity checks or could be extracted from the
> individual package description file inside the downloaded sources
> (ex. npm). We should skip the license detection from license files
> for now because they generate manual work and could be discuses
> later.
>
> That was the reason the current task based approach doesn't use them,
> yet! I mention it just to highlight that it can be solved either way,
> the approach doesn't really change what we need to do. The bigger
> concern is having information available in the metadata which I think
> we need do to some level regardless of which approach we choose.
>
>
> The recipe approach has the advantage that it uses fixed licenses and
> that license changes could be (theoretical) reviewed during recipe
> update.
>
> FWIW that is an important use case and one of our general strengths. We
> can only do that as the license information is written in recipes and
> can be compared at update time.
>
> Does this apply to the license of the every individual dependency or only
> to the combined license?
>
> In contrast the fetcher approach reduces the update procedure to a
> simple file rename or SRCREV update (ex. gitsm). Furthermore, the
> user could simply place a file beside the recipe to update the
> dependencies. Could we realize the same via devtool integration and a
> patch?
>
> This is effectively what the task based approach is aiming for
> currently. I think the idea was that we could have devtool/recipetool
> integration around that update task, a task was just a convenient way
> to capture the code to do it and get things working without needing the
> tool to be finished.
>
> What is the task based approach? `bitbake -c update xyz`?
>
>  We have different solutions between the languages (ex. npmsw vs
> crate vs pypi) and even inside the languages (ex. go-vendor vs
> gomod). I would like to unify the dependency support. It doesn't
> matter if we decide to use the bitbake fetcher or a bitbake / devtool
> command for the dependency and license resolution.
>
> I do very much prefer having one good way of doing things rather than
> multiple ways of doing things, each with a potential drawback. I'm
> therefore broadly in favour of doing that as long as we don't upset too
> much existing mindshare along the way.
>
> Okay
>
>
>  I have a WIP to integrate the the dependencies into the spdx .
> This
> uses the expanded_urldata / implicit_urldata function to add the
> dependencies to the process list of archiver and spdx.
>  https://github.com/weidmueller/poky/tree/feature/dependency-
> fetcher
>
> Regarding the license we could migrate the functionality from
> recipetool into a class and detect the licenses at build time.
> Theoretically the fetcher could fetch the license from the
> package
> manager repository but we have to trust the repository because we
> have no checksum to detect changes. Maybe we could integrate
> tools
> like Syft or ScanCode to detect the licenses at build time. At
> the
> moment the best solution is to make sure that the SBOM contains
> the
> name and version of the dependencies and let other tools handle
> the
> license via SBOM for now. Therefore I propose a common scheme to
> define the dependency name (dn) and version (dv) in the SRC_URI.
>
>
>
> We could compare what licenses the package manager is showing us
> with
> what is in the recipe and error if different. There would then need
> to
> be a command to update the licenses in the recipe (in much the way
> urls
> currently get updated).
>
>
>
> Either we request the licenses from the package manager during
> package update or during fetch. I wouldn't do both. Instead I would
> analyze the the license file during build and compare the detected
> license with the recipe or fetcher generated licenses. But the
> license detection from files is an other topic and I would like to
> postpone it for now.
>
> Agreed, I mention it just to highlight that supporting them does have
> impact on the design so any solution needs to ultimately be able to
> support it.
>
>
> You're using DL_DIR for that which I
> suspect isn't a great idea for tmp files.
>
>  Take over from gitsm.
>
> Probably not the best fetcher and I'd say gitsm should be fixed.
>
> I don't see a reason why the gitsm fetcher shouldn't handled like the
> other dependency fetcher. We could update the handler after we have a
> decision for the dependency fetchers.
>
> In principle perhaps but as mentioned above, gitsm has its own challenges=
.
>
> Based on your feedback I have the feeling that a dependency fetcher isn't
> the correct solution. The fetcher makes it impossible to review changes
> during recipe update. Additionally it needs caching for the resolved fetc=
h
> and license data.
>
> The alternative is to create an inc file with SRC_URIs, checksums, SRCREV=
s
> and LICENSE. Any recommendation how to integrate the dependency resolutio=
n
> and inc creation into oe-core?
>
> The url scheme is clever but also has a potential risk in that you
> can't really pass parameters to both the top level fetcher and the
> underlying one. I'm worried that is going to bite us further down
> the
> line.
>
> At the moment I don't see a real problem but maybe you are right. The
> existing language specific fetcher use fixed paths for there
> downloads.
>
>  What do you propose? Should the fetcher skip the unpack of the
> source or should we introduce a sub fetcher which uses the download
> from an other SRC_URI entry. The two entries could be linked via the
> name parameter. This approach could be combined with your suggestion
> above. The new fetcher will unpack a lock file from an other
> (default) download.
>
>
> I'm not really sure what is best right now. I'm trying to spell out the
> pros/cons of what is going on here in the hope it encourages others to
> give feedback as well. I agree there isn't a problem right now but I
> worry there soon will be by mixing two things together like this. The
> way we handle git protocol does cause us friction with other urls
> schemes already.
>
> The dependency fetcher could simple skip the unpack. In this case the
> user needs to use a variable to pass the same URL to the git and
> dependency fetcher or we could provide a python function to generate
> two SRC_URI with the same base URL.
>
>
> I'm starting to wonder about a slightly different approach, basically
> an optional generated file alongside a recipe which contains "expanded"
> information which is effectively expensive to generate (in computation
> or resource like network access/process terms). We could teach bitbake
> a new phase of parsing where it generated them if missing. There are
> some other pieces of information which we know during the build process
> which it would be helpful to know earlier (e.g. which packages a recipe
> generates). I've wondered about this for a long time and the fetcher
> issues remind me of it again. It would be a big change with advantages
> and drawbacks. I think it would put more pressure on a layer maintainer
> as they'd have to computationally keep this up to date and it would
> complicate the patch workflow (who should send/regen the files?). I'm
> putting the idea there, I'm not saying I think we should do it, I'm
> just considering options.
>
> Do you mean like a cache or like the inc files? Is the file totally auto
> generated or is manual editing acceptable?
>
>  =3D Open questions
>
> * Where should we download dependencies?
> ** Should we use a folder per fetcher (ex. git and npm)?
> ** Should we use the main folder (ex. crate)?
> ** Should we translate the name into folder (ex. gomod)?
> ** Should we integrate the name into the filename (ex. git)?
>
>
>
>
>
> DL_DIR is meant to be a complete cache of the source so it would
> need
> to be downloaded there. Given it maps to the other fetchers, the
> existing cache mechanisms likely work for these just fine, the open
> question is on whether the lock/spec files should be cached after
> extraction.
>
>
> You misunderstand the question. Its about the downloadfilename
> parameter. At the moment some fetcher use sub folder inside DL_DIR
> and others use the main folder. It looks like every fetcher has its
> own concept to handle file collision between different fetchers. The
> git and npm fetcher use there own folder, the crate fetcher use its
> own .crate file prefix, the gomod fetcher translate the URL into
> multiple folders and the git fetcher translate the URL into a single
> folder name.
>
> That makes more sense. The layout is partially legacy. The wget and
> local fetchers were first and hence go directly into DL_DIR. git/svn
> were separated out into their own directories with a plan to have a
> directory per fetcher. That didn't always work out with each newer
> fetcher. Each fetcher does have to handle a unique naming of its urls
> as only the specific fetcher can know all the urls parameters and which
> ones affect the output vs which ones don't.
>
>
>  This doesn't explain why the npm but not the gomod and crate fetcher
> use a sub folder. All fetchers are based on the wget fetcher.
>
> That is probably "my fault". Put yourself in my position. You get a ton
> of different patches, all touching very varied aspects of the system.
> When reviewing them you have to try and remember the original design
> decisions, the future directions, the ways things broke in the past, a
> desire to try and have clean consistent APIs and so on. I have tried
> very hard to move things in a direction where things incrementally
> improve, without unnecessarily blocking new features. It means that
> things that merge often aren't perfect. We've tried a few different
> approaches with the newer programming languages and each approach has
> had pros and cons. The inconsistency is probably as I missed something
> in review. Sorry :(.
>
> Sorry, I don't want to criticism you. I see that you have a lot of work. =
I
> want to understand the reasons for the actual design and how it should lo=
ok
> like.
>
> I only have finite time. There are few people who seem to want to dive
> in and help with review of patches like these. I did ask some people
> yesterday, one told me they simply couldn't understand these patches.
>
> What can I do to improve the review?
>
> I'm doing my best to ask the right questions, try and help others
> understand them, ensure my own concerns I can identify are resolved and
> I don't want to de-motivate you on this work either, I think the idea
> of improving this is great and I'd love to see it. Equally, I'm also
> the first person everyone will complain to if we change something and
> it causes problems for people.
>
> So the explanation is probably I just missed something in review at
> some point. The intent was to separate out the fetcher output going
> forward (unless it makes sense to be shared).
>
> FWIW there are multiple things which bother me about the existing
> fetcher storage layout but that is a different discussion.
>
> Okay.
>
> * Where should we unpack the dependencies?
> ** Should we use a folder inside the parent folder (ex.
> node_modules)?
> ** Should we use a fixed folder inside unpackdir
>    (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
>
>
> This likely depends on the fetcher as the different mechanisms will
> have different expectations about how they should be extracted (as
> npm/etc. would).
>
>
> It depends on the fetcher but the fetcher could use the same
> approach. At the moment every fetcher use a different approach. The
> crate fetcher use a fixed value. The gomod fetcher uses a variable
> (GO_MOD_CACHE_DIR) and the npm fetcher uses a parameter (destsuffix).
> Furthermore the gomod fetcher override the common subdir parameter.
>
> I think we really need to standardise that if we can. Each new fetcher
> has claimed a certain approach is effectively required by the package
> manager.
>
>  What would be your desired solution? Is the variable okay or do you pref=
er a self contain SRC_URI?
>
> I suspect we need a default via a variable and then the option to
> change the default via parameters. The default value should be a
> bitbake fetcher namespaced control variable.
>
> I'm wary of making a definitive statement saying X if that isn't going
> to make sense for some backend though. I simply don't have enough
> knowledge of them all, which is why you see me being reluctant to make
> definitive statements about design.
>
> Okay.
>
> * How should we treat archives for package manager caches?
> ** Should we unpack the archives to support patching (ex. npm)?
> ** Should we copy the packed archive to avoid unpacking and
> packaging
>    (ex. gomod)?
>
>
> If there are archives left after do_unpack, which task is going
> to unpack those? Are we expecting the build process in
> configure/compile to decompress them? Would those management
> tools accept things if they were extracted earlier? "unpack"
> would be the correct time to do it but I can see this getting
> into conflict with the package manager :/.
>
>
> Most package manager expect archives. In the npm case the archive is
> unpack by the fetcher and packed by thenpm.bbclass to support
> patching. The gomod fetcher doesn't unpack the downloaded archive and
> the gomodgit fetcher create archives from git folders during unpack.
> It would be possible to always keep the archives or always extract
> the archives and recreate archives during build. It is a decision
> between performance and patchability.
>
>  At the moment it is complicated to work with the different fetcher
> because every fetcher use a different concept and it is unclear what
> is the desired approach.
>
>
> This is a challenge. Can we handle the unpacking with the package
> manager as a specific step or does it have to be combined with other
> steps like configure/compile?
>
>
> It looks like this is possible:
>  cargo fetch
>  go mod vendor
>  npm install
>
>  I suspect you're thinking about using the package manager in
> do_unpack to unpack the archives and patch the unpacked archives
> afterwards?
>
> I'm wondering about it, yes. I know we've had challenges with patching
> rust modules for example so this isn't a theoretical problem :/.
>
> It is an interesting idea because most package manager check the integrit=
y
> before unpack. Additionally it should simplify and speed up the npm build
> because it removes the repack of the packages. The problem is that we nee=
d
> an additional task to patch the dependency specification file and to unpa=
ck
> the file.
>
> I did wonder if patches 1-5 of this series could be merged
> separately too as they look reasonable regardless of the rest
> of the series?
>
>
> Sure. Should I resend the patches as separate series?
>
> Yes please, that would then let us remove the bits we can easily
> review/sort and focus on this other part.
>
>
> Done.
>
> Thanks.
>
>
> I will also resend the go h1 checksum commit separate because it
> could be useful for the gomod fetcher.
>
> Yes, I was waiting for a new version of that one with the naming tweaked.
>
> Done.
>
> Should I also move the dn / dv parameter patches to a separate series
> because it could be useful without the dependency fetcher. I could
> add the parameters to the fetchers in a backward compatible way.
>
> I need to think more about that one...
>
> The motivation is to include the dependencies with name, version, license
> and cpe into the SBOM.
>
> Regards
>   Stefan
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16981):
> https://lists.openembedded.org/g/bitbake-devel/message/16981
> Mute This Topic: https://lists.openembedded.org/mt/110212697/1050810
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> bruce.ashfield@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--000000000000c86a6a062b20a8fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi all,</div><div class=3D"gmail_default" style=3D"font-size:=
small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">I&#=
39;m going to reply at this point in the thread to at least let everyone kn=
ow that I&#39;ve been reading along, but honestly can&#39;t say if a few qu=
estions that I have have been asked (and answered).</div><div class=3D"gmai=
l_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default"=
 style=3D"font-size:small">The biggest use case that I have for the layers =
and recipes that I maintain is about being able to both &quot;easily&quot; =
patch or update vendor/dependencies of the main application build.</div><di=
v class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">It was unclear to me how I&#39;d =
do that with these changes.=C2=A0</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">For the copied/extracted dependencies, I can see that you&#39;d =
just be able to figure=C2=A0out where they were extracted (and I see the di=
scussions on where to extract/store some of the files) and then write a pat=
ch as you would with any recipe. But would there be a way to patch the depe=
ndency &quot;lock file&quot; ? I definitely don&#39;t see a way that I&#39;=
d be able to tweak a source hash and have an updated dependency pulled in .=
. but I could have easily missed that.</div><div class=3D"gmail_default" st=
yle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">Those are the primary reasons why I&#39;ll stay with explicit=
ly listed / visible dependencies, unless something similar is available in =
a re-worked / unified fetcher.</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">I prefer the translation to git, so I have=C2=A0debug source for vend=
or dependencies as well as a well travelled path to mirror and archive the =
source, but something like the update task of rust is at least explicit and=
 visible to me, so I can also use it without too many issues.</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmai=
l_default" style=3D"font-size:small">Bruce</div><div class=3D"gmail_default=
" style=3D"font-size:small"><br></div></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 7, =
2025 at 11:13=E2=80=AFAM Stefan Herbrechtsmeier via <a href=3D"http://lists=
.openembedded.org">lists.openembedded.org</a> &lt;stefan.herbrechtsmeier-os=
s=3D<a href=3D"mailto:weidmueller.com@lists.openembedded.org">weidmueller.c=
om@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><u></u>

 =20
  <div>
    <div>Am 07.01.2025 um 12:01 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>On Tue, 2025-01-07 at 10:47 +0100, Stefan Herbrechtsmeier wrote:
</pre>
      <blockquote type=3D"cite">
        <pre>Am 06.01.2025 um 16:30 schrieb Richard Purdie:
</pre>
        <blockquote type=3D"cite">
          <pre>On Mon, 2025-01-06 at 15:35 +0100, Stefan Herbrechtsmeier wr=
ote:
</pre>
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <pre>=C2=A0I&#39;m a little bit worried about how easily you =
could sneak a
&quot;floating&quot; version into this and make the fetcher non-
deterministic. Does (or could?) the code detect and error on
that?=C2=A0
=C2=A0=C2=A0
</pre>
            </blockquote>
            <pre>We could raise an error if a checksum is missing in the
dependency specification file or make the checksum mandatory for
the dependency fetcher.=C2=A0 Furthermore we could inspect the
dependency URLs to detect a misuse of the file like a latest
string for the version.
=C2=A0
</pre>
          </blockquote>
          <pre>I think adding such an error would be a requirement for merg=
ing
this.
=C2=A0=C2=A0
</pre>
        </blockquote>
        <pre>Should the dependency fetcher (ex. npmsw) or the language spec=
ific
fetcher (ex. npm) fail if the version points to a latest version?
</pre>
      </blockquote>
      <pre>I think right now it has to error to try and reduce complexity. =
It is
possible to support such things but you have to pass that version
information back up the stack so that PV represents the different
versions and that is a new level of complexity.

I guess we should consider how you could theoretically support it as
that might influence the design. With multiple git repos in SRC_URI for
example, we end up adding multiple shortened shas to construct a PV so
that if any change, PV changes. We also have to add an incrementing
integer so that on opkg/dpkg/rpm operations work and versions sort.</pre>
    </blockquote>
    <p>Okay. In this case we should add the checks to the dependency
      resolution. Thereby we prohibit dynamic versions for the
      dependencies and allows users to add support for it to the fetcher
      of the package manager.<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <pre>Put another way, could one of these SRC_URIs map to mult=
iple
different combinations of underlying component versions?
</pre>
            </blockquote>
            <pre>If you mean the extracted SRC_URI for a single dependency =
from
the dependency specification file (ex. npm-shrinkwrap.json) it
could use special URLs to map to the latest version. But this is
a missus of the dependency specification file and could be
detected. The tools generate files with fixed versions always
because a floating version with a fixed checksum make no senses.=C2=A0
</pre>
          </blockquote>
          <pre>Even if it shouldn&#39;t happen, we need to detect and error=
 for this
case as it would become very problematic for us.

</pre>
        </blockquote>
        <pre>Okay. Should we disallow a dynamic version for package manager
downloads generally or do you see a reasonable use case?
</pre>
      </blockquote>
      <pre>See above.

</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <pre>=C2=A0I also thought it would make sense to generate recip=
es from the
dependency specification files and therefore worked on the
recipetool
previous. But it looks like the tool isn&#39;t really used and I&#39;m
afraid
nobody will use the recipe to fix dependencies. In most cases it
is
easy to update a dependency in the native tooling and only
provide an
updated dependency specification file.
=C2=A0
</pre>
          </blockquote>
          <pre>=C2=A0
I think people have wanted a single simple command to translate the
specification file into our recipe format to update the recipe. For
various reasons people didn&#39;t seem to find the recipetool approach
was working and created the task workflow based one. There are pros
and cons to both and I don&#39;t have a strong preference. I would like
to see something which makes it clear to users what is going on
though and is simple to use.

People do intuitively understand a .inc file with a list of urls in
it. There are challenges in updating it.

This other approach is not as intuitive as everything is abstracted
out of sight.

One thing for example which worries me is how are the license
fields in the recipe going to be updated?

Currently, if we teach the class, it can set LICENSE variables
appropriately. With the new approach, you don&#39;t know the licenses
until
after unpack has run. Yes it can write it into the SPDX, but it
won&#39;t
work for something like the layer index or forms of analysis which
don&#39;t build things.

This does also extend to vulnerability analysis since we can&#39;t know
what is in a given recipe without actually unpacking it. For
example we
could know crate XXX at version YYY has a CVE but we can&#39;t tell if
a
recipe uses that crate until after do_unpack, or at least not
without
expandurl.
=C2=A0
</pre>
        </blockquote>
        <pre>=C2=A0
The main question is if the meta data should contain all information.
If yes, we shouldn&#39;t allow any fetcher which requires an external
source. This should include the gitsm fetcher and we should replace
the single SRC_URI with multiple git SRC_URIs.
</pre>
      </blockquote>
      <pre>If we had tooling that supported that well we could certainly co=
nsider
it. It isn&#39;t straight forward as you can have a git repo containing
submodules which then themselves contain submodules which can then
contain more levels of submodules. There are therefore multiple levels
of expansion possible.</pre>
    </blockquote>
    <p>Okay. That makes the git submodule special in compare to the
      other dependency fetcher.<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <pre>We can go even further and forbid specific package manager fet=
chers
and use plain https or git SRC_URIs. The python and go-vendor fetcher
use this approach.
=C2=A0
=C2=A0Alternative we allow dependency fetchers and require that the meta
data be always used via bitbake. In this case we could extend the
meta data via the fetcher.
=C2=A0
=C2=A0In both cases it is possible to produce the same meta data. It
doesn&#39;t matter if we use recipetool, devtool, bbclasses or fetcher.
In any case we could resolve the SRC_URIs, checksums or srcrev from a
file. The license information could be fetched from the package
repositories without integrity checks or could be extracted from the
individual package description file inside the downloaded sources
(ex. npm). We should skip the license detection from license files
for now because they generate manual work and could be discuses
later.
</pre>
      </blockquote>
      <pre>That was the reason the current task based approach doesn&#39;t =
use them,
yet! I mention it just to highlight that it can be solved either way,
the approach doesn&#39;t really change what we need to do. The bigger
concern is having information available in the metadata which I think
we need do to some level regardless of which approach we choose.

</pre>
      <blockquote type=3D"cite">
        <pre>The recipe approach has the advantage that it uses fixed licen=
ses and
that license changes could be (theoretical) reviewed during recipe
update.=C2=A0
</pre>
      </blockquote>
      <pre>FWIW that is an important use case and one of our general streng=
ths. We
can only do that as the license information is written in recipes and
can be compared at update time.</pre>
    </blockquote>
    <p>Does this apply to the license of the every individual dependency
      or only to the combined license?<br>
      <br>
      <span style=3D"white-space:pre-wrap">
</span><span style=3D"white-space:pre-wrap">
</span></p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <pre>In contrast the fetcher approach reduces the update procedure =
to a
simple file rename or SRCREV update (ex. gitsm). Furthermore, the
user could simply place a file beside the recipe to update the
dependencies. Could we realize the same via devtool integration and a
patch?
</pre>
      </blockquote>
      <pre>This is effectively what the task based approach is aiming for
currently. I think the idea was that we could have devtool/recipetool
integration around that update task, a task was just a convenient way
to capture the code to do it and get things working without needing the
tool to be finished.</pre>
    </blockquote>
    What is the task based approach? `bitbake -c update xyz`?<br>
    <br>
    <span style=3D"white-space:pre-wrap">
</span>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <pre>=C2=A0We have different solutions between the languages (ex. n=
pmsw vs
crate vs pypi) and even inside the languages (ex. go-vendor vs
gomod). I would like to unify the dependency support. It doesn&#39;t
matter if we decide to use the bitbake fetcher or a bitbake / devtool
command for the dependency and license resolution.
</pre>
      </blockquote>
      <pre>I do very much prefer having one good way of doing things rather=
 than
multiple ways of doing things, each with a potential drawback. I&#39;m
therefore broadly in favour of doing that as long as we don&#39;t upset too
much existing mindshare along the way.</pre>
    </blockquote>
    <p>Okay<br>
      <br>
      <span style=3D"white-space:pre-wrap">
</span></p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <pre>=C2=A0
=C2=A0I have a WIP to integrate the the dependencies into the spdx .
This
uses the expanded_urldata / implicit_urldata function to add the
dependencies to the process list of archiver and spdx.
=C2=A0
<a href=3D"https://github.com/weidmueller/poky/tree/feature/dependency" tar=
get=3D"_blank">https://github.com/weidmueller/poky/tree/feature/dependency<=
/a>-
fetcher

Regarding the license we could migrate the functionality from
recipetool into a class and detect the licenses at build time.
Theoretically the fetcher could fetch the license from the
package
manager repository but we have to trust the repository because we
have no checksum to detect changes. Maybe we could integrate
tools
like Syft or ScanCode to detect the licenses at build time. At
the
moment the best solution is to make sure that the SBOM contains
the
name and version of the dependencies and let other tools handle
the
license via SBOM for now. Therefore I propose a common scheme to
define the dependency name (dn) and version (dv) in the SRC_URI.
=C2=A0
</pre>
          </blockquote>
          <pre>=C2=A0
We could compare what licenses the package manager is showing us
with
what is in the recipe and error if different. There would then need
to
be a command to update the licenses in the recipe (in much the way
urls
currently get updated).
=C2=A0
</pre>
        </blockquote>
        <pre>=C2=A0
Either we request the licenses from the package manager during
package update or during fetch. I wouldn&#39;t do both. Instead I would
analyze the the license file during build and compare the detected
license with the recipe or fetcher generated licenses. But the
license detection from files is an other topic and I would like to
postpone it for now.
</pre>
      </blockquote>
      <pre>Agreed, I mention it just to highlight that supporting them does=
 have
impact on the design so any solution needs to ultimately be able to
support it.

</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <pre>You&#39;re using DL_DIR for that which I
suspect isn&#39;t a great idea for tmp files.
</pre>
            </blockquote>
            <pre>=C2=A0Take over from gitsm.
</pre>
          </blockquote>
          <pre>Probably not the best fetcher and I&#39;d say gitsm should b=
e fixed.
</pre>
        </blockquote>
        <pre>I don&#39;t see a reason why the gitsm fetcher shouldn&#39;t h=
andled like the
other dependency fetcher. We could update the handler after we have a
decision for the dependency fetchers.
</pre>
      </blockquote>
      <pre>In principle perhaps but as mentioned above, gitsm has its own c=
hallenges.</pre>
    </blockquote>
    <p>Based on your feedback I have the feeling that a dependency
      fetcher isn&#39;t the correct solution. The fetcher makes it
      impossible to review changes during recipe update.=C2=A0Additionally =
it
      needs caching for the resolved fetch and license data.<br>
      <br>
      The alternative is to create an inc file with SRC_URIs, checksums,
      SRCREVs and LICENSE. Any recommendation how to integrate the
      dependency resolution and inc creation into oe-core?<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <pre>The url scheme is clever but also has a potential risk i=
n that you
can&#39;t really pass parameters to both the top level fetcher and the
underlying one. I&#39;m worried that is going to bite us further down
the
line.
</pre>
            </blockquote>
            <pre>At the moment I don&#39;t see a real problem but maybe you=
 are right. The
existing language specific fetcher use fixed paths for there
downloads.
=C2=A0
=C2=A0What do you propose? Should the fetcher skip the unpack of the
source or should we introduce a sub fetcher which uses the download
from an other SRC_URI entry. The two entries could be linked via the
name parameter. This approach could be combined with your suggestion
above. The new fetcher will unpack a lock file from an other
(default) download.
</pre>
          </blockquote>
          <pre>=C2=A0
I&#39;m not really sure what is best right now. I&#39;m trying to spell out=
 the
pros/cons of what is going on here in the hope it encourages others to
give feedback as well. I agree there isn&#39;t a problem right now but I
worry there soon will be by mixing two things together like this. The
way we handle git protocol does cause us friction with other urls
schemes already.
</pre>
        </blockquote>
        <pre>The dependency fetcher could simple skip the unpack. In this c=
ase the
user needs to use a variable to pass the same URL to the git and
dependency fetcher or we could provide a python function to generate
two SRC_URI with the same base URL.

</pre>
      </blockquote>
      <pre>I&#39;m starting to wonder about a slightly different approach, =
basically
an optional generated file alongside a recipe which contains &quot;expanded=
&quot;
information which is effectively expensive to generate (in computation
or resource like network access/process terms). We could teach bitbake
a new phase of parsing where it generated them if missing. There are
some other pieces of information which we know during the build process
which it would be helpful to know earlier (e.g. which packages a recipe
generates). I&#39;ve wondered about this for a long time and the fetcher
issues remind me of it again. It would be a big change with advantages
and drawbacks. I think it would put more pressure on a layer maintainer
as they&#39;d have to computationally keep this up to date and it would
complicate the patch workflow (who should send/regen the files?). I&#39;m
putting the idea there, I&#39;m not saying I think we should do it, I&#39;m
just considering options.
</pre>
    </blockquote>
    <p>Do you mean like a cache or like the inc files? Is the file
      totally auto generated or is manual editing acceptable?<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <pre>=C2=A0=3D Open questions
</pre>
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <pre>* Where should we download dependencies?
** Should we use a folder per fetcher (ex. git and npm)?
** Should we use the main folder (ex. crate)?
** Should we translate the name into folder (ex. gomod)?
** Should we integrate the name into the filename (ex. git)?
=C2=A0
=C2=A0
</pre>
              </blockquote>
              <pre>=C2=A0
=C2=A0
DL_DIR is meant to be a complete cache of the source so it would
need
to be downloaded there. Given it maps to the other fetchers, the
existing cache mechanisms likely work for these just fine, the open
question is on whether the lock/spec files should be cached after
extraction.
</pre>
            </blockquote>
            <pre>=C2=A0
You misunderstand the question. Its about the downloadfilename
parameter. At the moment some fetcher use sub folder inside DL_DIR
and others use the main folder. It looks like every fetcher has its
own concept to handle file collision between different fetchers. The
git and npm fetcher use there own folder, the crate fetcher use its
own .crate file prefix, the gomod fetcher translate the URL into
multiple folders and the git fetcher translate the URL into a single
folder name.
</pre>
          </blockquote>
          <pre>That makes more sense. The layout is partially legacy. The w=
get and
local fetchers were first and hence go directly into DL_DIR. git/svn
were separated out into their own directories with a plan to have a
directory per fetcher. That didn&#39;t always work out with each newer
fetcher. Each fetcher does have to handle a unique naming of its urls
as only the specific fetcher can know all the urls parameters and which
ones affect the output vs which ones don&#39;t.
=C2=A0
</pre>
        </blockquote>
        <pre>=C2=A0This doesn&#39;t explain why the npm but not the gomod a=
nd crate fetcher
use a sub folder. All fetchers are based on the wget fetcher.
</pre>
      </blockquote>
      <pre>That is probably &quot;my fault&quot;. Put yourself in my positi=
on. You get a ton
of different patches, all touching very varied aspects of the system.
When reviewing them you have to try and remember the original design
decisions, the future directions, the ways things broke in the past, a
desire to try and have clean consistent APIs and so on. I have tried
very hard to move things in a direction where things incrementally
improve, without unnecessarily blocking new features. It means that
things that merge often aren&#39;t perfect. We&#39;ve tried a few different
approaches with the newer programming languages and each approach has
had pros and cons. The inconsistency is probably as I missed something
in review. Sorry :(.</pre>
    </blockquote>
    <p>Sorry, I don&#39;t want to criticism you. I see that you have a lot
      of work. I want to understand the reasons for the actual design
      and how it should look like.<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <pre>I only have finite time. There are few people who seem to want t=
o dive
in and help with review of patches like these. I did ask some people
yesterday, one told me they simply couldn&#39;t understand these patches.</=
pre>
    </blockquote>
    <p>What can I do to improve the review?<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <pre>I&#39;m doing my best to ask the right questions, try and help o=
thers
understand them, ensure my own concerns I can identify are resolved and
I don&#39;t want to de-motivate you on this work either, I think the idea
of improving this is great and I&#39;d love to see it. Equally, I&#39;m als=
o
the first person everyone will complain to if we change something and
it causes problems for people.=C2=A0

So the explanation is probably I just missed something in review at
some point. The intent was to separate out the fetcher output going
forward (unless it makes sense to be shared).

FWIW there are multiple things which bother me about the existing
fetcher storage layout but that is a different discussion.</pre>
    </blockquote>
    <p>Okay.<br>
    </p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <pre>* Where should we unpack the dependencies?
** Should we use a folder inside the parent folder (ex.
node_modules)?
** Should we use a fixed folder inside unpackdir
=C2=A0=C2=A0 (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
</pre>
              </blockquote>
              <pre>=C2=A0
This likely depends on the fetcher as the different mechanisms will
have different expectations about how they should be extracted (as
npm/etc. would).
</pre>
            </blockquote>
            <pre>=C2=A0
It depends on the fetcher but the fetcher could use the same
approach. At the moment every fetcher use a different approach. The
crate fetcher use a fixed value. The gomod fetcher uses a variable
(GO_MOD_CACHE_DIR) and the npm fetcher uses a parameter (destsuffix).
Furthermore the gomod fetcher override the common subdir parameter.
</pre>
          </blockquote>
          <pre>I think we really need to standardise that if we can. Each n=
ew fetcher
has claimed a certain approach is effectively required by the package
manager.
</pre>
        </blockquote>
      </blockquote>
      <pre></pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre>=C2=A0What would be your desired solution? Is the variable o=
kay or do you prefer a self contain SRC_URI?
</pre>
        </blockquote>
      </blockquote>
      <pre>I suspect we need a default via a variable and then the option t=
o
change the default via parameters. The default value should be a
bitbake fetcher namespaced control variable.

I&#39;m wary of making a definitive statement saying X if that isn&#39;t go=
ing
to make sense for some backend though. I simply don&#39;t have enough
knowledge of them all, which is why you see me being reluctant to make
definitive statements about design.
</pre>
    </blockquote>
    <p>Okay.<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">
                <pre>* How should we treat archives for package manager cac=
hes?
** Should we unpack the archives to support patching (ex. npm)?
** Should we copy the packed archive to avoid unpacking and
packaging
=C2=A0=C2=A0 (ex. gomod)?
=C2=A0
</pre>
              </blockquote>
              <pre>If there are archives left after do_unpack, which task i=
s going
to unpack those? Are we expecting the build process in
configure/compile to decompress them? Would those management
tools accept things if they were extracted earlier? &quot;unpack&quot;
would be the correct time to do it but I can see this getting
into conflict with the package manager :/.
</pre>
            </blockquote>
            <pre>=C2=A0
Most package manager expect archives. In the npm case the archive is
unpack by the fetcher and packed by thenpm.bbclass to support
patching. The gomod fetcher doesn&#39;t unpack the downloaded archive and
the gomodgit fetcher create archives from git folders during unpack.
It would be possible to always keep the archives or always extract
the archives and recreate archives during build. It is a decision
between performance and patchability.
=C2=A0
=C2=A0At the moment it is complicated to work with the different fetcher
because every fetcher use a different concept and it is unclear what
is the desired approach.
</pre>
          </blockquote>
          <pre>=C2=A0
This is a challenge. Can we handle the unpacking with the package
manager as a specific step or does it have to be combined with other
steps like configure/compile?
=C2=A0=C2=A0
</pre>
        </blockquote>
        <pre>It looks like this is possible:
=C2=A0cargo fetch
=C2=A0go mod vendor
=C2=A0npm install
=C2=A0
=C2=A0I suspect you&#39;re thinking about using the package manager in
do_unpack to unpack the archives and patch the unpacked archives
afterwards?
</pre>
      </blockquote>
      <pre>I&#39;m wondering about it, yes. I know we&#39;ve had challenges=
 with patching
rust modules for example so this isn&#39;t a theoretical problem :/.</pre>
    </blockquote>
    <p>It is an interesting idea because most package manager check the
      integrity before unpack. Additionally it should simplify and speed
      up the npm build because it removes the repack of the packages.
      The problem is that we need an additional task to patch the
      dependency specification file and to unpack the file.<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <blockquote type=3D"cite">
              <pre>I did wonder if patches 1-5 of this series could be merg=
ed
separately too as they look reasonable regardless of the rest
of the series?=C2=A0
</pre>
            </blockquote>
            <pre>=C2=A0
Sure. Should I resend the patches as separate series?
</pre>
          </blockquote>
          <pre>Yes please, that would then let us remove the bits we can ea=
sily
review/sort and focus on this other part.
=C2=A0=C2=A0
</pre>
        </blockquote>
        <pre>Done.
</pre>
      </blockquote>
      <pre>Thanks.

</pre>
      <blockquote type=3D"cite">
        <pre>I will also resend the go h1 checksum commit separate because =
it
could be useful for the gomod fetcher.
</pre>
      </blockquote>
      <pre>Yes, I was waiting for a new version of that one with the naming=
 tweaked.</pre>
    </blockquote>
    <p>Done.<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <pre>Should I also move the dn / dv parameter patches to a separate=
 series
because it could be useful without the dependency fetcher. I could
add the parameters to the fetchers in a backward compatible way.
</pre>
      </blockquote>
      <pre>I need to think more about that one...
</pre>
    </blockquote>
    <p>The motivation is to include the dependencies with name, version,
      license and cpe into the SBOM.<br>
    </p>
    <p>Regards<br>
      =C2=A0 Stefan<br>
      <br>
    </p>
    <p><span style=3D"white-space:pre-wrap">
</span></p>
  </div>

<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16981): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16981" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16981</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/110212697/105=
0810" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/110212697/1050810</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:bruce.ashfield@gmail.com" target=
=3D"_blank">bruce.ashfield@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">- Thou shalt not follow the NULL pointer, for chaos and madness a=
wait thee at its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star T=
rek II<br><br></div></div>

--000000000000c86a6a062b20a8fa--

