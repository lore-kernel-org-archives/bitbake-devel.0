Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F94CCD1BB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 10:55:04 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web10.5803.1761130498572162100
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Oct 2025 03:54:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CdAECchV;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: adam.blank.g@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c2823c3475so3538585a34.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 03:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761130498; x=1761735298; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DwzdQL/gan8yTwiPVDG5vti3BQYdOjeNAD57CzO6bV0=;
        b=CdAECchVJueH/qeR7hqPwqXGSnZAB2mr8K7OGi3qV9C2nWRaW+ZovKtcV7OS0WyN06
         7lt/5g3MYyYvVhGNwK9YKdN5S6NAyapt9V2NVt79/8znkpLeiGrG4p0AZyAy3JBwlXNt
         MoyWej9Qm/jfKjBMitUhmcaTJCihEnda7QleKqwjPR7QgaK0SjOpMSlzCM3BSVSR4l9p
         hU7rfCEaJ7l1F3i8+seY2Oq7H8jXjVCGtshDcf/dUvGAkZ2ohBx3zS70mK8eSoWvC11S
         L9vmQoNSyw4J5xTdH6u3+nyMzh84FwlKHqRwBEJhH46qOZg3HT1ehP0p8VelU12xNwsV
         WGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130498; x=1761735298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwzdQL/gan8yTwiPVDG5vti3BQYdOjeNAD57CzO6bV0=;
        b=rQW5mUprrm1RCWdrH/bgYqyuddg04UdzZF9alUGdSSU07dPEooKOsmqDXfQZBNo1pa
         j4aFRZioKDo1FG38Nqr4ETNXvBOhEVpBNgrYTfcxoKrU5bMvUKJvphddSmKbif0cPhMT
         txQOweQipCfVk67w2bOXaq8DZMUVZCzbq14alnvvzxzFqN8h1AV+iLx6Xqkfr41n5g6o
         ogHMegi5khQnCi+WDN9mVA1Lzp7uXIsOdMvIi9HH99dJxqOBUPoabuQYCIMMPhTMZOAj
         0+1zwMdzS5XpGT9BOIftwbX+P3OirYheMl28jI95jZkbri0T7K0Vs8R/RpMrH2iq2rQ2
         YUUw==
X-Gm-Message-State: AOJu0YzoEKTpaY8WnOF5H9KbR58rN2ZDpYXXPt84C7n2jnous3qMsqW4
	MXP3xUkQ2q4LAn2p+PmRc9yHx+xqL/tvW2rn4GcIKBKJlz8mmDifOc/4D3stOhKwAdsDLFp3GbJ
	zI/hFGGlTR83Js6zU6ChAgAWwL4jGU6E=
X-Gm-Gg: ASbGncv9Ato0t423CkYJJpGWtHYYR2Ou63gx8bJawbzrj7UTjKI56fsypSvUffMb4d6
	/Ju3QUwTGOaTSAIdbKSWaaaBLrg1tj6crGWd08Z2ZG4RiuSK/gB7CVVdy3uLBgJR7VlUioGmdT4
	+U/aO11+hvxe4+rrxIZiGXeTXQDRe8V8owyOXMoFO/crTs61UIsN75+pMEehFftc86WQkKizbdb
	Se98K/3omguvkrjpH9JHeTYbXs2zX7WMNfbMTmg0aMf0AKP4+lD6rvCIOtd5A==
X-Google-Smtp-Source: AGHT+IEDr54Nthrq7nvUeoyF6DSM4wtH5JDURMQdgoF1LWB79ssooggkEUSgklv+L7dkDjjiZTSE21D30N1BUfpy2F8=
X-Received: by 2002:a05:6808:860a:b0:449:39e0:f3d4 with SMTP id
 5614622812f47-44939f06126mr1338689b6e.3.1761130497549; Wed, 22 Oct 2025
 03:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251017102015.5296-1-adam.blank.g@gmail.com> <DDKQ53FGJVMH.12F5WALOQ3PPI@bootlin.com>
 <CAFAffzyXUzWci6X_GhQJeQVO_x+2tJLG+peaApbeMdwxdzZkQQ@mail.gmail.com> <DDOOBSC2KD95.1E6Q0RAKUCAVX@bootlin.com>
In-Reply-To: <DDOOBSC2KD95.1E6Q0RAKUCAVX@bootlin.com>
From: Adam Blank <adam.blank.g@gmail.com>
Date: Wed, 22 Oct 2025 12:54:46 +0200
X-Gm-Features: AS18NWBkC3_L8j-F3vsBOHi2ToF8jzFh3GCtDvjg4l9eGpQot8AUGlsu8lGJnWs
Message-ID: <CAFAffzzR3oqDenSbuNYmeLCEwA5QSJk9kJ6cNxQpX8SixZc-2A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual: AUTOREV and
 SRCREV_FORMAT roles in fetching
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000b5a8f40641bd250f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 10:55:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18206

--000000000000b5a8f40641bd250f
Content-Type: text/plain; charset="UTF-8"

Thanks for your comments.

I've already sent this change in the form of 3 separate patches.
Patch 1/3 shall be discarded as pointed out by Alex Kanavin.
Patch 2/3 (the main one) will be updated with your comments from this topic.
Patch 3/3 is purely for "style and completeness".

Thanks,
Adam


On Wed, 22 Oct 2025 at 09:31, Antonin Godard <antonin.godard@bootlin.com>
wrote:

> On Sat Oct 18, 2025 at 3:18 PM CEST, Adam Blank wrote:
> [...]
> >> > --  *subdir:* Unpacks the specific URL to the specified subdirectory
> >> > -   within the root directory.
> >> > +-  *"subdir":* Unpacks the specific URL to the specified subdirectory
> >> > +   within the specified root directory. This path can be further
> >> modified
> >> > +   by fetcher specific parameters.
> >>
> >> I'm not sure I get what you mean here. Could you give a short example?
> >>
> >>
> > Sure, this is what the Git fetcher does for example (those are the actual
> > code fragments):
> > subdir = ud.parm.get("subdir")
> > destdir = os.path.join(destdir, subdir)
> > destdir = = os.path.join(destdir, destsuffix)
> > As you can see, the Git specific 'destsuffix' will be daisy-chained with
> > the more generic 'subdir'.
>
> Ah I see, ok, thanks.
>
> [...]
> >> >  Auto Revisions
> >> >  ==============
> >> >
> >> > -We need to document ``AUTOREV`` and :term:`SRCREV_FORMAT` here.
> >> > +For recipes which need to use the latest revision of their source
> code,
> >> > +the way to achieve it is to use :term:`AUTOREV` as the value of the
> >> > +source code repository's :term:`SRCREV`::
> >>
> >> Suggestion: simplify the sentence to:
> >>
> >> """
> >> For recipes which need to use the latest revision of their source code,
> >> the way to achieve it is to set :term:`SRCREV` to :term:`AUTOREV` in the
> >> recipe::
> >> """
> >>
> >>
> > I beg to differ. As a non-native English speaker, I would understand this
> > to mean
> > 'SRCREV = "AUTOREV"', which is a different thing entirely. In my opinion
> > those few extra
> > words are a small cost compared to the comprehensibility they provide.
>
> I understand it your way now which is clearer.
>
> >> > +
> >> > +   SRCREV = "${AUTOREV}"
> >> > +
> >> > +In this case, to properly show the revision information in the
> >> package's version
> >> > +string, :term:`PV` should be set to include the ``+`` sign.
> >>
> >> I'm quite sure this logic is not part of Bitbake but OE-Core:
> >>
> >>
> https://git.openembedded.org/openembedded-core/tree/meta/classes-global/package.bbclass#n317
> >>
> >> I'm not sure having the "+" in PV adds anything for standalone Bitbake,
> so
> >> I'd
> >> remove this sentence.
> >>
> >>
> > Sure, no problem.
> >
> >
> >> > +
> >> > +.. note::
> >> > +
> >> > +   With :term:`AUTOREV`, BitBake will always need to take the
> >> additional step of
> >> > +   querying the remore repository to retrieve the latest available
> >> revision.
> >>
> >> s/remore/remote
> >>
> >> > +
> >> > +   Also, recipes using it don't benefit from the caching mechanism.
> >>
> >> I just made a quick test:
> >>
> >> - Set SRCREV = "${AUTOREV}" for the procps recipe in OE-Core.
> >> - bitbake -c unpack procps -> unpacks the source code
> >> - bitbake -c unpack procps -> "Attempted 3 tasks of which 3 didn't need
> to
> >> be
> >>   rerun and all succeeded."
> >>
> >> So I think bitbake does not rebuild when the remote hasn't changed, and
> >> recipes
> >> do benefit from the sstate-cache?
> >>
> >>
> > I did the same test, but adding the following line:
> > python() {
> >     bb.error("Reparsing %s" % d.getVar('PN'))
> > }
> > Having this line, calling 'bitbake procs' shows that it gets reparsed
> every
> > time in the case
> > where it uses AUTOREV.
> >
> > Regardless, my intention was to hint to the user, that the effects of the
> > following code can be
> > expected (again, taken from the Git fetcher):
> > def _latest_revision(self, ud, d, name):
> >     bb.fetch2.mark_recipe_nocache(d)
> >
> > I don't know what (if any) would be a better choice of words. Perhaps
> this?
> > """
> > don't benefit from all the caching mechanisms
> > """
>
> I see, I assumed sstate-cache. I think what is correct to say is: "this
> recipe
> is not part of the parsing-time cache and so is parsed everytime BitBake
> is run."
>
> >
> >> > +Multiple Source Control Repositories
> >> > +====================================
> >> > +
> >> > +For some recipes it is necessary to make use of more than one
> >> > +version controlled source code repository. It such case, the recipe
> >>
> >> s/It/In/
> >>
> >> > +must provide BitBake with information about how it should include
> >> > +all those SCM versions in its package version string, instead of its
> >>
> >> s/all those SCM versions/the different SCM revisions/
> >>
> >> would sound better IMO.
> >>
> >> > +usual approach with a single :term:`SRCREV`.
> >> > +
> >> > +For this purpose, the recipe must set the :term:`SRCREV_FORMAT`
> >> > +variable. One notable example is the OpenEmbedded
> >> ``kernel-yocto.bbclass``::
> >>
> >> It would be nice to keep example free of OpenEmbedded references. Can
> you
> >> convert it to another example, without mentioning it?
> >>
> >>
> > Of course. I was merely attempting to stick to the 'convention' from this
> > file, where base.bbclass
> > was referenced.
> >
> >
> >> > +
> >> > +   SRCREV_FORMAT ?= "meta_machine"
> >>
> >> > +
> >> > +The value given to :term:`SRCREV_FORMAT` references names, which were
> >>
> >> Suggestion:
> >>
> >> """
> >> The value given to :term:`SRCREV_FORMAT` references names separated by
> >> underscores ("_"), which are assigned...
> >> """
> >>
> >>
> > Hmmm. What would be the grounds for that? There is no such limitation in
> > the code.
> > In fact, even such abomination gets through:
> > 'SRCREV_FORMAT = "adam@machine@meta@blank"' and successfully produces a
> > package:
> > Image--5.15.173+git0+adam@fa3f7978db@567f0adb9d@blank-r0-beetroot
> > -20251018125101.bin
>
> I wasn't aware other characters could be used to separate entried here.
> Thanks!
>
> >> > +assigned using the ``name`` parameter to those components of
> >> :term:`SRC_URI`,
> >>
> >> Suggestion:
> >>
> >> """
> >> assigned using the ``name`` parameter in an :term:`SRC_URI` definition.
> >> """
> >>
> >> > +which represent the version controlled source code repositories. In
> the
> >> above
> >> > +example, the :term:`SRC_URI` contained two URLs named "meta" and
> >> "machine".
> >>
> >> IMO, it is important to give an example of the corresponding SRC_URI
> >> definition
> >> here. Users reading this will understand better with the full picture.
> >>
> >>
> > Sure thing.
> >
> >
> >> > diff --git
> >> a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> >> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> >> > index 810f88689..9256c20b6 100644
> >> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> >> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> >> > @@ -36,6 +36,14 @@ overview of their function and contents.
> >> >        when specified allows for the Git binary from the host to be
> used
> >> >        rather than building ``git-native``.
> >> >
> >> > +   :term:`AUTOREV`
> >> > +      This is a special variable used during fetching. When
> >> :term:`SRCREV` is
> >> > +      set to the value of this variable, it means that the latest
> >> revision
> >> > +      from the version controlled source code repository should be
> used.
> >>
> >> Suggestion:
> >>
> >> """
> >> ...set to the value of this variable, the latest revision from the
> version
> >> controlled source code repository is used.
> >> """
> >>
> >> > +      Here is an example::
> >>
> >> """
> >> It should be set as follows:
> >> """
> >>
> >> There's no other way of using AUTOREV I think, so it's not really an
> >> example.
> >>
> >> > +
> >> > +         SRCREV = "${AUTOREV}"
> >> > +
> >> >     :term:`AZ_SAS`
> >> >        Azure Storage Shared Access Signature, when using the
> >> >        :ref:`Azure Storage fetcher
> >> <bitbake-user-manual/bitbake-user-manual-fetching:fetchers>`
> >> > @@ -1622,7 +1630,8 @@ overview of their function and contents.
> >> >
> >> >        -  ``name``: Specifies a name to be used for association with
> >> >           :term:`SRC_URI` checksums or :term:`SRCREV` when you have
> more
> >> than one
> >> > -         file or git repository specified in :term:`SRC_URI`. For
> >> example::
> >> > +         file or source control repository specified in
> :term:`SRC_URI`.
> >> > +         For example::
> >> >
> >> >              SRC_URI = "git://
> example.com/foo.git;branch=main;name=first
> >> \
> >> >                         git://
> >> example.com/bar.git;branch=main;name=second \
> >> > @@ -1635,7 +1644,8 @@ overview of their function and contents.
> >> >        -  ``subdir``: Places the file (or extracts its contents) into
> the
> >> >           specified subdirectory. This option is useful for unusual
> >> tarballs
> >> >           or other archives that do not have their files already in a
> >> > -         subdirectory within the archive.
> >> > +         subdirectory within the archive. This path can be further
> >> modified
> >> > +         by fetcher specific parameters.
> >>
> >> Ditto: I'm not sure I get what you mean here. Could you give a short
> >> example
> >> maybe?
> >>
> >> >
> >> >        -  ``subpath``: Limits the checkout to a specific subpath of
> the
> >> >           tree when using the Git fetcher is used.
> >> > @@ -1657,11 +1667,11 @@ overview of their function and contents.
> >> >        identifier and not just a tag.
> >> >
> >> >     :term:`SRCREV_FORMAT`
> >> > -      Helps construct valid :term:`SRCREV` values when
> >> > +      Helps construct a valid package version string when
> >>
> >> I'm not sure why this changed. This variable does help constructing
> >> multiple
> >> SRCREV values. Package version strings are just a by-product of using
> it,
> >> no?
> >>
> >>
> > Perhaps it is again a point of view of a non-native English speaker, but
> it
> > sounded false to
> > my ear. The way it was phrased suggested, that SRCREV_FORMAT is in some
> way
> > a
> > prerequisite or an input to the final value of some SRCREV* variables. If
> > fact though, it is used solely as
> > a formatter, into which Bitbake will plug the already pre-existing values
> > of 'named'
> > SRCREV variables, to provide a string which will later be used (outside
> of
> > BitBake) for PKGV.
>
> I see that clearly now, understood.
>
> Thanks,
> Antonin
>
> --
> Antonin Godard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

--000000000000b5a8f40641bd250f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Thanks for your comments.</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">I&#39;ve already sent this change in the form of 3 separate =
patches.</div><div class=3D"gmail_default" style=3D"font-size:small">Patch =
1/3 shall be discarded as pointed out by Alex Kanavin.</div><div class=3D"g=
mail_default" style=3D"font-size:small">Patch 2/3 (the main one) will be up=
dated with your comments from this topic.</div><div class=3D"gmail_default"=
 style=3D"font-size:small">Patch 3/3 is purely for &quot;style and complete=
ness&quot;.</div><div class=3D"gmail_default" style=3D"font-size:small"><br=
></div><div class=3D"gmail_default" style=3D"font-size:small">Thanks,</div>=
<div class=3D"gmail_default" style=3D"font-size:small">Adam</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 22 Oct 2025 =
at 09:31, Antonin Godard &lt;<a href=3D"mailto:antonin.godard@bootlin.com" =
target=3D"_blank">antonin.godard@bootlin.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Sat Oct 18, 2025 at 3:18 PM =
CEST, Adam Blank wrote:<br>
[...]<br>
&gt;&gt; &gt; --=C2=A0 *subdir:* Unpacks the specific URL to the specified =
subdirectory<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0within the root directory.<br>
&gt;&gt; &gt; +-=C2=A0 *&quot;subdir&quot;:* Unpacks the specific URL to th=
e specified subdirectory<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0within the specified root directory. This path =
can be further<br>
&gt;&gt; modified<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0by fetcher specific parameters.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m not sure I get what you mean here. Could you give a short =
example?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Sure, this is what the Git fetcher does for example (those are the act=
ual<br>
&gt; code fragments):<br>
&gt; subdir =3D ud.parm.get(&quot;subdir&quot;)<br>
&gt; destdir =3D os.path.join(destdir, subdir)<br>
&gt; destdir =3D =3D os.path.join(destdir, destsuffix)<br>
&gt; As you can see, the Git specific &#39;destsuffix&#39; will be daisy-ch=
ained with<br>
&gt; the more generic &#39;subdir&#39;.<br>
<br>
Ah I see, ok, thanks.<br>
<br>
[...]<br>
&gt;&gt; &gt;=C2=A0 Auto Revisions<br>
&gt;&gt; &gt;=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -We need to document ``AUTOREV`` and :term:`SRCREV_FORMAT` he=
re.<br>
&gt;&gt; &gt; +For recipes which need to use the latest revision of their s=
ource code,<br>
&gt;&gt; &gt; +the way to achieve it is to use :term:`AUTOREV` as the value=
 of the<br>
&gt;&gt; &gt; +source code repository&#39;s :term:`SRCREV`::<br>
&gt;&gt;<br>
&gt;&gt; Suggestion: simplify the sentence to:<br>
&gt;&gt;<br>
&gt;&gt; &quot;&quot;&quot;<br>
&gt;&gt; For recipes which need to use the latest revision of their source =
code,<br>
&gt;&gt; the way to achieve it is to set :term:`SRCREV` to :term:`AUTOREV` =
in the<br>
&gt;&gt; recipe::<br>
&gt;&gt; &quot;&quot;&quot;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; I beg to differ. As a non-native English speaker, I would understand t=
his<br>
&gt; to mean<br>
&gt; &#39;SRCREV =3D &quot;AUTOREV&quot;&#39;, which is a different thing e=
ntirely. In my opinion<br>
&gt; those few extra<br>
&gt; words are a small cost compared to the comprehensibility they provide.=
<br>
<br>
I understand it your way now which is clearer.<br>
<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0SRCREV =3D &quot;${AUTOREV}&quot;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +In this case, to properly show the revision information in t=
he<br>
&gt;&gt; package&#39;s version<br>
&gt;&gt; &gt; +string, :term:`PV` should be set to include the ``+`` sign.<=
br>
&gt;&gt;<br>
&gt;&gt; I&#39;m quite sure this logic is not part of Bitbake but OE-Core:<=
br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://git.openembedded.org/openembedded-core/tree/met=
a/classes-global/package.bbclass#n317" rel=3D"noreferrer" target=3D"_blank"=
>https://git.openembedded.org/openembedded-core/tree/meta/classes-global/pa=
ckage.bbclass#n317</a><br>
&gt;&gt;<br>
&gt;&gt; I&#39;m not sure having the &quot;+&quot; in PV adds anything for =
standalone Bitbake, so<br>
&gt;&gt; I&#39;d<br>
&gt;&gt; remove this sentence.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Sure, no problem.<br>
&gt;<br>
&gt;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +.. note::<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0With :term:`AUTOREV`, BitBake will always need =
to take the<br>
&gt;&gt; additional step of<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0querying the remore repository to retrieve the =
latest available<br>
&gt;&gt; revision.<br>
&gt;&gt;<br>
&gt;&gt; s/remore/remote<br>
&gt;&gt;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0Also, recipes using it don&#39;t benefit from t=
he caching mechanism.<br>
&gt;&gt;<br>
&gt;&gt; I just made a quick test:<br>
&gt;&gt;<br>
&gt;&gt; - Set SRCREV =3D &quot;${AUTOREV}&quot; for the procps recipe in O=
E-Core.<br>
&gt;&gt; - bitbake -c unpack procps -&gt; unpacks the source code<br>
&gt;&gt; - bitbake -c unpack procps -&gt; &quot;Attempted 3 tasks of which =
3 didn&#39;t need to<br>
&gt;&gt; be<br>
&gt;&gt;=C2=A0 =C2=A0rerun and all succeeded.&quot;<br>
&gt;&gt;<br>
&gt;&gt; So I think bitbake does not rebuild when the remote hasn&#39;t cha=
nged, and<br>
&gt;&gt; recipes<br>
&gt;&gt; do benefit from the sstate-cache?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; I did the same test, but adding the following line:<br>
&gt; python() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0bb.error(&quot;Reparsing %s&quot; % d.getVar(&#39;P=
N&#39;))<br>
&gt; }<br>
&gt; Having this line, calling &#39;bitbake procs&#39; shows that it gets r=
eparsed every<br>
&gt; time in the case<br>
&gt; where it uses AUTOREV.<br>
&gt;<br>
&gt; Regardless, my intention was to hint to the user, that the effects of =
the<br>
&gt; following code can be<br>
&gt; expected (again, taken from the Git fetcher):<br>
&gt; def _latest_revision(self, ud, d, name):<br>
&gt;=C2=A0 =C2=A0 =C2=A0bb.fetch2.mark_recipe_nocache(d)<br>
&gt;<br>
&gt; I don&#39;t know what (if any) would be a better choice of words. Perh=
aps this?<br>
&gt; &quot;&quot;&quot;<br>
&gt; don&#39;t benefit from all the caching mechanisms<br>
&gt; &quot;&quot;&quot;<br>
<br>
I see, I assumed sstate-cache. I think what is correct to say is: &quot;thi=
s recipe<br>
is not part of the parsing-time cache and so is parsed everytime BitBake is=
 run.&quot;<br>
<br>
&gt;<br>
&gt;&gt; &gt; +Multiple Source Control Repositories<br>
&gt;&gt; &gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +For some recipes it is necessary to make use of more than on=
e<br>
&gt;&gt; &gt; +version controlled source code repository. It such case, the=
 recipe<br>
&gt;&gt;<br>
&gt;&gt; s/It/In/<br>
&gt;&gt;<br>
&gt;&gt; &gt; +must provide BitBake with information about how it should in=
clude<br>
&gt;&gt; &gt; +all those SCM versions in its package version string, instea=
d of its<br>
&gt;&gt;<br>
&gt;&gt; s/all those SCM versions/the different SCM revisions/<br>
&gt;&gt;<br>
&gt;&gt; would sound better IMO.<br>
&gt;&gt;<br>
&gt;&gt; &gt; +usual approach with a single :term:`SRCREV`.<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +For this purpose, the recipe must set the :term:`SRCREV_FORM=
AT`<br>
&gt;&gt; &gt; +variable. One notable example is the OpenEmbedded<br>
&gt;&gt; ``kernel-yocto.bbclass``::<br>
&gt;&gt;<br>
&gt;&gt; It would be nice to keep example free of OpenEmbedded references. =
Can you<br>
&gt;&gt; convert it to another example, without mentioning it?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Of course. I was merely attempting to stick to the &#39;convention&#39=
; from this<br>
&gt; file, where base.bbclass<br>
&gt; was referenced.<br>
&gt;<br>
&gt;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0SRCREV_FORMAT ?=3D &quot;meta_machine&quot;<br>
&gt;&gt;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +The value given to :term:`SRCREV_FORMAT` references names, w=
hich were<br>
&gt;&gt;<br>
&gt;&gt; Suggestion:<br>
&gt;&gt;<br>
&gt;&gt; &quot;&quot;&quot;<br>
&gt;&gt; The value given to :term:`SRCREV_FORMAT` references names separate=
d by<br>
&gt;&gt; underscores (&quot;_&quot;), which are assigned...<br>
&gt;&gt; &quot;&quot;&quot;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Hmmm. What would be the grounds for that? There is no such limitation =
in<br>
&gt; the code.<br>
&gt; In fact, even such abomination gets through:<br>
&gt; &#39;SRCREV_FORMAT =3D &quot;adam@machine@meta@blank&quot;&#39; and su=
ccessfully produces a<br>
&gt; package:<br>
&gt; Image--5.15.173+git0+adam@fa3f7978db@567f0adb9d@blank-r0-beetroot<br>
&gt; -20251018125101.bin<br>
<br>
I wasn&#39;t aware other characters could be used to separate entried here.=
 Thanks!<br>
<br>
&gt;&gt; &gt; +assigned using the ``name`` parameter to those components of=
<br>
&gt;&gt; :term:`SRC_URI`,<br>
&gt;&gt;<br>
&gt;&gt; Suggestion:<br>
&gt;&gt;<br>
&gt;&gt; &quot;&quot;&quot;<br>
&gt;&gt; assigned using the ``name`` parameter in an :term:`SRC_URI` defini=
tion.<br>
&gt;&gt; &quot;&quot;&quot;<br>
&gt;&gt;<br>
&gt;&gt; &gt; +which represent the version controlled source code repositor=
ies. In the<br>
&gt;&gt; above<br>
&gt;&gt; &gt; +example, the :term:`SRC_URI` contained two URLs named &quot;=
meta&quot; and<br>
&gt;&gt; &quot;machine&quot;.<br>
&gt;&gt;<br>
&gt;&gt; IMO, it is important to give an example of the corresponding SRC_U=
RI<br>
&gt;&gt; definition<br>
&gt;&gt; here. Users reading this will understand better with the full pict=
ure.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Sure thing.<br>
&gt;<br>
&gt;<br>
&gt;&gt; &gt; diff --git<br>
&gt;&gt; a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt;&gt; b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt;&gt; &gt; index 810f88689..9256c20b6 100644<br>
&gt;&gt; &gt; --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variabl=
es.rst<br>
&gt;&gt; &gt; +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variabl=
es.rst<br>
&gt;&gt; &gt; @@ -36,6 +36,14 @@ overview of their function and contents.<b=
r>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 when specified allows for the Git =
binary from the host to be used<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 rather than building ``git-native`=
`.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0:term:`AUTOREV`<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 This is a special variable used during =
fetching. When<br>
&gt;&gt; :term:`SRCREV` is<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 set to the value of this variable, it m=
eans that the latest<br>
&gt;&gt; revision<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 from the version controlled source code=
 repository should be used.<br>
&gt;&gt;<br>
&gt;&gt; Suggestion:<br>
&gt;&gt;<br>
&gt;&gt; &quot;&quot;&quot;<br>
&gt;&gt; ...set to the value of this variable, the latest revision from the=
 version<br>
&gt;&gt; controlled source code repository is used.<br>
&gt;&gt; &quot;&quot;&quot;<br>
&gt;&gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 Here is an example::<br>
&gt;&gt;<br>
&gt;&gt; &quot;&quot;&quot;<br>
&gt;&gt; It should be set as follows:<br>
&gt;&gt; &quot;&quot;&quot;<br>
&gt;&gt;<br>
&gt;&gt; There&#39;s no other way of using AUTOREV I think, so it&#39;s not=
 really an<br>
&gt;&gt; example.<br>
&gt;&gt;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRCREV =3D &quot;${AUTOREV=
}&quot;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0:term:`AZ_SAS`<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Azure Storage Shared Access Signat=
ure, when using the<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 :ref:`Azure Storage fetcher<br>
&gt;&gt; &lt;bitbake-user-manual/bitbake-user-manual-fetching:fetchers&gt;`=
<br>
&gt;&gt; &gt; @@ -1622,7 +1630,8 @@ overview of their function and contents=
.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 -=C2=A0 ``name``: Specifies a name=
 to be used for association with<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:term:`SRC_URI` check=
sums or :term:`SRCREV` when you have more<br>
&gt;&gt; than one<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file or git repository spe=
cified in :term:`SRC_URI`. For<br>
&gt;&gt; example::<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file or source control rep=
ository specified in :term:`SRC_URI`.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0For example::<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SRC_URI =3D &=
quot;git://<a href=3D"http://example.com/foo.git;branch=3Dmain;name=3Dfirst=
" rel=3D"noreferrer" target=3D"_blank">example.com/foo.git;branch=3Dmain;na=
me=3Dfirst</a><br>
&gt;&gt; \<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0git://<br>
&gt;&gt; <a href=3D"http://example.com/bar.git;branch=3Dmain;name=3Dsecond"=
 rel=3D"noreferrer" target=3D"_blank">example.com/bar.git;branch=3Dmain;nam=
e=3Dsecond</a> \<br>
&gt;&gt; &gt; @@ -1635,7 +1644,8 @@ overview of their function and contents=
.<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 -=C2=A0 ``subdir``: Places the fil=
e (or extracts its contents) into the<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0specified subdirector=
y. This option is useful for unusual<br>
&gt;&gt; tarballs<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0or other archives tha=
t do not have their files already in a<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0subdirectory within the ar=
chive.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0subdirectory within the ar=
chive. This path can be further<br>
&gt;&gt; modified<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0by fetcher specific parame=
ters.<br>
&gt;&gt;<br>
&gt;&gt; Ditto: I&#39;m not sure I get what you mean here. Could you give a=
 short<br>
&gt;&gt; example<br>
&gt;&gt; maybe?<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 -=C2=A0 ``subpath``: Limits the ch=
eckout to a specific subpath of the<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tree when using the G=
it fetcher is used.<br>
&gt;&gt; &gt; @@ -1657,11 +1667,11 @@ overview of their function and conten=
ts.<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 identifier and not just a tag.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0:term:`SRCREV_FORMAT`<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 Helps construct valid :term:`SRCREV` va=
lues when<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 Helps construct a valid package version=
 string when<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m not sure why this changed. This variable does help constru=
cting<br>
&gt;&gt; multiple<br>
&gt;&gt; SRCREV values. Package version strings are just a by-product of us=
ing it,<br>
&gt;&gt; no?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Perhaps it is again a point of view of a non-native English speaker, b=
ut it<br>
&gt; sounded false to<br>
&gt; my ear. The way it was phrased suggested, that SRCREV_FORMAT is in som=
e way<br>
&gt; a<br>
&gt; prerequisite or an input to the final value of some SRCREV* variables.=
 If<br>
&gt; fact though, it is used solely as<br>
&gt; a formatter, into which Bitbake will plug the already pre-existing val=
ues<br>
&gt; of &#39;named&#39;<br>
&gt; SRCREV variables, to provide a string which will later be used (outsid=
e of<br>
&gt; BitBake) for PKGV.<br>
<br>
I see that clearly now, understood.<br>
<br>
Thanks,<br>
Antonin<br>
<br>
-- <br>
Antonin Godard, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
<br>
</blockquote></div>
</div>

--000000000000b5a8f40641bd250f--

