Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QSE8k-0001ws-O1
	for bitbake-devel@lists.openembedded.org;
	Thu, 02 Jun 2011 22:05:11 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 02 Jun 2011 13:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,311,1304319600"; d="scan'208";a="12747955"
Received: from unknown (HELO [10.255.13.82]) ([10.255.13.82])
	by fmsmga001.fm.intel.com with ESMTP; 02 Jun 2011 13:01:57 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 02 Jun 2011 13:01:52 -0700
In-Reply-To: <1cd9d0b284c1cd1966b0c2c1ea9fbad15c5ed5fc.1306947210.git.paul.eggleton@linux.intel.com>
References: <cover.1306947210.git.paul.eggleton@linux.intel.com>
	<1cd9d0b284c1cd1966b0c2c1ea9fbad15c5ed5fc.1306947210.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.0.1 (3.0.1-1.fc15) 
Message-ID: <1307044917.2050.15.camel@scimitar>
Mime-Version: 1.0
Subject: Re: [RFC PATCH 1/2] bitbake: track skipped packages
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
X-List-Received-Date: Thu, 02 Jun 2011 20:05:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-06-01 at 18:26 +0100, Paul Eggleton wrote:
> Add skiplist to cooker that allows access to the list of packages skipped
> via SkipPackage (this includes COMPATIBLE_MACHINE, INCOMPATIBLE_LICENSE,
> etc.) This can be used to enhance error reporting.

Neat. Minor coding style nit below.

> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/cache.py     |   12 +++++++++---
>  bitbake/lib/bb/cooker.py    |   16 ++++++++++++++++
>  bitbake/lib/bb/parse/ast.py |   12 ++++++------
>  3 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
> index d083c51..076262b 100644
> --- a/bitbake/lib/bb/cache.py
> +++ b/bitbake/lib/bb/cache.py
> @@ -59,6 +59,7 @@ recipe_fields = (
>      'broken',
>      'not_world',
>      'skipped',
> +    'skipreason',
>      'timestamp',
>      'packages',
>      'packages_dynamic',
> @@ -128,11 +129,15 @@ class RecipeInfo(namedtuple('RecipeInfo', recipe_fields)):
>  
>      @classmethod
>      def from_metadata(cls, filename, metadata):
> -        if cls.getvar('__SKIPPED', metadata):
> +        skipval = cls.getvar('__SKIPPED', metadata)
> +        if skipval:
>              return cls.make_optional(skipped=True,
> +                                     skipreason=skipval,
>                                       file_depends=metadata.getVar('__depends', False),
>                                       timestamp=bb.parse.cached_mtime(filename),
> -                                     variants=cls.listvar('__VARIANTS', metadata) + [''])
> +                                     variants=cls.listvar('__VARIANTS', metadata) + [''],
> +                                     provides=cls.depvar('PROVIDES', metadata),
> +                                     rprovides=cls.depvar('RPROVIDES', metadata))
>  
>          tasks = metadata.getVar('__BBTASKS', False)
>  
> @@ -152,6 +157,7 @@ class RecipeInfo(namedtuple('RecipeInfo', recipe_fields)):
>              variants         = cls.listvar('__VARIANTS', metadata) + [''],
>  
>              skipped          = False,
> +            skipreason       = None,
>              timestamp        = bb.parse.cached_mtime(filename),
>              packages         = cls.listvar('PACKAGES', metadata),
>              pn               = pn,
> @@ -348,7 +354,7 @@ class Cache(object):
>          cached, infos = self.load(fn, appends, cfgData)
>          for virtualfn, info in infos:
>              if info.skipped:
> -                logger.debug(1, "Skipping %s", virtualfn)
> +                logger.debug(1, "Skipping %s: %s", (virtualfn, info.skipreason) )
>                  skipped += 1
>              else:
>                  self.add_info(virtualfn, info, cacheData, not cached)
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 0b52f18..9b12e0d 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -55,6 +55,20 @@ class NothingToBuild(Exception):
>  class state:
>      initial, parsing, running, shutdown, stop = range(5)
>  
> +
> +class SkippedPackage:
> +    def __init__(self, info = None, reason = None):
> +        self.skipreason = None
> +        self.provides = None
> +        self.rprovides = None
> +
> +        if info:
> +            self.skipreason = info.skipreason
> +            self.provides = info.provides
> +            self.rprovides = info.rprovides
> +        elif reason:
> +            self.skipreason = reason
> +
>  #============================================================================#
>  # BBCooker
>  #============================================================================#
> @@ -66,6 +80,7 @@ class BBCooker:
>      def __init__(self, configuration, server):
>          self.status = None
>          self.appendlist = {}
> +        self.skiplist = {}
>  
>          if server:
>              self.server = server.BitBakeServer(self)
> @@ -1198,6 +1213,7 @@ class CookerParser(object):
>          for virtualfn, info in result:
>              if info.skipped:
>                  self.skipped += 1
> +                self.cooker.skiplist[virtualfn] = SkippedPackage(info)
>              self.bb_cache.add_info(virtualfn, info, self.cooker.status,
>                                          parsed=parsed)
>          return True
> diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
> index 375dc61..18e491c 100644
> --- a/bitbake/lib/bb/parse/ast.py
> +++ b/bitbake/lib/bb/parse/ast.py
> @@ -376,8 +376,8 @@ def multi_finalize(fn, d):
>      try:
>          if not onlyfinalise or "default" in onlyfinalise:
>              finalize(fn, d)
> -    except bb.parse.SkipPackage:
> -        bb.data.setVar("__SKIPPED", True, d)
> +    except bb.parse.SkipPackage as e:
> +        bb.data.setVar("__SKIPPED", e.args[0], d)
>      datastores = {"": safe_d}
>  
>      versions = (d.getVar("BBVERSIONS", True) or "").split()
> @@ -419,8 +419,8 @@ def multi_finalize(fn, d):
>              verfunc(pv, d, safe_d)
>              try:
>                  finalize(fn, d)
> -            except bb.parse.SkipPackage:
> -                bb.data.setVar("__SKIPPED", True, d)
> +            except bb.parse.SkipPackage as e:
> +                bb.data.setVar("__SKIPPED", e.args[0], d)

This doesn't seem very Pythonic. I think you should just be able to do:
bb.data.setVar("__SKIPPED", e, d)
or possibly:
bb.data.setVar("__SKIPPED", str(e), d)

I know I'm being picky but that e.args[0] stuck out like a sore thumb.

>  
>          _create_variants(datastores, versions, verfunc)
>  
> @@ -439,8 +439,8 @@ def multi_finalize(fn, d):
>              try:
>                  if not onlyfinalise or variant in onlyfinalise:
>                      finalize(fn, variant_d, variant)
> -            except bb.parse.SkipPackage:
> -                bb.data.setVar("__SKIPPED", True, variant_d)
> +            except bb.parse.SkipPackage as e:
> +                bb.data.setVar("__SKIPPED", e.args[0], variant_d)

Same as above.

>  
>      if len(datastores) > 1:
>          variants = filter(None, datastores.iterkeys())

-- 
Joshua Lock
        Yocto Build System Monkey
        Intel Open Source Technology Centre



