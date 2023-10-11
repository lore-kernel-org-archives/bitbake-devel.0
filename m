Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5514CD98FB
	for <webhook@archiver.kernel.org>; Wed, 11 Oct 2023 08:02:49 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.11791.1697011357536948628
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Oct 2023 01:02:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pianon.eu header.s=mail20151219 header.b=PuEPSMQb;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 6B1105C0096;
	Wed, 11 Oct 2023 10:02:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1697011354; x=1698825755; bh=x1
	X93aQP/aya8o2VhYcD4MfmId8hAPe01Xab6mx1ZNA=; b=PuEPSMQblXhbbe62RO
	rFBDegWHzK6hloy83+DSrzMMiyBrYjOz42AqXKWy1fNH790pjveLHbEm3GZsOzfb
	enCZRI0OJbrxLIcOsCUxWD4JVf4Ois6bFEscF9wTEEp2OfBtGw3G4keqyov3gr9n
	4yf+lHvRjTfgzUq0hieK5evMI=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o6yOaVioFwUf; Wed, 11 Oct 2023 10:02:34 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 834345C0095;
	Wed, 11 Oct 2023 10:02:34 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Oct 2023 10:02:34 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org, jpewhacker@gmail.com,
 carlo@piana.eu, luca.ceresoli@bootlin.com, peter.kjellerstedt@axis.com
Subject: Re: [PATCH v5] fetch2: Add API for upstream source tracing
In-Reply-To: <20231001075225.1054512-1-alberto@pianon.eu>
References: <20231001075225.1054512-1-alberto@pianon.eu>
Message-ID: <6618da6c6215f91b1e898ffa6d96a970@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Oct 2023 08:02:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15208

Hi Richard,
I just noticed that the patch has been merged!
Thanks for your availability and patience :)
Cheers,
Alberto

On 2023-10-01 09:52, alberto@pianon.eu wrote:
> From: Alberto Pianon <alberto@pianon.eu>
> 
> This patch adds an API to bb.fetch2 to enable users to plug in an 
> unpack
> tracer that can trace each source file back to its corresponding
> upstream source url, even when multiple upstream sources are combined
> together in the same unpack directory. This may be required for 
> software
> composition analysis, license compliance, and detailed SBoM generation.
> 
> This patch provides only the needed hooks in bb.fetch2 code and a dummy
> abstract class defining the API; users may load their own unpack tracer
> class by setting the BB_UNPACK_TRACER_CLASS config parameter.
> 
> Signed-off-by: Alberto Pianon <alberto@pianon.eu>
> ---
>  lib/bb/fetch2/__init__.py | 78 +++++++++++++++++++++++++++++++++++++++
>  lib/bb/fetch2/crate.py    |  2 +
>  lib/bb/fetch2/git.py      |  2 +
>  lib/bb/fetch2/gitsm.py    |  4 ++
>  lib/bb/fetch2/hg.py       |  1 +
>  lib/bb/fetch2/npm.py      |  1 +
>  lib/bb/fetch2/npmsw.py    |  3 ++
>  7 files changed, 91 insertions(+)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index ffb1a92b..35e9ca96 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1579,6 +1579,7 @@ class FetchMethod(object):
>              unpackdir = rootdir
> 
>          if not unpack or not cmd:
> +            urldata.unpack_tracer.unpack("file-copy", unpackdir)
>              # If file == dest, then avoid any copies, as we already 
> put the file into dest!
>              dest = os.path.join(unpackdir, os.path.basename(file))
>              if file != dest and not (os.path.exists(dest) and 
> os.path.samefile(file, dest)):
> @@ -1593,6 +1594,8 @@ class FetchMethod(object):
>                          destdir = urlpath.rsplit("/", 1)[0] + '/'
>                          bb.utils.mkdirhier("%s/%s" % (unpackdir, 
> destdir))
>                  cmd = 'cp -fpPRH "%s" "%s"' % (file, destdir)
> +        else:
> +            urldata.unpack_tracer.unpack("archive-extract", unpackdir)
> 
>          if not cmd:
>              return
> @@ -1684,6 +1687,55 @@ class FetchMethod(object):
>          """
>          return []
> 
> +
> +class DummyUnpackTracer(object):
> +    """
> +    Abstract API definition for a class that traces unpacked source 
> files back
> +    to their respective upstream SRC_URI entries, for software 
> composition
> +    analysis, license compliance and detailed SBOM generation 
> purposes.
> +    User may load their own unpack tracer class (instead of the dummy
> +    one) by setting the BB_UNPACK_TRACER_CLASS config parameter.
> +    """
> +    def start(self, unpackdir, urldata_dict, d):
> +        """
> +        Start tracing the core Fetch.unpack process, using an index to 
> map
> +        unpacked files to each SRC_URI entry.
> +        This method is called by Fetch.unpack and it may receive 
> nested calls by
> +        gitsm and npmsw fetchers, that expand SRC_URI entries by 
> adding implicit
> +        URLs and by recursively calling Fetch.unpack from new (nested) 
> Fetch
> +        instances.
> +        """
> +        return
> +    def start_url(self, url):
> +        """Start tracing url unpack process.
> +        This method is called by Fetch.unpack before the 
> fetcher-specific unpack
> +        method starts, and it may receive nested calls by gitsm and 
> npmsw
> +        fetchers.
> +        """
> +        return
> +    def unpack(self, unpack_type, destdir):
> +        """
> +        Set unpack_type and destdir for current url.
> +        This method is called by the fetcher-specific unpack method 
> after url
> +        tracing started.
> +        """
> +        return
> +    def finish_url(self, url):
> +        """Finish tracing url unpack process and update the file 
> index.
> +        This method is called by Fetch.unpack after the 
> fetcher-specific unpack
> +        method finished its job, and it may receive nested calls by 
> gitsm
> +        and npmsw fetchers.
> +        """
> +        return
> +    def complete(self):
> +        """
> +        Finish tracing the Fetch.unpack process, and check if all 
> nested
> +        Fecth.unpack calls (if any) have been completed; if so, save 
> collected
> +        metadata.
> +        """
> +        return
> +
> +
>  class Fetch(object):
>      def __init__(self, urls, d, cache = True, localonly = False, 
> connection_cache = None):
>          if localonly and cache:
> @@ -1704,10 +1756,30 @@ class Fetch(object):
>          if key in urldata_cache:
>              self.ud = urldata_cache[key]
> 
> +        # the unpack_tracer object needs to be made available to 
> possible nested
> +        # Fetch instances (when those are created by gitsm and npmsw 
> fetchers)
> +        # so we set it as a global variable
> +        global unpack_tracer
> +        try:
> +            unpack_tracer
> +        except NameError:
> +            class_path = d.getVar("BB_UNPACK_TRACER_CLASS")
> +            if class_path:
> +                # use user-defined unpack tracer class
> +                import importlib
> +                module_name, _, class_name = 
> class_path.rpartition(".")
> +                module = importlib.import_module(module_name)
> +                class_ = getattr(module, class_name)
> +                unpack_tracer = class_()
> +            else:
> +                # fall back to the dummy/abstract class
> +                unpack_tracer = DummyUnpackTracer()
> +
>          for url in urls:
>              if url not in self.ud:
>                  try:
>                      self.ud[url] = FetchData(url, d, localonly)
> +                    self.ud[url].unpack_tracer = unpack_tracer
>                  except NonLocalMethod:
>                      if localonly:
>                          self.ud[url] = None
> @@ -1883,6 +1955,8 @@ class Fetch(object):
>          if not urls:
>              urls = self.urls
> 
> +        unpack_tracer.start(root, self.ud, self.d)
> +
>          for u in urls:
>              ud = self.ud[u]
>              ud.setup_localpath(self.d)
> @@ -1890,11 +1964,15 @@ class Fetch(object):
>              if ud.lockfile:
>                  lf = bb.utils.lockfile(ud.lockfile)
> 
> +            unpack_tracer.start_url(u)
>              ud.method.unpack(ud, root, self.d)
> +            unpack_tracer.finish_url(u)
> 
>              if ud.lockfile:
>                  bb.utils.unlockfile(lf)
> 
> +        unpack_tracer.complete()
> +
>      def clean(self, urls=None):
>          """
>          Clean files that the fetcher gets or places
> diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
> index 3310ed00..01d49435 100644
> --- a/lib/bb/fetch2/crate.py
> +++ b/lib/bb/fetch2/crate.py
> @@ -101,8 +101,10 @@ class Crate(Wget):
>          bp = d.getVar('BP')
>          if bp == ud.parm.get('name'):
>              cmd = "tar -xz --no-same-owner -f %s" % thefile
> +            ud.unpack_tracer.unpack("crate-extract", rootdir)
>          else:
>              cargo_bitbake = self._cargo_bitbake_path(rootdir)
> +            ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)
> 
>              cmd = "tar -xz --no-same-owner -f %s -C %s" % (thefile, 
> cargo_bitbake)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 4385d0b3..c7ed1f03 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -589,6 +589,8 @@ class Git(FetchMethod):
>          destdir = ud.destdir = os.path.join(destdir, destsuffix)
>          if os.path.exists(destdir):
>              bb.utils.prunedir(destdir)
> +        if not ud.bareclone:
> +            ud.unpack_tracer.unpack("git", destdir)
> 
>          need_lfs = self._need_lfs(ud)
> 
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index a87361cc..f7f3af72 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -218,6 +218,10 @@ class GitSM(Git):
> 
>              try:
>                  newfetch = Fetch([url], d, cache=False)
> +                # modpath is needed by unpack tracer to calculate 
> submodule
> +                # checkout dir
> +                new_ud = newfetch.ud[url]
> +                new_ud.modpath = modpath
>                  
> newfetch.unpack(root=os.path.dirname(os.path.join(repo_conf, 'modules', 
> module)))
>              except Exception as e:
>                  logger.error('gitsm: submodule unpack failed: %s %s' % 
> (type(e).__name__, str(e)))
> diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
> index 063e1300..cbff8c49 100644
> --- a/lib/bb/fetch2/hg.py
> +++ b/lib/bb/fetch2/hg.py
> @@ -242,6 +242,7 @@ class Hg(FetchMethod):
>          revflag = "-r %s" % ud.revision
>          subdir = ud.parm.get("destsuffix", ud.module)
>          codir = "%s/%s" % (destdir, subdir)
> +        ud.unpack_tracer.unpack("hg", codir)
> 
>          scmdata = ud.parm.get("scmdata", "")
>          if scmdata != "nokeep":
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index f83485ad..15f3f19b 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -298,6 +298,7 @@ class Npm(FetchMethod):
>          destsuffix = ud.parm.get("destsuffix", "npm")
>          destdir = os.path.join(rootdir, destsuffix)
>          npm_unpack(ud.localpath, destdir, d)
> +        ud.unpack_tracer.unpack("npm", destdir)
> 
>      def clean(self, ud, d):
>          """Clean any existing full or partial download"""
> diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
> index 4ff2c8ff..ff5f8dc7 100644
> --- a/lib/bb/fetch2/npmsw.py
> +++ b/lib/bb/fetch2/npmsw.py
> @@ -191,7 +191,9 @@ class NpmShrinkWrap(FetchMethod):
>              else:
>                  raise ParameterError("Unsupported dependency: %s" % 
> name, ud.url)
> 
> +            # name is needed by unpack tracer for module mapping
>              ud.deps.append({
> +                "name": name,
>                  "url": url,
>                  "localpath": localpath,
>                  "extrapaths": extrapaths,
> @@ -270,6 +272,7 @@ class NpmShrinkWrap(FetchMethod):
>          destsuffix = ud.parm.get("destsuffix")
>          if destsuffix:
>              destdir = os.path.join(rootdir, destsuffix)
> +        ud.unpack_tracer.unpack("npm-shrinkwrap", destdir)
> 
>          bb.utils.mkdirhier(destdir)
>          bb.utils.copyfile(ud.shrinkwrap_file,

