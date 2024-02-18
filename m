Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBBDC48BF6
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 12:43:42 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.16956.1708260217897431005
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 04:43:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Lb0TnRaW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so25039565e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 04:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708260216; x=1708865016; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1q8cxHBJlCZj7d/NehpIVPaBvx5XUUTmHBh9LbVnxE0=;
        b=Lb0TnRaWXMfF0O6gHC9Ej3zDKiwijB1bAYzC7q5Xcj/ZcsxD/qpAVVGX8wPDFbXDWf
         f25s3l3j8fWPOBKroQ0JZJHa6tJ82Vjzsrq8eAopMKtNcmbaWLYu81gjCehx7cNhkN4E
         vd6HgmpEGqFzbP9NuXADBce+QvYoRmCjBnFb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708260216; x=1708865016;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1q8cxHBJlCZj7d/NehpIVPaBvx5XUUTmHBh9LbVnxE0=;
        b=gjP+nfpQ6rDqz1Ciox6Br7yiFro4maMLCVSy/wh4RYk0nGyzaYru6Exl4n8kk6phlX
         BzZMUiAoy9bjxFEpMhItWl5aAFMiAbF+YBIhMGuyDZliUExudVqx1VsoRCVGRe3kYUBf
         sENDRg9G9izQBwfPudXjaV1TVMxexIbQ2rmekrHGJpj94LBwfUk0jF+PoY1whjZ3XALy
         iAm9+kQjWmfhgtnCpKAFVtA3UsBXOuyM0/lUdJCwRzVYjpW/peQ1u6ng93Mahzs+WE/N
         6xRCLwER6iBMomAVS/0/WfOmZpDYDigXcSqZPOaZcpXF/OCwux3arx/WlonNXjy5D4tr
         jxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+NYpyz1bJ3KEM/exLMus+SalvoiX9ebdRJ9uKZx7UTTc5aFNMPvss5CudxlWVKW9oVWbMiy4ZgWSGl0pCt4rd5xEOh3xPKNpgaTahPbjmLzrCEZE=
X-Gm-Message-State: AOJu0Yz9x+OZQi52bsoHCF5PjmIhMOWcTuu/Aj7iuKKyXHOCkTsYsuUk
	g4gPgVSA4Hw3Bef6lIOUQnw6SDY50SurkVzfUhdPS2YZ92gRrc08yqM+r4DiegE=
X-Google-Smtp-Source: AGHT+IGrbv6HNoAOSaDK1Nx15eQOEu/J3NeDmANX2SW68zZYsLWLEP3gTViKT105j/nE0SW9Hnz78w==
X-Received: by 2002:adf:efd2:0:b0:33d:201f:ea9d with SMTP id i18-20020adfefd2000000b0033d201fea9dmr5271759wrp.2.1708260216002;
        Sun, 18 Feb 2024 04:43:36 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3d44:5cd8:cef2:3070? ([2001:8b0:aba:5f3c:3d44:5cd8:cef2:3070])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b0041264edf506sm645018wmo.38.2024.02.18.04.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 04:43:35 -0800 (PST)
Message-ID: <6f2645a7c4db2ae149d387544d2b94209cfed3f4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] taskexp_ncurses: ncurses version of
 taskexp.py
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: david.reyna@windriver.com, bitbake-devel@lists.openembedded.org
Date: Sun, 18 Feb 2024 12:43:34 +0000
In-Reply-To: <c3864291243d501bcaae5ed79cb1fd4577ac324a.1708252029.git.David.Reyna@windriver.com>
References: <cover.1708252029.git.David.Reyna@windriver.com>
	 <c3864291243d501bcaae5ed79cb1fd4577ac324a.1708252029.git.David.Reyna@windriver.com>
Autocrypt: addr=richard.purdie@linuxfoundation.org; prefer-encrypt=mutual; keydata=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
 YNvg==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 12:43:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15914

On Sun, 2024-02-18 at 02:41 -0800, Reyna, David via
lists.openembedded.org wrote:
> From: David Reyna <David.Reyna@windriver.com>
>=20
> * Create an ncurses version of the GTK app "taskexp.py".
> * Add these additional features:
> =C2=A0 - Sort tasks in recipes by their dependency order
> =C2=A0 - Print individual and/or recipe-wide dependencies to a file
> =C2=A0 - Add a wild card filter
> =C2=A0 - Show the target recipes on BOLD
> * Provide a GUI self test
> * Provide a non-ncurses self test for ptest
>=20
> Signed-off-by: David Reyna <David.Reyna@windriver.com>
> ---
> =C2=A0lib/bb/ui/taskexp_ncurses.py | 1511
> ++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 1511 insertions(+)
> =C2=A0create mode 100755 bitbake/lib/bb/ui/taskexp_ncurses.py
>=20
> diff --git a/lib/bb/ui/taskexp_ncurses.py
> b/lib/bb/ui/taskexp_ncurses.py
> new file mode 100755
> index 00000000000..ffa91ea1044
> --- /dev/null
> +++ b/lib/bb/ui/taskexp_ncurses.py
> @@ -0,0 +1,1511 @@
> +#
> +# BitBake Graphical ncurses-based Dependency Explorer
> +#=C2=A0=C2=A0 * Based on the GTK implementation
> +#=C2=A0=C2=A0 * Intended to run on any Linux host
> +#
> +# Copyright (C) 2007=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ross Burt=
on
> +# Copyright (C) 2007 - 2008 Richard Purdie
> +# Copyright (C) 2022 - 2024 David Reyna
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +#
> +# Execution example:
> +#=C2=A0=C2=A0 $ bitbake -g -u taskexp_ncurses.py acl zlib
> +#
> +# Self-test example (executes a script of GUI actions):
> +#=C2=A0=C2=A0 $ TASK_EXP_UNIT_TEST=3D1 bitbake -g -u taskexp_ncurses.py =
zlib acl
> +#=C2=A0=C2=A0 ...
> +#=C2=A0=C2=A0 $ echo $?
> +#=C2=A0=C2=A0 0
> +#=C2=A0=C2=A0 $ TASK_EXP_UNIT_TEST=3D1 bitbake -g -u taskexp_ncurses.py =
zlib acl
> foo
> +#=C2=A0=C2=A0 ERROR: Nothing PROVIDES 'foo'. Close matches:
> +#=C2=A0=C2=A0 ofono
> +#=C2=A0=C2=A0 $ echo $?
> +#=C2=A0=C2=A0 1
> +#
> +# Self-test with no terminal example (only tests dependency fetch
> from bitbake):
> +#=C2=A0=C2=A0 $ TASK_EXP_UNIT_TEST_NOTERM=3D1 bitbake -g -u taskexp_ncur=
ses.py_2
> quilt
> +#=C2=A0=C2=A0 $ echo $?
> +#=C2=A0=C2=A0 0

Thanks for this David, it is nice to see this ready to go in :)

I did make one small tweak to the patch when I queued it to drop the
.py and .py_2 from the above command examples since it caused them not
to work.

I've also queued a script to autobuilder-helper to allow us to run
these tests.

Cheers,

Richard




