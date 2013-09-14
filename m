Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 79B6160EDA
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 14 Sep 2013 08:33:21 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8E8l9ch026777; Sat, 14 Sep 2013 09:47:09 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qby6ooXsysyN; Sat, 14 Sep 2013 09:47:09 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8E8l4t1026773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sat, 14 Sep 2013 09:47:06 +0100
Message-ID: <1379147582.3484.284.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Sat, 14 Sep 2013 09:33:02 +0100
In-Reply-To: <1379076430.3484.266.camel@ted>
References: <1378828081-22646-1-git-send-email-alexandru.damian@intel.com>
	<1379076430.3484.266.camel@ted>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: cooker: clear up state on stateShutdown command
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
X-List-Received-Date: Sat, 14 Sep 2013 08:33:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-09-13 at 13:47 +0100, Richard Purdie wrote:
> On Tue, 2013-09-10 at 16:48 +0100, Alex DAMIAN wrote:
> > From: Alexandru DAMIAN <alexandru.damian@intel.com>
> > 
> > On resident bitbake server, a stateShutdown command (first
> > Ctrl-C in client) will leave the server in an unusable state.
> > 
> > This patch forces the server to reload data and begin
> > processing commands again, coping correctly with Ctrl-C commands.
> > 
> > Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> > 
> > diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> > index c3721aa..42eec2c 100644
> > --- a/bitbake/lib/bb/cooker.py
> > +++ b/bitbake/lib/bb/cooker.py
> > @@ -1101,6 +1101,7 @@ class BBCooker:
> >                  rq.finish_runqueue(True)
> >              elif self.state == state.shutdown:
> >                  rq.finish_runqueue(False)
> > +                self.state = state.initial
> >              failures = 0
> >              try:
> >                  retval = rq.execute_runqueue()
> > @@ -1191,7 +1192,7 @@ class BBCooker:
> >          if self.state == state.running:
> >              return
> >  
> > -        if self.state in (state.shutdown, state.stop):
> > +        if self.state == state.stop:
> >              self.parser.shutdown(clean=False, force = True)
> >              sys.exit(1)
> 
> This doesn't seem very intuitive. As I read the code above, "shutdown"
> means it sits and does nothing, "stop" means it exits? Surely these
> should be the other way around?

For completeness, my patch series addresses the above problems in
different ways. The underlying problems were the server not being reset
to state.initial after a command failed and the sys.exit() call causing
the server to exit.

Cheers,

Richard


