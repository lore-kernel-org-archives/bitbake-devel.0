Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20D3C433FE
	for <webhook@archiver.kernel.org>; Mon, 28 Nov 2022 14:50:20 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.119637.1669647019476225237
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Nov 2022 06:50:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ax/q9anj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id bx10so5133921wrb.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LFlVRzhXBvDtyITqi0gNN75HQnxiNgwz8qsyR7FEdQw=;
        b=ax/q9anjLAleh+GhkquA+PZRId3WaFdzTxpSoSrYWKqO0E3wsntQSyLiG2qQYjpiQr
         pqkAIA8dIfshEVFQenN27f0qLw0B+cm14iXweZ79YmaqzkZ3SvEz9cXx4d1y3z+8V5+a
         kaVE4fkZfCTLSRgZlIVFiyvrE9vfQPtcHE+UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LFlVRzhXBvDtyITqi0gNN75HQnxiNgwz8qsyR7FEdQw=;
        b=ZDG4P890bCWKYAAIRrmNrFX9k7NX2o8wE+3JEowbq+Gbgj1HEAI/VxDgTj+Gd3Ge8v
         Zp7+GyhO8fGQte0tvlzTkKIyFY/LHt7euS7WI/jV/05ib+FGhFqgjer/PtVCmWCUH0he
         xBqCx+/jRtBFK2yAUFkzOdlVywH6m0fGrYOohvPH6xA8PMB899HfaksvJKlxUOROP939
         2bgJbiDZAvgCtZ3hSECa8og5e4Yp9yVO7kKz/jO6Wr7ID8Om1RdW4mlh3qMKwN7Y+yd5
         zawz16Qq4QzYJXyXWMR4u59BbLzQnJ5GSrCEe5C447gbNp0WVEmR++dtT3W7kZWz42Av
         gzRA==
X-Gm-Message-State: ANoB5pkahwVmOWVUWxHBrQazhLOVTzjgNAA+C/tC7gNjXE8/pygElfCC
	wNaYVVpcnkv5ZvasubWmWdDXBQ==
X-Google-Smtp-Source: AA0mqf6hNin/VR+8J8PPIfLc8U0cgYosK2IREzWBqV1X/c2ACo4tP29wEmBFcjp4xCxr+F7rOcWLqw==
X-Received: by 2002:adf:d841:0:b0:236:5655:13a5 with SMTP id k1-20020adfd841000000b00236565513a5mr31107436wrl.477.1669647017792;
        Mon, 28 Nov 2022 06:50:17 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1da4:7286:b644:a924? ([2001:8b0:aba:5f3c:1da4:7286:b644:a924])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003c64c186206sm16339096wmn.16.2022.11.28.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 06:50:17 -0800 (PST)
Message-ID: <e24eafaaf45b8293be9a27a740c6dbdae2c9aba5.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH RFC 2/2] ast/data: Add dependencies from
 python module functions
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Nov 2022 14:50:16 +0000
In-Reply-To: <CAJdd5GbhgOf_9fKvk==RXLiOdW57DHvcdktDAsU6aaSDM-d3Qw@mail.gmail.com>
References: <20221127213610.539976-1-richard.purdie@linuxfoundation.org>
	 <20221127213610.539976-2-richard.purdie@linuxfoundation.org>
	 <CAJdd5GbhgOf_9fKvk==RXLiOdW57DHvcdktDAsU6aaSDM-d3Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 14:50:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14121

On Mon, 2022-11-28 at 08:32 -0600, Joshua Watt wrote:
> On Sun, Nov 27, 2022 at 3:36 PM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > --- a/lib/bb/parse/ast.py
> > +++ b/lib/bb/parse/ast.py
> > @@ -10,6 +10,7 @@
> >  #
> >=20
> >  import sys
> > +import inspect
> >  import bb
> >  from bb import methodpool
> >  from bb.parse import logger
> > @@ -284,7 +285,44 @@ class PyLibNode(AstNode):
> >              bb.utils._context[self.namespace] =3D __import__(self.name=
space)
> >              toimport =3D getattr(bb.utils._context[self.namespace], "B=
BIMPORTS", [])
> >              for i in toimport:
> > -                bb.utils._context[i.split(".", 1)[0]] =3D __import__(i=
)
> > +                base =3D i.split(".", 1)[0]
> > +                bb.utils._context[base] =3D __import__(i)
> > +                if "." in i:
> > +                    mod =3D getattr(bb.utils._context[base], i.split("=
.", 1)[1])
> > +                    funcs =3D dir(mod)
> > +                    for f in funcs:
> > +                        if f.startswith("_"):
> > +                            continue
> > +                        fcall =3D getattr(mod, f)
> > +                        if not callable(fcall):
> > +                            continue
> > +                        src =3D inspect.getsource(fcall)
>=20
> While the text of a module should always be present, making python go
> back to it is probably inefficient when it's already gone through the
> effort of converting it to byte code (I beleive it has to go find the
> corresponding .py file for the .pyc file it already loaded into
> memory). Perhaps we can split out the part of PythonParser that deals
> with the compiled AST to a new function and call that with inspect?
>=20
> Maybe something like:
>=20
>   bytecode =3D inspect.getmembers_static(fcall, "__code__")[0][1]
>   parser.parse_python_ast(bytecode)

Sadly we need the text since PythonParser has it's own optimisations
and hash lookups based upon that :/. I agree this is probably not as
efficient as it should be though. We also still don't currently get the
lineno information we need either.

>=20
> > +                        name =3D "%s.%s" % (i, f)
> > +                        parser =3D bb.codeparser.PythonParser(name, lo=
gger)
> > +                        parser.parse_python(src, filename=3Dinspect.ge=
tfile(fcall), lineno=3D1)
> > +                        execs =3D parser.execs
> > +                        # Expand internal module exec references
> > +                        for e in parser.execs:
> > +                            if e in funcs:
> > +                                execs.remove(e)
>=20
> You are modifying parser.execs in place which will ruin your
> iteration.

Well spotted. It was meant to be execs =3D parser.execs.copy() (see the
other copy()'s of the other bits later.

>  I think you probably want:
>=20
>  execs =3D {f"{i}.{e}" if e in funcs else e for e in parser.execs}
>=20
> Or if you don't want list comprehension:
>=20
>  execs =3D []
>  for e in parse.execs:
>    if e in funcs:
>      execs.add(f"{i}.{e}")
>   else:
>      execs.add(e)

Cheers,

Richard

