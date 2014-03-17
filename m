Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 01C316F605
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Mar 2014 15:05:47 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2HF5WKC019188; Mon, 17 Mar 2014 15:05:33 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CZQZCEHDCFUj; Mon, 17 Mar 2014 15:05:32 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2HF5QPY019185
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 17 Mar 2014 15:05:27 GMT
Message-ID: <1395068720.3808.52.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 17 Mar 2014 15:05:20 +0000
In-Reply-To: <20140316235620.GC3725@jama>
References: <CAJTo0LZffXzAyhu23+phNpKTNbvRV5zYvwRQR5ssvG-t_isqnw@mail.gmail.com>
	<20140316235620.GC3725@jama>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Exception on error
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
X-List-Received-Date: Mon, 17 Mar 2014 15:05:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-03-17 at 00:56 +0100, Martin Jansa wrote:
> On Thu, Mar 13, 2014 at 04:35:35PM +0000, Burton, Ross wrote:
> > Hi,
> > 
> > Just got this error when bitbake was shutting down after a failed parse:
> > 
> > ERROR: An uncaught exception occured in runqueue, please see the failure below:
> > ERROR: Running idle function
> > Traceback (most recent call last):
> >   File "/home/ross/Yocto/poky/bitbake/lib/bb/server/process.py", line
> > 128, in ProcessServer.idle_commands(delay=0.1, fds=[<read-only
> > Connection, handle 4>, <read-write Connection, handle 7>, <read-write
> > Connection, handle 12>]):
> >                  try:
> >     >                retval = function(self, data, False)
> >                      if retval is False:
> >   File "/home/ross/Yocto/poky/bitbake/lib/bb/cooker.py", line 1171, in
> > buildTargetsIdle(server=<ProcessServer(ProcessServer-1, started)>,
> > rq=<bb.runqueue.RunQueue instance at 0x16b8dd40>, abort=False):
> >                  try:
> >     >                retval = rq.execute_runqueue()
> >                  except runqueue.TaskFailure as exc:
> >   File "/home/ross/Yocto/poky/bitbake/lib/bb/runqueue.py", line 1122,
> > in RunQueue.execute_runqueue():
> >                  try:
> >     >                self.teardown_workers()
> >                  except:
> >   File "/home/ross/Yocto/poky/bitbake/lib/bb/runqueue.py", line 950,
> > in RunQueue.teardown_workers():
> >              self.teardown = True
> >     >        signal.signal(signal.SIGCHLD, self.oldsigchld)
> >              self._teardown_worker(self.worker, self.workerpipe)
> > TypeError: signal handler must be signal.SIG_IGN, signal.SIG_DFL, or a
> > callable object
> > 
> > I can look into this maybe tomorrow but hopefully someone will
> > recognise it as a simple fix and send a patch first.
> 
> I've started seeing this one today in some builds and only sometimes,
> 
> bitbake -S some-image
> 
> seems to be best reproducer here.

Thanks Martin, that let me reproduce and push a fix.

Cheers,

Richard


