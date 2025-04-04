Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC25C36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 15:12:44 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web10.13984.1743779562211419344
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Apr 2025 08:12:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=k+z9PRvP;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5499d2134e8so2572911e87.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Apr 2025 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743779560; x=1744384360; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzywEQVCKPMG2bk9LwjXKl09xx2yEZs4mNcV9PvoHu8=;
        b=k+z9PRvPmbzQjUFUb3uVuAPcf49R35lbuHOyZrDJ33JbLt5zckPbvmcBcysQTHYkWO
         kGh495RDQg9AVNVXIcVeO/goKc3K5SCtpXE6N5QVA+zBhGiiR66wexWka9ZpnFCnBedW
         KOQMugprmqDZSK2hWmnNk4U+n58zud1XYjTnps5atM/gz3fwJ+LEiNpxE0NXecGh1AHD
         k4hc3aUJH/P4Yt06S2EiM+qKwcIWF7LkGQYLIv6UuXGYQQ0pgV70gjZ2otJLEzIkg8dV
         bvnWGLN8OSyK19slp81VajmhxJH6JnTpaGmjxnCEhfCpxWvbIhIZ0uUIryzMbgP7qbu8
         CnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743779560; x=1744384360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzywEQVCKPMG2bk9LwjXKl09xx2yEZs4mNcV9PvoHu8=;
        b=h4lkE3SZHULbUzB9DsbU+wC9px00cSHvzzJMGIEpxkC0pS4Ha4C2nmSdCywLTChBRV
         l1fEX+30yOno+M6cYUrchYdf+AqSCmh0ov5QFA5AXiS8Va1ySBJcDBcSUkHspqeCypEy
         0/nccsw4utQX3IHel7V/kQL7FEkkxX7gI+9t/A+Wkd+G8nALO2477b9ssV0AW8tGmHKe
         boCoV/kfxTV4Pfp/noQPCbL4P2fC8kNHdFDApSLBd0Wd2BD0zYf7onwGGIH1Gysf+nUC
         6m6H2qkGrpWpOiTDJ9iskQw1y0BoSn+3QrpfiweEdZvdxTjIZFj5UtTF6zCSci1v6EgM
         /doQ==
X-Gm-Message-State: AOJu0YykeQnjolHXOqBcmAlD1/FwZ8elk3QqVIGKZSbOpj7ySH5JLbfG
	9U10pTUa4BljqVvkz1cWHEyowtoeb+CNOzISn6zVwDKwQ03tlo+UeYkbEJrTFwBsnVNqTcUHpy9
	FBoJqA7zuUOlM+qK3DACqTOiuMEA=
X-Gm-Gg: ASbGncsUVfYgYL1m0ty4+hbeNNnMAtZxG3oV2JqJeH1myBAwkqCqHtyxGU8jzrua6Ei
	uVsPYHIldqY1Bm/BDdIoU317X6k8i9RwL+jbhl4dEjFVHaSVf5iMpsr0GxDlDw+aHDCHDEitqD8
	f3M7W+AfhagBH8kWuHisPfdXnDmkog
X-Google-Smtp-Source: AGHT+IGOGscJzNxjFymBkQPX6KbStYyRa5bYmeG1op0xcGmsAA7K12e+lTgZA1SO9DLmX7uaad/2M3QCzvyLnNBmRys=
X-Received: by 2002:a05:6512:3f2a:b0:545:1d96:d702 with SMTP id
 2adb3069b0e04-54c22845b20mr1122590e87.48.1743779559895; Fri, 04 Apr 2025
 08:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250402091303.2346229-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250402091303.2346229-1-richard.purdie@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 4 Apr 2025 17:12:27 +0200
X-Gm-Features: ATxdqUGs_UiUQhNR0g0PNdLH1ki_2IK3ft4jJmvF0X08s7odxc15BixIhdAiVMA
Message-ID: <CA+chaQc38CF0yZTDE5XifNE5DCyP1sNOBv+1NvAt1Cg9339c+A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] parse/ConfHandler: Add warning for
 deprecated whitespace usage
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Apr 2025 15:12:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17516

Acked-by: Martin Jansa <martin.jansa@gmail.com>

I've sent an update to avoid warnings for few more layers which are
included in some of my builds (meta-filesystems, meta-arm,
meta-virtualization, meta-webos-ports, meta-webosose, meta-qt5,
meta-qt6, meta-raspberrypi and internal LGE layers).

I wrote a silly script which quickly proved that writing regexp with
sed which works correctly across all various shell/python/bitbake
syntaxes supported by bitbake is more difficult than initially
expected (as it can contain shell variables, bitbake variables, $, ',
", [], $@, ...).

That's why there are multiple versions (which might help in some cases
if you layer has many similar cases) and the comments documenting the
limitations and false-positives are longer than the original one-liner
I was using for the migration. Last couple cases where the script
didn't work I've usually adjusted manually. It was still useful for me
when doing the migrations and feel free to use it at your own risk.
"bitbake -nk world 2>&1 | tee world.log" and then pass the world.log
to the script.

#!/bin/bash

# https://lists.openembedded.org/g/bitbake-devel/message/17508

LOG=3D$1

# it's a bit silly and simple but resolved 99% of the issues in layers I'm =
using
grep WARNING:.*whitespace.around.the.assignment $LOG | sort -u | while
read LINE; do
    # there could be 2 paths as in:
    # WARNING: meta-webos/recipes-core/packagegroups/packagegroup-core-tool=
s-profile.bbappend:10
has a lack of whitespace around the assignment: 'LTTNGTOOLS:no-lttng=3D
""'
    # WARNING: oe-core/meta/recipes-core/packagegroups/packagegroup-core-to=
ols-profile.bb:
meta-webos/recipes-core/packagegroups/packagegroup-core-tools-profile.bbapp=
end:10
has a lack of whitespace around the assignment: 'LTTNGTOOLS:no-lt
tng=3D ""'
    # but some global files will be shown only once e.g.:
    # WARNING: meta-foo/conf/layer.conf:10 has a lack of whitespace
around the assignment: 'BBFILE_PATTERN_meta-foo:=3D "^${LAYERDIR}/"'
    # the paths are full, I've just stripped the TOPDIR prefix
    # always take the one with lineno which is what we want to change

    f=3D`echo $LINE | sed "s/^WARNING: \([^:]*:
\)*\([^:]\+\):\([0-9]\+\) has a lack of whitespace around the
assignment: '\(.*\)'$/\2/g"`
    #l=3D`echo $LINE | sed "s/^WARNING: \([^:]*:
\)*\([^:]\+\):\([0-9]\+\) has a lack of whitespace around the
assignment: '\(.*\)'$/\3/g"`
    p=3D`echo $LINE | sed "s/^WARNING: \([^:]*:
\)*\([^:]\+\):\([0-9]\+\) has a lack of whitespace around the
assignment: '\(.*\)'$/\4/g"`

    if [ ! -f "$f" ] ; then
        echo "ERROR: failed to parse filename from $LINE"
        continue
    fi

    for o in ??=3D ?=3D +=3D =3D+ :=3D \\\\.=3D =3D\\\\. =3D; do
        # replace only first one found to avoid adding space in ??=3D
(when doing ?=3D) or +=3D (when doing =3D)
        if echo $p | grep -qG "[^ ]$o" || echo $p | grep -qG "$o[^ ]"; then
            pp=3D$(echo $p | sed "s/ *$o */ $o /g; s/^'//g; s/'$//g")
            echo "sed -i 's@$p@$pp@g' $f"
            # some cases might have ^ like in "^${LAYERDIR}/", so use
e.g. @ to convert them,
            # but @ is often used in ${@..} so pick a character not
used in the WARNINGs you got.

            # there are some other limitations as well as some
patterns might have ' or " in them
            # or both typically with ${@..}, e.g. one of mine:
            # 'WEBOS_SUBMISSION_NUMBER=3D"${@
'${WEBOS_SUBMISSION}'.split('.')[-1] }"'
            # either fix those manually or with manual sed matching
just a part of it.

            # another case where this won't work are variables with
line breaks e.g.:
            # 'CXXFLAGS +=3D"
-I${STAGING_INCDIR}/media-resource-calculator-clang
-I${STAGING_INCDIR}/cbe "'
            # is triggered on recipe which has:
            # CXXFLAGS +=3D" \
            #    -I${STAGING_INCDIR}/media-resource-calculator-clang \
            #    -I${STAGING_INCDIR}/cbe \
            # "
            # and the regexp again doesn't work

            # it also doesn't work well on cases like:
            # 'EXTRA_OEMAKE=3D"BUILDTAGS=3D''"'
            # often used in meta-virtualization where only first =3D
should have spaces around

            # sed -i 's^'"$p"'^'"$pp"'^g' $f
            # sed -i 's@'"$p"'@'"$pp"'@g' $f
            sed -i 's&'"$p"'&'"$pp"'&g' $f
            break;
        fi
    done
done

On Wed, Apr 2, 2025 at 11:13=E2=80=AFAM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> A lack of whitespace around variable assignment operators makes the
> files harder to read.
>
> There is a deeper issue in that a "+" character can sometimes be confused
> between the variable name and the assignment operator.
>
> Start showing warnings for such usage so we encourage people to use
> consistent whitespace which helps with file readability in general.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/parse/parse_py/ConfHandler.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py=
/ConfHandler.py
> index 1bde597254..675838d845 100644
> --- a/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/lib/bb/parse/parse_py/ConfHandler.py
> @@ -23,7 +23,7 @@ __config_regexp__  =3D re.compile( r"""
>      (?P<var>[a-zA-Z0-9\-_+.${}/~:]*?)
>      (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@/]*)\])?
>
> -    \s* (
> +    (?P<whitespace>\s*) (
>          (?P<colon>:=3D) |
>          (?P<lazyques>\?\?=3D) |
>          (?P<ques>\?=3D) |
> @@ -32,7 +32,7 @@ __config_regexp__  =3D re.compile( r"""
>          (?P<predot>=3D\.) |
>          (?P<postdot>\.=3D) |
>          =3D
> -    ) \s*
> +    ) (?P<whitespace2>\s*)
>
>      (?!'[^']*'[^']*'$)
>      (?!\"[^\"]*\"[^\"]*\"$)
> @@ -168,6 +168,8 @@ def feeder(lineno, s, fn, statements, baseconfig=3DFa=
lse, conffile=3DTrue):
>          groupd =3D m.groupdict()
>          if groupd['var'] =3D=3D "":
>              raise ParseError("Empty variable name in assignment: '%s'" %=
 s, fn, lineno);
> +        if not groupd['whitespace'] or not groupd['whitespace2']:
> +            logger.warning("%s:%s has a lack of whitespace around the as=
signment: '%s'" % (fn, lineno, s))
>          ast.handleData(statements, fn, lineno, groupd)
>          return
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17508): https://lists.openembedded.org/g/bitbake-deve=
l/message/17508
> Mute This Topic: https://lists.openembedded.org/mt/112043500/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [martin=
.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

