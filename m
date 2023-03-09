Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2A2C61DA4
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 21:50:05 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.4206.1678398602450306518
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Mar 2023 13:50:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Gf1/K7Kl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id p26so2179794wmc.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 13:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678398601;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL3sowMLuHP2rDNZbfsi/DBoQj5yD4K/EvX/xJDnh8U=;
        b=Gf1/K7KligBDT9UdGABeY1aa27AFyW45vZfF+jJf+XpKt5h6Ab4h9ymHJ4Lvu76aBZ
         ZI5Uci5M1g/GyfBXaTN9nOD+aZ0tfARlZSN/tBMTpuCj+1i9QOAp43KsjEHIH/GHj6zz
         JOLoqRYV5uYSVk/5RQcSMNvjn/OTFQFrr3yLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398601;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WL3sowMLuHP2rDNZbfsi/DBoQj5yD4K/EvX/xJDnh8U=;
        b=7Kx7BaZXYdwAKpCbc5YTif7oWAwJ6jeZL00V0WrdesbKXgjyRs2VuJOduEFNTm4dsW
         6P/sHqJkc2I+t65RFawCC5ZAmOk3vg/alCXAHfdxSfSD4IOE03WxrzWAtji0j2a4Cr0C
         v3bHFCcphItDZ9O5/APUFG+/fLBmhRLi0/ii/A2DCW5v2UzrNtFytLczwRJ5jBSgwm1y
         mHhf3dOjgevOVaxNrvo6haUvUWp2yBkhPS2kYD8DWWz04GILnZTtDXdnutl7YR+HzCME
         QgI1MztuNkDagf2uWEYbHMEp1TupzVdMVtN3B3HiGay7DD6NpbMF42xoXLJ8+HPVcybx
         UnAQ==
X-Gm-Message-State: AO0yUKUhjQXtV6BFBLc3+GjIUILN0kJEu8RRvcom7LJCxDKLA+Kc7p49
	zjFDIzlqbfq4i/GzmjeRRqvE/w==
X-Google-Smtp-Source: AK7set925S1Zhpd6r6AiKd7ysEK69Yc5maCAzt1ymzS94TFsTVuWdjLdaqQvm6AH/mKxdkI1UqFlSg==
X-Received: by 2002:a05:600c:3b21:b0:3e8:c9f7:b09d with SMTP id m33-20020a05600c3b2100b003e8c9f7b09dmr626481wms.15.1678398600568;
        Thu, 09 Mar 2023 13:50:00 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:a9dd:6583:8973:50aa? ([2001:8b0:aba:5f3c:a9dd:6583:8973:50aa])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c24ce00b003eb5a531232sm135014wmu.38.2023.03.09.13.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:50:00 -0800 (PST)
Message-ID: <fe609df3cf13d7eb6f0021eb2d3f34704cfaddb8.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] build: Make python output print to
 stdout when running with -v (verbose)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Asselstine <mark.asselstine@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 09 Mar 2023 21:49:59 +0000
In-Reply-To: <20230309192138.991-1-mark.asselstine@windriver.com>
References: <20230309192138.991-1-mark.asselstine@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 21:50:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14532

On Thu, 2023-03-09 at 14:21 -0500, Mark Asselstine wrote:
> When tasks are run with -v (verbose) on the bitbake commandline, shell
> tasks print their stdout, python tasks do not.
>=20
> This change redirects the python task's print output to an in memory
> buffer. After the task is executed the output is printed to stdout via
> the logger. This makes the python task behavior match the shell task
> behavior when running with -v. The contents of the task's log files
> remain unchanged after this change.
>=20
> This approach should keep the correct order in most cases, however, if
> the python task accesses the logger directly, that content will appear
> before other output. On the other hand, this change should negate the
> need for python tasks to access the logger directly.
>=20
> The following example will produce out-of-order output
>=20
> --
> python do_build() {
>    print("Start")
>    bb.plain("********************");
>    bb.plain("*                  *");
>    bb.plain("*  Hello, World!   *");
>    bb.plain("*                  *");
>    bb.plain("********************");
>    print("Finish")
> }
> --
> will output
> --
> ********************
> *                  *
> *  Hello, World!   *
> *                  *
> ********************
> Start
> Finish
> --
>=20
> The logging-test.bb in meta-selftest or the above 'hello world!' can
> be used to review this change.
>=20
> [Yocto #14544]
>=20
> Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> ---
>  lib/bb/build.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 5a172711..eb2d5b59 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -25,6 +25,7 @@ import bb
>  import bb.msg
>  import bb.process
>  import bb.progress
> +from io import StringIO
>  from bb import data, event, utils
> =20
>  bblogger =3D logging.getLogger('BitBake')
> @@ -296,9 +297,17 @@ def exec_func_python(func, d, runfile, cwd=3DNone):
>          lineno =3D int(d.getVarFlag(func, "lineno", False))
>          bb.methodpool.insert_method(func, text, fn, lineno - 1)
> =20
> +        if verboseStdoutLogging:
> +            sys.stdout.flush()
> +            sys.stdout =3D execio =3D StringIO()
>          comp =3D utils.better_compile(code, func, "exec_func_python() au=
togenerated")
>          utils.better_exec(comp, {"d": d}, code, "exec_func_python() auto=
generated")
>      finally:
> +        if verboseStdoutLogging:
> +            execio.flush()
> +            logger.plain("%s" % execio.getvalue())
> +            sys.stdout =3D sys.__stdout__
> +            execio.close()
>          # We want any stdout/stderr to be printed before any other log m=
essages to make debugging
>          # more accurate. In some cases we seem to lose stdout/stderr ent=
irely in logging tests without this.
>          sys.stdout.flush()

From memory, I think exec_func_python can get called recursively so I
suspect this is going to corrupt sys.stdout. You could save it's value,
then restore it?

Also, what about stderr?

Cheers,

Richard


