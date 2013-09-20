Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id AA2866028B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Sep 2013 11:59:21 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8KCDGqD019092; Fri, 20 Sep 2013 13:13:43 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QuEoBPS3wbNq; Fri, 20 Sep 2013 13:13:42 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8KCDdYE019134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 20 Sep 2013 13:13:41 +0100
Message-ID: <1379678342.18603.140.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 20 Sep 2013 12:59:02 +0100
In-Reply-To: <3335435.nZ1M0MKWov@helios>
References: <1379672987.18603.139.camel@ted> <3335435.nZ1M0MKWov@helios>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] build: Add BB_TASK_NICE_LEVEL to task code
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
X-List-Received-Date: Fri, 20 Sep 2013 11:59:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-09-20 at 12:09 +0100, Paul Eggleton wrote:
> On Friday 20 September 2013 11:29:47 Richard Purdie wrote:
> > On Linux its not possible for processes to regain a previous nice level
> > after it has changed. Its therefore not possible to have a core low
> > priority and then raise the priorities of individual tasks.
> > 
> > This variable allows us to do something like:
> > 
> > BB_TASK_NICE_LEVEL = "5"
> > BB_TASK_NICE_LEVEL_task-testimage = "0"
> > 
> > to give priority to specific tasks which the BB_NICE_LEVEL functionality
> > doesn't give us the option of.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> > index 8aec699..9addd71 100644
> > --- a/bitbake/lib/bb/build.py
> > +++ b/bitbake/lib/bb/build.py
> > @@ -346,6 +346,13 @@ def _exec_task(fn, task, d, quieterr):
> >      if not tempdir:
> >          bb.fatal("T variable not set, unable to build")
> > 
> > +    # Change nice level if we're asked to
> > +    nice = localdata.getVar("BB_TASK_NICE_LEVEL", True)
> > +    if nice:
> > +        curnice = os.nice(0)
> > +        nice = int(nice) - curnice
> > +        logger.debug(1, "Renice to %s " % os.nice(nice))
> 
> It's a matter of style to be sure, but I think it's better not to have debug 
> statements that do more than just printing debug output - could the latter be 
> split onto two lines? Then it's easy to tell what's being done.

Agreed, although this is a copy and paste of the BB_NICE_LEVEL code so
we should probably fix both.

Cheers,

Richard


