Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 119016E85C;
	Sun, 23 Feb 2014 09:25:47 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1N9PiHf021836; Sun, 23 Feb 2014 09:25:44 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id g8BGqnzz-ouL; Sun, 23 Feb 2014 09:25:44 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1N9PfmD021828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 23 Feb 2014 09:25:42 GMT
Message-ID: <1393147533.5181.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Sun, 23 Feb 2014 09:25:33 +0000
In-Reply-To: <20140223090640.GR3854@jama>
References: <20140222120736.GN3854@jama> <20140223090640.GR3854@jama>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: ValueError: insecure string pickle with latest bitbake
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
X-List-Received-Date: Sun, 23 Feb 2014 09:25:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2014-02-23 at 10:06 +0100, Martin Jansa wrote:
> On Sat, Feb 22, 2014 at 01:07:36PM +0100, Martin Jansa wrote:
> > Hi,
> > 
> > last couple of days many of my jenkins builds failed with exception like
> > this:
> > 
> > ERROR: An uncaught exception occured in runqueue, please see the failure below:
> > ERROR: Running idle function
> > Traceback (most recent call last):
> >   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/cooker.py", line 1182, in buildTargetsIdle(server=<ProcessServer(ProcessServer-2, started)>, rq=<bb.runqueue.RunQueue instance at 0x16a95d40>, abort=False):
> >                  try:
> >     >                retval = rq.execute_runqueue()
> >                  except runqueue.TaskFailure as exc:
> >   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runqueue.py", line 1093, in RunQueue.execute_runqueue():
> >                  try:
> >     >                self.teardown_workers()
> >                  except:
> >   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runqueue.py", line 925, in RunQueue.teardown_workers():
> >              self.workerpipe = None
> >     >        self._teardown_worker(self.fakeworker, self.fakeworkerpipe)
> >              self.fakeworker = None
> >   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runqueue.py", line 906, in RunQueue._teardown_worker(worker=<subprocess.Popen object at 0xcb4e690>, workerpipe=<bb.runqueue.runQueuePipe instance at 0x11c17710>):
> >              while worker.returncode is None:
> >     >            workerpipe.read()
> >                  worker.poll()
> >   File "/home/jenkins/oe/shr-core-branches/shr-core/bitbake/lib/bb/runqueue.py", line 2095, in runQueuePipe.read():
> >                  while index != -1 and self.queue.startswith("<event>"):
> >     >                event = pickle.loads(self.queue[7:index])
> >                      bb.event.fire_from_worker(event, self.d)
> > ValueError: insecure string pickle
> > 
> > and it repeats the same exception very quickly (generated 3GB log in ~ hour)
> > 
> > It doesn't happen always, it seems to be triggered in different places in build.
> > 
> > Anyone else seeing this as well?
> > 
> > I'll add some debug output around it and wait for it to happen again.
> 
> I got one example now (not sure if this is the only one):
> 
> Because it shows runrpmdeps and I'm the only one so far seeing this, I guess it's caused by:
> http://lists.openembedded.org/pipermail/openembedded-core/2014-February/089632.html
> I'll try to revert that one from my builds

Ah, it that function is called as:

processed = list(pool.imap(oe.package.filedeprunner, pkglist))

i.e. we have multiple processes each running this function. If we print
output, the output stream has no synchronisation and can hence be
corrupted which would explain the value error. You can see an <event>
appear half way through your output...

Cheers,

Richard 


