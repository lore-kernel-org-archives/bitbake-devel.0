Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C3FCCD195
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 16:06:11 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.20013.1760717161934657116
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Oct 2025 09:06:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=148ZPhCC;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 00C891A1483
	for <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 16:06:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C9B00606DB;
	Fri, 17 Oct 2025 16:05:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69912102F2326;
	Fri, 17 Oct 2025 18:05:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760717159; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AZikJiJN0Vs/SsFsSyx+I4ek1XJNu6KouN4FPsv/HC8=;
	b=148ZPhCC+NcL5J6wAKlEhwtWqnSX2D+OqE3aeoJLeSzSBhUKdKIWDleBlaF4jYNTePnmy0
	9j4nwtwM2v6D3e9z+eWHuMdDGVDPUC/sjgMjs0dVr8mf7hrjVP2ywJbzvC3RDJoWEafCEk
	CEQWyf8KVE0vtJ4yeEbCi9FIcSxhK/snbx0pN/KLh2pYMLBp0KyvT72mVCEwHdFWeHSvO6
	oB81boOEI9P4ixo72VNaOAq548w4g6hMUfKTmU9BsII75IN1qCdThyX1PVrb1oGeElHqc+
	Xq2G/6Yx4cfSD7CIEJuCsK0Z+0CcWuCvu7l49iomjrDjiLA0VzlFev51CdZM0Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 18:05:56 +0200
Message-Id: <DDKQ53FGJVMH.12F5WALOQ3PPI@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual: AUTOREV and
 SRCREV_FORMAT roles in fetching
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <adam.blank.g@gmail.com>, <bitbake-devel@lists.openembedded.org>
References: <20251017102015.5296-1-adam.blank.g@gmail.com>
In-Reply-To: <20251017102015.5296-1-adam.blank.g@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 16:06:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18185

Hi,

On Fri Oct 17, 2025 at 12:20 PM CEST, Adam Blank via lists.openembedded.org=
 wrote:
> Describe the roles of AUTOREV and SRCREV_FORMAT in the fetching step.
> Add their missing descriptions to the variable reference section.
> Correct encountered style issues.

Thanks! Next, time I think it would be better to split addition and style
cleanup in different patches, to make it easier to review. See my comments =
below
otherwise.

>
> Fixes [YOCTO #14498]
>
> Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
> ---
>  .../bitbake-user-manual-fetching.rst          | 115 ++++++++++++------
>  .../bitbake-user-manual-ref-variables.rst     |  22 +++-
>  2 files changed, 95 insertions(+), 42 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index f357765b7..1b5fa3ae1 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -42,7 +42,7 @@ The instantiation of the fetch class is usually followe=
d by::
>     rootdir =3D l.getVar('UNPACKDIR')
>     fetcher.unpack(rootdir)
> =20
> -This code unpacks the downloaded files to the specified by ``UNPACKDIR``=
.
> +This code unpacks the downloaded files to the specified :term:`UNPACKDIR=
`.
> =20
>  .. note::
> =20
> @@ -51,7 +51,7 @@ This code unpacks the downloaded files to the specified=
 by ``UNPACKDIR``.
>     examine the OpenEmbedded class file ``base.bbclass``
>     .
> =20
> -The :term:`SRC_URI` and ``UNPACKDIR`` variables are not hardcoded into t=
he
> +The :term:`SRC_URI` and :term:`UNPACKDIR` variables are not hardcoded in=
to the
>  fetcher, since those fetcher methods can be (and are) called with
>  different variable names. In OpenEmbedded for example, the shared state
>  (sstate) code uses the fetch module to fetch the sstate files.
> @@ -159,19 +159,25 @@ URLs except Git URLs, BitBake uses the common ``unp=
ack`` method.
>  A number of parameters exist that you can specify within the URL to
>  govern the behavior of the unpack stage:
> =20
> --  *unpack:* Controls whether the URL components are unpacked. If set to
> +-  *"unpack":* Controls whether the URL components are unpacked. If set =
to
>     "1", which is the default, the components are unpacked. If set to
>     "0", the unpack stage leaves the file alone. This parameter is useful
>     when you want an archive to be copied in and not be unpacked.
> =20
> --  *dos:* Applies to ``.zip`` and ``.jar`` files and specifies whether
> +-  *"dos":* Applies to ``.zip`` and ``.jar`` files and specifies whether
>     to use DOS line ending conversion on text files.
> =20
> --  *striplevel:* Strip specified number of leading components (levels)
> -   from file names on extraction
> +-  *"striplevel":* Strip specified number of leading components (levels)
> +   from file names on extraction.
> =20
> --  *subdir:* Unpacks the specific URL to the specified subdirectory
> -   within the root directory.
> +-  *"subdir":* Unpacks the specific URL to the specified subdirectory
> +   within the specified root directory. This path can be further modifie=
d
> +   by fetcher specific parameters.

I'm not sure I get what you mean here. Could you give a short example?

> +
> +-  *"name":* Assigns a name to a given component of the :term:`SRC_URI`.
> +   This component is later referenced by this name when specifying its
> +   :term:`SRCREV` or :term:`SRC_URI` checksum, or to correctly place its
> +   revision in the package version string with aid of :term:`SRCREV_FORM=
AT`.
> =20
>  The unpack call automatically decompresses and extracts files with ".Z",
>  ".z", ".gz", ".xz", ".zip", ".jar", ".ipk", ".rpm". ".srpm", ".deb" and
> @@ -246,21 +252,19 @@ Some example URLs are as follows::
>     introduce ambiguity when parsing URLs that also contain semi-colons,
>     for example::
> =20
> -           SRC_URI =3D "http://abc123.org/git/?p=3Dgcc/gcc.git;a=3Dsnaps=
hot;h=3Da5dd47"
> -
> +      SRC_URI =3D "http://abc123.org/git/?p=3Dgcc/gcc.git;a=3Dsnapshot;h=
=3Da5dd47"
> =20
>     Such URLs should should be modified by replacing semi-colons with '&'
>     characters::
> =20
> -           SRC_URI =3D "http://abc123.org/git/?p=3Dgcc/gcc.git&a=3Dsnaps=
hot&h=3Da5dd47"
> -
> +      SRC_URI =3D "http://abc123.org/git/?p=3Dgcc/gcc.git&a=3Dsnapshot&h=
=3Da5dd47"
> =20
>     In most cases this should work. Treating semi-colons and '&' in
>     queries identically is recommended by the World Wide Web Consortium
>     (W3C). Note that due to the nature of the URL, you may have to
>     specify the name of the downloaded file as well::
> =20
> -           SRC_URI =3D "http://abc123.org/git/?p=3Dgcc/gcc.git&a=3Dsnaps=
hot&h=3Da5dd47;downloadfilename=3Dmyfile.bz2"
> +      SRC_URI =3D "http://abc123.org/git/?p=3Dgcc/gcc.git&a=3Dsnapshot&h=
=3Da5dd47;downloadfilename=3Dmyfile.bz2"
> =20
> =20
>  .. _cvs-fetcher:
> @@ -398,16 +402,16 @@ This fetcher supports the following parameters:
> =20
>     .. note::
> =20
> -     When ``protocol`` is "ssh", the URL expected in :term:`SRC_URI` dif=
fers
> -     from the one that is typically passed to ``git clone`` command and =
provided
> -     by the Git server to fetch from. For example, the URL returned by G=
itLab
> -     server for ``mesa`` when cloning over SSH is
> -     ``git@gitlab.freedesktop.org:mesa/mesa.git``, however the expected =
URL in
> -     :term:`SRC_URI` is the following::
> +      When ``protocol`` is "ssh", the URL expected in :term:`SRC_URI` di=
ffers
> +      from the one that is typically passed to ``git clone`` command and=
 provided
> +      by the Git server to fetch from. For example, the URL returned by =
GitLab
> +      server for ``mesa`` when cloning over SSH is
> +      ``git@gitlab.freedesktop.org:mesa/mesa.git``, however the expected=
 URL in
> +      :term:`SRC_URI` is the following::
> =20
> -       SRC_URI =3D "git://git@gitlab.freedesktop.org/mesa/mesa.git;branc=
h=3Dmain;protocol=3Dssh;..."
> +         SRC_URI =3D "git://git@gitlab.freedesktop.org/mesa/mesa.git;bra=
nch=3Dmain;protocol=3Dssh;..."
> =20
> -     Note the ``:`` character changed for a ``/`` before the path to the=
 project.
> +      Note the ``:`` character changed for a ``/`` before the path to th=
e project.
> =20
>  -  *"nocheckout":* Tells the fetcher to not checkout source code when
>     unpacking when set to "1". Set this option for the URL where there is
> @@ -453,7 +457,7 @@ This fetcher supports the following parameters:
>     By default, the path is ``git/``.
> =20
>  -  *"usehead":* Enables local ``git://`` URLs to use the current branch
> -   HEAD as the revision for use with ``AUTOREV``. The "usehead"
> +   HEAD as the revision for use with :term:`AUTOREV`. The "usehead"
>     parameter implies no branch and only works when the transfer protocol
>     is ``file://``.
> =20
> @@ -525,10 +529,10 @@ The fetcher uses the ``rcleartool`` or
> =20
>  Following are options for the :term:`SRC_URI` statement:
> =20
> --  *vob*: The name, which must include the prepending "/" character,
> +-  *"vob":*: The name, which must include the prepending "/" character,
>     of the ClearCase VOB. This option is required.
> =20
> --  *module*: The module, which must include the prepending "/"
> +-  *"module":*: The module, which must include the prepending "/"
>     character, in the selected VOB.
> =20
>     .. note::
> @@ -540,7 +544,7 @@ Following are options for the :term:`SRC_URI` stateme=
nt:
> =20
>           load /example_vob/example_module
> =20
> --  *proto*: The protocol, which can be either ``http`` or ``https``.
> +-  *"proto"*: The protocol, which can be either ``http`` or ``https``.
> =20
>  By default, the fetcher creates a configuration specification. If you
>  want this specification written to an area other than the default, use
> @@ -549,9 +553,9 @@ the specification is written.
> =20
>  .. note::
> =20
> -   the SRCREV loses its functionality if you specify this variable. Howe=
ver,
> -   SRCREV is still used to label the archive after a fetch even though i=
t does
> -   not define what is fetched.
> +   the :term:`SRCREV` loses its functionality if you specify this variab=
le.
> +   However, :term:`SRCREV` is still used to label the archive after a fe=
tch even
> +   though it does not define what is fetched.
> =20
>  Here are a couple of other behaviors worth mentioning:
> =20
> @@ -606,21 +610,23 @@ password, and fetches a Revision based on a Label::
> =20
>  .. note::
> =20
> -   You should always set S to "${UNPACKDIR}/p4" in your recipe.
> +   Your recipe should always set S as shown in the above example::

s/above/following ?

> +
> +     S =3D "${UNPACKDIR}/p4"
> =20
>  By default, the fetcher strips the depot location from the local file pa=
ths. In
>  the above example, the content of ``example-depot/main/source/`` will be=
 placed
>  in ``${UNPACKDIR}/p4``.  For situations where preserving parts of the re=
mote depot
>  paths locally is desirable, the fetcher supports two parameters:
> =20
> -- *"module":*
> -    The top-level depot location or directory to fetch. The value of thi=
s
> -    parameter can also point to a single file within the depot, in which=
 case
> -    the local file path will include the module path.
> -- *"remotepath":*
> -    When used with the value "``keep``", the fetcher will mirror the ful=
l depot
> -    paths locally for the specified location, even in combination with t=
he
> -    ``module`` parameter.
> +-  *"module":*
> +   The top-level depot location or directory to fetch. The value of this
> +   parameter can also point to a single file within the depot, in which =
case
> +   the local file path will include the module path.
> +-  *"remotepath":*
> +   When used with the value "``keep``", the fetcher will mirror the full=
 depot
> +   paths locally for the specified location, even in combination with th=
e
> +   ``module`` parameter.
> =20
>  Here is an example use of the the ``module`` parameter::
> =20
> @@ -843,4 +849,37 @@ submodules. However, you might find the code helpful=
 and readable.
>  Auto Revisions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -We need to document ``AUTOREV`` and :term:`SRCREV_FORMAT` here.
> +For recipes which need to use the latest revision of their source code,
> +the way to achieve it is to use :term:`AUTOREV` as the value of the
> +source code repository's :term:`SRCREV`::

Suggestion: simplify the sentence to:

"""
For recipes which need to use the latest revision of their source code,
the way to achieve it is to set :term:`SRCREV` to :term:`AUTOREV` in the re=
cipe::
"""


> +
> +   SRCREV =3D "${AUTOREV}"
> +
> +In this case, to properly show the revision information in the package's=
 version
> +string, :term:`PV` should be set to include the ``+`` sign.

I'm quite sure this logic is not part of Bitbake but OE-Core:
https://git.openembedded.org/openembedded-core/tree/meta/classes-global/pac=
kage.bbclass#n317

I'm not sure having the "+" in PV adds anything for standalone Bitbake, so =
I'd
remove this sentence.

> +
> +.. note::
> +
> +   With :term:`AUTOREV`, BitBake will always need to take the additional=
 step of
> +   querying the remore repository to retrieve the latest available revis=
ion.

s/remore/remote

> +
> +   Also, recipes using it don't benefit from the caching mechanism.

I just made a quick test:

- Set SRCREV =3D "${AUTOREV}" for the procps recipe in OE-Core.
- bitbake -c unpack procps -> unpacks the source code
- bitbake -c unpack procps -> "Attempted 3 tasks of which 3 didn't need to =
be
  rerun and all succeeded."

So I think bitbake does not rebuild when the remote hasn't changed, and rec=
ipes
do benefit from the sstate-cache?

> +Multiple Source Control Repositories
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +For some recipes it is necessary to make use of more than one
> +version controlled source code repository. It such case, the recipe

s/It/In/

> +must provide BitBake with information about how it should include
> +all those SCM versions in its package version string, instead of its

s/all those SCM versions/the different SCM revisions/

would sound better IMO.

> +usual approach with a single :term:`SRCREV`.
> +
> +For this purpose, the recipe must set the :term:`SRCREV_FORMAT`
> +variable. One notable example is the OpenEmbedded ``kernel-yocto.bbclass=
``::

It would be nice to keep example free of OpenEmbedded references. Can you
convert it to another example, without mentioning it?

> +
> +   SRCREV_FORMAT ?=3D "meta_machine"

> +
> +The value given to :term:`SRCREV_FORMAT` references names, which were

Suggestion:

"""
The value given to :term:`SRCREV_FORMAT` references names separated by
underscores ("_"), which are assigned...
"""

> +assigned using the ``name`` parameter to those components of :term:`SRC_=
URI`,

Suggestion:

"""
assigned using the ``name`` parameter in an :term:`SRC_URI` definition.
"""

> +which represent the version controlled source code repositories. In the =
above
> +example, the :term:`SRC_URI` contained two URLs named "meta" and "machin=
e".

IMO, it is important to give an example of the corresponding SRC_URI defini=
tion
here. Users reading this will understand better with the full picture.

> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 810f88689..9256c20b6 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -36,6 +36,14 @@ overview of their function and contents.
>        when specified allows for the Git binary from the host to be used
>        rather than building ``git-native``.
> =20
> +   :term:`AUTOREV`
> +      This is a special variable used during fetching. When :term:`SRCRE=
V` is
> +      set to the value of this variable, it means that the latest revisi=
on
> +      from the version controlled source code repository should be used.

Suggestion:

"""
...set to the value of this variable, the latest revision from the version
controlled source code repository is used.
"""

> +      Here is an example::

"""
It should be set as follows:
"""

There's no other way of using AUTOREV I think, so it's not really an exampl=
e.

> +
> +         SRCREV =3D "${AUTOREV}"
> +
>     :term:`AZ_SAS`
>        Azure Storage Shared Access Signature, when using the
>        :ref:`Azure Storage fetcher <bitbake-user-manual/bitbake-user-manu=
al-fetching:fetchers>`
> @@ -1622,7 +1630,8 @@ overview of their function and contents.
> =20
>        -  ``name``: Specifies a name to be used for association with
>           :term:`SRC_URI` checksums or :term:`SRCREV` when you have more =
than one
> -         file or git repository specified in :term:`SRC_URI`. For exampl=
e::
> +         file or source control repository specified in :term:`SRC_URI`.
> +         For example::
> =20
>              SRC_URI =3D "git://example.com/foo.git;branch=3Dmain;name=3D=
first \
>                         git://example.com/bar.git;branch=3Dmain;name=3Dse=
cond \
> @@ -1635,7 +1644,8 @@ overview of their function and contents.
>        -  ``subdir``: Places the file (or extracts its contents) into the
>           specified subdirectory. This option is useful for unusual tarba=
lls
>           or other archives that do not have their files already in a
> -         subdirectory within the archive.
> +         subdirectory within the archive. This path can be further modif=
ied
> +         by fetcher specific parameters.

Ditto: I'm not sure I get what you mean here. Could you give a short exampl=
e
maybe?

> =20
>        -  ``subpath``: Limits the checkout to a specific subpath of the
>           tree when using the Git fetcher is used.
> @@ -1657,11 +1667,11 @@ overview of their function and contents.
>        identifier and not just a tag.
> =20
>     :term:`SRCREV_FORMAT`
> -      Helps construct valid :term:`SRCREV` values when
> +      Helps construct a valid package version string when

I'm not sure why this changed. This variable does help constructing multipl=
e
SRCREV values. Package version strings are just a by-product of using it, n=
o?

>        multiple source controlled URLs are used in
>        :term:`SRC_URI`.
> =20
> -      The system needs help constructing these values under these
> +      The system needs help constructing this value under these
>        circumstances. Each component in the :term:`SRC_URI` is assigned a=
 name
>        and these are referenced in the :term:`SRCREV_FORMAT` variable. Co=
nsider
>        an example with URLs named "machine" and "meta". In this case,
> @@ -1697,3 +1707,7 @@ overview of their function and contents.
>     :term:`TOPDIR`
>        Points to the build directory. BitBake automatically sets this
>        variable.
> +
> +   :term:`UNPACKDIR`
> +      The directory into which recipe's downloads are unpacked during it=
s
> +      build process.

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


