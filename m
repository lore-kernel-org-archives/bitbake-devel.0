Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QhsZd-0000Q3-Bh
	for bitbake-devel@lists.openembedded.org;
	Sat, 16 Jul 2011 02:17:37 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 15 Jul 2011 17:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,211,1309762800"; d="scan'208";a="28617962"
Received: from unknown (HELO [10.255.14.32]) ([10.255.14.32])
	by fmsmga002.fm.intel.com with ESMTP; 15 Jul 2011 17:13:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Fri, 15 Jul 2011 17:13:29 -0700
In-Reply-To: <1310769104.20015.1256.camel@rex>
References: <cover.1310761024.git.josh@linux.intel.com>
	<9a52d91b4f94d428140842add6eb54dd0f4446f1.1310761024.git.josh@linux.intel.com>
	<1310769104.20015.1256.camel@rex>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1310775215.2309.19.camel@scimitar>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/6] command|cooker: Add reparseFiles command
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 16 Jul 2011 00:17:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-07-15 at 23:31 +0100, Richard Purdie wrote:
> On Fri, 2011-07-15 at 13:20 -0700, Joshua Lock wrote:
> > Add command reparseFiles to reparse bb files in a running cooker instance.
> > 
> > Fixes [YOCTO #1249]
> > 
> > Signed-off-by: Joshua Lock <josh@linux.intel.com>
> > ---
> >  lib/bb/command.py |    8 +++++++
> >  lib/bb/cooker.py  |   54 +++++++++++++++++++++++++++++++++-------------------
> >  2 files changed, 42 insertions(+), 20 deletions(-)
> > 
> 
> > diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> > index 23f2c76..e4daaef 100644
> > --- a/lib/bb/cooker.py
> > +++ b/lib/bb/cooker.py
> > @@ -122,21 +122,8 @@ class BBCooker:
> >                  logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
> >                  sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
> >  
> > -        self.configuration.data = bb.data.init()
> > -
> > -        bb.data.inheritFromOS(self.configuration.data)
> > -
> > -        try:
> > -            self.parseConfigurationFiles(self.configuration.prefile,
> > -                                         self.configuration.postfile)
> > -        except SyntaxError:
> > -            sys.exit(1)
> > -        except Exception:
> > -            logger.exception("Error parsing configuration files")
> > -            sys.exit(1)
> > -
> > -        if not self.configuration.cmd:
> > -            self.configuration.cmd = bb.data.getVar("BB_DEFAULT_TASK", self.configuration.data, True) or "build"
> > +        self.configuration.data = None
> > +        self.loadConfigurationData()
> >  
> >          bbpkgs = bb.data.getVar('BBPKGS', self.configuration.data, True)
> >          if bbpkgs and len(self.configuration.pkgs_to_build) == 0:
> > @@ -163,6 +150,26 @@ class BBCooker:
> >  
> >          self.parser = None
> >  
> > +    def loadConfigurationData(self):
> > +        self.configuration.data = bb.data.init()
> > +
> > +        if not self.server_registration_cb:
> > +            bb.data.setVar("BB_WORKERCONTEXT", "1", self.configuration.data)
> 
> This looks like one of the last remaining differences between the
> bitbake in poky and the upstream. See:
> 
> http://git.openembedded.net/cgit.cgi/bitbake/commit/?h=master-poky&id=a67671bcdd92f2ae3cd364b2addefef70a3c2398
> 
> but bottom line is this shouldn't be here.

Whoops.

> 
> > +        bb.data.inheritFromOS(self.configuration.data)
> 
> and this line is the one that worries me since it pokes around the
> environment. If we do this later, we're likely using a different
> environment and I'm not happy this is going to give good results.
> 
> This actually ties into the terminal bbclass issues Chris has been
> proposing recently. I think we need to store off the original
> environment into a datastore and then leave it somewhere fixed we can
> recall it later for the likes of this function and the terminal class
> code.

Ah, that's a better idea. I'll take a stab at something to do that.

> 
> > +        try:
> > +            self.parseConfigurationFiles(self.configuration.prefile,
> > +                                         self.configuration.postfile)
> > +        except SyntaxError:
> > +            sys.exit(1)
> > +        except Exception:
> > +            logger.exception("Error parsing configuration files")
> > +            sys.exit(1)
> > +
> > +        if not self.configuration.cmd:
> > +            self.configuration.cmd = bb.data.getVar("BB_DEFAULT_TASK", self.configuration.data, True) or "build"
> > +
> >      def parseConfiguration(self):
> >  
> > 
> > @@ -508,7 +515,7 @@ class BBCooker:
> >          bb.data.expandKeys(localdata)
> >  
> >          # Handle PREFERRED_PROVIDERS
> > -        for p in (bb.data.getVar('PREFERRED_PROVIDERS', localdata, 1) or "").split():
> > +        for p in (bb.data.getVar('PREFERRED_PROVIDERS', localdata, True) or "").split():
> >              try:
> >                  (providee, provider) = p.split(':')
> >              except:
> > @@ -999,8 +1006,8 @@ class BBCooker:
> >  
> >          self.server_registration_cb(buildTargetsIdle, rq)
> >  
> > -    def updateCache(self):
> > -        if self.state == state.running:
> > +    def updateCache(self, force=False):
> > +        if self.state == state.running and not force:
> >              return
> >  
> >          if self.state in (state.shutdown, state.stop):
> > @@ -1010,6 +1017,8 @@ class BBCooker:
> >          if self.state != state.parsing:
> >              self.parseConfiguration ()
> >  
> > +            if self.status:
> > +                del self.status
> >              self.status = bb.cache.CacheData(self.caches_array)
> >  
> >              ignore = bb.data.getVar("ASSUME_PROVIDED", self.configuration.data, 1) or ""
> > @@ -1083,7 +1092,7 @@ class BBCooker:
> >  
> >          collectlog.debug(1, "collecting .bb files")
> >  
> > -        files = (data.getVar( "BBFILES", self.configuration.data, 1 ) or "").split()
> > +        files = (data.getVar( "BBFILES", self.configuration.data, True) or "").split()
> >          data.setVar("BBFILES", " ".join(files), self.configuration.data)
> >  
> >          # Sort files by priority
> > @@ -1140,7 +1149,8 @@ class BBCooker:
> >              base = os.path.basename(f).replace('.bbappend', '.bb')
> >              if not base in self.appendlist:
> >                 self.appendlist[base] = []
> > -            self.appendlist[base].append(f)
> > +            if f not in self.appendlist[base]:
> > +                self.appendlist[base].append(f)
> 
> append files only get appended once. Shouldn't that be a separate patch?

Quite possibly. I have a bad habit of spotting things and changing them
when I should be thinking about something else. I'll split this change
out next time. Must have missed it this try.

> 
> Otherwise the patch and the idea are ok, we just need to be careful to
> get this right...

Thanks for the detailed review. I'll work on a new revision to address
your concerns.

Regards,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



