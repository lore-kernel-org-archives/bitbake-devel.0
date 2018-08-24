Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9F92C795B4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Aug 2018 06:57:33 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	w7O6vVE2005269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 24 Aug 2018 07:57:32 +0100
Message-ID: <e6d788b6c5cc824bb8cf98f2d8bb66b6a1b7a367.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Joshua Watt
	<jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Fri, 24 Aug 2018 07:57:31 +0100
In-Reply-To: <c18b7f96-8809-0224-b419-2fff12994680@prevas.dk>
References: <20180821140416.10764-1-JPEWhacker@gmail.com>
	<c18b7f96-8809-0224-b419-2fff12994680@prevas.dk>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.1 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] daemonize: Flush stdio on exit
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
X-List-Received-Date: Fri, 24 Aug 2018 06:57:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2018-08-22 at 15:33 +0200, Rasmus Villemoes wrote:
> On 2018-08-21 16:04, Joshua Watt wrote:
> > In spite of a comment suggesting otherwise, os._exit() does not
> > flush
> > buffered output from file descriptors before exiting the process
> > like
> > os.exit() does. This means that any un-flushed output is lost in
> > the
> > daemon process, in particular the traceback from any thrown
> > exceptions,
> > making debugging exceptions in the daemon quite difficult.
> > 
> > The solution is to flush stdout and stderr before exiting.
> > 
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >  bitbake/lib/bb/daemonize.py | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/bitbake/lib/bb/daemonize.py
> > b/bitbake/lib/bb/daemonize.py
> > index 8300d1d0f0f..bf16793468e 100644
> > --- a/bitbake/lib/bb/daemonize.py
> > +++ b/bitbake/lib/bb/daemonize.py
> > @@ -49,8 +49,8 @@ def createDaemon(function, logfile):
> >              # exit() or _exit()?
> >              # _exit is like exit(), but it doesn't call any
> > functions registered
> >              # with atexit (and on_exit) or any registered signal
> > handlers.  It also
> > -            # closes any open file descriptors.  Using exit() may
> > cause all stdio
> > -            # streams to be flushed twice and any temporary files
> > may be unexpectedly
> > +            # closes any open file descriptors, but doesn't flush
> > any buffered output.
> > +            # Using exit() may cause all any temporary files to be
> > unexpectedly
> >              # removed.  It's therefore recommended that child
> > branches of a fork()
> >              # and the parent branch(es) of a daemon use _exit().
> >              os._exit(0)
> > @@ -79,4 +79,9 @@ def createDaemon(function, logfile):
> >          traceback.print_exc()
> >      finally:
> >          bb.event.print_ui_queue()
> > +        # os._exit() doesn't flush open files like os.exit() does.
> > Manually flush
> > +        # stdout and stderr so that any logging output will be
> > seen, particularly
> > +        # exception tracebacks.
> > +        sys.stdout.flush()
> > +        sys.stderr.flush()
> >          os._exit(0)
> > 
> 
> Well, that's of course better than not getting the output, but
> there's then the issue of double printing: The intermediate child
> does _exit(), but the grandparent may have had stuff in the stdio
> buffers before the very first fork(), and that content would be
> inherited down to the grandchild. So I think you should (also)
> explicitly flush stdout and stderr before the first fork().

You're correct, we should do that. I was thinking we did flush things
before forking but looking at the code I'm thinking of the fork() call
in bitbake-worker, not the one in daemonize.py.

I'd happily take a patch if someone wants to work one up!

Cheers,

Richard



