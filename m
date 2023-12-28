Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AB5C3DA6E
	for <webhook@archiver.kernel.org>; Thu, 28 Dec 2023 10:45:08 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.121043.1703760302863724840
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Dec 2023 02:45:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=U/BSrWQ5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.181, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cca664b0dfso53373161fa.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 Dec 2023 02:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703760301; x=1704365101; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z9Dc9Enp1M/nf03BB30Y2baXTZcjtTPxwskA8Sp9qo=;
        b=U/BSrWQ5q2MA9r0MyXceb+4A0zOHCPy0lgLYyBdQVuZUs9hvAkWF6U46J2LFC5yPJ9
         +FvnQ+sHJvv/x5dN0x9LjWTzBrcj6we9OG2HUijbJ6NMaNgTIOkpUi0H/opzJTom98WP
         GWqn9Y4Fft6GEZEMqWJThuis0B5cjx7LHZJP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703760301; x=1704365101;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Z9Dc9Enp1M/nf03BB30Y2baXTZcjtTPxwskA8Sp9qo=;
        b=VEl1s5Dwg9volj6aMb+tz5KRn2oCsA9d4XJgtDX3jYvxdQoUzMhcQHDyWvmpIUzGT2
         qymISgCvgmfBCJ9VV3mRFOqm2DDn4c5n4b9LoAzZrj4mhqCxI8jFVeXbWW5JKHQqrnbA
         CsVHXD9YCtJbNdbpXSF/4ZPX0lswqdpUFFYRZAqpZhWT3ngApKCb/gzwiIfjSixcgsoV
         9u5Lt2pOhA3VLt7WeiZ/ZSCmlGaZEaBygjwackBVwUGI+35OXNAhhyj2HfA5vY8MsaR1
         AN0s9QFTi0GmtLl/BwFOUlw5T03gvs6p5K1jTIyhYLoM+uUMKnVTFwosS49VVpRSEeNA
         FAcA==
X-Gm-Message-State: AOJu0Yy3D/lQ6vynG+VTYNSC4Alqas9GqOEiD5l2EM+BIjsOSd/qdxM8
	pf41RzgoChjsp+Sv4NVo5Bof3voBdxEhqA==
X-Google-Smtp-Source: AGHT+IEEROx1TcOn8UADDxm6waXMUmZta8NMsHGaElmcMAIu+umxpNrKRDnavFK3f6MxozPb7N7opg==
X-Received: by 2002:ac2:55ae:0:b0:50e:7b6c:4a1e with SMTP id y14-20020ac255ae000000b0050e7b6c4a1emr1993476lfg.45.1703760300757;
        Thu, 28 Dec 2023 02:45:00 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7c86:799e:26ff:d556? ([2001:8b0:aba:5f3c:7c86:799e:26ff:d556])
        by smtp.gmail.com with ESMTPSA id az11-20020a05600c600b00b0040d5c9ad678sm6465712wmb.26.2023.12.28.02.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 02:45:00 -0800 (PST)
Message-ID: <8919f2990c1c8eace318a9075280a1b256c498c5.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/1] bitbake: event: Improve error
 message for eventhandler
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 28 Dec 2023 10:44:59 +0000
In-Reply-To: <666b301d-e444-4a20-a5a9-602e56e773b5@windriver.com>
References: <cover.1703602054.git.liezhi.yang@windriver.com>
	 <fc7836bc2ab8d8eded60098081d74d427091ad74.1703602054.git.liezhi.yang@windriver.com>
	 <eaf8b03af08d979f90db0eca8ac46281ae29436d.camel@linuxfoundation.org>
	 <666b301d-e444-4a20-a5a9-602e56e773b5@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Dec 2023 10:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15712

On Thu, 2023-12-28 at 15:15 +0800, Robert Yang wrote:
> Hi RP,
>=20
> On 12/28/23 07:42, Richard Purdie wrote:
> > On Tue, 2023-12-26 at 07:11 -0800, Robert Yang via
> > lists.openembedded.org wrote:
> > > From: Robert Yang <liezhi.yang@windriver.com>
> > >=20
> > > * In python 3.10.9, the error message was:
> > >    ERROR: Unable to register event handler 'defaultbase_eventhandler'=
:
> > >      File "/path/to/poky/meta/classes-global/base.bbclass", line 4
> > >        # SPDX-License-Identifier: MIT
> > >               ^^^^^
> > >    SyntaxError: invalid syntax
> > >=20
> > >    This is hard to debug since the error line number 4 is incorrect, =
but nothing
> > >    is wrong with the code in line 4.
> > >=20
> > > * In python 3.8.10, the error message was:
> > >    ERROR: Unable to register event handler 'defaultbase_eventhandler'=
:
> > >      File "/path/to/poky/meta/classes-global/base.bbclass", line 4
> > >        an error line
> > >           ^
> > >    SyntaxError: invalid syntax
> > >=20
> > > * Now the error message and lineno is correct:
> > >    ERROR: Unable to register event handler 'defaultbase_eventhandler'=
:
> > >    File "/path/to/poky/meta/classes-global/base.bbclass", line 256
> > >        an error line
> > >           ^^^^^
> > >    SyntaxError: invalid syntax
> > >=20
> > > * Fixed it via:
> > > - Don't pass filename to compile() to make it can report error code c=
orrectly
> > >    in both python 3.8.10 and 3.10.9.
> > >=20
> > > - Fix the lineno offset and filename in traceback message.
> > >=20
> > > Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> > > ---
> > >   bitbake/lib/bb/event.py | 23 ++++++++++++++++++-----
> > >   1 file changed, 18 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
> > > index f8acacd80d1..9eecb141379 100644
> > > --- a/bitbake/lib/bb/event.py
> > > +++ b/bitbake/lib/bb/event.py
> > > @@ -260,16 +260,29 @@ def register(name, handler, mask=3DNone, filena=
me=3DNone, lineno=3DNone, data=3DNone):
> > >               try:
> > >                   code =3D bb.methodpool.compile_cache(tmp)
> > >                   if not code:
> > > -                    if filename is None:
> > > -                        filename =3D "%s(e, d)" % name
> > > -                    code =3D compile(tmp, filename, "exec", ast.PyCF=
_ONLY_AST)
> > > +                    code =3D compile(tmp, name, "exec", ast.PyCF_ONL=
Y_AST)
> > >                       if lineno is not None:
> > >                           ast.increment_lineno(code, lineno-1)
> > > -                    code =3D compile(code, filename, "exec")
> > > +                    code =3D compile(code, name, "exec")
> > >                       bb.methodpool.compile_cache_add(tmp, code)
> > >               except SyntaxError:
> > > +                exc_lines =3D traceback.format_exc(limit=3D0).splitl=
ines()
> > > +                # Fix lineno offset manually since compile() cannot =
handle it correctly
> > > +                if filename and lineno:
> > > +                    line_first =3D exc_lines[0]
> > > +                    if 'File ' in line_first and ' line ' in line_fi=
rst:
> > > +                        lineno_new =3D line_first.split(' line ')[-1=
]
> > > +                        if lineno_new:
> > > +                            lineno_new =3D int(lineno_new)
> > > +                        lineno_new +=3D lineno - 1
> > > +                        line_first =3D 'File "%s", line %d' % (filen=
ame, lineno_new)
> > > +                        # Fix filename
> > > +                        exc_lines[0] =3D line_first.replace(name, fi=
lename)
> > > +                    else:
> > > +                        logger.warning('Failed to fix lineno for %s:=
%s' % (filename, name))
> > > +
> > >                   logger.error("Unable to register event handler '%s'=
:\n%s", name,
> > > -                             ''.join(traceback.format_exc(limit=3D0)=
))
> > > +                             '\n'.join(exc_lines))
> > >                   _handlers[name] =3D noop
> > >                   return
> >=20
> >=20
> > This is better but I'm still wondering if we can improve. The other
> > trick we could use is to inject "\n" characters into the start of the
> > string you're compiling so the line numbers really match up. Would that
> > work better?
>=20
> If you meant the following line:
>=20
> if 'File ' in line_first and ' line ' in line_first:
>=20
> I can use re.match() to improve it and send a V3.

I mean something like:

tmp =3D "\n" * (lineno-1) + tmp

which would increase the line numbers on the string to match the needed
line numbers before we compile it.

Cheers,

Richard

