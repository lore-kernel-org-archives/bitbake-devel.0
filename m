Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8878C46CD2
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 23:42:44 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web10.113663.1703720562669650046
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Dec 2023 15:42:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=W7PbVN2m;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.219.170, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbdb12203b4so4082103276.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 15:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703720562; x=1704325362; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTYBvTnbOgpzDWFOaCSlEUy5vLqo9APRb3Xxv4ftwOA=;
        b=W7PbVN2mgiSgUrgN3u/1LUpwSeZaTzW2MP7zHqzhNQEZ5qvNeGGzS9ZH10pgyMfahz
         l9G7/61nYP+g3Mi5xguUiTfOsFk84RecjS/1D0Z+jauA8sUwxTuBINRqvs52REyec72x
         B/cxjnf6/i3bDFt+W6k1lSLZo7t0wsAKUqEaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703720562; x=1704325362;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mTYBvTnbOgpzDWFOaCSlEUy5vLqo9APRb3Xxv4ftwOA=;
        b=pu/XG5+80iR4Vk+nXugtZl07t7E0JH74vfljVU2p1FFXzFO4v+o9pdrheumZepPgdd
         9ZpLu5EZKx/bgPUmxFNOF9eL1oAxAdgFZL3WN2ub34T3Bb/+b0esSy/jjTLsiNCCob2Y
         kqSEfI2+CkXLxig4D43GgMgWriA8ZIJe5adUCtF3zqukhDmtqv9aHAS7/zW/gcPxkmA8
         2AS6YpJuT0177pIH+XY3GJ/blGuu1Ah33iHHTbbHdUG7QWHQ/28ZIR6S7H+74sZ1xw7x
         Bp+xdNmbpiuaG+YautlPv4bp2+ngk/i0139sbRHki5L7Naltceu+Uz95ozSjNUcgPZI6
         iJMg==
X-Gm-Message-State: AOJu0YzM6mH6dLc8ksQiM9+ITtgaJNQWWRwdo5i/Rosd/EZJ5AsHaKMH
	KB9EK3M4a+P43+oC/sOzba04z38ikC6hUsdKSETz/ovRLEQ=
X-Google-Smtp-Source: AGHT+IFhQTv13c4gv/C59VukAbUxHbB00TnDDMcd2WgBuaDyAXHvig5C+jqn/yB5GdIAgTZYHCY5XA==
X-Received: by 2002:a25:8108:0:b0:dbd:120e:f33a with SMTP id o8-20020a258108000000b00dbd120ef33amr4758898ybk.6.1703720561701;
        Wed, 27 Dec 2023 15:42:41 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7c86:799e:26ff:d556? ([2001:8b0:aba:5f3c:7c86:799e:26ff:d556])
        by smtp.gmail.com with ESMTPSA id b19-20020a25ae93000000b00dbdb2966f67sm5697246ybj.24.2023.12.27.15.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 15:42:41 -0800 (PST)
Message-ID: <eaf8b03af08d979f90db0eca8ac46281ae29436d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/1] bitbake: event: Improve error
 message for eventhandler
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org
Date: Wed, 27 Dec 2023 23:42:37 +0000
In-Reply-To: <fc7836bc2ab8d8eded60098081d74d427091ad74.1703602054.git.liezhi.yang@windriver.com>
References: <cover.1703602054.git.liezhi.yang@windriver.com>
	 <fc7836bc2ab8d8eded60098081d74d427091ad74.1703602054.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 23:42:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15710

On Tue, 2023-12-26 at 07:11 -0800, Robert Yang via
lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
>=20
> * In python 3.10.9, the error message was:
>   ERROR: Unable to register event handler 'defaultbase_eventhandler':
>     File "/path/to/poky/meta/classes-global/base.bbclass", line 4
>       # SPDX-License-Identifier: MIT
>              ^^^^^
>   SyntaxError: invalid syntax
>=20
>   This is hard to debug since the error line number 4 is incorrect, but n=
othing
>   is wrong with the code in line 4.
>=20
> * In python 3.8.10, the error message was:
>   ERROR: Unable to register event handler 'defaultbase_eventhandler':
>     File "/path/to/poky/meta/classes-global/base.bbclass", line 4
>       an error line
>          ^
>   SyntaxError: invalid syntax
>=20
> * Now the error message and lineno is correct:
>   ERROR: Unable to register event handler 'defaultbase_eventhandler':
>   File "/path/to/poky/meta/classes-global/base.bbclass", line 256
>       an error line
>          ^^^^^
>   SyntaxError: invalid syntax
>=20
> * Fixed it via:
> - Don't pass filename to compile() to make it can report error code corre=
ctly
>   in both python 3.8.10 and 3.10.9.
>=20
> - Fix the lineno offset and filename in traceback message.
>=20
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/event.py | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
> index f8acacd80d1..9eecb141379 100644
> --- a/bitbake/lib/bb/event.py
> +++ b/bitbake/lib/bb/event.py
> @@ -260,16 +260,29 @@ def register(name, handler, mask=3DNone, filename=
=3DNone, lineno=3DNone, data=3DNone):
>              try:
>                  code =3D bb.methodpool.compile_cache(tmp)
>                  if not code:
> -                    if filename is None:
> -                        filename =3D "%s(e, d)" % name
> -                    code =3D compile(tmp, filename, "exec", ast.PyCF_ONL=
Y_AST)
> +                    code =3D compile(tmp, name, "exec", ast.PyCF_ONLY_AS=
T)
>                      if lineno is not None:
>                          ast.increment_lineno(code, lineno-1)
> -                    code =3D compile(code, filename, "exec")
> +                    code =3D compile(code, name, "exec")
>                      bb.methodpool.compile_cache_add(tmp, code)
>              except SyntaxError:
> +                exc_lines =3D traceback.format_exc(limit=3D0).splitlines=
()
> +                # Fix lineno offset manually since compile() cannot hand=
le it correctly
> +                if filename and lineno:
> +                    line_first =3D exc_lines[0]
> +                    if 'File ' in line_first and ' line ' in line_first:
> +                        lineno_new =3D line_first.split(' line ')[-1]
> +                        if lineno_new:
> +                            lineno_new =3D int(lineno_new)
> +                        lineno_new +=3D lineno - 1
> +                        line_first =3D 'File "%s", line %d' % (filename,=
 lineno_new)
> +                        # Fix filename
> +                        exc_lines[0] =3D line_first.replace(name, filena=
me)
> +                    else:
> +                        logger.warning('Failed to fix lineno for %s:%s' =
% (filename, name))
> +
>                  logger.error("Unable to register event handler '%s':\n%s=
", name,
> -                             ''.join(traceback.format_exc(limit=3D0)))
> +                             '\n'.join(exc_lines))
>                  _handlers[name] =3D noop
>                  return


This is better but I'm still wondering if we can improve. The other
trick we could use is to inject "\n" characters into the start of the
string you're compiling so the line numbers really match up. Would that
work better?

Cheers,

Richard


