Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFD8C433F5
	for <webhook@archiver.kernel.org>; Fri, 21 Jan 2022 16:31:20 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.14390.1642782678440418409
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jan 2022 08:31:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=Smqx93+D;
 spf=softfail (domain: sakoman.com, ip: 209.85.218.42,
 mailfrom: steve@sakoman.com)
Received: by mail-ej1-f42.google.com with SMTP id m4so1559882ejb.9
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jan 2022 08:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSrJJUm7Yt6oqL3V+LlSHdEMOg/g9pmhaqm428O1iss=;
        b=Smqx93+D3AgH7LUz2adlIdFGIwD61HAYZO+Ln1i1EBI5JzyRRturepzcJgrOYFKEEc
         tzIF0rzvmOKVj64u9d93m2Q+b7wUKLTlNz+llVtr/s9oyQmVPWcyP4QKUWF2Mnp+cqpN
         26Sj8sCMuajT3gwUMkfOQvcWU14D7jhGpOh4/gWeFShMXSqfvldCgOLhNN7+VVBgwcZJ
         eT3J2VYUVrNcuKv64rZoue2QU8v9WwkXWZz/AJcXbk0TSiS0RFUPd+3atc2zY8aAyl20
         D4+MAZAk3RaWKQjeDSBjhX8l/8T9M6do035UeUw9P5i99lAFv2A+ho6RlIl8qD90jMm1
         CB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSrJJUm7Yt6oqL3V+LlSHdEMOg/g9pmhaqm428O1iss=;
        b=m+RyP6TiZxHMlZfpwVSM1TmL2S9hez2sFk1m/qktgsrWb34X2FjzNDzWSv5BfCcN1O
         ehg6Z/gD/rlTrSZIWNmTA5k1E99bW9C+sfjsNUCM1Q7VFlKIVKKDFcDBh9DfRbMXhBGg
         KVttH6zMyvmdXq7fI7ApPH6xHXCexaTHvtWbXgM7NpYW4IucOQ+Svp4esD1EGn3xz9aS
         3kQsD77fbqrvDl0wsd8XSh+6n+1EtDhNxrTjRHilwAH6s6jzIEeLyjF3OhCNdB6lTuUj
         CiGn9ypbAVZa5Mb2tFKGs9huflNZqI8JUGVN8EJy6P5kufSx4AvBcIMjbdtEjZEugUcA
         5MVQ==
X-Gm-Message-State: AOAM531Gst+MzPLdjB9+v0htmmGkubi/Y9d1z4nDiPcgX9W2KbTGBikV
	HEAESlVEnGatcNNkkddfnX92pnKbIJBEY4OqkPBK9w==
X-Google-Smtp-Source: 
 ABdhPJxZB+KMtxY0el3qcOVZTIqTt6+V2nFySgGyawtexOSGk3nYVAlNR1AXmZ17grUWmHmzHLtkiZyWjgi2f2VneA0=
X-Received: by 2002:a17:906:a1d1:: with SMTP id
 bx17mr3925068ejb.602.1642782676519;
 Fri, 21 Jan 2022 08:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20220121145142.763-1-jatedev@gmail.com>
 <CAOSpxdZdS+eRKqQVNSRDWc0pFrFtgA1XG-LX3gbU2=y0qexn9w@mail.gmail.com>
 <CAPphmgZ=SDGZg9VVj4UW2+igxxYbDLQ1FsSyWrb1sof_y5YcjQ@mail.gmail.com>
In-Reply-To: 
 <CAPphmgZ=SDGZg9VVj4UW2+igxxYbDLQ1FsSyWrb1sof_y5YcjQ@mail.gmail.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Fri, 21 Jan 2022 06:31:05 -1000
Message-ID: 
 <CAOSpxdaLH759hfsm5LKMq3XFn9ZANb4tHba+EwGUkBGtMePHCA@mail.gmail.com>
Subject: Re: [bitbake][dunfell][1.46][PATCH v2] hashserv: specify loop for
 asyncio in python < 3.6
To: Jate Sujjavanich <jatedev@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 16:31:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13273

On Fri, Jan 21, 2022 at 6:05 AM Jate Sujjavanich <jatedev@gmail.com> wrote:
>
> - Changed the version check on the minor (< 7 to <6) after testing python 3.6 with bitbake.
> - Changed the comment to reflect this
> - Added Bugzilla tracker

Thanks!

Steve

> On Fri, Jan 21, 2022 at 9:55 AM Steve Sakoman <steve@sakoman.com> wrote:
>>
>> Hi Jate,
>>
>> Just want to confirm that the only difference between V1 and V2 is the
>> addition of the reference to the bug number?
>>
>> Thanks,
>>
>> Steve
>>
>> On Fri, Jan 21, 2022 at 4:52 AM Jate Sujjavanich <jatedev@gmail.com> wrote:
>> >
>> > [YOCTO #14697]
>> >
>> > Detect python version 3.5 restoring loop argument where
>> > it is still required. In 3.6 auto loop detection is available.
>> >
>> > Bitbake 1.46 is used in dunfell which lists a minimum python version
>> > of 3.5. Omitting this argument leads to a regression and hang during
>> > "Initialising tasks" at 44%.
>> >
>> > Signed-off-by: Jate Sujjavanich <jatedev@gmail.com>
>> > ---
>> >  lib/hashserv/server.py | 23 +++++++++++++++++------
>> >  1 file changed, 17 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
>> > index 56f354bd..f38a22ad 100644
>> > --- a/lib/hashserv/server.py
>> > +++ b/lib/hashserv/server.py
>> > @@ -12,6 +12,7 @@ import math
>> >  import os
>> >  import signal
>> >  import socket
>> > +import sys
>> >  import time
>> >  from . import chunkify, DEFAULT_MAX_CHUNK
>> >
>> > @@ -419,9 +420,14 @@ class Server(object):
>> >          self._cleanup_socket = None
>> >
>> >      def start_tcp_server(self, host, port):
>> > -        self.server = self.loop.run_until_complete(
>> > -            asyncio.start_server(self.handle_client, host, port)
>> > -        )
>> > +        if sys.version_info[0] == 3 and sys.version_info[1] < 6:
>> > +            self.server = self.loop.run_until_complete(
>> > +                asyncio.start_server(self.handle_client, host, port, loop=self.loop)
>> > +            )
>> > +        else:
>> > +            self.server = self.loop.run_until_complete(
>> > +                asyncio.start_server(self.handle_client, host, port)
>> > +            )
>> >
>> >          for s in self.server.sockets:
>> >              logger.info('Listening on %r' % (s.getsockname(),))
>> > @@ -444,9 +450,14 @@ class Server(object):
>> >          try:
>> >              # Work around path length limits in AF_UNIX
>> >              os.chdir(os.path.dirname(path))
>> > -            self.server = self.loop.run_until_complete(
>> > -                asyncio.start_unix_server(self.handle_client, os.path.basename(path))
>> > -            )
>> > +            if sys.version_info[0] == 3 and sys.version_info[1] < 6:
>> > +                self.server = self.loop.run_until_complete(
>> > +                    asyncio.start_unix_server(self.handle_client, os.path.basename(path), loop=self.loop)
>> > +                )
>> > +            else:
>> > +                self.server = self.loop.run_until_complete(
>> > +                    asyncio.start_unix_server(self.handle_client, os.path.basename(path))
>> > +                )
>> >          finally:
>> >              os.chdir(cwd)
>> >
>> > --
>> > 2.25.1
>> >

