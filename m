Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9850FCCD1AB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:33 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.3428.1761118283461462483
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Oct 2025 00:31:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=EHl7zPCb;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 879164E4126F
	for <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 07:31:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D4F8606DC;
	Wed, 22 Oct 2025 07:31:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86767102F2426;
	Wed, 22 Oct 2025 09:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761118281; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cDQI7G5FJSPZaz3LhO2J/dR4gGYWLH/GQ1HmROrj14s=;
	b=EHl7zPCbNCq7VeXmXSK08mdt5fGh/+fFMo3YUflhIPykFyh+u9p253YasfFw/aBQTnxVp5
	8wBEnAJMLG2YZ0xvEj8pXtWvmVG0+JsukTRogaxUdyXruPXv8LXxRxu5J6CHFuh8qCLd/Z
	D5VFJqXKxe/OKS/QWXpualAEuBDp0niJ/TMEKDRjj3wlG1bStzmbcdTkI73bO6E2s+R9NU
	EGOMu2Fzos9RbGhQF93pc971oYI29Ai4fiqnNwFivfEi1/g9bcXTAVXXp4accPovavMbDV
	vJJfl46vmEbIQI7vTLgxSkDso4GAkV9CKYt7/+DQFo1SmVEFAmohRKNhID670g==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 09:31:18 +0200
Message-Id: <DDOOBSC2KD95.1E6Q0RAKUCAVX@bootlin.com>
Cc: <bitbake-devel@lists.openembedded.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Adam Blank" <adam.blank.g@gmail.com>
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual: AUTOREV and
 SRCREV_FORMAT roles in fetching
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20251017102015.5296-1-adam.blank.g@gmail.com>
 <DDKQ53FGJVMH.12F5WALOQ3PPI@bootlin.com>
 <CAFAffzyXUzWci6X_GhQJeQVO_x+2tJLG+peaApbeMdwxdzZkQQ@mail.gmail.com>
In-Reply-To: <CAFAffzyXUzWci6X_GhQJeQVO_x+2tJLG+peaApbeMdwxdzZkQQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 07:31:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18205

On Sat Oct 18, 2025 at 3:18 PM CEST, Adam Blank wrote:
[...]
>> > --  *subdir:* Unpacks the specific URL to the specified subdirectory
>> > -   within the root directory.
>> > +-  *"subdir":* Unpacks the specific URL to the specified subdirectory
>> > +   within the specified root directory. This path can be further
>> modified
>> > +   by fetcher specific parameters.
>>
>> I'm not sure I get what you mean here. Could you give a short example?
>>
>>
> Sure, this is what the Git fetcher does for example (those are the actual
> code fragments):
> subdir =3D ud.parm.get("subdir")
> destdir =3D os.path.join(destdir, subdir)
> destdir =3D =3D os.path.join(destdir, destsuffix)
> As you can see, the Git specific 'destsuffix' will be daisy-chained with
> the more generic 'subdir'.

Ah I see, ok, thanks.

[...]
>> >  Auto Revisions
>> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > -We need to document ``AUTOREV`` and :term:`SRCREV_FORMAT` here.
>> > +For recipes which need to use the latest revision of their source cod=
e,
>> > +the way to achieve it is to use :term:`AUTOREV` as the value of the
>> > +source code repository's :term:`SRCREV`::
>>
>> Suggestion: simplify the sentence to:
>>
>> """
>> For recipes which need to use the latest revision of their source code,
>> the way to achieve it is to set :term:`SRCREV` to :term:`AUTOREV` in the
>> recipe::
>> """
>>
>>
> I beg to differ. As a non-native English speaker, I would understand this
> to mean
> 'SRCREV =3D "AUTOREV"', which is a different thing entirely. In my opinio=
n
> those few extra
> words are a small cost compared to the comprehensibility they provide.

I understand it your way now which is clearer.

>> > +
>> > +   SRCREV =3D "${AUTOREV}"
>> > +
>> > +In this case, to properly show the revision information in the
>> package's version
>> > +string, :term:`PV` should be set to include the ``+`` sign.
>>
>> I'm quite sure this logic is not part of Bitbake but OE-Core:
>>
>> https://git.openembedded.org/openembedded-core/tree/meta/classes-global/=
package.bbclass#n317
>>
>> I'm not sure having the "+" in PV adds anything for standalone Bitbake, =
so
>> I'd
>> remove this sentence.
>>
>>
> Sure, no problem.
>
>
>> > +
>> > +.. note::
>> > +
>> > +   With :term:`AUTOREV`, BitBake will always need to take the
>> additional step of
>> > +   querying the remore repository to retrieve the latest available
>> revision.
>>
>> s/remore/remote
>>
>> > +
>> > +   Also, recipes using it don't benefit from the caching mechanism.
>>
>> I just made a quick test:
>>
>> - Set SRCREV =3D "${AUTOREV}" for the procps recipe in OE-Core.
>> - bitbake -c unpack procps -> unpacks the source code
>> - bitbake -c unpack procps -> "Attempted 3 tasks of which 3 didn't need =
to
>> be
>>   rerun and all succeeded."
>>
>> So I think bitbake does not rebuild when the remote hasn't changed, and
>> recipes
>> do benefit from the sstate-cache?
>>
>>
> I did the same test, but adding the following line:
> python() {
>     bb.error("Reparsing %s" % d.getVar('PN'))
> }
> Having this line, calling 'bitbake procs' shows that it gets reparsed eve=
ry
> time in the case
> where it uses AUTOREV.
>
> Regardless, my intention was to hint to the user, that the effects of the
> following code can be
> expected (again, taken from the Git fetcher):
> def _latest_revision(self, ud, d, name):
>     bb.fetch2.mark_recipe_nocache(d)
>
> I don't know what (if any) would be a better choice of words. Perhaps thi=
s?
> """
> don't benefit from all the caching mechanisms
> """

I see, I assumed sstate-cache. I think what is correct to say is: "this rec=
ipe
is not part of the parsing-time cache and so is parsed everytime BitBake is=
 run."

>
>> > +Multiple Source Control Repositories
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > +
>> > +For some recipes it is necessary to make use of more than one
>> > +version controlled source code repository. It such case, the recipe
>>
>> s/It/In/
>>
>> > +must provide BitBake with information about how it should include
>> > +all those SCM versions in its package version string, instead of its
>>
>> s/all those SCM versions/the different SCM revisions/
>>
>> would sound better IMO.
>>
>> > +usual approach with a single :term:`SRCREV`.
>> > +
>> > +For this purpose, the recipe must set the :term:`SRCREV_FORMAT`
>> > +variable. One notable example is the OpenEmbedded
>> ``kernel-yocto.bbclass``::
>>
>> It would be nice to keep example free of OpenEmbedded references. Can yo=
u
>> convert it to another example, without mentioning it?
>>
>>
> Of course. I was merely attempting to stick to the 'convention' from this
> file, where base.bbclass
> was referenced.
>
>
>> > +
>> > +   SRCREV_FORMAT ?=3D "meta_machine"
>>
>> > +
>> > +The value given to :term:`SRCREV_FORMAT` references names, which were
>>
>> Suggestion:
>>
>> """
>> The value given to :term:`SRCREV_FORMAT` references names separated by
>> underscores ("_"), which are assigned...
>> """
>>
>>
> Hmmm. What would be the grounds for that? There is no such limitation in
> the code.
> In fact, even such abomination gets through:
> 'SRCREV_FORMAT =3D "adam@machine@meta@blank"' and successfully produces a
> package:
> Image--5.15.173+git0+adam@fa3f7978db@567f0adb9d@blank-r0-beetroot
> -20251018125101.bin

I wasn't aware other characters could be used to separate entried here. Tha=
nks!

>> > +assigned using the ``name`` parameter to those components of
>> :term:`SRC_URI`,
>>
>> Suggestion:
>>
>> """
>> assigned using the ``name`` parameter in an :term:`SRC_URI` definition.
>> """
>>
>> > +which represent the version controlled source code repositories. In t=
he
>> above
>> > +example, the :term:`SRC_URI` contained two URLs named "meta" and
>> "machine".
>>
>> IMO, it is important to give an example of the corresponding SRC_URI
>> definition
>> here. Users reading this will understand better with the full picture.
>>
>>
> Sure thing.
>
>
>> > diff --git
>> a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> > index 810f88689..9256c20b6 100644
>> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> > @@ -36,6 +36,14 @@ overview of their function and contents.
>> >        when specified allows for the Git binary from the host to be us=
ed
>> >        rather than building ``git-native``.
>> >
>> > +   :term:`AUTOREV`
>> > +      This is a special variable used during fetching. When
>> :term:`SRCREV` is
>> > +      set to the value of this variable, it means that the latest
>> revision
>> > +      from the version controlled source code repository should be us=
ed.
>>
>> Suggestion:
>>
>> """
>> ...set to the value of this variable, the latest revision from the versi=
on
>> controlled source code repository is used.
>> """
>>
>> > +      Here is an example::
>>
>> """
>> It should be set as follows:
>> """
>>
>> There's no other way of using AUTOREV I think, so it's not really an
>> example.
>>
>> > +
>> > +         SRCREV =3D "${AUTOREV}"
>> > +
>> >     :term:`AZ_SAS`
>> >        Azure Storage Shared Access Signature, when using the
>> >        :ref:`Azure Storage fetcher
>> <bitbake-user-manual/bitbake-user-manual-fetching:fetchers>`
>> > @@ -1622,7 +1630,8 @@ overview of their function and contents.
>> >
>> >        -  ``name``: Specifies a name to be used for association with
>> >           :term:`SRC_URI` checksums or :term:`SRCREV` when you have mo=
re
>> than one
>> > -         file or git repository specified in :term:`SRC_URI`. For
>> example::
>> > +         file or source control repository specified in :term:`SRC_UR=
I`.
>> > +         For example::
>> >
>> >              SRC_URI =3D "git://example.com/foo.git;branch=3Dmain;name=
=3Dfirst
>> \
>> >                         git://
>> example.com/bar.git;branch=3Dmain;name=3Dsecond \
>> > @@ -1635,7 +1644,8 @@ overview of their function and contents.
>> >        -  ``subdir``: Places the file (or extracts its contents) into =
the
>> >           specified subdirectory. This option is useful for unusual
>> tarballs
>> >           or other archives that do not have their files already in a
>> > -         subdirectory within the archive.
>> > +         subdirectory within the archive. This path can be further
>> modified
>> > +         by fetcher specific parameters.
>>
>> Ditto: I'm not sure I get what you mean here. Could you give a short
>> example
>> maybe?
>>
>> >
>> >        -  ``subpath``: Limits the checkout to a specific subpath of th=
e
>> >           tree when using the Git fetcher is used.
>> > @@ -1657,11 +1667,11 @@ overview of their function and contents.
>> >        identifier and not just a tag.
>> >
>> >     :term:`SRCREV_FORMAT`
>> > -      Helps construct valid :term:`SRCREV` values when
>> > +      Helps construct a valid package version string when
>>
>> I'm not sure why this changed. This variable does help constructing
>> multiple
>> SRCREV values. Package version strings are just a by-product of using it=
,
>> no?
>>
>>
> Perhaps it is again a point of view of a non-native English speaker, but =
it
> sounded false to
> my ear. The way it was phrased suggested, that SRCREV_FORMAT is in some w=
ay
> a
> prerequisite or an input to the final value of some SRCREV* variables. If
> fact though, it is used solely as
> a formatter, into which Bitbake will plug the already pre-existing values
> of 'named'
> SRCREV variables, to provide a string which will later be used (outside o=
f
> BitBake) for PKGV.

I see that clearly now, understood.

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


