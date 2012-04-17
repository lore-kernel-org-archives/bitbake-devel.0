Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SK5yC-0007OR-RS for bitbake-devel@lists.openembedded.org;
	Tue, 17 Apr 2012 12:49:13 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3HAdjZ2011868;
	Tue, 17 Apr 2012 11:39:45 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 11217-08; Tue, 17 Apr 2012 11:39:41 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3HAdauA011862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Apr 2012 11:39:37 +0100
Message-ID: <1334659179.616.72.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Tue, 17 Apr 2012 11:39:39 +0100
In-Reply-To: <49da1e00e1a8a0b0b241942cc70cfc89be232a2a.1334650694.git.dongxiao.xu@intel.com>
References: <cover.1334650694.git.dongxiao.xu@intel.com>
	<49da1e00e1a8a0b0b241942cc70cfc89be232a2a.1334650694.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/4] bitbake: Retain order for __depends and __base_depends
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
X-List-Received-Date: Tue, 17 Apr 2012 10:49:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Dongxiao,

I've spent a while thinking about this patch and its implications. We
have several potential correctness issues here. I finally realised there
is a correctness issue for get_file_depends() with the ordering which
means I can't merge it :(. I'm going to give all the feedback I came up
with whilst considering it as there are other details we need to get
right.

The issue is that we need consider what we're using this variable for
and how. We need the data to be meaningful, useful and correct. We're
trying to use the data for multiple things and it needs to be correct in
each case.

On Tue, 2012-04-17 at 16:21 +0800, Dongxiao Xu wrote:
> Bitbake take seriously with variables order, therefore when setting
> values to __depends and __base_depends, we need to retain its order.
> 
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  lib/bb/cache.py          |    6 ++++--
>  lib/bb/cooker.py         |    6 ++++--
>  lib/bb/parse/__init__.py |   12 ++++++++----
>  3 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> index 47e814b..a114582 100644
> --- a/lib/bb/cache.py
> +++ b/lib/bb/cache.py
> @@ -391,12 +391,14 @@ class Cache(object):
>          """Parse the specified filename, returning the recipe information"""
>          infos = []
>          datastores = cls.load_bbfile(filename, appends, configdata)
> -        depends = set()
> +        depends = []
>          for variant, data in sorted(datastores.iteritems(),
>                                      key=lambda i: i[0],
>                                      reverse=True):
>              virtualfn = cls.realfn2virtual(filename, variant)
> -            depends |= (data.getVar("__depends", False) or set())
> +            for dep in (data.getVar("__depends", False) or []):
> +                if dep not in depends:
> +                    depends.append(dep)
>              if depends and not variant:
>                  data.setVar("__depends", depends)

This one is the hardest to get right. We really need to:

* Save off the original __depends
* Check the returned __depends and compute what was added compared to
the original __depends value for each variant, then add only these
additions to the base __depends value.


> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index dea0aad..51341fa 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -680,8 +680,10 @@ class BBCooker:
>          # Generate a list of parsed configuration files by searching the files
>          # listed in the __depends and __base_depends variables with a .conf suffix.
>          conffiles = []
> -        dep_files = self.configuration.data.getVar('__depends') or set()
> -        dep_files.union(self.configuration.data.getVar('__base_depends') or set())
> +        dep_files = self.configuration.data.getVar('__depends') or []
> +        for dep in (self.configuration.data.getVar('__base_depends') or []):
> +            if dep not in dep_files:
> +                dep_files.append(dep)

Here we may as well do:

    dep_files = set(self.configuration.data.getVar('__depends') or [])
    dep_files.update(self.configuration.data.getVar('__base_depends') or [])

since order and duplicates don't matter.

>          for f in dep_files:
>              if f[0].endswith(".conf"):
> diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
> index 7b9c47e..f223ff9 100644
> --- a/lib/bb/parse/__init__.py
> +++ b/lib/bb/parse/__init__.py
> @@ -73,8 +73,10 @@ def update_mtime(f):
>  def mark_dependency(d, f):
>      if f.startswith('./'):
>          f = "%s/%s" % (os.getcwd(), f[2:])
> -    deps = d.getVar('__depends') or set()
> -    deps.update([(f, cached_mtime(f))])
> +    deps = d.getVar('__depends') or []
> +    t = cached_mtime(f)
> +    if (f, t) not in deps:
> +        deps.append((f, t))
>      d.setVar('__depends', deps)

I think this should be unconditional even if it introduces duplicates so
that we can know if the file was included more than once:

    deps = d.getVar('__depends') or []
    t = cached_mtime(f)
    deps.append((f, t))
    d.setVar('__depends', deps)

>  def supports(fn, data):
> @@ -134,8 +136,10 @@ def vars_from_file(mypkg, d):
>  def get_file_depends(d):
>      '''Return the dependent files'''
>      dep_files = []
> -    depends = d.getVar('__depends', True) or set()
> -    depends = depends.union(d.getVar('__base_depends', True) or set())
> +    depends = d.getVar('__depends', True) or []
> +    for dep in (d.getVar('__base_depends', True) or []):
> +        if dep not in depends:
> +            depends.append(dep)
>      for (fn, _) in depends:
>          dep_files.append(os.path.abspath(fn))
>      return " ".join(dep_files)

This is the one that really worried me. __base_depends needs to be
listed before __depends as that was the order used. Again, we shouldn't
be removing duplicates so:

    depends = d.getVar('__base_depends', True) or []
    for dep in (d.getVar('__depends', True) or []):
        depends.append(dep)

Also, in cache.py:cacheValidUpdate(), we might as well do something
like:

-  for f, old_mtime in depends:
+  for f, old_mtime in set(depends):

although this is a micro optimisation. We could do that when the value
is placed in the cache I guess and reduce cache size too.

Cheers,

Richard




