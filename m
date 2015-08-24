Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 8BBA26AC1E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Aug 2015 14:59:44 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 24 Aug 2015 07:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,738,1432623600"; d="scan'208";a="754397270"
Received: from achalot-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.20.62])
	by orsmga001.jf.intel.com with ESMTP; 24 Aug 2015 07:59:42 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Saul Wold <sgw@linux.intel.com>
Date: Mon, 24 Aug 2015 15:59:40 +0100
Message-ID: <9669711.LimNJde33H@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.1.5-100.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <1440238280.12105.284.camel@linuxfoundation.org>
References: <1440092897-6518-1-git-send-email-sgw@linux.intel.com>
	<1440238280.12105.284.camel@linuxfoundation.org>
MIME-Version: 1.0
Cc: akuster808@gmail.com, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH][1.24/Dizzy] cooker: properly fix bitbake.lock handling
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
X-List-Received-Date: Mon, 24 Aug 2015 14:59:46 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 22 August 2015 11:11:20 Richard Purdie wrote:
> On Thu, 2015-08-20 at 10:48 -0700, Saul Wold wrote:
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> > If the PR server or indeed any other child process takes some time to
> > exit (which it sometimes does when saving its database), it can end up
> > holding bitbake.lock after the UI exits, which led to errors if you ran
> > bitbake commands successively - we saw this when running the PR server
> > oe-selftest tests in OE-Core. The recent attempt to fix this wasn't
> > quite right and ended up breaking memory resident bitbake. This time we
> > close the lock file when cooker shuts down (inside the UI process)
> > instead of unlocking it, and this is done in the cooker code rather than
> > the actual UI code so it doesn't matter which UI is in use. Additionally
> > we report that we're waiting for the lock to be released, using lsof or
> > fuser if available to list the processes with the lock open.
> > 
> > The 'magic' in the locking is due to all spawned subprocesses of bitbake
> > holding an open file descriptor to the bitbake.lock. It is automatically
> > unlocked when all those fds close the file (as all the processes
> > terminate). We close the UI copy of the lock explicitly, then close the
> > server process copy, any remaining open copy is therefore some proess
> > exiting.
> > 
> > (The reproducer for the problem is to set PRSERV_HOST = "localhost:0"
> > and add a call to time.sleep(20) after self.server_close() in
> > lib/prserv/serv.py, then run "bitbake -p; bitbake -p" ).
> > 
> > Cleanup work done by Paul Eggleton <paul.eggleton@linux.intel.com>.
> > 
> > This reverts bitbake commit 69ecd15aece54753154950c55d7af42f85ad8606 and
> > e97a9f1528d77503b5c93e48e3de9933fbb9f3cd.
> > 
> > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> > [sgw - merged changes from new main.py to bin/bitbake, dizzy will continue
> > to use bin/bitbake and not use the new main.py (which is removed)]
> > Signed-off-by: Saul Wold <sgw@linux.intel.com>
> > 
> > Conflicts:
> > 	lib/bb/cooker.py
> > 	lib/bb/main.py
> > 	lib/bb/tinfoil.py
> > 	lib/bb/ui/knotty.py
> > 
> > ---
> > 
> >  bin/bitbake         |  7 ++++++-
> >  lib/bb/cooker.py    | 31 ++++++++++++++++++++++++++++++-
> >  lib/bb/tinfoil.py   |  5 +++++
> >  lib/bb/ui/knotty.py | 43 ++++++++++++++++++++++++-------------------
> >  lib/bb/utils.py     | 29 +++++++++++++++++++++++++----
> >  5 files changed, 90 insertions(+), 25 deletions(-)
> > 
> > diff --git a/bin/bitbake b/bin/bitbake
> > index a2e8cc1..d3055fb 100755
> > --- a/bin/bitbake
> > +++ b/bin/bitbake
> > 
> > @@ -263,13 +263,18 @@ def start_server(servermodule, configParams, 
configuration, features):
> >                  logger.handle(event)
> >          
> >          raise exc_info[1], None, exc_info[2]
> >      
> >      server.detach()
> > 
> > +    cooker.lock.close()
> > 
> >      return server
> >  
> >  def main():
> > -    configParams = BitBakeConfigParameters()
> > +    # Python multiprocessing requires /dev/shm on Linux
> > +    if sys.platform.startswith('linux') and not os.access('/dev/shm',
> > os.W_OK | os.X_OK): +        raise sys.exit("FATAL: /dev/shm does not
> > exist or is not writable") +
> > +    conaigParams = BitBakeConfigParameters()
> > 
> >      configuration = cookerdata.CookerConfiguration()
> >      configuration.setConfigParameters(configParams)
> 
> conaigParams ?
> 
> I think the above hunk shouldn't be there...

Not to mention this needs to be in 1.26 (i.e. corresponding to fido) first, and 
properly tested.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

