Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAB6C433F5
	for <webhook@archiver.kernel.org>; Sat, 20 Nov 2021 17:54:05 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web12.969.1637430843577050226
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Nov 2021 09:54:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=UPEyaLd4;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1637430844;
  x=1668966844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BLlmRb8aSw26MtqNKnSM2lZG0yDzJFp9D/Rw2R+Yc2c=;
  b=UPEyaLd4KloxmR9eWgc02zPrJD7BFhMz+ybnzSam4a/oXVEjWQnY+kqW
   QOVibg/qVvkXFIvA2ruINidipixIkPauFEPRQ4ohwdnknXTw2gJi6WHmE
   ZRHoA1v/X2o+jtP6RDZAMrF9gHVKfLhC5XAWg7bhmAKbRzC/88J6h5Avy
   dgtao2MF8150kJ+K14xJmW9+YnxvAUogL+974cZgdrYXE5GfGq2dZBuiu
   SMHJVM3G+1r27WhLsdmksiL5/+56tjKXtj12p/M1BEY8jGbmt7eHA0zEG
   uAdy05MaLwVKotlD3jDv7H4Mq916fFNJOaruDoSKkt5y4IUgEbqPMi0RY
   g==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Subject: RE: [bitbake-devel] [PATCH] bitbake-user-manual: fix backslash issues
Thread-Topic: [bitbake-devel] [PATCH] bitbake-user-manual: fix backslash
 issues
Thread-Index: AQHX3We8WJtFNZn8vES+Qwd0VG/faKwMsxzg
Date: Sat, 20 Nov 2021 17:53:55 +0000
Message-ID: <185ef6ca05f246dd88a48b224f153663@axis.com>
References: <20211119170554.1972442-1-michael.opdenacker@bootlin.com>
In-Reply-To: <20211119170554.1972442-1-michael.opdenacker@bootlin.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 20 Nov 2021 17:54:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13081

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Michael Opdenacker
> Sent: den 19 november 2021 18:06
> To: bitbake-devel@lists.openembedded.org
> Cc: docs@lists.yoctoproject.org; Michael Opdenacker <michael.opdenacker@b=
ootlin.com>
> Subject: [bitbake-devel] [PATCH] bitbake-user-manual: fix backslash issue=
s
>=20
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  .../bitbake-user-manual-fetching.rst          | 20 +++++++++----------
>  .../bitbake-user-manual-metadata.rst          | 10 +++++-----
>  2 files changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index 4396830a..260d43ab 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -84,18 +84,18 @@ fetcher does know how to use HTTP as a transport.
>  Here are some examples that show commonly used mirror definitions::
>=20
>     PREMIRRORS ?=3D "\
> -      bzr://.*/.\*  http://somemirror.org/sources/ \\n \
> -      cvs://.*/.\*  http://somemirror.org/sources/ \\n \
> -      git://.*/.\*  http://somemirror.org/sources/ \\n \
> -      hg://.*/.\*   http://somemirror.org/sources/ \\n \
> -      osc://.*/.\*  http://somemirror.org/sources/ \\n \
> -      p4://.*/.\*   http://somemirror.org/sources/ \\n \
> -     svn://.*/.\*   http://somemirror.org/sources/ \\n"
> +      bzr://.*/.\*  http://somemirror.org/sources/ \n \
> +      cvs://.*/.\*  http://somemirror.org/sources/ \n \
> +      git://.*/.\*  http://somemirror.org/sources/ \n \
> +      hg://.*/.\*   http://somemirror.org/sources/ \n \
> +      osc://.*/.\*  http://somemirror.org/sources/ \n \
> +      p4://.*/.\*   http://somemirror.org/sources/ \n \
> +     svn://.*/.\*   http://somemirror.org/sources/ \n"
>=20
>     MIRRORS =3D+ "\
> -      ftp://.*/.\*   http://somemirror.org/sources/ \\n \
> -      http://.*/.\*  http://somemirror.org/sources/ \\n \
> -      https://.*/.\* http://somemirror.org/sources/ \\n"
> +      ftp://.*/.\*   http://somemirror.org/sources/ \n \
> +      http://.*/.\*  http://somemirror.org/sources/ \n \
> +      https://.*/.\* http://somemirror.org/sources/ \n"

These were all recently corrected in OE-Core to remove the \n as they=20
have not been needed for a long time, so I suggest you do the same here.

>  It is useful to note that BitBake
>  supports cross-URLs. It is possible to mirror a Git repository on an
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 119720d5..46bcfa60 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -104,15 +104,15 @@ Line Joining
>=20
>  Outside of :ref:`functions <bitbake-user-manual/bitbake-user-manual-meta=
data:functions>`,
>  BitBake joins any line ending in
> -a backslash character ("\") with the following line before parsing
> -statements. The most common use for the "\" character is to split
> +a backslash character ("\\") with the following line before parsing
> +statements. The most common use for the "\\" character is to split
>  variable assignments over multiple lines, as in the following example::
>=20
>     FOO =3D "bar \
>            baz \
>            qaz"
>=20
> -Both the "\" character and the newline
> +Both the "\\" character and the newline
>  character that follow it are removed when joining lines. Thus, no
>  newline characters end up in the value of ``FOO``.
>=20
> @@ -125,7 +125,7 @@ Consider this additional example where the two assign=
ments both assign
>=20
>  .. note::
>=20
> -   BitBake does not interpret escape sequences like "\n" in variable
> +   BitBake does not interpret escape sequences like "\\n" in variable
>     values. For these to have an effect, the value must be passed to some
>     utility that interprets escape sequences, such as
>     ``printf`` or ``echo -n``.
> @@ -159,7 +159,7 @@ behavior::
>     C =3D "qux"
>     *At this point, ${A} equals "qux bar baz"*
>     B =3D "norf"
> -   *At this point, ${A} equals "norf baz"\*
> +   *At this point, ${A} equals "norf baz"*
>=20
>  Contrast this behavior with the
>  :ref:`bitbake-user-manual/bitbake-user-manual-metadata:immediate variabl=
e
> --
> 2.25.1

//Peter


