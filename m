Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93409CCD184
	for <webhook@archiver.kernel.org>; Sat, 18 Oct 2025 13:18:27 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.web10.5666.1760793506002255534
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 18 Oct 2025 06:18:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BRsUjjXt;
 spf=pass (domain: gmail.com, ip: 209.85.161.46, mailfrom: adam.blank.g@gmail.com)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-64e5f669511so1441612eaf.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 18 Oct 2025 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760793505; x=1761398305; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=miRtF/tW8mOQulOlhO172uSTj3mBy9rZsKIDrqeb0wc=;
        b=BRsUjjXt7VzWs8d9VHkGDzTpgIx/lz83TyXr2Thn8SqEKSPlCOhsATREJzLCDHqQxA
         LyBA2Jp7MvPo2u4urmxgh36un/OfTONeGK7N61K6C03+i/txKk/pjoupy4Yu6a+p9ErG
         deBwSXrs9j6eC4Ts99ke657sSBh0B15Pjw8ac6p5pTk2pG6McPcN/n6zigAZNVmisWP8
         JwkR7fK26+7N1CxEADVWlrgUj7FguRxF9vIiZqPPJYQBHTk6sohq6Ae5EUPpNPL8xF5h
         gFbI2+lG6DySYH/A/4KYeRxjePCnjdEZJJYqfD8A9YZp4C0Q+Rk4cmcLG0EH1WAmzKh/
         qGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760793505; x=1761398305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miRtF/tW8mOQulOlhO172uSTj3mBy9rZsKIDrqeb0wc=;
        b=t1ZYFoS9TZsWVBsti4DU4OSEnfsZgZ/ta9XcNUaN++WnVb0Xck59a8XYFdt04uiIiO
         tZrf+JHl1swS2nPWBu/Kgc5Dzsc1hoDRiquVBdEk+dP9S5MVyqtY67MK0YlJWvWirET5
         OP+QEcvhdv1nFyJ/nonE3os47uvg4ajUqGj5k3P7nPNO7KXaW26CsNpbopEkdfzlJ2Jk
         6rJyK8tzkmMfgEWf4DmEGUfxu0aKulnXbz6CFkfxuyWl5DOW/cBqcccQhq6ogQUQq/uD
         o7uw1j62YFnt3Fsk6Y/ozDdsyPbpCB2+rRCDuzwsQUHJPMkE+rHg7iniKgQKUN21q8Hh
         +PCg==
X-Gm-Message-State: AOJu0Yz869bAs0S06yosTgcbquPkw0/ci/MQNjZR+k6CasOFnVg53cfG
	ZhAf5X7JItGn7dD1/BXdfFu/1P1b/AsLVPsObRAeN9pZg4NKitQXxpToXokXJkVULkPG/eKYTZV
	EMO/Ivl1hIwzVjdr0JiZkMH3rkrnswtLyZPrZ
X-Gm-Gg: ASbGnct2GY5Ex3unpAZmyXqtpviqL05oL/wnbqDdheNtQVd5kSANf8vqNCxNS5uRYct
	Cd9DMDEIC1GND1hy026cflR7uralz86nvS4BAXLE0JOCIwbnT9/SSH8sOb8z3CyI00L1DRtHCLE
	SZa5kO0tUA4lRto+kej+fe7Sm2AHSyuR3vPNTDsdDJy+MThSRgKIlKNelCWv5msW5gjIvHUGXK0
	wZk78eUYsp91Ifcw0D20+Ug9xFITNqQYsG/Y0grrh1C2TqKLmx2nALM1+WPb9/I+RH4UGAd
X-Google-Smtp-Source: AGHT+IG6LGKEltJTpJ6e7HIAtC5rruR6eQ+iBA5QXcUAMoeymGBSAIuDB8uMB7OYWtiFVnV7mogYoZwFBofg2l6/rCU=
X-Received: by 2002:a05:6870:a0a1:b0:359:f7d0:262f with SMTP id
 586e51a60fabf-3c98cf1419bmr2849025fac.1.1760793504894; Sat, 18 Oct 2025
 06:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251017102015.5296-1-adam.blank.g@gmail.com> <DDKQ53FGJVMH.12F5WALOQ3PPI@bootlin.com>
In-Reply-To: <DDKQ53FGJVMH.12F5WALOQ3PPI@bootlin.com>
From: Adam Blank <adam.blank.g@gmail.com>
Date: Sat, 18 Oct 2025 15:18:13 +0200
X-Gm-Features: AS18NWCFp7etEQES_DyGAj94qGR7nM-FDuHAveFh3clRF0P3FOPMvXew4c4_lEA
Message-ID: <CAFAffzyXUzWci6X_GhQJeQVO_x+2tJLG+peaApbeMdwxdzZkQQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual: AUTOREV and
 SRCREV_FORMAT roles in fetching
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000061d3de06416eaf5e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 18 Oct 2025 13:18:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18194

--00000000000061d3de06416eaf5e
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 18:06, Antonin Godard <antonin.godard@bootlin.com>
wrote:

> Hi,
>
> On Fri Oct 17, 2025 at 12:20 PM CEST, Adam Blank via
> lists.openembedded.org wrote:
> > Describe the roles of AUTOREV and SRCREV_FORMAT in the fetching step.
> > Add their missing descriptions to the variable reference section.
> > Correct encountered style issues.
>
> Thanks! Next, time I think it would be better to split addition and style
> cleanup in different patches, to make it easier to review. See my comments
> below
> otherwise.
>

Yes, sure, I'll upload the next version as two separate changes.


> >
> > Fixes [YOCTO #14498]
> >
> > Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
> > ---
> >  .../bitbake-user-manual-fetching.rst          | 115 ++++++++++++------
> >  .../bitbake-user-manual-ref-variables.rst     |  22 +++-
> >  2 files changed, 95 insertions(+), 42 deletions(-)
> >
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> > index f357765b7..1b5fa3ae1 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> > @@ -42,7 +42,7 @@ The instantiation of the fetch class is usually
> followed by::
> >     rootdir = l.getVar('UNPACKDIR')
> >     fetcher.unpack(rootdir)
> >
> > -This code unpacks the downloaded files to the specified by
> ``UNPACKDIR``.
> > +This code unpacks the downloaded files to the specified
> :term:`UNPACKDIR`.
> >
> >  .. note::
> >
> > @@ -51,7 +51,7 @@ This code unpacks the downloaded files to the
> specified by ``UNPACKDIR``.
> >     examine the OpenEmbedded class file ``base.bbclass``
> >     .
> >
> > -The :term:`SRC_URI` and ``UNPACKDIR`` variables are not hardcoded into
> the
> > +The :term:`SRC_URI` and :term:`UNPACKDIR` variables are not hardcoded
> into the
> >  fetcher, since those fetcher methods can be (and are) called with
> >  different variable names. In OpenEmbedded for example, the shared state
> >  (sstate) code uses the fetch module to fetch the sstate files.
> > @@ -159,19 +159,25 @@ URLs except Git URLs, BitBake uses the common
> ``unpack`` method.
> >  A number of parameters exist that you can specify within the URL to
> >  govern the behavior of the unpack stage:
> >
> > --  *unpack:* Controls whether the URL components are unpacked. If set to
> > +-  *"unpack":* Controls whether the URL components are unpacked. If set
> to
> >     "1", which is the default, the components are unpacked. If set to
> >     "0", the unpack stage leaves the file alone. This parameter is useful
> >     when you want an archive to be copied in and not be unpacked.
> >
> > --  *dos:* Applies to ``.zip`` and ``.jar`` files and specifies whether
> > +-  *"dos":* Applies to ``.zip`` and ``.jar`` files and specifies whether
> >     to use DOS line ending conversion on text files.
> >
> > --  *striplevel:* Strip specified number of leading components (levels)
> > -   from file names on extraction
> > +-  *"striplevel":* Strip specified number of leading components (levels)
> > +   from file names on extraction.
> >
> > --  *subdir:* Unpacks the specific URL to the specified subdirectory
> > -   within the root directory.
> > +-  *"subdir":* Unpacks the specific URL to the specified subdirectory
> > +   within the specified root directory. This path can be further
> modified
> > +   by fetcher specific parameters.
>
> I'm not sure I get what you mean here. Could you give a short example?
>
>
Sure, this is what the Git fetcher does for example (those are the actual
code fragments):
subdir = ud.parm.get("subdir")
destdir = os.path.join(destdir, subdir)
destdir = = os.path.join(destdir, destsuffix)
As you can see, the Git specific 'destsuffix' will be daisy-chained with
the more generic 'subdir'.


> > +
> > +-  *"name":* Assigns a name to a given component of the :term:`SRC_URI`.
> > +   This component is later referenced by this name when specifying its
> > +   :term:`SRCREV` or :term:`SRC_URI` checksum, or to correctly place its
> > +   revision in the package version string with aid of
> :term:`SRCREV_FORMAT`.
> >
> >  The unpack call automatically decompresses and extracts files with ".Z",
> >  ".z", ".gz", ".xz", ".zip", ".jar", ".ipk", ".rpm". ".srpm", ".deb" and
> > @@ -246,21 +252,19 @@ Some example URLs are as follows::
> >     introduce ambiguity when parsing URLs that also contain semi-colons,
> >     for example::
> >
> > -           SRC_URI = "
> http://abc123.org/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47"
> > -
> > +      SRC_URI = "
> http://abc123.org/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47"
> >
> >     Such URLs should should be modified by replacing semi-colons with '&'
> >     characters::
> >
> > -           SRC_URI = "
> http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47"
> > -
> > +      SRC_URI = "
> http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47"
> >
> >     In most cases this should work. Treating semi-colons and '&' in
> >     queries identically is recommended by the World Wide Web Consortium
> >     (W3C). Note that due to the nature of the URL, you may have to
> >     specify the name of the downloaded file as well::
> >
> > -           SRC_URI = "
> http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47;downloadfilename=myfile.bz2
> "
> > +      SRC_URI = "
> http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47;downloadfilename=myfile.bz2
> "
> >
> >
> >  .. _cvs-fetcher:
> > @@ -398,16 +402,16 @@ This fetcher supports the following parameters:
> >
> >     .. note::
> >
> > -     When ``protocol`` is "ssh", the URL expected in :term:`SRC_URI`
> differs
> > -     from the one that is typically passed to ``git clone`` command and
> provided
> > -     by the Git server to fetch from. For example, the URL returned by
> GitLab
> > -     server for ``mesa`` when cloning over SSH is
> > -     ``git@gitlab.freedesktop.org:mesa/mesa.git``, however the
> expected URL in
> > -     :term:`SRC_URI` is the following::
> > +      When ``protocol`` is "ssh", the URL expected in :term:`SRC_URI`
> differs
> > +      from the one that is typically passed to ``git clone`` command
> and provided
> > +      by the Git server to fetch from. For example, the URL returned by
> GitLab
> > +      server for ``mesa`` when cloning over SSH is
> > +      ``git@gitlab.freedesktop.org:mesa/mesa.git``, however the
> expected URL in
> > +      :term:`SRC_URI` is the following::
> >
> > -       SRC_URI = "git://
> git@gitlab.freedesktop.org/mesa/mesa.git;branch=main;protocol=ssh;..."
> > +         SRC_URI = "git://
> git@gitlab.freedesktop.org/mesa/mesa.git;branch=main;protocol=ssh;..."
> >
> > -     Note the ``:`` character changed for a ``/`` before the path to
> the project.
> > +      Note the ``:`` character changed for a ``/`` before the path to
> the project.
> >
> >  -  *"nocheckout":* Tells the fetcher to not checkout source code when
> >     unpacking when set to "1". Set this option for the URL where there is
> > @@ -453,7 +457,7 @@ This fetcher supports the following parameters:
> >     By default, the path is ``git/``.
> >
> >  -  *"usehead":* Enables local ``git://`` URLs to use the current branch
> > -   HEAD as the revision for use with ``AUTOREV``. The "usehead"
> > +   HEAD as the revision for use with :term:`AUTOREV`. The "usehead"
> >     parameter implies no branch and only works when the transfer protocol
> >     is ``file://``.
> >
> > @@ -525,10 +529,10 @@ The fetcher uses the ``rcleartool`` or
> >
> >  Following are options for the :term:`SRC_URI` statement:
> >
> > --  *vob*: The name, which must include the prepending "/" character,
> > +-  *"vob":*: The name, which must include the prepending "/" character,
> >     of the ClearCase VOB. This option is required.
> >
> > --  *module*: The module, which must include the prepending "/"
> > +-  *"module":*: The module, which must include the prepending "/"
> >     character, in the selected VOB.
> >
> >     .. note::
> > @@ -540,7 +544,7 @@ Following are options for the :term:`SRC_URI`
> statement:
> >
> >           load /example_vob/example_module
> >
> > --  *proto*: The protocol, which can be either ``http`` or ``https``.
> > +-  *"proto"*: The protocol, which can be either ``http`` or ``https``.
> >
> >  By default, the fetcher creates a configuration specification. If you
> >  want this specification written to an area other than the default, use
> > @@ -549,9 +553,9 @@ the specification is written.
> >
> >  .. note::
> >
> > -   the SRCREV loses its functionality if you specify this variable.
> However,
> > -   SRCREV is still used to label the archive after a fetch even though
> it does
> > -   not define what is fetched.
> > +   the :term:`SRCREV` loses its functionality if you specify this
> variable.
> > +   However, :term:`SRCREV` is still used to label the archive after a
> fetch even
> > +   though it does not define what is fetched.
> >
> >  Here are a couple of other behaviors worth mentioning:
> >
> > @@ -606,21 +610,23 @@ password, and fetches a Revision based on a Label::
> >
> >  .. note::
> >
> > -   You should always set S to "${UNPACKDIR}/p4" in your recipe.
> > +   Your recipe should always set S as shown in the above example::
>
> s/above/following ?
>
> > +
> > +     S = "${UNPACKDIR}/p4"
> >
> >  By default, the fetcher strips the depot location from the local file
> paths. In
> >  the above example, the content of ``example-depot/main/source/`` will
> be placed
> >  in ``${UNPACKDIR}/p4``.  For situations where preserving parts of the
> remote depot
> >  paths locally is desirable, the fetcher supports two parameters:
> >
> > -- *"module":*
> > -    The top-level depot location or directory to fetch. The value of
> this
> > -    parameter can also point to a single file within the depot, in
> which case
> > -    the local file path will include the module path.
> > -- *"remotepath":*
> > -    When used with the value "``keep``", the fetcher will mirror the
> full depot
> > -    paths locally for the specified location, even in combination with
> the
> > -    ``module`` parameter.
> > +-  *"module":*
> > +   The top-level depot location or directory to fetch. The value of this
> > +   parameter can also point to a single file within the depot, in which
> case
> > +   the local file path will include the module path.
> > +-  *"remotepath":*
> > +   When used with the value "``keep``", the fetcher will mirror the
> full depot
> > +   paths locally for the specified location, even in combination with
> the
> > +   ``module`` parameter.
> >
> >  Here is an example use of the the ``module`` parameter::
> >
> > @@ -843,4 +849,37 @@ submodules. However, you might find the code
> helpful and readable.
> >  Auto Revisions
> >  ==============
> >
> > -We need to document ``AUTOREV`` and :term:`SRCREV_FORMAT` here.
> > +For recipes which need to use the latest revision of their source code,
> > +the way to achieve it is to use :term:`AUTOREV` as the value of the
> > +source code repository's :term:`SRCREV`::
>
> Suggestion: simplify the sentence to:
>
> """
> For recipes which need to use the latest revision of their source code,
> the way to achieve it is to set :term:`SRCREV` to :term:`AUTOREV` in the
> recipe::
> """
>
>
I beg to differ. As a non-native English speaker, I would understand this
to mean
'SRCREV = "AUTOREV"', which is a different thing entirely. In my opinion
those few extra
words are a small cost compared to the comprehensibility they provide.


> > +
> > +   SRCREV = "${AUTOREV}"
> > +
> > +In this case, to properly show the revision information in the
> package's version
> > +string, :term:`PV` should be set to include the ``+`` sign.
>
> I'm quite sure this logic is not part of Bitbake but OE-Core:
>
> https://git.openembedded.org/openembedded-core/tree/meta/classes-global/package.bbclass#n317
>
> I'm not sure having the "+" in PV adds anything for standalone Bitbake, so
> I'd
> remove this sentence.
>
>
Sure, no problem.


> > +
> > +.. note::
> > +
> > +   With :term:`AUTOREV`, BitBake will always need to take the
> additional step of
> > +   querying the remore repository to retrieve the latest available
> revision.
>
> s/remore/remote
>
> > +
> > +   Also, recipes using it don't benefit from the caching mechanism.
>
> I just made a quick test:
>
> - Set SRCREV = "${AUTOREV}" for the procps recipe in OE-Core.
> - bitbake -c unpack procps -> unpacks the source code
> - bitbake -c unpack procps -> "Attempted 3 tasks of which 3 didn't need to
> be
>   rerun and all succeeded."
>
> So I think bitbake does not rebuild when the remote hasn't changed, and
> recipes
> do benefit from the sstate-cache?
>
>
I did the same test, but adding the following line:
python() {
    bb.error("Reparsing %s" % d.getVar('PN'))
}
Having this line, calling 'bitbake procs' shows that it gets reparsed every
time in the case
where it uses AUTOREV.

Regardless, my intention was to hint to the user, that the effects of the
following code can be
expected (again, taken from the Git fetcher):
def _latest_revision(self, ud, d, name):
    bb.fetch2.mark_recipe_nocache(d)

I don't know what (if any) would be a better choice of words. Perhaps this?
"""
don't benefit from all the caching mechanisms
"""


> > +Multiple Source Control Repositories
> > +====================================
> > +
> > +For some recipes it is necessary to make use of more than one
> > +version controlled source code repository. It such case, the recipe
>
> s/It/In/
>
> > +must provide BitBake with information about how it should include
> > +all those SCM versions in its package version string, instead of its
>
> s/all those SCM versions/the different SCM revisions/
>
> would sound better IMO.
>
> > +usual approach with a single :term:`SRCREV`.
> > +
> > +For this purpose, the recipe must set the :term:`SRCREV_FORMAT`
> > +variable. One notable example is the OpenEmbedded
> ``kernel-yocto.bbclass``::
>
> It would be nice to keep example free of OpenEmbedded references. Can you
> convert it to another example, without mentioning it?
>
>
Of course. I was merely attempting to stick to the 'convention' from this
file, where base.bbclass
was referenced.


> > +
> > +   SRCREV_FORMAT ?= "meta_machine"
>
> > +
> > +The value given to :term:`SRCREV_FORMAT` references names, which were
>
> Suggestion:
>
> """
> The value given to :term:`SRCREV_FORMAT` references names separated by
> underscores ("_"), which are assigned...
> """
>
>
Hmmm. What would be the grounds for that? There is no such limitation in
the code.
In fact, even such abomination gets through:
'SRCREV_FORMAT = "adam@machine@meta@blank"' and successfully produces a
package:
Image--5.15.173+git0+adam@fa3f7978db@567f0adb9d@blank-r0-beetroot
-20251018125101.bin


> > +assigned using the ``name`` parameter to those components of
> :term:`SRC_URI`,
>
> Suggestion:
>
> """
> assigned using the ``name`` parameter in an :term:`SRC_URI` definition.
> """
>
> > +which represent the version controlled source code repositories. In the
> above
> > +example, the :term:`SRC_URI` contained two URLs named "meta" and
> "machine".
>
> IMO, it is important to give an example of the corresponding SRC_URI
> definition
> here. Users reading this will understand better with the full picture.
>
>
Sure thing.


> > diff --git
> a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > index 810f88689..9256c20b6 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > @@ -36,6 +36,14 @@ overview of their function and contents.
> >        when specified allows for the Git binary from the host to be used
> >        rather than building ``git-native``.
> >
> > +   :term:`AUTOREV`
> > +      This is a special variable used during fetching. When
> :term:`SRCREV` is
> > +      set to the value of this variable, it means that the latest
> revision
> > +      from the version controlled source code repository should be used.
>
> Suggestion:
>
> """
> ...set to the value of this variable, the latest revision from the version
> controlled source code repository is used.
> """
>
> > +      Here is an example::
>
> """
> It should be set as follows:
> """
>
> There's no other way of using AUTOREV I think, so it's not really an
> example.
>
> > +
> > +         SRCREV = "${AUTOREV}"
> > +
> >     :term:`AZ_SAS`
> >        Azure Storage Shared Access Signature, when using the
> >        :ref:`Azure Storage fetcher
> <bitbake-user-manual/bitbake-user-manual-fetching:fetchers>`
> > @@ -1622,7 +1630,8 @@ overview of their function and contents.
> >
> >        -  ``name``: Specifies a name to be used for association with
> >           :term:`SRC_URI` checksums or :term:`SRCREV` when you have more
> than one
> > -         file or git repository specified in :term:`SRC_URI`. For
> example::
> > +         file or source control repository specified in :term:`SRC_URI`.
> > +         For example::
> >
> >              SRC_URI = "git://example.com/foo.git;branch=main;name=first
> \
> >                         git://
> example.com/bar.git;branch=main;name=second \
> > @@ -1635,7 +1644,8 @@ overview of their function and contents.
> >        -  ``subdir``: Places the file (or extracts its contents) into the
> >           specified subdirectory. This option is useful for unusual
> tarballs
> >           or other archives that do not have their files already in a
> > -         subdirectory within the archive.
> > +         subdirectory within the archive. This path can be further
> modified
> > +         by fetcher specific parameters.
>
> Ditto: I'm not sure I get what you mean here. Could you give a short
> example
> maybe?
>
> >
> >        -  ``subpath``: Limits the checkout to a specific subpath of the
> >           tree when using the Git fetcher is used.
> > @@ -1657,11 +1667,11 @@ overview of their function and contents.
> >        identifier and not just a tag.
> >
> >     :term:`SRCREV_FORMAT`
> > -      Helps construct valid :term:`SRCREV` values when
> > +      Helps construct a valid package version string when
>
> I'm not sure why this changed. This variable does help constructing
> multiple
> SRCREV values. Package version strings are just a by-product of using it,
> no?
>
>
Perhaps it is again a point of view of a non-native English speaker, but it
sounded false to
my ear. The way it was phrased suggested, that SRCREV_FORMAT is in some way
a
prerequisite or an input to the final value of some SRCREV* variables. If
fact though, it is used solely as
a formatter, into which Bitbake will plug the already pre-existing values
of 'named'
SRCREV variables, to provide a string which will later be used (outside of
BitBake) for PKGV.


> >        multiple source controlled URLs are used in
> >        :term:`SRC_URI`.
> >
> > -      The system needs help constructing these values under these
> > +      The system needs help constructing this value under these
> >        circumstances. Each component in the :term:`SRC_URI` is assigned
> a name
> >        and these are referenced in the :term:`SRCREV_FORMAT` variable.
> Consider
> >        an example with URLs named "machine" and "meta". In this case,
> > @@ -1697,3 +1707,7 @@ overview of their function and contents.
> >     :term:`TOPDIR`
> >        Points to the build directory. BitBake automatically sets this
> >        variable.
> > +
> > +   :term:`UNPACKDIR`
> > +      The directory into which recipe's downloads are unpacked during
> its
> > +      build process.
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

--00000000000061d3de06416eaf5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 17 Oct 20=
25 at 18:06, Antonin Godard &lt;<a href=3D"mailto:antonin.godard@bootlin.co=
m" target=3D"_blank">antonin.godard@bootlin.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Fri Oct 17, 2025 at 12:20 PM CEST, Adam Blank via <a href=3D"http://list=
s.openembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded=
.org</a> wrote:<br>
&gt; Describe the roles of AUTOREV and SRCREV_FORMAT in the fetching step.<=
br>
&gt; Add their missing descriptions to the variable reference section.<br>
&gt; Correct encountered style issues.<br>
<br>
Thanks! Next, time I think it would be better to split addition and style<b=
r>
cleanup in different patches, to make it easier to review. See my comments =
below<br>
otherwise.<br></blockquote><div><br></div><div class=3D"gmail_default" styl=
e=3D"font-size:small">Yes, sure, I&#39;ll upload the next version as two se=
parate changes.</div><div class=3D"gmail_default" style=3D"font-size:small"=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Fixes [YOCTO #14498]<br>
&gt;<br>
&gt; Signed-off-by: Adam Blank &lt;<a href=3D"mailto:adam.blank.g@gmail.com=
" target=3D"_blank">adam.blank.g@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../bitbake-user-manual-fetching.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 115 ++++++++++++------<br>
&gt;=C2=A0 .../bitbake-user-manual-ref-variables.rst=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 22 +++-<br>
&gt;=C2=A0 2 files changed, 95 insertions(+), 42 deletions(-)<br>
&gt;<br>
&gt; diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst<br>
&gt; index f357765b7..1b5fa3ae1 100644<br>
&gt; --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst<br>
&gt; +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst<br>
&gt; @@ -42,7 +42,7 @@ The instantiation of the fetch class is usually foll=
owed by::<br>
&gt;=C2=A0 =C2=A0 =C2=A0rootdir =3D l.getVar(&#39;UNPACKDIR&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0fetcher.unpack(rootdir)<br>
&gt;=C2=A0 <br>
&gt; -This code unpacks the downloaded files to the specified by ``UNPACKDI=
R``.<br>
&gt; +This code unpacks the downloaded files to the specified :term:`UNPACK=
DIR`.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 .. note::<br>
&gt;=C2=A0 <br>
&gt; @@ -51,7 +51,7 @@ This code unpacks the downloaded files to the specif=
ied by ``UNPACKDIR``.<br>
&gt;=C2=A0 =C2=A0 =C2=A0examine the OpenEmbedded class file ``base.bbclass`=
`<br>
&gt;=C2=A0 =C2=A0 =C2=A0.<br>
&gt;=C2=A0 <br>
&gt; -The :term:`SRC_URI` and ``UNPACKDIR`` variables are not hardcoded int=
o the<br>
&gt; +The :term:`SRC_URI` and :term:`UNPACKDIR` variables are not hardcoded=
 into the<br>
&gt;=C2=A0 fetcher, since those fetcher methods can be (and are) called wit=
h<br>
&gt;=C2=A0 different variable names. In OpenEmbedded for example, the share=
d state<br>
&gt;=C2=A0 (sstate) code uses the fetch module to fetch the sstate files.<b=
r>
&gt; @@ -159,19 +159,25 @@ URLs except Git URLs, BitBake uses the common ``=
unpack`` method.<br>
&gt;=C2=A0 A number of parameters exist that you can specify within the URL=
 to<br>
&gt;=C2=A0 govern the behavior of the unpack stage:<br>
&gt;=C2=A0 <br>
&gt; --=C2=A0 *unpack:* Controls whether the URL components are unpacked. I=
f set to<br>
&gt; +-=C2=A0 *&quot;unpack&quot;:* Controls whether the URL components are=
 unpacked. If set to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;1&quot;, which is the default, the components=
 are unpacked. If set to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;0&quot;, the unpack stage leaves the file alo=
ne. This parameter is useful<br>
&gt;=C2=A0 =C2=A0 =C2=A0when you want an archive to be copied in and not be=
 unpacked.<br>
&gt;=C2=A0 <br>
&gt; --=C2=A0 *dos:* Applies to ``.zip`` and ``.jar`` files and specifies w=
hether<br>
&gt; +-=C2=A0 *&quot;dos&quot;:* Applies to ``.zip`` and ``.jar`` files and=
 specifies whether<br>
&gt;=C2=A0 =C2=A0 =C2=A0to use DOS line ending conversion on text files.<br=
>
&gt;=C2=A0 <br>
&gt; --=C2=A0 *striplevel:* Strip specified number of leading components (l=
evels)<br>
&gt; -=C2=A0 =C2=A0from file names on extraction<br>
&gt; +-=C2=A0 *&quot;striplevel&quot;:* Strip specified number of leading c=
omponents (levels)<br>
&gt; +=C2=A0 =C2=A0from file names on extraction.<br>
&gt;=C2=A0 <br>
&gt; --=C2=A0 *subdir:* Unpacks the specific URL to the specified subdirect=
ory<br>
&gt; -=C2=A0 =C2=A0within the root directory.<br>
&gt; +-=C2=A0 *&quot;subdir&quot;:* Unpacks the specific URL to the specifi=
ed subdirectory<br>
&gt; +=C2=A0 =C2=A0within the specified root directory. This path can be fu=
rther modified<br>
&gt; +=C2=A0 =C2=A0by fetcher specific parameters.<br>
<br>
I&#39;m not sure I get what you mean here. Could you give a short example?<=
br>
<br></blockquote><div><div class=3D"gmail_default" style=3D"font-size:small=
"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Sure, th=
is is what the Git fetcher does for example (those are the actual code frag=
ments):</div><div class=3D"gmail_default" style=3D"font-size:small">subdir =
=3D ud.parm.get(&quot;subdir&quot;)</div><div class=3D"gmail_default" style=
=3D"font-size:small">destdir =3D os.path.join(destdir, subdir)</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">destdir =3D =3D os.path.joi=
n(destdir, destsuffix)</div><div class=3D"gmail_default" style=3D"font-size=
:small">As you can see, the Git specific &#39;destsuffix&#39; will be daisy=
-chained with the more generic &#39;subdir&#39;.</div></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +-=C2=A0 *&quot;name&quot;:* Assigns a name to a given component of th=
e :term:`SRC_URI`.<br>
&gt; +=C2=A0 =C2=A0This component is later referenced by this name when spe=
cifying its<br>
&gt; +=C2=A0 =C2=A0:term:`SRCREV` or :term:`SRC_URI` checksum, or to correc=
tly place its<br>
&gt; +=C2=A0 =C2=A0revision in the package version string with aid of :term=
:`SRCREV_FORMAT`.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 The unpack call automatically decompresses and extracts files wi=
th &quot;.Z&quot;,<br>
&gt;=C2=A0 &quot;.z&quot;, &quot;.gz&quot;, &quot;.xz&quot;, &quot;.zip&quo=
t;, &quot;.jar&quot;, &quot;.ipk&quot;, &quot;.rpm&quot;. &quot;.srpm&quot;=
, &quot;.deb&quot; and<br>
&gt; @@ -246,21 +252,19 @@ Some example URLs are as follows::<br>
&gt;=C2=A0 =C2=A0 =C2=A0introduce ambiguity when parsing URLs that also con=
tain semi-colons,<br>
&gt;=C2=A0 =C2=A0 =C2=A0for example::<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRC_URI =3D &quot;<a href=3D=
"http://abc123.org/git/?p=3Dgcc/gcc.git;a=3Dsnapshot;h=3Da5dd47" rel=3D"nor=
eferrer" target=3D"_blank">http://abc123.org/git/?p=3Dgcc/gcc.git;a=3Dsnaps=
hot;h=3Da5dd47</a>&quot;<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 SRC_URI =3D &quot;<a href=3D"http://abc123.org/g=
it/?p=3Dgcc/gcc.git;a=3Dsnapshot;h=3Da5dd47" rel=3D"noreferrer" target=3D"_=
blank">http://abc123.org/git/?p=3Dgcc/gcc.git;a=3Dsnapshot;h=3Da5dd47</a>&q=
uot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0Such URLs should should be modified by replacing se=
mi-colons with &#39;&amp;&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0characters::<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRC_URI =3D &quot;<a href=3D=
"http://abc123.org/git/?p=3Dgcc/gcc.git&amp;a=3Dsnapshot&amp;h=3Da5dd47" re=
l=3D"noreferrer" target=3D"_blank">http://abc123.org/git/?p=3Dgcc/gcc.git&a=
mp;a=3Dsnapshot&amp;h=3Da5dd47</a>&quot;<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 SRC_URI =3D &quot;<a href=3D"http://abc123.org/g=
it/?p=3Dgcc/gcc.git&amp;a=3Dsnapshot&amp;h=3Da5dd47" rel=3D"noreferrer" tar=
get=3D"_blank">http://abc123.org/git/?p=3Dgcc/gcc.git&amp;a=3Dsnapshot&amp;=
h=3Da5dd47</a>&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0In most cases this should work. Treating semi-colon=
s and &#39;&amp;&#39; in<br>
&gt;=C2=A0 =C2=A0 =C2=A0queries identically is recommended by the World Wid=
e Web Consortium<br>
&gt;=C2=A0 =C2=A0 =C2=A0(W3C). Note that due to the nature of the URL, you =
may have to<br>
&gt;=C2=A0 =C2=A0 =C2=A0specify the name of the downloaded file as well::<b=
r>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRC_URI =3D &quot;<a href=3D=
"http://abc123.org/git/?p=3Dgcc/gcc.git&amp;a=3Dsnapshot&amp;h=3Da5dd47;dow=
nloadfilename=3Dmyfile.bz2" rel=3D"noreferrer" target=3D"_blank">http://abc=
123.org/git/?p=3Dgcc/gcc.git&amp;a=3Dsnapshot&amp;h=3Da5dd47;downloadfilena=
me=3Dmyfile.bz2</a>&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 SRC_URI =3D &quot;<a href=3D"http://abc123.org/g=
it/?p=3Dgcc/gcc.git&amp;a=3Dsnapshot&amp;h=3Da5dd47;downloadfilename=3Dmyfi=
le.bz2" rel=3D"noreferrer" target=3D"_blank">http://abc123.org/git/?p=3Dgcc=
/gcc.git&amp;a=3Dsnapshot&amp;h=3Da5dd47;downloadfilename=3Dmyfile.bz2</a>&=
quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 .. _cvs-fetcher:<br>
&gt; @@ -398,16 +402,16 @@ This fetcher supports the following parameters:<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0.. note::<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0When ``protocol`` is &quot;ssh&quot;, the URL exp=
ected in :term:`SRC_URI` differs<br>
&gt; -=C2=A0 =C2=A0 =C2=A0from the one that is typically passed to ``git cl=
one`` command and provided<br>
&gt; -=C2=A0 =C2=A0 =C2=A0by the Git server to fetch from. For example, the=
 URL returned by GitLab<br>
&gt; -=C2=A0 =C2=A0 =C2=A0server for ``mesa`` when cloning over SSH is<br>
&gt; -=C2=A0 =C2=A0 =C2=A0``git@gitlab.freedesktop.org:mesa/mesa.git``, how=
ever the expected URL in<br>
&gt; -=C2=A0 =C2=A0 =C2=A0:term:`SRC_URI` is the following::<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 When ``protocol`` is &quot;ssh&quot;, the URL ex=
pected in :term:`SRC_URI` differs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 from the one that is typically passed to ``git c=
lone`` command and provided<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 by the Git server to fetch from. For example, th=
e URL returned by GitLab<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 server for ``mesa`` when cloning over SSH is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ``git@gitlab.freedesktop.org:mesa/mesa.git``, ho=
wever the expected URL in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 :term:`SRC_URI` is the following::<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0SRC_URI =3D &quot;git://<a href=3D"http://=
git@gitlab.freedesktop.org/mesa/mesa.git;branch=3Dmain;protocol=3Dssh;.." r=
el=3D"noreferrer" target=3D"_blank">git@gitlab.freedesktop.org/mesa/mesa.gi=
t;branch=3Dmain;protocol=3Dssh;..</a>.&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRC_URI =3D &quot;git://<a href=3D"=
http://git@gitlab.freedesktop.org/mesa/mesa.git;branch=3Dmain;protocol=3Dss=
h;.." rel=3D"noreferrer" target=3D"_blank">git@gitlab.freedesktop.org/mesa/=
mesa.git;branch=3Dmain;protocol=3Dssh;..</a>.&quot;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0Note the ``:`` character changed for a ``/`` befo=
re the path to the project.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 Note the ``:`` character changed for a ``/`` bef=
ore the path to the project.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 -=C2=A0 *&quot;nocheckout&quot;:* Tells the fetcher to not check=
out source code when<br>
&gt;=C2=A0 =C2=A0 =C2=A0unpacking when set to &quot;1&quot;. Set this optio=
n for the URL where there is<br>
&gt; @@ -453,7 +457,7 @@ This fetcher supports the following parameters:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0By default, the path is ``git/``.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 -=C2=A0 *&quot;usehead&quot;:* Enables local ``git://`` URLs to =
use the current branch<br>
&gt; -=C2=A0 =C2=A0HEAD as the revision for use with ``AUTOREV``. The &quot=
;usehead&quot;<br>
&gt; +=C2=A0 =C2=A0HEAD as the revision for use with :term:`AUTOREV`. The &=
quot;usehead&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0parameter implies no branch and only works when the=
 transfer protocol<br>
&gt;=C2=A0 =C2=A0 =C2=A0is ``file://``.<br>
&gt;=C2=A0 <br>
&gt; @@ -525,10 +529,10 @@ The fetcher uses the ``rcleartool`` or<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Following are options for the :term:`SRC_URI` statement:<br>
&gt;=C2=A0 <br>
&gt; --=C2=A0 *vob*: The name, which must include the prepending &quot;/&qu=
ot; character,<br>
&gt; +-=C2=A0 *&quot;vob&quot;:*: The name, which must include the prependi=
ng &quot;/&quot; character,<br>
&gt;=C2=A0 =C2=A0 =C2=A0of the ClearCase VOB. This option is required.<br>
&gt;=C2=A0 <br>
&gt; --=C2=A0 *module*: The module, which must include the prepending &quot=
;/&quot;<br>
&gt; +-=C2=A0 *&quot;module&quot;:*: The module, which must include the pre=
pending &quot;/&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0character, in the selected VOB.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0.. note::<br>
&gt; @@ -540,7 +544,7 @@ Following are options for the :term:`SRC_URI` stat=
ement:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load /example_vob/example_modu=
le<br>
&gt;=C2=A0 <br>
&gt; --=C2=A0 *proto*: The protocol, which can be either ``http`` or ``http=
s``.<br>
&gt; +-=C2=A0 *&quot;proto&quot;*: The protocol, which can be either ``http=
`` or ``https``.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 By default, the fetcher creates a configuration specification. I=
f you<br>
&gt;=C2=A0 want this specification written to an area other than the defaul=
t, use<br>
&gt; @@ -549,9 +553,9 @@ the specification is written.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 .. note::<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0the SRCREV loses its functionality if you specify this v=
ariable. However,<br>
&gt; -=C2=A0 =C2=A0SRCREV is still used to label the archive after a fetch =
even though it does<br>
&gt; -=C2=A0 =C2=A0not define what is fetched.<br>
&gt; +=C2=A0 =C2=A0the :term:`SRCREV` loses its functionality if you specif=
y this variable.<br>
&gt; +=C2=A0 =C2=A0However, :term:`SRCREV` is still used to label the archi=
ve after a fetch even<br>
&gt; +=C2=A0 =C2=A0though it does not define what is fetched.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Here are a couple of other behaviors worth mentioning:<br>
&gt;=C2=A0 <br>
&gt; @@ -606,21 +610,23 @@ password, and fetches a Revision based on a Labe=
l::<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 .. note::<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0You should always set S to &quot;${UNPACKDIR}/p4&quot; i=
n your recipe.<br>
&gt; +=C2=A0 =C2=A0Your recipe should always set S as shown in the above ex=
ample::<br>
<br>
s/above/following ?<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0S =3D &quot;${UNPACKDIR}/p4&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 By default, the fetcher strips the depot location from the local=
 file paths. In<br>
&gt;=C2=A0 the above example, the content of ``example-depot/main/source/``=
 will be placed<br>
&gt;=C2=A0 in ``${UNPACKDIR}/p4``.=C2=A0 For situations where preserving pa=
rts of the remote depot<br>
&gt;=C2=A0 paths locally is desirable, the fetcher supports two parameters:=
<br>
&gt;=C2=A0 <br>
&gt; -- *&quot;module&quot;:*<br>
&gt; -=C2=A0 =C2=A0 The top-level depot location or directory to fetch. The=
 value of this<br>
&gt; -=C2=A0 =C2=A0 parameter can also point to a single file within the de=
pot, in which case<br>
&gt; -=C2=A0 =C2=A0 the local file path will include the module path.<br>
&gt; -- *&quot;remotepath&quot;:*<br>
&gt; -=C2=A0 =C2=A0 When used with the value &quot;``keep``&quot;, the fetc=
her will mirror the full depot<br>
&gt; -=C2=A0 =C2=A0 paths locally for the specified location, even in combi=
nation with the<br>
&gt; -=C2=A0 =C2=A0 ``module`` parameter.<br>
&gt; +-=C2=A0 *&quot;module&quot;:*<br>
&gt; +=C2=A0 =C2=A0The top-level depot location or directory to fetch. The =
value of this<br>
&gt; +=C2=A0 =C2=A0parameter can also point to a single file within the dep=
ot, in which case<br>
&gt; +=C2=A0 =C2=A0the local file path will include the module path.<br>
&gt; +-=C2=A0 *&quot;remotepath&quot;:*<br>
&gt; +=C2=A0 =C2=A0When used with the value &quot;``keep``&quot;, the fetch=
er will mirror the full depot<br>
&gt; +=C2=A0 =C2=A0paths locally for the specified location, even in combin=
ation with the<br>
&gt; +=C2=A0 =C2=A0``module`` parameter.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Here is an example use of the the ``module`` parameter::<br>
&gt;=C2=A0 <br>
&gt; @@ -843,4 +849,37 @@ submodules. However, you might find the code help=
ful and readable.<br>
&gt;=C2=A0 Auto Revisions<br>
&gt;=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;=C2=A0 <br>
&gt; -We need to document ``AUTOREV`` and :term:`SRCREV_FORMAT` here.<br>
&gt; +For recipes which need to use the latest revision of their source cod=
e,<br>
&gt; +the way to achieve it is to use :term:`AUTOREV` as the value of the<b=
r>
&gt; +source code repository&#39;s :term:`SRCREV`::<br>
<br>
Suggestion: simplify the sentence to:<br>
<br>
&quot;&quot;&quot;<br>
For recipes which need to use the latest revision of their source code,<br>
the way to achieve it is to set :term:`SRCREV` to :term:`AUTOREV` in the re=
cipe::<br>
&quot;&quot;&quot;<br>
<br></blockquote><div><span class=3D"gmail_default" style=3D"font-size:smal=
l"><br></span></div><div><span class=3D"gmail_default" style=3D"font-size:s=
mall">I beg to differ.</span>=C2=A0<span class=3D"gmail_default" style=3D"f=
ont-size:small">As a non-native English speaker, I would understand this to=
 mean</span></div><div><span class=3D"gmail_default" style=3D"font-size:sma=
ll">&#39;SRCREV =3D &quot;AUTOREV&quot;&#39;, which is a different thing en=
tirely. In my opinion those few extra</span></div><div><span class=3D"gmail=
_default" style=3D"font-size:small">words are a small cost compared to the =
comprehensibility they provide.</span></div><div><span class=3D"gmail_defau=
lt" style=3D"font-size:small"><br></span></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0SRCREV =3D &quot;${AUTOREV}&quot;<br>
&gt; +<br>
&gt; +In this case, to properly show the revision information in the packag=
e&#39;s version<br>
&gt; +string, :term:`PV` should be set to include the ``+`` sign.<br>
<br>
I&#39;m quite sure this logic is not part of Bitbake but OE-Core:<br>
<a href=3D"https://git.openembedded.org/openembedded-core/tree/meta/classes=
-global/package.bbclass#n317" rel=3D"noreferrer" target=3D"_blank">https://=
git.openembedded.org/openembedded-core/tree/meta/classes-global/package.bbc=
lass#n317</a><br>
<br>
I&#39;m not sure having the &quot;+&quot; in PV adds anything for standalon=
e Bitbake, so I&#39;d<br>
remove this sentence.<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">Sure, no problem.</div></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +.. note::<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0With :term:`AUTOREV`, BitBake will always need to take t=
he additional step of<br>
&gt; +=C2=A0 =C2=A0querying the remore repository to retrieve the latest av=
ailable revision.<br>
<br>
s/remore/remote<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0Also, recipes using it don&#39;t benefit from the cachin=
g mechanism.<br>
<br>
I just made a quick test:<br>
<br>
- Set SRCREV =3D &quot;${AUTOREV}&quot; for the procps recipe in OE-Core.<b=
r>
- bitbake -c unpack procps -&gt; unpacks the source code<br>
- bitbake -c unpack procps -&gt; &quot;Attempted 3 tasks of which 3 didn&#3=
9;t need to be<br>
=C2=A0 rerun and all succeeded.&quot;<br>
<br>
So I think bitbake does not rebuild when the remote hasn&#39;t changed, and=
 recipes<br>
do benefit from the sstate-cache?<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">I did the same test, but adding the following line:</div><=
/div><div>python() {<br>=C2=A0 =C2=A0 bb.error(&quot;Reparsing %s&quot; % d=
.getVar(&#39;PN&#39;))<br>}</div><div><div class=3D"gmail_default" style=3D=
"font-size:small">Having this line, calling &#39;bitbake procs&#39; shows t=
hat it gets reparsed every time in the case</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">where it uses AUTOREV.</div></div><div><br></d=
iv><div><div class=3D"gmail_default" style=3D"font-size:small">Regardless, =
my intention was to hint to the user, that the effects of the following cod=
e can be</div></div><div><div class=3D"gmail_default" style=3D"font-size:sm=
all">expected (again, taken from the Git fetcher):</div><div class=3D"gmail=
_default" style=3D"font-size:small">def _latest_revision(self, ud, d, name)=
:</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0=
=C2=A0bb.fetch2.mark_recipe_nocache(d)</div><br></div><div><div class=3D"gm=
ail_default" style=3D"font-size:small">I don&#39;t know what (if any) would=
 be a better choice of words. Perhaps this?</div></div><div class=3D"gmail_=
default" style=3D"font-size:small">&quot;&quot;&quot;</div><div class=3D"gm=
ail_default" style=3D"font-size:small">don&#39;t benefit from all the cachi=
ng mechanisms</div><div class=3D"gmail_default" style=3D"font-size:small">&=
quot;&quot;&quot;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
&gt; +Multiple Source Control Repositories<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +For some recipes it is necessary to make use of more than one<br>
&gt; +version controlled source code repository. It such case, the recipe<b=
r>
<br>
s/It/In/<br>
<br>
&gt; +must provide BitBake with information about how it should include<br>
&gt; +all those SCM versions in its package version string, instead of its<=
br>
<br>
s/all those SCM versions/the different SCM revisions/<br>
<br>
would sound better IMO.<br>
<br>
&gt; +usual approach with a single :term:`SRCREV`.<br>
&gt; +<br>
&gt; +For this purpose, the recipe must set the :term:`SRCREV_FORMAT`<br>
&gt; +variable. One notable example is the OpenEmbedded ``kernel-yocto.bbcl=
ass``::<br>
<br>
It would be nice to keep example free of OpenEmbedded references. Can you<b=
r>
convert it to another example, without mentioning it?<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">Of course. I was merely attempting to stick to the &#39;co=
nvention&#39; from this file, where base.bbclass</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">was referenced.</div></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0SRCREV_FORMAT ?=3D &quot;meta_machine&quot;<br>
<br>
&gt; +<br>
&gt; +The value given to :term:`SRCREV_FORMAT` references names, which were=
<br>
<br>
Suggestion:<br>
<br>
&quot;&quot;&quot;<br>
The value given to :term:`SRCREV_FORMAT` references names separated by<br>
underscores (&quot;_&quot;), which are assigned...<br>
&quot;&quot;&quot;<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">Hmmm. What would be the grounds for that? There is no such=
 limitation in the code.</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">In fact, even such abomination gets through:</div><div class=3D"g=
mail_default" style=3D"font-size:small">&#39;SRCREV_FORMAT =3D &quot;adam@m=
achine@meta@blank&quot;&#39; and successfully produces a package:</div></di=
v><div>Image--5.15.173+git0+adam@fa3f7978db@567f0adb9d@blank-r0-<span class=
=3D"gmail_default" style=3D"font-size:small">beetroot</span>-20251018125101=
.bin</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
&gt; +assigned using the ``name`` parameter to those components of :term:`S=
RC_URI`,<br>
<br>
Suggestion:<br>
<br>
&quot;&quot;&quot;<br>
assigned using the ``name`` parameter in an :term:`SRC_URI` definition.<br>
&quot;&quot;&quot;<br>
<br>
&gt; +which represent the version controlled source code repositories. In t=
he above<br>
&gt; +example, the :term:`SRC_URI` contained two URLs named &quot;meta&quot=
; and &quot;machine&quot;.<br>
<br>
IMO, it is important to give an example of the corresponding SRC_URI defini=
tion<br>
here. Users reading this will understand better with the full picture.<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">Sure thing.</div></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=
.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
&gt; index 810f88689..9256c20b6 100644<br>
&gt; --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt; +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt; @@ -36,6 +36,14 @@ overview of their function and contents.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 when specified allows for the Git binary fr=
om the host to be used<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 rather than building ``git-native``.<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0:term:`AUTOREV`<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 This is a special variable used during fetching.=
 When :term:`SRCREV` is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 set to the value of this variable, it means that=
 the latest revision<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 from the version controlled source code reposito=
ry should be used.<br>
<br>
Suggestion:<br>
<br>
&quot;&quot;&quot;<br>
...set to the value of this variable, the latest revision from the version<=
br>
controlled source code repository is used.<br>
&quot;&quot;&quot;<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 Here is an example::<br>
<br>
&quot;&quot;&quot;<br>
It should be set as follows:<br>
&quot;&quot;&quot;<br>
<br>
There&#39;s no other way of using AUTOREV I think, so it&#39;s not really a=
n example.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRCREV =3D &quot;${AUTOREV}&quot;<b=
r>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0:term:`AZ_SAS`<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Azure Storage Shared Access Signature, when=
 using the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 :ref:`Azure Storage fetcher &lt;bitbake-use=
r-manual/bitbake-user-manual-fetching:fetchers&gt;`<br>
&gt; @@ -1622,7 +1630,8 @@ overview of their function and contents.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 -=C2=A0 ``name``: Specifies a name to be us=
ed for association with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:term:`SRC_URI` checksums or :=
term:`SRCREV` when you have more than one<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file or git repository specified in=
 :term:`SRC_URI`. For example::<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file or source control repository s=
pecified in :term:`SRC_URI`.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0For example::<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SRC_URI =3D &quot;git:=
//<a href=3D"http://example.com/foo.git;branch=3Dmain;name=3Dfirst" rel=3D"=
noreferrer" target=3D"_blank">example.com/foo.git;branch=3Dmain;name=3Dfirs=
t</a> \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0git://<a href=3D"http://example.com/bar.git;branch=3Dma=
in;name=3Dsecond" rel=3D"noreferrer" target=3D"_blank">example.com/bar.git;=
branch=3Dmain;name=3Dsecond</a> \<br>
&gt; @@ -1635,7 +1644,8 @@ overview of their function and contents.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 -=C2=A0 ``subdir``: Places the file (or ext=
racts its contents) into the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0specified subdirectory. This o=
ption is useful for unusual tarballs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0or other archives that do not =
have their files already in a<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0subdirectory within the archive.<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0subdirectory within the archive. Th=
is path can be further modified<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0by fetcher specific parameters.<br>
<br>
Ditto: I&#39;m not sure I get what you mean here. Could you give a short ex=
ample<br>
maybe?<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 -=C2=A0 ``subpath``: Limits the checkout to=
 a specific subpath of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tree when using the Git fetche=
r is used.<br>
&gt; @@ -1657,11 +1667,11 @@ overview of their function and contents.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 identifier and not just a tag.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0:term:`SRCREV_FORMAT`<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 Helps construct valid :term:`SRCREV` values when=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 Helps construct a valid package version string w=
hen<br>
<br>
I&#39;m not sure why this changed. This variable does help constructing mul=
tiple<br>
SRCREV values. Package version strings are just a by-product of using it, n=
o?<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">Perhaps it is again a point of view of a non-native Englis=
h speaker, but it sounded false to</div><div class=3D"gmail_default" style=
=3D"font-size:small">my ear. The way it was phrased suggested, that SRCREV_=
FORMAT is in some way a</div><div class=3D"gmail_default" style=3D"font-siz=
e:small">prerequisite or an input to the final value of some SRCREV* variab=
les. If fact though, it is used solely as</div><div class=3D"gmail_default"=
 style=3D"font-size:small">a formatter, into which Bitbake will plug the al=
ready pre-existing values of &#39;named&#39;</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">SRCREV variables, to provide a string which w=
ill later be used (outside of BitBake) for PKGV.</div></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 multiple source controlled URLs are used in=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 :term:`SRC_URI`.<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 The system needs help constructing these values =
under these<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 The system needs help constructing this value un=
der these<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 circumstances. Each component in the :term:=
`SRC_URI` is assigned a name<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 and these are referenced in the :term:`SRCR=
EV_FORMAT` variable. Consider<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 an example with URLs named &quot;machine&qu=
ot; and &quot;meta&quot;. In this case,<br>
&gt; @@ -1697,3 +1707,7 @@ overview of their function and contents.<br>
&gt;=C2=A0 =C2=A0 =C2=A0:term:`TOPDIR`<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Points to the build directory. BitBake auto=
matically sets this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 variable.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0:term:`UNPACKDIR`<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 The directory into which recipe&#39;s downloads =
are unpacked during its<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 build process.<br>
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
</blockquote></div></div>
</div>
</div>

--00000000000061d3de06416eaf5e--

