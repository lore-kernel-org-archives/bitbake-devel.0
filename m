Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1SWyvQ-0005mN-9m
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 01:55:36 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4MNjPao026603
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 22 May 2012 16:45:25 -0700 (PDT)
Received: from Macintosh-5.local (172.25.36.232) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Tue, 22 May 2012 16:45:24 -0700
Message-ID: <4FBC2513.4090607@windriver.com>
Date: Tue, 22 May 2012 18:45:23 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6;
	rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <cover.1337728949.git.paul.eggleton@linux.intel.com>
	<470bb8bf282b2fa038947bd81a3b48d9b18607c8.1337728949.git.paul.eggleton@linux.intel.com>
In-Reply-To: <470bb8bf282b2fa038947bd81a3b48d9b18607c8.1337728949.git.paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] bitbake: implement checksums for local files in SRC_URI
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
X-List-Received-Date: Tue, 22 May 2012 23:55:36 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/12 6:23 PM, Paul Eggleton wrote:
> Gathers a list of paths to have checksums calculated at parse time, and
> processes these when calculating task hashes. Checksums are cached with
> the file's current mtime. Thus, changing any local file in SRC_URI will
> now cause the do_fetch taskhash to change, thus forcing a rebuild.

Does the mtime change invalidate the checksum, or just cause the checksum to be 
re-interpreted?

The issue I see is that you share a ccache file with someone else, their files 
may simply have a different mtime on them.

 From reading the code below, I think the comment is just confusing me.  The 
checksum is computed and stored bases on a hash + mtime.  If the mtime changes, 
that will cause the system to recalculate the checksum, which may end up being 
the same.. (and if it is, no rebuild) right?

--Mark

> This change adds very roughly about an 8% increase in parse time (a few
> seconds) and maybe a few seconds during runqueue generation, so a fairly
> moderate performance hit.
>
> Note that since paths are resolved at parse time, this will not force
> a rebuild when files are introduced which would cause that resolved path
> to be different - for example, where a machine-specific version of a file
> was added without otherwise changing the recipe. This will need to be
> handled in a future update.
>
> Code to hook this into the signature generator was courtesy of
> Richard Purdie<richard.purdie@linuxfoundation.org>.
>
> Implements [YOCTO #2044].
>
> Signed-off-by: Paul Eggleton<paul.eggleton@linux.intel.com>
> ---
>   bitbake/lib/bb/cache.py           |   13 ++++--
>   bitbake/lib/bb/checksum.py        |   90 +++++++++++++++++++++++++++++++++++++
>   bitbake/lib/bb/cooker.py          |    2 +
>   bitbake/lib/bb/fetch2/__init__.py |   85 +++++++++++++++++++++++++++++++++++
>   bitbake/lib/bb/siggen.py          |   24 ++++++++++
>   5 files changed, 211 insertions(+), 3 deletions(-)
>   create mode 100644 bitbake/lib/bb/checksum.py
>
> diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
> index 36e6356..dea2a80 100644
> --- a/bitbake/lib/bb/cache.py
> +++ b/bitbake/lib/bb/cache.py
> @@ -43,7 +43,7 @@ except ImportError:
>       logger.info("Importing cPickle failed. "
>                   "Falling back to a very slow implementation.")
>
> -__cache_version__ = "143"
> +__cache_version__ = "144"
>
>   def getCacheFile(path, filename, data_hash):
>       return os.path.join(path, filename + "." + data_hash)
> @@ -76,9 +76,13 @@ class RecipeInfoCommon(object):
>                       for task in tasks)
>
>       @classmethod
> -    def flaglist(cls, flag, varlist, metadata):
> -        return dict((var, metadata.getVarFlag(var, flag, True))
> +    def flaglist(cls, flag, varlist, metadata, squash=False):
> +        out_dict = dict((var, metadata.getVarFlag(var, flag, True))
>                       for var in varlist)
> +        if squash:
> +            return dict((k,v) for (k,v) in out_dict.iteritems() if v)
> +        else:
> +            return out_dict
>
>       @classmethod
>       def getvar(cls, var, metadata):
> @@ -128,6 +132,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
>           self.stamp = self.getvar('STAMP', metadata)
>           self.stamp_base = self.flaglist('stamp-base', self.tasks, metadata)
>           self.stamp_extrainfo = self.flaglist('stamp-extra-info', self.tasks, metadata)
> +        self.file_checksums = self.flaglist('file-checksums', self.tasks, metadata, True)
>           self.packages_dynamic = self.listvar('PACKAGES_DYNAMIC', metadata)
>           self.depends          = self.depvar('DEPENDS', metadata)
>           self.provides         = self.depvar('PROVIDES', metadata)
> @@ -154,6 +159,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
>           cachedata.stamp = {}
>           cachedata.stamp_base = {}
>           cachedata.stamp_extrainfo = {}
> +        cachedata.file_checksums = {}
>           cachedata.fn_provides = {}
>           cachedata.pn_provides = defaultdict(list)
>           cachedata.all_depends = []
> @@ -185,6 +191,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
>           cachedata.stamp[fn] = self.stamp
>           cachedata.stamp_base[fn] = self.stamp_base
>           cachedata.stamp_extrainfo[fn] = self.stamp_extrainfo
> +        cachedata.file_checksums[fn] = self.file_checksums
>
>           provides = [self.pn]
>           for provide in self.provides:
> diff --git a/bitbake/lib/bb/checksum.py b/bitbake/lib/bb/checksum.py
> new file mode 100644
> index 0000000..514ff0b
> --- /dev/null
> +++ b/bitbake/lib/bb/checksum.py
> @@ -0,0 +1,90 @@
> +# Local file checksum cache implementation
> +#
> +# Copyright (C) 2012 Intel Corporation
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +import os
> +import stat
> +import bb.utils
> +import logging
> +from bb.cache import MultiProcessCache
> +
> +logger = logging.getLogger("BitBake.Cache")
> +
> +try:
> +    import cPickle as pickle
> +except ImportError:
> +    import pickle
> +    logger.info("Importing cPickle failed. "
> +                "Falling back to a very slow implementation.")
> +
> +
> +# mtime cache (non-persistent)
> +# based upon the assumption that files do not change during bitbake run
> +class FileMtimeCache(object):
> +    cache = {}
> +
> +    def cached_mtime(self, f):
> +        if f not in self.cache:
> +            self.cache[f] = os.stat(f)[stat.ST_MTIME]
> +        return self.cache[f]
> +
> +    def cached_mtime_noerror(self, f):
> +        if f not in self.cache:
> +            try:
> +                self.cache[f] = os.stat(f)[stat.ST_MTIME]
> +            except OSError:
> +                return 0
> +        return self.cache[f]
> +
> +    def update_mtime(self, f):
> +        self.cache[f] = os.stat(f)[stat.ST_MTIME]
> +        return self.cache[f]
> +
> +    def clear(self):
> +        self.cache.clear()
> +
> +# Checksum + mtime cache (persistent)
> +class FileChecksumCache(MultiProcessCache):
> +    cache_file_name = "local_file_checksum_cache.dat"
> +    CACHE_VERSION = 1
> +
> +    def __init__(self):
> +        self.mtime_cache = FileMtimeCache()
> +        MultiProcessCache.__init__(self)
> +
> +    def get_checksum(self, f):
> +        entry = self.cachedata[0].get(f)
> +        cmtime = self.mtime_cache.cached_mtime(f)
> +        if entry:
> +            (mtime, hashval) = entry
> +            if cmtime == mtime:
> +                return hashval
> +            else:
> +                bb.debug(2, "file %s changed mtime, recompute checksum" % f)
> +
> +        hashval = bb.utils.md5_file(f)
> +        self.cachedata_extras[0][f] = (cmtime, hashval)
> +        return hashval
> +
> +    def merge_data(self, source, dest):
> +        for h in source[0]:
> +            if h in dest:
> +                (smtime, _) = source[0][h]
> +                (dmtime, _) = dest[0][h]
> +                if smtime>  dmtime:
> +                    dest[0][h] = source[0][h]
> +            else:
> +                dest[0][h] = source[0][h]
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index dea0aad..8ad4922 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1570,6 +1570,7 @@ class CookerParser(object):
>               def init():
>                   Parser.cfg = self.cfgdata
>                   multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, args=(self.cfgdata,), exitpriority=1)
> +                multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, args=(self.cfgdata,), exitpriority=1)
>
>               self.feeder_quit = multiprocessing.Queue(maxsize=1)
>               self.parser_quit = multiprocessing.Queue(maxsize=self.num_processes)
> @@ -1618,6 +1619,7 @@ class CookerParser(object):
>           sync.start()
>           multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
>           bb.codeparser.parser_cache_savemerge(self.cooker.configuration.data)
> +        bb.fetch.fetcher_parse_done(self.cooker.configuration.data)
>
>       def load_cached(self):
>           for filename, appends in self.fromcache:
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 0b976c4..d4b6c3e 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -8,6 +8,7 @@ BitBake build tools.
>   """
>
>   # Copyright (C) 2003, 2004  Chris Larson
> +# Copyright (C) 2012  Intel Corporation
>   #
>   # This program is free software; you can redistribute it and/or modify
>   # it under the terms of the GNU General Public License version 2 as
> @@ -30,9 +31,11 @@ import os, re
>   import logging
>   import urllib
>   import bb.persist_data, bb.utils
> +import bb.checksum
>   from bb import data
>
>   __version__ = "2"
> +_checksum_cache = bb.checksum.FileChecksumCache()
>
>   logger = logging.getLogger("BitBake.Fetcher")
>
> @@ -233,10 +236,18 @@ def fetcher_init(d):
>       else:
>           raise FetchError("Invalid SRCREV cache policy of: %s" % srcrev_policy)
>
> +    _checksum_cache.init_cache(d)
> +
>       for m in methods:
>           if hasattr(m, "init"):
>               m.init(d)
>
> +def fetcher_parse_save(d):
> +    _checksum_cache.save_extras(d)
> +
> +def fetcher_parse_done(d):
> +    _checksum_cache.save_merge(d)
> +
>   def fetcher_compare_revisions(d):
>       """
>       Compare the revisions in the persistant cache with current values and
> @@ -553,6 +564,80 @@ def srcrev_internal_helper(ud, d, name):
>
>       return rev
>
> +
> +def get_checksum_file_list(d):
> +    """ Get a list of files checksum in SRC_URI
> +
> +    Returns the all resolved local path of all local file entries in
> +    SRC_URI as a space-separated string
> +    """
> +    fetch = Fetch([], d)
> +
> +    dl_dir = d.getVar('DL_DIR', True)
> +    filelist = []
> +    for u in fetch.urls:
> +        ud = fetch.ud[u]
> +
> +        if isinstance(ud.method, local.Local):
> +            ud.setup_localpath(d)
> +            f = ud.localpath
> +            if f.startswith(dl_dir):
> +                # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
> +                if os.path.exists(f):
> +                    bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN', True), os.path.basename(f)))
> +                else:
> +                    bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN', True), os.path.basename(f)))
> +                    continue
> +            filelist.append(f)
> +
> +    return " ".join(filelist)
> +
> +
> +def get_file_checksums(filelist, pn):
> +    """Get a list of the checksums for a list of local files
> +
> +    Returns the checksums for a list of local files, caching the results as
> +    it proceeds
> +
> +    """
> +
> +    def checksum_file(f):
> +        try:
> +            checksum = _checksum_cache.get_checksum(f)
> +        except OSError as e:
> +            import traceback
> +            bb.warn("Unable to get checksum for %s SRC_URI entry %s: %s" % (pn, os.path.basename(f), e))
> +            return None
> +        return checksum
> +
> +    checksums = []
> +    for pth in filelist.split():
> +        checksum = None
> +        if '*' in pth:
> +            # Handle globs
> +            import glob
> +            for f in glob.glob(pth):
> +                checksum = checksum_file(f)
> +                if checksum:
> +                    checksums.append((f, checksum))
> +        elif os.path.isdir(pth):
> +            # Handle directories
> +            for root, dirs, files in os.walk(pth):
> +                for name in files:
> +                    fullpth = os.path.join(root, name)
> +                    checksum = checksum_file(fullpth)
> +                    if checksum:
> +                        checksums.append((fullpth, checksum))
> +        else:
> +            checksum = checksum_file(pth)
> +
> +        if checksum:
> +            checksums.append((pth, checksum))
> +
> +    checksums.sort()
> +    return checksums
> +
> +
>   class FetchData(object):
>       """
>       A class which represents the fetcher state for a given URI.
> diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
> index 5a0b80e..daf5677 100644
> --- a/bitbake/lib/bb/siggen.py
> +++ b/bitbake/lib/bb/siggen.py
> @@ -60,6 +60,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
>           self.taskhash = {}
>           self.taskdeps = {}
>           self.runtaskdeps = {}
> +        self.file_checksum_values = {}
>           self.gendeps = {}
>           self.lookupcache = {}
>           self.pkgnameextract = re.compile("(?P<fn>.*)\..*")
> @@ -152,6 +153,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
>           k = fn + "." + task
>           data = dataCache.basetaskhash[k]
>           self.runtaskdeps[k] = []
> +        self.file_checksum_values[k] = {}
>           recipename = dataCache.pkg_fn[fn]
>           for dep in sorted(deps, key=clean_basepath):
>               depname = dataCache.pkg_fn[self.pkgnameextract.search(dep).group('fn')]
> @@ -161,6 +163,12 @@ class SignatureGeneratorBasic(SignatureGenerator):
>                   bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?", dep)
>               data = data + self.taskhash[dep]
>               self.runtaskdeps[k].append(dep)
> +
> +        if task in dataCache.file_checksums[fn]:
> +            checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
> +            for (f,cs) in checksums:
> +               self.file_checksum_values[k][f] = cs
> +               data = data + cs
>           h = hashlib.md5(data).hexdigest()
>           self.taskhash[k] = h
>           #d.setVar("BB_TASKHASH_task-%s" % task, taskhash[task])
> @@ -197,6 +205,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
>
>           if runtime and k in self.taskhash:
>               data['runtaskdeps'] = self.runtaskdeps[k]
> +            data['file_checksum_values'] = self.file_checksum_values[k]
>               data['runtaskhashes'] = {}
>               for dep in data['runtaskdeps']:
>                   data['runtaskhashes'][dep] = self.taskhash[dep]
> @@ -304,6 +313,18 @@ def compare_sigfiles(a, b):
>           for dep in changed:
>               print "Variable %s value changed from %s to %s" % (dep, a_data['varvals'][dep], b_data['varvals'][dep])
>
> +    changed, added, removed = dict_diff(a_data['file_checksum_values'], b_data['file_checksum_values'])
> +    if changed:
> +        for f in changed:
> +            print "Checksum for file %s changed from %s to %s" % (f, a_data['file_checksum_values'][f], b_data['file_checksum_values'][f])
> +    if added:
> +        for f in added:
> +            print "Dependency on checksum of file %s was added" % (f)
> +    if removed:
> +        for f in removed:
> +            print "Dependency on checksum of file %s was removed" % (f)
> +
> +
>       if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
>           a = clean_basepaths(a_data['runtaskhashes'])
>           b = clean_basepaths(b_data['runtaskhashes'])
> @@ -353,6 +374,9 @@ def dump_sigfile(a):
>       if 'runtaskdeps' in a_data:
>           print "Tasks this task depends on: %s" % (a_data['runtaskdeps'])
>
> +    if 'file_checksum_values' in a_data:
> +        print "This task depends on the checksums of files: %s" % (a_data['file_checksum_values'])
> +
>       if 'runtaskhashes' in a_data:
>           for dep in a_data['runtaskhashes']:
>               print "Hash for dependent task %s is %s" % (dep, a_data['runtaskhashes'][dep])



