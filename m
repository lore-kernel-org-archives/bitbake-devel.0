Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA14EC3601E
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 06:37:18 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web10.28070.1744267028412161240
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Apr 2025 23:37:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kd+Oyl0c;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30db1bc464dso4004911fa.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Apr 2025 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744267026; x=1744871826; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWpg4cDvrgml2Nat8ezmH+PGOOqNeyOL2uQjlmJyw9s=;
        b=kd+Oyl0c5i6cZR3g1wKAyQA+6hg88q0/dm/FL4MK3/mJ8XnHCDrK5ZG1S2DXV/RHIF
         FmRnsk1USos1FcOuw7RnMdmr9kvINdxfPXrN/7nQLITcZeaozhnnhrtaN8ZRzF4VGsIE
         ZFP5+s1NqChefLagvirFyyrM35xh3AjAHLrUZsPiDfxuovOyMP0eDNcD4Zhfj9P3A7si
         M62jZc9v+TS4vU6unn0R7Txv64eLfX9Yc4MS0WMZrbC+xK8lkx3MtOyQPhHWYI+jpDmu
         WDS6729jw4xWXIYCFih4JaljROtkXKrZGmWfvxp8/voiUympFKnv8EyhH/KEOfCJDLUT
         ERHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744267026; x=1744871826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWpg4cDvrgml2Nat8ezmH+PGOOqNeyOL2uQjlmJyw9s=;
        b=DCVGB/e6FQFbzuxYZEY//3Iu5ZDGFyHSf2NrkGJR5iRsioEHANyIfBkVnn/ihOxsCZ
         P7OVpk45llE5xGPLxtpwyaJiOFJfNYfdzsUiyL3jrl/pprEL3oHljIijWH6u2oWqGdiJ
         sZhUw/J0EZKqxk1Bdt2jbcjOgS8Yos6YNGxpNK32iNfGhzm8sadQTzT4Al2zRHuWKQIH
         COCNz+u9x35jPJlwKBtJ+MYnS/HYDquCjRzUzdaj+as634l05LrksSx30rD/6/jKm3hh
         /wsdBKT2x6JurCkaUPckEvFyjkfSCdiLeG4l3qwLZV1vWD0NMgcaQNFUJ8R93WR8qNX+
         FpLg==
X-Forwarded-Encrypted: i=1; AJvYcCUNMu7z65mR/BDm7gnmSfm9JAk4rrMwVLzFuoTUf7jUE3vqGzq27cRDJD/mk/TY1imIi1k55+BhtrXyoriP@lists.openembedded.org
X-Gm-Message-State: AOJu0YzO19FTu+xlYKuq2yPV2dRSGtOzVyoDR36GQG9JV7Khjj8YqhRK
	8IgLvOTFiVE79Gzlalf4At17J1A27mMDgkjvleuDxyPmytkqGWl76dCtLmfz1hQiecxAPrATR5o
	s1woXzPIswBtXQo2c0qz4Qn85IGg=
X-Gm-Gg: ASbGncvy4IPGpaHCrvWr/6LRzPouowJlLWYNaf/R8nCbtyjlpy/U8/EL39FGjGD3QYN
	YlckP/03pvFelEF88E8Db/pWLAJnWpg8uRSm/NgZKGwGGuA0V9u2hV10GHq/Stst1xtBikgMpKG
	aTFQ9x15J0Hym5ZpvbzjzFb54660W7H0v6k6s=
X-Google-Smtp-Source: AGHT+IFqwHptH79MRm5GjuMEFNgEFN2JTAaT73H6Mp5Z0DRkfa1hP+1vra3H/6sbwmS+euIhGks7fzq3VIDJYK8FxNs=
X-Received: by 2002:a05:651c:2118:b0:30b:cb10:3a20 with SMTP id
 38308e7fff4ca-30faccb2938mr6131831fa.32.1744267026242; Wed, 09 Apr 2025
 23:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250402091303.2346229-1-richard.purdie@linuxfoundation.org> <18332645F6CADDA9.4816@lists.openembedded.org>
In-Reply-To: <18332645F6CADDA9.4816@lists.openembedded.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 10 Apr 2025 08:36:55 +0200
X-Gm-Features: ATxdqUFjhsJWddKFTt5YglbMZD95nx34p0qY5GpAfXZmz_omrGvoIKlsSJdctZU
Message-ID: <CA+chaQfjYPV9Lg-jgMPFcFduWszCBer4_-Nj7a=QvRqD8w-d0w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] parse/ConfHandler: Add warning for
 deprecated whitespace usage
To: martin.jansa@gmail.com
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Apr 2025 06:37:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17524

On Fri, Apr 4, 2025 at 5:12=E2=80=AFPM Martin Jansa via lists.openembedded.=
org
<martin.jansa=3Dgmail.com@lists.openembedded.org> wrote:
>
> Acked-by: Martin Jansa <martin.jansa@gmail.com>
>
> I've sent an update to avoid warnings for few more layers which are
> included in some of my builds (meta-filesystems, meta-arm,
> meta-virtualization, meta-webos-ports, meta-webosose, meta-qt5,
> meta-qt6, meta-raspberrypi and internal LGE layers).
>
> I wrote a silly script which quickly proved that writing regexp with
> sed which works correctly across all various shell/python/bitbake
> syntaxes supported by bitbake is more difficult than initially
> expected (as it can contain shell variables, bitbake variables, $, ',
> ", [], $@, ...).
>
> That's why there are multiple versions (which might help in some cases
> if you layer has many similar cases) and the comments documenting the
> limitations and false-positives are longer than the original one-liner
> I was using for the migration. Last couple cases where the script
> didn't work I've usually adjusted manually. It was still useful for me
> when doing the migrations and feel free to use it at your own risk.
> "bitbake -nk world 2>&1 | tee world.log" and then pass the world.log
> to the script.
>
> #!/bin/bash
>
> # https://lists.openembedded.org/g/bitbake-devel/message/17508
>
> LOG=3D$1
>
> # it's a bit silly and simple but resolved 99% of the issues in layers I'=
m using
> grep WARNING:.*whitespace.around.the.assignment $LOG | sort -u | while
> read LINE; do
>     # there could be 2 paths as in:
>     # WARNING: meta-webos/recipes-core/packagegroups/packagegroup-core-to=
ols-profile.bbappend:10
> has a lack of whitespace around the assignment: 'LTTNGTOOLS:no-lttng=3D
> ""'
>     # WARNING: oe-core/meta/recipes-core/packagegroups/packagegroup-core-=
tools-profile.bb:
> meta-webos/recipes-core/packagegroups/packagegroup-core-tools-profile.bba=
ppend:10
> has a lack of whitespace around the assignment: 'LTTNGTOOLS:no-lt
> tng=3D ""'
>     # but some global files will be shown only once e.g.:
>     # WARNING: meta-foo/conf/layer.conf:10 has a lack of whitespace
> around the assignment: 'BBFILE_PATTERN_meta-foo:=3D "^${LAYERDIR}/"'
>     # the paths are full, I've just stripped the TOPDIR prefix
>     # always take the one with lineno which is what we want to change
>
>     f=3D`echo $LINE | sed "s/^WARNING: \([^:]*:
> \)*\([^:]\+\):\([0-9]\+\) has a lack of whitespace around the
> assignment: '\(.*\)'$/\2/g"`
>     #l=3D`echo $LINE | sed "s/^WARNING: \([^:]*:
> \)*\([^:]\+\):\([0-9]\+\) has a lack of whitespace around the
> assignment: '\(.*\)'$/\3/g"`
>     p=3D`echo $LINE | sed "s/^WARNING: \([^:]*:
> \)*\([^:]\+\):\([0-9]\+\) has a lack of whitespace around the
> assignment: '\(.*\)'$/\4/g"`
>
>     if [ ! -f "$f" ] ; then
>         echo "ERROR: failed to parse filename from $LINE"
>         continue
>     fi
>
>     for o in ??=3D ?=3D +=3D =3D+ :=3D \\\\.=3D =3D\\\\. =3D; do
>         # replace only first one found to avoid adding space in ??=3D
> (when doing ?=3D) or +=3D (when doing =3D)
>         if echo $p | grep -qG "[^ ]$o" || echo $p | grep -qG "$o[^ ]"; th=
en
>             pp=3D$(echo $p | sed "s/ *$o */ $o /g; s/^'//g; s/'$//g")
>             echo "sed -i 's@$p@$pp@g' $f"
>             # some cases might have ^ like in "^${LAYERDIR}/", so use
> e.g. @ to convert them,
>             # but @ is often used in ${@..} so pick a character not
> used in the WARNINGs you got.
>
>             # there are some other limitations as well as some
> patterns might have ' or " in them
>             # or both typically with ${@..}, e.g. one of mine:
>             # 'WEBOS_SUBMISSION_NUMBER=3D"${@
> '${WEBOS_SUBMISSION}'.split('.')[-1] }"'
>             # either fix those manually or with manual sed matching
> just a part of it.
>
>             # another case where this won't work are variables with
> line breaks e.g.:
>             # 'CXXFLAGS +=3D"
> -I${STAGING_INCDIR}/media-resource-calculator-clang
> -I${STAGING_INCDIR}/cbe "'
>             # is triggered on recipe which has:
>             # CXXFLAGS +=3D" \
>             #    -I${STAGING_INCDIR}/media-resource-calculator-clang \
>             #    -I${STAGING_INCDIR}/cbe \
>             # "
>             # and the regexp again doesn't work
>
>             # it also doesn't work well on cases like:
>             # 'EXTRA_OEMAKE=3D"BUILDTAGS=3D''"'
>             # often used in meta-virtualization where only first =3D
> should have spaces around
>
>             # sed -i 's^'"$p"'^'"$pp"'^g' $f
>             # sed -i 's@'"$p"'@'"$pp"'@g' $f
>             sed -i 's&'"$p"'&'"$pp"'&g' $f
>             break;
>         fi
>     done
> done

Bruce was brave enough trying to use this yesterday and mentioned that
the long lines were wrapped in e-mail (as I haven't send it with git
send-email), here is it as a file:

https://github.com/shr-project/meta-webosose/blob/jansa/master/meta-webos/s=
cripts/add-whitespace-around-assignment.sh

I also forgot to mention that the warnings are shown only when it's
not parsed in cache, so if you want to re-run it after initial pass
then remove the parser cache before calling bitbake again.

Cheers,

