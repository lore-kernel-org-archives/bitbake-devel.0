Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1C69C719B3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Mar 2017 10:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v2UABETW004988; 
	Thu, 30 Mar 2017 11:11:14 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uzFDpgZBsZDf; Thu, 30 Mar 2017 11:11:14 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v2UAB99R004983
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Mar 2017 11:11:10 +0100
Message-ID: <1490868669.13980.354.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>, Diana
	Thayer <garbados@gmail.com>
Date: Thu, 30 Mar 2017 11:11:09 +0100
In-Reply-To: <1490634472.28281.111.camel@linux.intel.com>
References: <1490128025-7864-1-git-send-email-garbados@gmail.com>
	<1490634472.28281.111.camel@linux.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bug 9962: improve -v, -D documentation
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
X-List-Received-Date: Thu, 30 Mar 2017 10:11:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2017-03-27 at 11:07 -0600, Leonardo Sandoval wrote:
> On Tue, 2017-03-21 at 13:27 -0700, Diana Thayer wrote:
> >                  Read the specified file before
> > bitbake.conf.
> >         -R POSTFILE, --postread=POSTFILE
> >                               Read the specified file after bitbake.conf.
> > -       -v, --verbose         Output more log message data to the terminal.
> > -       -D, --debug           Increase the debug level. You can specify this more
> > -                             than once.
> > +       -v, --verbose         Enable tracing of shell tasks (with 'set -x').
> > +                             Also print bb.note(...) messages to stdout (in
> > +                             addition to writing them to ${T}/log.do_).
> > +       -D, --debug           Increase the debug level. You can specify this
> > +                             more than once. -D sets the debug level to 1,
> > +                             where only bb.debug(1, ...) messages are printed
> > +                             to stdout; -DD sets the debug level to 2, where
> > +                             both bb.debug(1, ...) and bb.debug(2, ...)
> > +                             messages are printed; etc. Without -D, no debug
> > +                             messages are printed. Note that -D only affects
> > +                             output to stdout. All debug messages are written
> > +                             to ${T}/log.do_taskname, regardless of the debug
> > +                             level.
> I think the description is fine for -D/--debug , but I am not sure if
> this is the place to describe that level N includes N-1, etc.. This 
> is something standard, and describing here make it a bit verbose.

FWIW I tend to agree with you. Further patches are welcome.

Cheers,

Richard

