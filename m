Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 467DA6067C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 23:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6CN0rTw031203; Wed, 13 Jul 2016 00:00:53 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id caco6vRorCQe; Wed, 13 Jul 2016 00:00:53 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6CN0miu031199
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 13 Jul 2016 00:00:49 +0100
Message-ID: <1468364448.28829.122.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>, Ross Burton
	<ross.burton@intel.com>
Date: Wed, 13 Jul 2016 00:00:48 +0100
In-Reply-To: <CABcZAN=KiVhYkSOUBiOdPSW3kKdJJXfWfrV9FE=o4bbjY5wkng@mail.gmail.com>
References: <1468336521-8177-1-git-send-email-ross.burton@intel.com>
	<CABcZAN=KiVhYkSOUBiOdPSW3kKdJJXfWfrV9FE=o4bbjY5wkng@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] lib/bb/utils: fix set_process_name
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 12 Jul 2016 23:00:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-07-12 at 08:20 -0700, Christopher Larson wrote:
> 
> On Tue, Jul 12, 2016 at 8:15 AM, Ross Burton <ross.burton@intel.com>
> wrote:
> > With Python 3 create_string_buffer needs a bytes() not a str() but
> > as we were
> > catching all exceptions nobody noticed.
> > 
> > [ YOCTO #9910 ]
> > 
> > Signed-off-by: Ross Burton <ross.burton@intel.com>
> > ---
> >  bitbake/lib/bb/utils.py | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> > index 0a1bf68..3bc2437 100644
> > --- a/bitbake/lib/bb/utils.py
> > +++ b/bitbake/lib/bb/utils.py
> > @@ -1444,9 +1444,8 @@ def set_process_name(name):
> >      # This is nice to have for debugging, not essential
> >      try:
> >          libc = cdll.LoadLibrary('libc.so.6')
> > -        buff = create_string_buffer(len(name)+1)
> > -        buff.value = name
> > -        libc.prctl(15, byref(buff), 0, 0, 0)
> > +        buf = create_string_buffer(bytes(name, 'utf-8'))
> > +        libc.prctl(15, byref(buf), 0, 0, 0)
> >      except:
> >          pass
> > 
> Why are we catching all exceptions, anyway? That's not usually a good
> idea.

The variety of ways cdll and direct syscalls can fail is potentially
quite large in this code block and if this doesn't work, its not really
a big deal, its there for debugging so at the time it seemed reasonable
just to continue if it fails. If someone wants to figure out the
different cdll failure modes on various distros, I'm happy for them to
do so and send a patch. Obviously it did hurt in the python3 transition
but we won't do that every day...

Cheers,

Richard



