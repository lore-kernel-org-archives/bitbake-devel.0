Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0025DC433EF
	for <webhook@archiver.kernel.org>; Sat,  9 Jul 2022 06:52:24 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web08.3966.1657349535804476601
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Jul 2022 23:52:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A3Zvy8rU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id
 v10-20020a05600c15ca00b003a2db8aa2c4so357394wmf.2
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Jul 2022 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=OF9cNbSOp7nN2KMEqK/gJWxynFXIvzuxc4y6k3OMxAk=;
        b=A3Zvy8rU6A07LBTi71pBHAjqJf1SYQGq+uUx4UIMPqpJxZu1HuMYj3IDR3hdNtke92
         OMNEjd7/KKFQuCfViDkbKdgfWUEn8LOwCz2oEQ1TZ7JEzGRgRq3fDaiDL7C4CzlmLWRd
         QxiiqgOJr/AoFLf2n++9UHIfzb3Y2pnIDy23A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=OF9cNbSOp7nN2KMEqK/gJWxynFXIvzuxc4y6k3OMxAk=;
        b=utOltlQHzLazYALEvOotGvMUZ6g5ZTyavFqbOl8df3NZvE7zCK7E8S3pg/HL3h9Lq8
         MpbnGsyF3G+zHiJ8yUy4BV2nULdLe3ep0FvZ3i0B2bMJqyVgb9nXZhiCknocgcgXkaE2
         RCWA8TmDw0H+A9+kiO9u2esva7WuL9y83Ipj6ZjD4ZpfXqlbJK2TmuAbkOne8D3yeFsb
         RDDJuTK6s5S7YO+1z5abdkrSpVQ3uRJlz0XzXdyMx8uL/cBk2fzfpvDPI5WYaMaJoBKE
         U9h6/HrSHairqdbagnLCGpDHjcabntthf8HTYwX6MuqEx0nIG6V5Huz2pQT6nqw6l7HS
         76Aw==
X-Gm-Message-State: AJIora92jTGAMZnlTPZH4Y58scDn8ffNJBgTkNj+MmYkJ4jP+GGIsUrS
	k2LxdIi/xbNifuUM5MoA8EwsQA==
X-Google-Smtp-Source: 
 AGRyM1v+9i8njI3V0lcuEWYxiEQEzniRw1xmzUimWK7UnfKLwh7wPef7DWvbkQc6xhZZrDCVqUuzGg==
X-Received: by 2002:a05:600c:35ca:b0:3a2:aee3:a8ff with SMTP id
 r10-20020a05600c35ca00b003a2aee3a8ffmr3827622wmq.206.1657349534134;
        Fri, 08 Jul 2022 23:52:14 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:78bd:8c65:f2d6:6780?
 ([2001:8b0:aba:5f3c:78bd:8c65:f2d6:6780])
        by smtp.gmail.com with ESMTPSA id
 r1-20020a5d6941000000b00210bac248c8sm727100wrw.11.2022.07.08.23.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 23:52:13 -0700 (PDT)
Message-ID: 
 <c677e1a7cedcd974e9ecd6b0bb4aefdcd240932f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch2: local files only in DL_DIR
 becomes fatal error
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paulo Neves <ptsneves@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Sat, 09 Jul 2022 07:52:12 +0100
In-Reply-To: <20220708205407.1680137-1-ptsneves@gmail.com>
References: <20220708205407.1680137-1-ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 Jul 2022 06:52:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13814

On Fri, 2022-07-08 at 22:54 +0200, Paulo Neves wrote:
> When trying to checksum local files, if a given file is not found
> anywhere else than the DL_DIR then this means that the the build is
> inconsistent, and unreproducible.
>=20
> This also means that if the DL_DIR is removed or not available the
> build does not know how to fetch the file and will fail. With this
> commit we fail earlier and consistently on this condition.
>=20
> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> ---
>  lib/bb/fetch2/__init__.py | 4 +++-
>  lib/bb/tests/fetch.py     | 7 +++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index ac557176..5f05278a 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1233,7 +1233,9 @@ def get_checksum_file_list(d):
>                  if f.startswith(dl_dir):
>                      # The local fetcher's behaviour is to return a path =
under DL_DIR if it couldn't find the file anywhere else
>                      if os.path.exists(f):
> -                        bb.warn("Getting checksum for %s SRC_URI entry %=
s: file not found except in DL_DIR" % (d.getVar('PN'), os.path.basename(f))=
)
> +                        bb.fatal(("Getting checksum for %s SRC_URI entry=
 %s: file not found except in DL_DIR."
> +                            " This means there is no way to get the file=
 except for an orphaned copy"
> +                            " in DL_DIR.") % (d.getVar('PN'), os.path.ba=
sename(f)))
>                      else:
>                          bb.warn("Unable to get checksum for %s SRC_URI e=
ntry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
>                  filelist.append(f + ":" + str(os.path.exists(f)))

Did you manage to trigger that error in a real world use case?

I've just been looking at this code and it is horribly old and
outdated. I can't help wonder if we shouldn't do something a bit more
invasive to clean it up a bit more. I suspect it does some of these
things for old/obsolete reasons...

I ask since I'm wondering if anyone ever hits these code paths in a
valid usecase.

Thanks for working on it, we do need to improve some of these things.

Cheers,

Richard




