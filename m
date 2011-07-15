Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QhqzK-0006kM-Be for bitbake-devel@lists.openembedded.org;
	Sat, 16 Jul 2011 00:36:02 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6FMVxrN024805;
	Fri, 15 Jul 2011 23:31:59 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23794-10; Fri, 15 Jul 2011 23:31:55 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6FMVnQ4024799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 Jul 2011 23:31:52 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <9a52d91b4f94d428140842add6eb54dd0f4446f1.1310761024.git.josh@linux.intel.com>
References: <cover.1310761024.git.josh@linux.intel.com>
	<9a52d91b4f94d428140842add6eb54dd0f4446f1.1310761024.git.josh@linux.intel.com>
Date: Fri, 15 Jul 2011 23:31:44 +0100
Message-ID: <1310769104.20015.1256.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
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
X-List-Received-Date: Fri, 15 Jul 2011 22:36:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-07-15 at 13:20 -0700, Joshua Lock wrote:
> Add command reparseFiles to reparse bb files in a running cooker instance.
> 
> Fixes [YOCTO #1249]
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/command.py |    8 +++++++
>  lib/bb/cooker.py  |   54 +++++++++++++++++++++++++++++++++-------------------
>  2 files changed, 42 insertions(+), 20 deletions(-)
> 

> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 23f2c76..e4daaef 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -122,21 +122,8 @@ class BBCooker:
>                  logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
>                  sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
>  
> -        self.configuration.data = bb.data.init()
> -
> -        bb.data.inheritFromOS(self.configuration.data)
> -
> -        try:
> -            self.parseConfigurationFiles(self.configuration.prefile,
> -                                         self.configuration.postfile)
> -        except SyntaxError:
> -            sys.exit(1)
> -        except Exception:
> -            logger.exception("Error parsing configuration files")
> -            sys.exit(1)
> -
> -        if not self.configuration.cmd:
> -            self.configuration.cmd = bb.data.getVar("BB_DEFAULT_TASK", self.configuration.data, True) or "build"
> +        self.configuration.data = None
> +        self.loadConfigurationData()
>  
>          bbpkgs = bb.data.getVar('BBPKGS', self.configuration.data, True)
>          if bbpkgs and len(self.configuration.pkgs_to_build) == 0:
> @@ -163,6 +150,26 @@ class BBCooker:
>  
>          self.parser = None
>  
> +    def loadConfigurationData(self):
> +        self.configuration.data = bb.data.init()
> +
> +        if not self.server_registration_cb:
> +            bb.data.setVar("BB_WORKERCONTEXT", "1", self.configuration.data)

This looks like one of the last remaining differences between the
bitbake in poky and the upstream. See:

http://git.openembedded.net/cgit.cgi/bitbake/commit/?h=master-poky&id=a67671bcdd92f2ae3cd364b2addefef70a3c2398

but bottom line is this shouldn't be here.

> +        bb.data.inheritFromOS(self.configuration.data)

and this line is the one that worries me since it pokes around the
environment. If we do this later, we're likely using a different
environment and I'm not happy this is going to give good results.

This actually ties into the terminal bbclass issues Chris has been
proposing recently. I think we need to store off the original
environment into a datastore and then leave it somewhere fixed we can
recall it later for the likes of this function and the terminal class
code.

> +        try:
> +            self.parseConfigurationFiles(self.configuration.prefile,
> +                                         self.configuration.postfile)
> +        except SyntaxError:
> +            sys.exit(1)
> +        except Exception:
> +            logger.exception("Error parsing configuration files")
> +            sys.exit(1)
> +
> +        if not self.configuration.cmd:
> +            self.configuration.cmd = bb.data.getVar("BB_DEFAULT_TASK", self.configuration.data, True) or "build"
> +
>      def parseConfiguration(self):
>  
> 
> @@ -508,7 +515,7 @@ class BBCooker:
>          bb.data.expandKeys(localdata)
>  
>          # Handle PREFERRED_PROVIDERS
> -        for p in (bb.data.getVar('PREFERRED_PROVIDERS', localdata, 1) or "").split():
> +        for p in (bb.data.getVar('PREFERRED_PROVIDERS', localdata, True) or "").split():
>              try:
>                  (providee, provider) = p.split(':')
>              except:
> @@ -999,8 +1006,8 @@ class BBCooker:
>  
>          self.server_registration_cb(buildTargetsIdle, rq)
>  
> -    def updateCache(self):
> -        if self.state == state.running:
> +    def updateCache(self, force=False):
> +        if self.state == state.running and not force:
>              return
>  
>          if self.state in (state.shutdown, state.stop):
> @@ -1010,6 +1017,8 @@ class BBCooker:
>          if self.state != state.parsing:
>              self.parseConfiguration ()
>  
> +            if self.status:
> +                del self.status
>              self.status = bb.cache.CacheData(self.caches_array)
>  
>              ignore = bb.data.getVar("ASSUME_PROVIDED", self.configuration.data, 1) or ""
> @@ -1083,7 +1092,7 @@ class BBCooker:
>  
>          collectlog.debug(1, "collecting .bb files")
>  
> -        files = (data.getVar( "BBFILES", self.configuration.data, 1 ) or "").split()
> +        files = (data.getVar( "BBFILES", self.configuration.data, True) or "").split()
>          data.setVar("BBFILES", " ".join(files), self.configuration.data)
>  
>          # Sort files by priority
> @@ -1140,7 +1149,8 @@ class BBCooker:
>              base = os.path.basename(f).replace('.bbappend', '.bb')
>              if not base in self.appendlist:
>                 self.appendlist[base] = []
> -            self.appendlist[base].append(f)
> +            if f not in self.appendlist[base]:
> +                self.appendlist[base].append(f)

append files only get appended once. Shouldn't that be a separate patch?

Otherwise the patch and the idea are ok, we just need to be careful to
get this right...

Cheers,

Richard



