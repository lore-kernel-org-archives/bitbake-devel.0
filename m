Return-Path: <jatedev@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E838EC433EF
	for <webhook@archiver.kernel.org>; Fri, 21 Jan 2022 16:05:18 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web12.13745.1642781117565993050
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jan 2022 08:05:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=HJIl6uYN;
 spf=pass (domain: gmail.com, ip: 209.85.216.43, mailfrom: jatedev@gmail.com)
Received: by mail-pj1-f43.google.com with SMTP id o64so9729621pjo.2
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jan 2022 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vfjlo0+VTb2BJLzaS+lcvCk5i+6YgZi8QbSz+mIIl8k=;
        b=HJIl6uYN2gk2hq8F77GXPjjBH5bvF5lJDBlxtYqZljMXT0JSzPLGkHKrxDXPeWZa5y
         ClbGHzMkiYselnFJboi8cqrfMTbb0zDNNScEsv7h5di586pT1luPu8xUEqgCvRQ9iuUt
         qGzdjGpwVCX1LwnT4loJv4OWgnLU2nbh3ixiscBC2cqpMjqKltjqFIAyo5LaeyocmuE2
         4YtGx3n2F3kFXopIUPMlXwjEXOE1BRcoCK39VdZQvp+NpFJccst+Xs6M17mUhVR8ue0A
         MdFzKHhMEDTBnsywY4+l3hEae2dD8Glul8oeZwIOQOYqerErPEnREh/OW9Ppt3LQydvM
         U/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vfjlo0+VTb2BJLzaS+lcvCk5i+6YgZi8QbSz+mIIl8k=;
        b=E9ZOZz6I9IE4Cm24j7cOrLxl7vLG3oR001Jdcih/CkwygK5bhiSfcddi2b8dPLJs7M
         QkE2O6BopJKlLcBwBRJWaMbEd5ZgDD/hHJTNLtx9GnAs1rMVGZtBGj1BofnMompLPBdx
         lGSOQBuYfIh81pwxp2nRzikVnbBUXSFF6jTlHlDngTa9Ay3Bxw0CHmZBc517vDOG+DMP
         byZLmncp6VrSoF0mcJpzJRMU1K7+GQmAPcRU/tJsjnl5nmcLbp9jmWcEcfp3RJQxTYp9
         vM+M66WgDn4fx/4BIWQNGCoT4//J/CUt5ZlQ1DQ0MHMpshjZTkgthpVqMXKESwS4iySE
         5iyg==
X-Gm-Message-State: AOAM532elQfTM3VVEgZPxoMXtigB2oyu8zskI7La7IrPzcxuFIrxzVW5
	nsUvom/BaY98BDEcL34a2/h1xOH9uYFwqtr0k8A=
X-Google-Smtp-Source: 
 ABdhPJw1dU8vJDOMnsm4v1WpszlmLqkK7L19L0e5YFTrObGtpzAbjYMPZ0HcG5ep2NAN6hJSCH19nf4bv2JqUD4ElXM=
X-Received: by 2002:a17:90b:4c11:: with SMTP id
 na17mr1423266pjb.206.1642781117007;
 Fri, 21 Jan 2022 08:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20220121145142.763-1-jatedev@gmail.com>
 <CAOSpxdZdS+eRKqQVNSRDWc0pFrFtgA1XG-LX3gbU2=y0qexn9w@mail.gmail.com>
In-Reply-To: 
 <CAOSpxdZdS+eRKqQVNSRDWc0pFrFtgA1XG-LX3gbU2=y0qexn9w@mail.gmail.com>
From: Jate Sujjavanich <jatedev@gmail.com>
Date: Fri, 21 Jan 2022 11:05:05 -0500
Message-ID: 
 <CAPphmgZ=SDGZg9VVj4UW2+igxxYbDLQ1FsSyWrb1sof_y5YcjQ@mail.gmail.com>
Subject: Re: [bitbake][dunfell][1.46][PATCH v2] hashserv: specify loop for
 asyncio in python < 3.6
To: Steve Sakoman <steve@sakoman.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000ec492805d619c8e6"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 16:05:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13272

--000000000000ec492805d619c8e6
Content-Type: text/plain; charset="UTF-8"

- Changed the version check on the minor (< 7 to <6) after testing python
3.6 with bitbake.
- Changed the comment to reflect this
- Added Bugzilla tracker


On Fri, Jan 21, 2022 at 9:55 AM Steve Sakoman <steve@sakoman.com> wrote:

> Hi Jate,
>
> Just want to confirm that the only difference between V1 and V2 is the
> addition of the reference to the bug number?
>
> Thanks,
>
> Steve
>
> On Fri, Jan 21, 2022 at 4:52 AM Jate Sujjavanich <jatedev@gmail.com>
> wrote:
> >
> > [YOCTO #14697]
> >
> > Detect python version 3.5 restoring loop argument where
> > it is still required. In 3.6 auto loop detection is available.
> >
> > Bitbake 1.46 is used in dunfell which lists a minimum python version
> > of 3.5. Omitting this argument leads to a regression and hang during
> > "Initialising tasks" at 44%.
> >
> > Signed-off-by: Jate Sujjavanich <jatedev@gmail.com>
> > ---
> >  lib/hashserv/server.py | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> > index 56f354bd..f38a22ad 100644
> > --- a/lib/hashserv/server.py
> > +++ b/lib/hashserv/server.py
> > @@ -12,6 +12,7 @@ import math
> >  import os
> >  import signal
> >  import socket
> > +import sys
> >  import time
> >  from . import chunkify, DEFAULT_MAX_CHUNK
> >
> > @@ -419,9 +420,14 @@ class Server(object):
> >          self._cleanup_socket = None
> >
> >      def start_tcp_server(self, host, port):
> > -        self.server = self.loop.run_until_complete(
> > -            asyncio.start_server(self.handle_client, host, port)
> > -        )
> > +        if sys.version_info[0] == 3 and sys.version_info[1] < 6:
> > +            self.server = self.loop.run_until_complete(
> > +                asyncio.start_server(self.handle_client, host, port,
> loop=self.loop)
> > +            )
> > +        else:
> > +            self.server = self.loop.run_until_complete(
> > +                asyncio.start_server(self.handle_client, host, port)
> > +            )
> >
> >          for s in self.server.sockets:
> >              logger.info('Listening on %r' % (s.getsockname(),))
> > @@ -444,9 +450,14 @@ class Server(object):
> >          try:
> >              # Work around path length limits in AF_UNIX
> >              os.chdir(os.path.dirname(path))
> > -            self.server = self.loop.run_until_complete(
> > -                asyncio.start_unix_server(self.handle_client,
> os.path.basename(path))
> > -            )
> > +            if sys.version_info[0] == 3 and sys.version_info[1] < 6:
> > +                self.server = self.loop.run_until_complete(
> > +                    asyncio.start_unix_server(self.handle_client,
> os.path.basename(path), loop=self.loop)
> > +                )
> > +            else:
> > +                self.server = self.loop.run_until_complete(
> > +                    asyncio.start_unix_server(self.handle_client,
> os.path.basename(path))
> > +                )
> >          finally:
> >              os.chdir(cwd)
> >
> > --
> > 2.25.1
> >
>

--000000000000ec492805d619c8e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>- Changed the version check on the minor (&lt; 7 to &=
lt;6) after testing python 3.6 with bitbake.<br></div><div>- Changed the co=
mment to reflect this</div><div>- Added Bugzilla tracker<br></div><div><br>=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Fri, Jan 21, 2022 at 9:55 AM Steve Sakoman &lt;<a href=3D"mailto:s=
teve@sakoman.com">steve@sakoman.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hi Jate,<br>
<br>
Just want to confirm that the only difference between V1 and V2 is the<br>
addition of the reference to the bug number?<br>
<br>
Thanks,<br>
<br>
Steve<br>
<br>
On Fri, Jan 21, 2022 at 4:52 AM Jate Sujjavanich &lt;<a href=3D"mailto:jate=
dev@gmail.com" target=3D"_blank">jatedev@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; [YOCTO #14697]<br>
&gt;<br>
&gt; Detect python version 3.5 restoring loop argument where<br>
&gt; it is still required. In 3.6 auto loop detection is available.<br>
&gt;<br>
&gt; Bitbake 1.46 is used in dunfell which lists a minimum python version<b=
r>
&gt; of 3.5. Omitting this argument leads to a regression and hang during<b=
r>
&gt; &quot;Initialising tasks&quot; at 44%.<br>
&gt;<br>
&gt; Signed-off-by: Jate Sujjavanich &lt;<a href=3D"mailto:jatedev@gmail.co=
m" target=3D"_blank">jatedev@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/hashserv/server.py | 23 +++++++++++++++++------<br>
&gt;=C2=A0 1 file changed, 17 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py<br>
&gt; index 56f354bd..f38a22ad 100644<br>
&gt; --- a/lib/hashserv/server.py<br>
&gt; +++ b/lib/hashserv/server.py<br>
&gt; @@ -12,6 +12,7 @@ import math<br>
&gt;=C2=A0 import os<br>
&gt;=C2=A0 import signal<br>
&gt;=C2=A0 import socket<br>
&gt; +import sys<br>
&gt;=C2=A0 import time<br>
&gt;=C2=A0 from . import chunkify, DEFAULT_MAX_CHUNK<br>
&gt;<br>
&gt; @@ -419,9 +420,14 @@ class Server(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._cleanup_socket =3D None<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def start_tcp_server(self, host, port):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.server =3D self.loop.run_until_compl=
ete(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 asyncio.start_server(self.h=
andle_client, host, port)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if sys.version_info[0] =3D=3D 3 and sys.v=
ersion_info[1] &lt; 6:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.server =3D self.loop.r=
un_until_complete(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 asyncio.start=
_server(self.handle_client, host, port, loop=3Dself.loop)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.server =3D self.loop.r=
un_until_complete(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 asyncio.start=
_server(self.handle_client, host, port)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for s in self.server.sockets:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://logg=
er.info" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(&#39;Listenin=
g on %r&#39; % (s.getsockname(),))<br>
&gt; @@ -444,9 +450,14 @@ class Server(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Work around path len=
gth limits in AF_UNIX<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(os.path.dirna=
me(path))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.server =3D self.loop.r=
un_until_complete(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 asyncio.start=
_unix_server(self.handle_client, os.path.basename(path))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if sys.version_info[0] =3D=
=3D 3 and sys.version_info[1] &lt; 6:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.server =
=3D self.loop.run_until_complete(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 asyncio.start_unix_server(self.handle_client, os.path.basename(path), loop=
=3Dself.loop)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.server =
=3D self.loop.run_until_complete(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 asyncio.start_unix_server(self.handle_client, os.path.basename(path))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(cwd)<br>
&gt;<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
</blockquote></div>

--000000000000ec492805d619c8e6--

