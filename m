Return-Path: <A.Baumfalk@astro-kom.de>
X-Greylist: delayed 441 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 16 Feb 2018 16:18:05 UTC
Received: from mailrelay-out2.netcologne.de (mailrelay-out2.netcologne.de
	[81.173.193.132])
	by mail.openembedded.org (Postfix) with ESMTP id D59DE784EB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Feb 2018 16:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mailrelay-out2.netcologne.de (Postfix) with ESMTP id 61E4010B2D4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Feb 2018 17:10:45 +0100 (CET)
Received: from [213.196.222.82] (helo=mailrelay-out2.netcologne.de)
	by localhost with ESMTP (eXpurgate 4.3.1)
	(envelope-from <A.Baumfalk@astro-kom.de>)
	id 5a870285-0bdc-7f0000012729-7f000001d070-1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Feb 2018 17:10:45 +0100
Received: from ASTRO-EX1.Bensberg.de (unknown [213.196.222.82])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailrelay-out2.netcologne.de (Postfix) with ESMTPS
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Feb 2018 17:10:45 +0100 (CET)
Received: from [192.168.8.2] (192.168.100.114) by ASTRO-EX1.Bensberg.de
	(192.168.100.26) with Microsoft SMTP Server (TLS) id 15.0.775.38;
	Fri, 16 Feb 2018 17:10:26 +0100
To: <bitbake-devel@lists.openembedded.org>
From: Arno Baumfalk <a.baumfalk@astro-kom.de>
Message-ID: <a2f951c8-72a9-49a8-362b-a176577f351a@astro-kom.de>
Date: Fri, 16 Feb 2018 17:10:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
X-Originating-IP: [192.168.100.114]
X-ClientProxiedBy: ASTRO-EX1.Bensberg.de (192.168.100.26) To
	ASTRO-EX1.Bensberg.de (192.168.100.26)
X-purgate-ID: 153929::1518797445-00000BDC-E9209D49/0/0
X-purgate: clean
Subject: exception in checksum.py
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
X-List-Received-Date: Fri, 16 Feb 2018 16:18:06 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE

Hi all,

I am trying to migrate an older custom fetcher named "gitsmlocal", which 
was developed on the jethro branch, to the actual rocko branch. The 
recipes which are using this fetcher use the AUTOINC feature and set 
SRCREV and PV accordingly:

SRC_URI = "gitsmlocal://foo"
S = "${WORKDIR}/git"

SRCREV = "${AUTOREV}"
PV = "0.1+git${SRCPV}"

During "Initializing Tasks" I get an exception (traceback see below) in 
checksum.py, line 111, where the filelist is processed. It seems, that 
${SRCPV} was not expanded, but it is not clear to me why and I did not 
find an explanation when reading/debugging the bitbake code.

For reference, I have attached the gitsmlocal fetcher code, which I'd 
like to bring upstream later, if this is of interest. The idea of this 
fetcher is to support a project structure, where several subrepos are 
located inside an umbrella git repository. Gitsmlocal fetches from these 
local subrepos and checks their state (using gitdescribe). If they are 
"dirty" an autocommit is created for reference (some more description 
can be found in the code).

I hope you can help,
BR Arno

----
Traceback (most recent call last):
   File 
"/home/astro/Projects/U100-C-poky/poky/bitbake/lib/bb/runqueue.py", line 
1049, in RunQueueData.prepare():
                          (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
     >                    self.runtaskentries[tid].hash = 
bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
                          task = self.runtaskentries[tid].task
   File 
"/home/astro/Projects/U100-C-poky/build/../poky/meta/lib/oe/sstatesig.py", 
line 143, in 
SignatureGeneratorOEBasicHash.get_taskhash(fn='/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs_1.0.bb', 
task='do_fetch', deps=[], dataCache=<bb.cache.CacheData object at 
0x7fbe469bc908>):
          def get_taskhash(self, fn, task, deps, dataCache):
     >        h = super(bb.siggen.SignatureGeneratorBasicHash, 
self).get_taskhash(fn, task, deps, dataCache)

   File 
"/home/astro/Projects/U100-C-poky/poky/bitbake/lib/bb/siggen.py", line 
216, in 
SignatureGeneratorOEBasicHash.get_taskhash(fn='/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs_1.0.bb', 
task='do_fetch', deps=[], dataCache=<bb.cache.CacheData object at 
0x7fbe469bc908>):
                  else:
     >                checksums = 
bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
                  for (f,cs) in checksums:
   File 
"/home/astro/Projects/U100-C-poky/poky/bitbake/lib/bb/fetch2/__init__.py", 
line 1196, in 
get_file_checksums(filelist='${@base_set_filespath(["/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs-7.7+git${SRCPV}", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/files"], 
d)}/u100-c-statusloop:False 
/home/astro/yocto-downloads/u100-c-statusloop:False 
${@base_set_filespath(["/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs-7.7+git${SRCPV}", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/files"], 
d)}/u100-c-watchdog:False 
/home/astro/yocto-downloads/u100-c-watchdog:False 
${@base_set_filespath(["/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs-7.7+git${SRCPV}", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/files"], 
d)}/u100-c-populate:False 
/home/astro/yocto-downloads/u100-c-populate:False  ', pn='u100-c-phplibs'):
          """
     >    return _checksum_cache.get_checksums(filelist, pn)

   File 
"/home/astro/Projects/U100-C-poky/poky/bitbake/lib/bb/checksum.py", line 
111, in 
FileChecksumCache.get_checksums(filelist='${@base_set_filespath(["/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs-7.7+git${SRCPV}", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/files"], 
d)}/u100-c-statusloop:False 
/home/astro/yocto-downloads/u100-c-statusloop:False 
${@base_set_filespath(["/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs-7.7+git${SRCPV}", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/files"], 
d)}/u100-c-watchdog:False 
/home/astro/yocto-downloads/u100-c-watchdog:False 
${@base_set_filespath(["/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs-7.7+git${SRCPV}", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/u100-c-phplibs", 
"/home/astro/Projects/U100-C-poky/build/../meta-astro/meta-u100-c/recipes-core/u100-c-phplibs/files"], 
d)}/u100-c-populate:False 
/home/astro/yocto-downloads/u100-c-populate:False  ', pn='u100-c-phplibs'):
              for pth in filelist.split():
     >            exist = pth.split(":")[1]
                  if exist == "False":
IndexError: list index out of range
----
diff --git a/.gitignore b/.gitignore
index 9448453..94894d4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -24,5 +24,4 @@ documentation/user-manual/user-manual.tgz
  pull-*/
  bitbake/lib/toaster/contrib/tts/backlog.txt
  bitbake/lib/toaster/contrib/tts/log/*
-bitbake/lib/toaster/contrib/tts/.cache/*
-.idea
+bitbake/lib/toaster/contrib/tts/.cache/*
\ No newline at end of file
diff --git a/bitbake/lib/bb/fetch2/__init__.py 
b/bitbake/lib/bb/fetch2/__init__.py
index ce375b9..f70f1b5 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1842,7 +1842,6 @@ from . import osc
  from . import repo
  from . import clearcase
  from . import npm
-from . import gitsmlocal

  methods.append(local.Local())
  methods.append(wget.Wget())
@@ -1861,4 +1860,3 @@ methods.append(osc.Osc())
  methods.append(repo.Repo())
  methods.append(clearcase.ClearCase())
  methods.append(npm.Npm())
-methods.append(gitsmlocal.GitSMLocal())
diff --git a/bitbake/lib/bb/fetch2/gitsmlocal.py 
b/bitbake/lib/bb/fetch2/gitsmlocal.py
deleted file mode 100644
index fd32e99..0000000
--- a/bitbake/lib/bb/fetch2/gitsmlocal.py
+++ /dev/null
@@ -1,279 +0,0 @@
-"""
-Git fetcher that does not clone from a remote repository but from
-a git repository reachable in the filesystem.
-
-The intended use case is where the sources are in a sibling subrepository
-of the common parent, i.e. if your recipe is at 
yocto/meta-recipes/blabla.bb
-then the sources might be in sources/blabla (yocto and sources are 
submodules
-of another git repo).
-
-Handles URLs of this form:
-gitsmlocal://REPOCODENAME
-
-REPOCODENAME is resolved from a map file in TOPDIR/conf which looks 
like this:
-
-REPOCODENAME <path to git checkout relative to TOPDIR>
-
-(TOPDIR is usually the yocto "build" directory)
-"""
-
-import urllib
-import bb
-from bb.fetch2 import FetchError, FetchMethod
-from bb.fetch2 import logger
-from bb.fetch2 import runfetchcmd
-import os
-import tempfile
-import re
-
-from bb.utils import mkdirhier
-
-
-
-class GitSMLocal(FetchMethod):
-    __autocommit_msg_magic = "gitsmlocal_autocommit: " # do not change 
this, some recipes might depend on it
-    __autocommit_ref_category = "gitsmlocal"
-
-    def supports(self, ud, d):
-        """
-        Check to see if a given url can be fetched with this module.
-        """
-        return ud.type in ['gitsmlocal']
-
-    def supports_srcrev(self):
-        """
-        The fetcher supports auto source revisions (SRCREV)
-        """
-        return True
-
-    def _get_submodule_name(self, ud):
-        return urllib.unquote(ud.url.split("://")[1].split(";")[0])
-
-    def urldata_init(self, ud, d):
-        """
-        init gitsmlocal specific variables
-        """
-
-        def get_submodule_path(submodule_name, map_file, d):
-            with open(map_file) as f:
-                for line in f:
-                    if line.startswith('#'):
-                        continue
-                    s = line.strip().split()
-                    if len(s) < 2:
-                        continue
-                    if s[0] == submodule_name:
-                        topdir = d.getVar("TOPDIR")
-                        path = os.path.abspath(os.path.join(topdir, s[1]))
-                        return path
-
-            # we have not found the submodule in the map-file, but we 
cannot raise an exception here,
-            # because this part will be evaluated for all reciepes in 
the layer configuration, regardless
-            # if they are used in the current project
-            return ""
-
-        topdir = d.getVar("TOPDIR")
-        ud.basecmd = data.getVar("FETCHCMD_git", d) or "git -c 
core.fsyncobjectfiles=0"
-
-        # get path from map file and set ud.path accordingly
-        submodule_name = self._get_submodule_name(ud)
-        map_file = os.path.join(topdir, 'conf/gitsmlocal.map')
-        original_checkout_path = get_submodule_path(submodule_name, 
map_file, d)
-
-        if original_checkout_path != "":
-            # check if returned path is actually a git toplevel
-            detected_toplevel = self._run_git(ud, d, "rev-parse 
--show-toplevel", workdir=original_checkout_path).strip()
-
-            if original_checkout_path != detected_toplevel:
-                raise FetchError("Paths in the mapfile ({}) have to 
point to toplevel git directories,"
-                                 " i.e. the root of some submodule. 
path {} was given, but the toplevel is {}"
-                                 .format(map_file, 
original_checkout_path, detected_toplevel))
-
-        ud.path = original_checkout_path
-
-        # find current revisions
-        if len(ud.names) > 1:
-            raise FetchError("more than one name found, case is 
unsupported")
-
-        ud.revisions = {}
-        for name in ud.names:
-            ud.revisions[name] = self.latest_revision(ud, d, name)
-
-        ud.basename = os.path.basename(original_checkout_path)
-        ud.basepath = original_checkout_path
-
-    def localpath(self, ud, d):
-        if ud.basepath == '':
-            raise(FetchError("{} not found in 
gitsmlocal.map".format(self._get_submodule_name(ud))))
-
-        return ud.basepath
-
-    def _latest_revision(self, ud, d, name):
-
-        # check if we do have a local checkout
-        if ud.path == "":
-            return "UNKNOWN"
-
-        # recursively cleanup repository and return a hash
-        head = self._git_commit_recursive(ud, d, ud.path)
-
-        if head is None:
-            # query current head
-            head = self._run_git(ud, d, "rev-parse HEAD", 
workdir=ud.path).strip()
-
-        return head
-
-    def _build_revision(self, ud, d, name):
-        return ud.revisions[name]
-
-    def download(self, urldata, d):
-        pass
-
-    def _run_git(self, ud, d, command, git_dir=None, 
git_work_tree=None, git_index_file=None, git_force_dates=False, 
workdir=None):
-        parts = []
-
-        if git_force_dates:
-            parts.append('GIT_AUTHOR_DATE="2000-01-01 00:00:00"')
-            parts.append('GIT_COMMITTER_DATE="2000-01-01 00:00:00"')
-
-        if git_dir is not None:
-            parts.append('GIT_DIR="{}"'.format(git_dir))
-
-        if git_work_tree is not None:
- parts.append('GIT_WORK_TREE="{}"'.format(git_work_tree))
-
-        if git_index_file is not None:
- parts.append('GIT_INDEX_FILE="{}"'.format(git_index_file))
-
-        parts.append(ud.basecmd)
-        parts.append(command)
-
-        return runfetchcmd(" ".join(parts), d, workdir=workdir)
-
-    def _autocommit_ref(self, d):
-        pn = d.getVar("PN")
-        return "refs/{}/{}".format(self.__autocommit_ref_category, pn)
-
-    # def _log_tmp(self, d, file, message):
-    #     pn = d.getVar("PN")
-    #     if pn != "si-processing":
-    #         return
-    #
-    #     with open(file, 'a') as f:
-    #         f.write(message + "\n")
-
-    def _git_commit_recursive(self, ud, d, path):
-        # first list the submodules in the path directory
-        entering_submodules = self._run_git(ud, d, "submodule foreach", 
workdir=path).strip().splitlines()
-
-        # extract the relative path from git output
-        submodule_paths = [ re.sub('Entering \'(.*)\'', lambda 
matchobj: matchobj.group(1), es)
-                            for es in entering_submodules ]
-
-        # recurse into submodules and collect the returned hashes
-        submodule_hashes = [ (p, self._git_commit_recursive(ud, d, 
os.path.join(path, p)))
-                             for p in submodule_paths ]
-
-        # check if any submodule changed
-        no_submodule_changed = True
-        for _, h in submodule_hashes:
-            if h is not None:
-                no_submodule_changed = False
-                break
-
-        # now all submodules can be checked in with their temporary hashes
-
-        # check if the current checkout is dirty
-        is_dirty = self._run_git(ud, d, "status --porcelain | wc -l", 
workdir=path).strip()
-
-        if is_dirty == '0' and no_submodule_changed:
-            # if the directory is not dirty, simply return the head
-            return None
-
-        # there is a change either a submodule or in the files 
belonging to this level
-
-        # query current head
-        head = self._run_git(ud, d, "rev-parse HEAD", workdir=path).strip()
-
-        # first create a new index
-        tmpindex = tempfile.mktemp()
-
-        # get git-describe string (we do not use --dirty, for it will 
not append its mark when no tag is found!)
-        descr = self._run_git(ud, d, "describe --abbrev=40 --always 
--long --tags", workdir=path).strip()
-
-        # add all changed and untracked files to tmpindex
-        self._run_git(ud, d, "add -A", git_index_file=tmpindex)
-
-        # for each submodule, enter the new hash into the index
-        for p, h in submodule_hashes:
-            if h is not None:
-                try:
-                    self._run_git(ud, d, "update-index --cacheinfo 
160000,{},{}".format(h, p), git_index_file=tmpindex, workdir=path)
-                except FetchError:
-                    self._run_git(ud, d, "update-index --cacheinfo 
160000 {} {}".format(h, p), git_index_file=tmpindex, workdir=path)
-
-        # create tree object using git plumbing
-        u_tree = self._run_git(ud, d, "write-tree", 
git_index_file=tmpindex, workdir=path).strip()
-
-        # create commit object
-        # - we set a fixed date in order to get identical commits for 
identical contents
-        # - we put description info into the commit message, which may 
be used by other recipes
-        msg = "{}{}-dirty".format(self.__autocommit_msg_magic, descr)
-        cmd = 'commit-tree {} -p {} -m "{}"'.format(u_tree, head, msg)
-        revision = self._run_git(ud, d, cmd, git_index_file=tmpindex, 
git_force_dates=True, workdir=path).strip()
-
-        # make commit findable by adding a temporary reference
-        ref = self._autocommit_ref(d)
-        self._run_git(ud, d, 'update-ref {} {}'.format(ref, revision))
-
-        # cleanup the temp index
-        try:
-            os.unlink(tmpindex)
-        except Exception:
-            pass
-
-        # return the new revision
-        return revision
-
-    def unpack(self, ud, destdir, d):
-        # first, we add some info concerning the state of the local git 
repo to destdir for later use
-
-        # githash of HEAD (which might also be a temporary autocommit)
-        githash = self.latest_revision(ud, d, "default")
-        with open(os.path.join(destdir, 'githash'), 'w') as f:
-            f.write("{}\n".format(githash))
-
-        # git describe message
-        # in case of an autocommit we use the original describe 
message, which is part of the commit message
-        gitmsg = runfetchcmd("{} log --format=%B -n 1 
{}".format(ud.basecmd, githash), d, workdir=ud.path).strip()
-        if gitmsg.startswith(self.__autocommit_msg_magic):
-            gitdescribe = gitmsg[len(self.__autocommit_msg_magic):]
-        else:
-            gitdescribe = runfetchcmd("{} describe --always --abbrev=40 
--tags --long".format(ud.basecmd), d, workdir=ud.path).strip()
-
-        with open(os.path.join(destdir, 'gitdescribe'), 'w') as f:
-            f.write("{}\n".format(gitdescribe))
-
-        # we exclude versioninfo.rootfs here - it is a special recipe 
for generation to rootf version information
-        # and contains no source files
-        if self._get_submodule_name(ud) != 'versioninfo-rootfs':
-            # now we rsync the actual checkout to the dest directory
-
-            # create git subdir, where we will put the sources
-            srcdir = os.path.join(destdir, 'git')
-            if not os.path.exists(srcdir):
-                bb.utils.mkdirhier(srcdir)
-
-            # rsync workdir to unpack destdir, skipping ignored files
-            cmd = "{} ls-files --other -i --exclude-standard |" \
-                  " rsync -a --delete --delete-excluded --exclude .git 
--exclude-from - . {}".format(ud.basecmd, srcdir)
-            runfetchcmd(cmd, d, workdir=ud.path)
-
-    def _revision_key(self, ud, d, name):
-        """
-        Return a unique key for the url
-        """
-        return "gitsmlocal:" + str(ud.host) + str(name)
-
-    def clean(self, urldata, d):
-        return


