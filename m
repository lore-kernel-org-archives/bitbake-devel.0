Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.907.1591376510728684561
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 10:01:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=AAh99T1b;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id x93so7980946ede.9
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2020 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Yyx9RmYL+1NhQw/6e0IpUfcc9J2VJPdnUdk9d04TVM=;
        b=AAh99T1b5p+oZDJlFgTkMcZTEEsrh1UKiXYnH/4Y5wbKQlgYeRBryMdCYxkCuVbrH8
         dgpbdcaJxSY+MamGrrKxAP+7csP8kaDj55jGZqm7u4C4vj5aJpHXVJbtLoYpcQkjG3Ll
         vhP1fqsnzK/NANciZdrbdoxNb2LSrhRk4sVkT+qI9YwDJMAbU1S3JrWKm6CuLn15BP0y
         2Y65RjZObUo2U6HofUw9kYZdjosHZ3fEwmf2A0NcokIDgCT624bsKrLM3iljkgGYB1hQ
         mh1Xtg85NOFidixB6HM57WhBPnbDoFHT16SsgH1hq7MSeU4tLAEwGKyBNQIgx254a7vF
         luQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Yyx9RmYL+1NhQw/6e0IpUfcc9J2VJPdnUdk9d04TVM=;
        b=ppC/x8bPhMAmusJZz+EExSS/RWXog9s+e7nhcQEjKzWEDqyNNkfrLVuu4aYu4VPH6Z
         /vIrQRiEtLcuyb3jI1SmhAruFic9YE2mk4tYtIm76/poT9dXoVm3GZ0n+Ehtm4nUNVht
         3Ib7/DwlG8Dwzc9DtFVAopLnr+qmJvuQD3YoTzSwdsk5LVbrdExXGKNOlE/XyIPmPEel
         lTlpmK6lXJCzxy2J3+xhhsor0ap07k5t05/+6mvhKsfEE/gMU/JSAGdrM6Bm1ex+k1EZ
         dYf0f4OxsiDDQaMgADU75lGyQ707Rn8iAtWT6r456eeI7CDhCW7GFH5feKV0rgpRaRLy
         A7lw==
X-Gm-Message-State: AOAM5300PSMU7nqI/GKed2zX6mb9zedLXlNGGvy4Onr83PMi4IyTtjBd
	wOImWRNaU1omT1NUSVH/HWBi3PtglBMwRhWRG2w=
X-Google-Smtp-Source: ABdhPJxmwL6KZCDY+Vs0RPZThDkOMAQferxaTwHboJ+M3n2+SD3uugdkHGAAvJj90aWXDaekL8RxB0lku0xkDBO4lns=
X-Received: by 2002:a50:bb41:: with SMTP id y59mr10053183ede.311.1591376509210;
 Fri, 05 Jun 2020 10:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <1615B08CE92C4E2B.32071@lists.openembedded.org> <d5c2b555d38f4f30b78263b9ba8b371f@XBOX03.axis.com>
In-Reply-To: <d5c2b555d38f4f30b78263b9ba8b371f@XBOX03.axis.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Fri, 5 Jun 2020 19:01:37 +0200
Message-ID: <CA+chaQecctVYqh90jz=A63AU6ijFBu2YqpWxp1dkNy4J2j2QJQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [master][dunfell] prserv/serv: Avoid exception with newer versions of Python
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000089128c05a759378b"

--00000000000089128c05a759378b
Content-Type: text/plain; charset="UTF-8"

Strange, I was seeing this error on my system in those do_package tasks
when sending that initial work around, but devtool works for me fine on the
same ubuntu 20.04 system.

But if this works better for you, them I'm fine with the revert of my
change.

On Fri, Jun 5, 2020 at 5:56 PM Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <
> bitbake-devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> > Sent: den 5 juni 2020 17:49
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [master][dunfell] prserv/serv: Avoid exception
> with newer versions of Python
> >
> > The following exception was received when doing `devtool modify ...`:
> >
> >   Exception: ModuleNotFoundError: No module named '_sysconfigdata'
> >
> > This was previously partially solved in OE-Core, in commit 4b26eaf7
> > (prservice.py: fix do_package with newer Python in Ubuntu
> > 20.04). However, that only solved the problem for some cases where
> > prserv was imported. This should solve if for all of them.
> >
> > Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > ---
> >  bitbake/lib/prserv/serv.py | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
> > index 25dcf8a0ee..48f4b5b05d 100644
> > --- a/bitbake/lib/prserv/serv.py
> > +++ b/bitbake/lib/prserv/serv.py
> > @@ -2,6 +2,12 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  #
> >
> > +# Make sure _PYTHON_SYSCONFIGDATA_NAME is not set in the environment,
> which may
> > +# happen for recipes that, e.g., inherit python3native, which sets it.
> Otherwise
> > +# importing from xmlrpc.server fails with "No module named
> '_sysconfigdata'"
> > +if '_PYTHON_SYSCONFIGDATA_NAME' in os.environ:
> > +    del os.environ['_PYTHON_SYSCONFIGDATA_NAME']
> > +
> >  import os,sys,logging
> >  import signal, time
> >  from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
>
> Without this, I can no longer use devtool with neither master nor
> Dunfell.
>
> //Peter
>
> 
>

--00000000000089128c05a759378b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Strange, I was seeing this error on my system in those do_=
package tasks when sending that initial work around, but devtool works for =
me fine on the same ubuntu 20.04 system.<div><br></div><div>But if this wor=
ks better for you, them I&#39;m fine with the revert of my change.</div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Fri, Jun 5, 2020 at 5:56 PM Peter Kjellerstedt &lt;<a href=3D"mailto:peter.=
kjellerstedt@axis.com">peter.kjellerstedt@axis.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">&gt; -----Original Messag=
e-----<br>
&gt; From: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=
=3D"_blank">bitbake-devel@lists.openembedded.org</a> &lt;<a href=3D"mailto=
:bitbake-devel@lists.openembedded.org" target=3D"_blank">bitbake-devel@list=
s.openembedded.org</a>&gt; On Behalf Of Peter Kjellerstedt<br>
&gt; Sent: den 5 juni 2020 17:49<br>
&gt; To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D=
"_blank">bitbake-devel@lists.openembedded.org</a><br>
&gt; Subject: [bitbake-devel] [master][dunfell] prserv/serv: Avoid excepti=
on with newer versions of Python<br>
&gt; <br>
&gt; The following exception was received when doing `devtool modify ...`:=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Exception: ModuleNotFoundError: No module named &#39;_sys=
configdata&#39;<br>
&gt; <br>
&gt; This was previously partially solved in OE-Core, in commit 4b26eaf7<b=
r>
&gt; (prservice.py: fix do_package with newer Python in Ubuntu<br>
&gt; 20.04). However, that only solved the problem for some cases where<br=
>
&gt; prserv was imported. This should solve if for all of them.<br>
&gt; <br>
&gt; Signed-off-by: Peter Kjellerstedt &lt;<a href=3D"mailto:peter.kjeller=
stedt@axis.com" target=3D"_blank">peter.kjellerstedt@axis.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 bitbake/lib/prserv/serv.py | 6 ++++++<br>
&gt;=C2=A0 1 file changed, 6 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py<=
br>
&gt; index 25dcf8a0ee..48f4b5b05d 100644<br>
&gt; --- a/bitbake/lib/prserv/serv.py<br>
&gt; +++ b/bitbake/lib/prserv/serv.py<br>
&gt; @@ -2,6 +2,12 @@<br>
&gt;=C2=A0 # SPDX-License-Identifier: GPL-2.0-only<br>
&gt;=C2=A0 #<br>
&gt; <br>
&gt; +# Make sure _PYTHON_SYSCONFIGDATA_NAME is not set in the environment=
, which may<br>
&gt; +# happen for recipes that, e.g., inherit python3native, which sets i=
t. Otherwise<br>
&gt; +# importing from xmlrpc.server fails with &quot;No module named &#39=
;_sysconfigdata&#39;&quot;<br>
&gt; +if &#39;_PYTHON_SYSCONFIGDATA_NAME&#39; in os.environ:<br>
&gt; +=C2=A0 =C2=A0 del os.environ[&#39;_PYTHON_SYSCONFIGDATA_NAME&#39;]<b=
r>
&gt; +<br>
&gt;=C2=A0 import os,sys,logging<br>
&gt;=C2=A0 import signal, time<br>
&gt;=C2=A0 from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCReque=
stHandler<br>
<br>
Without this, I can no longer use devtool with neither master nor <br>
Dunfell.<br>
<br>
//Peter<br>
<br>
<br>
</blockquote></div>

--00000000000089128c05a759378b--
