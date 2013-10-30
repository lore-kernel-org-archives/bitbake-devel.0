Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 2B24C6C770
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Oct 2013 14:27:44 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r9UEReNE019061; Wed, 30 Oct 2013 14:27:41 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xgzuB11diPYS; Wed, 30 Oct 2013 14:27:40 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r9UERahq019052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Wed, 30 Oct 2013 14:27:37 GMT
Message-ID: <1383143251.25877.31.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Wed, 30 Oct 2013 14:27:31 +0000
In-Reply-To: <90225254375e09a27b2a7e754a1ee0268e75f0d5.1383056532.git.liezhi.yang@windriver.com>
References: <cover.1383056532.git.liezhi.yang@windriver.com>
	<90225254375e09a27b2a7e754a1ee0268e75f0d5.1383056532.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bb/fetch2: fix the "filename too long" error
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
X-List-Received-Date: Wed, 30 Oct 2013 14:27:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2013-10-29 at 22:24 +0800, Robert Yang wrote:
> When the SRC_URI is very long or the PREMIRROR/MIRROR is in a very deep
> directory, the git, svn and other fetchers will covert the path into
> the filename, so if:
> 
>   len(path) > NAME_MAX,
> 
> then we will get the "filename too long" error, the oe-core supports to
> build when len(TMPDIR) <= 410, but the NAME_MAX is usually 256, so we
> can easily get this error when we put the PREMIRROR/MIRROR in a deep
> dir.
> 
> Truncate the filename to NAME_MAX - 10 will fix the problem, the "-10"
> is used for the ".done" and ".lock", in fact, -5 would be OK, but use
> "-10" in case we will have other longer suffix in the future.
> 
> [YOCTO #5389]

Aren't the "long SRC_URI" and deep PREMIRROR/MIRROR problems different
issues?

As far as I know, we don't have any long SRC_URIs in use anywhere within
the project. We could just error if we found one with a path we couldn't
cope with.

The deep PREMIRROR/MIRROR issue on the other hand sounds like something
we should adjust the code to handle properly?

Randomly truncating path names like this looks like a rather hacky
solution and it loses key information, there is a reason these long
names are being used as keys.

Put another way, the mirror tarball name should not change depending on
how deep the DL_DIR or other directories are.

So no, there is no way this patch is correct or should be merged, sorry.

Cheers,

Richard



> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 18 ++++++++++++++++++
>  bitbake/lib/bb/fetch2/bzr.py      |  2 ++
>  bitbake/lib/bb/fetch2/git.py      |  6 ++++++
>  bitbake/lib/bb/fetch2/hg.py       |  3 +++
>  bitbake/lib/bb/fetch2/osc.py      |  2 ++
>  bitbake/lib/bb/fetch2/repo.py     |  4 ++++
>  bitbake/lib/bb/fetch2/svk.py      |  2 ++
>  bitbake/lib/bb/fetch2/svn.py      |  3 +++
>  8 files changed, 40 insertions(+)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 451d104..f76568e 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -959,6 +959,24 @@ def get_file_checksums(filelist, pn):
>      checksums.sort(key=operator.itemgetter(1))
>      return checksums
>  
> +def truncate_to_name_max(dirpath, filename):
> +    """
> +    Truncate the filename to meet len(filename) <= NAME_MAX -10, return
> +    the last NAME_MAX - 10 characters if it doesn't, the -10 is for the
> +    '.done', '.lock' and perhaps others in the future.
> +    """
> +    if not os.path.exists(dirpath):
> +        bb.utils.mkdirhier(dirpath)
> +
> +    name_max = os.pathconf(dirpath, 'PC_NAME_MAX')
> +    new_max = name_max - 10
> +    if len(filename) > new_max:
> +        new_name = filename[-new_max:]
> +        logger.debug(1, "Truncate %s to %s to meet %s (NAME_MAX - 10) characters" % \
> +                    (filename, new_name, new_max))
> +        filename = new_name
> +
> +    return filename
>  
>  class FetchData(object):
>      """
> diff --git a/bitbake/lib/bb/fetch2/bzr.py b/bitbake/lib/bb/fetch2/bzr.py
> index 5d9e5f9..f91c7ee 100644
> --- a/bitbake/lib/bb/fetch2/bzr.py
> +++ b/bitbake/lib/bb/fetch2/bzr.py
> @@ -51,6 +51,8 @@ class Bzr(FetchMethod):
>              ud.revision = self.latest_revision(ud.url, ud, d)
>  
>          ud.localfile = data.expand('bzr_%s_%s_%s.tar.gz' % (ud.host, ud.path.replace('/', '.'), ud.revision), d)
> +        # The length of the filename should be less than NAME_MAX - 10
> +        ud.localfile = bb.fetch2.truncate_to_name_max(ud.pkgdir, ud.localfile)
>  
>      def _buildbzrcommand(self, ud, d, command):
>          """
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 6175e4c..19598ef 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -135,9 +135,15 @@ class Git(FetchMethod):
>          if ud.rebaseable:
>              for name in ud.names:
>                  gitsrcname = gitsrcname + '_' + ud.revisions[name]
> +
>          ud.mirrortarball = 'git2_%s.tar.gz' % (gitsrcname)
> +        # The length of the filename should be less than NAME_MAX - 10
> +        ud.mirrortarball = bb.fetch2.truncate_to_name_max(d.getVar("DL_DIR", True), ud.mirrortarball)
>          ud.fullmirror = os.path.join(d.getVar("DL_DIR", True), ud.mirrortarball)
> +
>          gitdir = d.getVar("GITDIR", True) or (d.getVar("DL_DIR", True) + "/git2/")
> +        # The length of the filename should be less than NAME_MAX - 10
> +        gitsrcname = bb.fetch2.truncate_to_name_max(gitdir, gitsrcname)
>          ud.clonedir = os.path.join(gitdir, gitsrcname)
>  
>          ud.localfile = ud.clonedir
> diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
> index b1c8675..be9bb26 100644
> --- a/bitbake/lib/bb/fetch2/hg.py
> +++ b/bitbake/lib/bb/fetch2/hg.py
> @@ -66,6 +66,9 @@ class Hg(FetchMethod):
>  
>          ud.localfile = data.expand('%s_%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision), d)
>  
> +        # The length of the filename should be less than NAME_MAX - 10
> +        ud.localfile = bb.fetch2.truncate_to_name_max(ud.pkgdir, ud.localfile)
> +
>      def need_update(self, url, ud, d):
>          revTag = ud.parm.get('rev', 'tip')
>          if revTag == "tip":
> diff --git a/bitbake/lib/bb/fetch2/osc.py b/bitbake/lib/bb/fetch2/osc.py
> index 1a3a7bb..2e276e0 100644
> --- a/bitbake/lib/bb/fetch2/osc.py
> +++ b/bitbake/lib/bb/fetch2/osc.py
> @@ -48,6 +48,8 @@ class Osc(FetchMethod):
>                  ud.revision = ""
>  
>          ud.localfile = data.expand('%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.path.replace('/', '.'), ud.revision), d)
> +        # The length of the filename should be less than NAME_MAX - 10
> +        ud.localfile = bb.fetch2.truncate_to_name_max(ud.pkgdir, ud.localfile)
>  
>      def _buildosccommand(self, ud, d, command):
>          """
> diff --git a/bitbake/lib/bb/fetch2/repo.py b/bitbake/lib/bb/fetch2/repo.py
> index 8300da8..1e46968 100644
> --- a/bitbake/lib/bb/fetch2/repo.py
> +++ b/bitbake/lib/bb/fetch2/repo.py
> @@ -52,6 +52,8 @@ class Repo(FetchMethod):
>              ud.manifest += '.xml'
>  
>          ud.localfile = data.expand("repo_%s%s_%s_%s.tar.gz" % (ud.host, ud.path.replace("/", "."), ud.manifest, ud.branch), d)
> +        # The length of the filename should be less than NAME_MAX - 10
> +        ud.localfile = bb.fetch2.truncate_to_name_max(d.getVar("DL_DIR", True), ud.localfile)
>  
>      def download(self, loc, ud, d):
>          """Fetch url"""
> @@ -62,6 +64,8 @@ class Repo(FetchMethod):
>  
>          gitsrcname = "%s%s" % (ud.host, ud.path.replace("/", "."))
>          repodir = data.getVar("REPODIR", d, True) or os.path.join(data.getVar("DL_DIR", d, True), "repo")
> +        # The length of the filename should be less than NAME_MAX - 10
> +        gitsrcname = bb.fetch2.truncate_to_name_max(repodir, gitsrcname)
>          codir = os.path.join(repodir, gitsrcname, ud.manifest)
>  
>          if ud.user:
> diff --git a/bitbake/lib/bb/fetch2/svk.py b/bitbake/lib/bb/fetch2/svk.py
> index ee3823f..dbd78f3 100644
> --- a/bitbake/lib/bb/fetch2/svk.py
> +++ b/bitbake/lib/bb/fetch2/svk.py
> @@ -53,6 +53,8 @@ class Svk(FetchMethod):
>          ud.revision = ud.parm.get('rev', "")
>  
>          ud.localfile = data.expand('%s_%s_%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision, ud.date), d)
> +        # The length of the filename should be less than NAME_MAX - 10
> +        ud.localfile = bb.fetch2.truncate_to_name_max(d.getVar("DL_DIR", True), ud.localfile)
>  
>      def need_update(self, url, ud, d):
>          if ud.date == "now":
> diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
> index 9a779d2..c155735 100644
> --- a/bitbake/lib/bb/fetch2/svn.py
> +++ b/bitbake/lib/bb/fetch2/svn.py
> @@ -65,6 +65,9 @@ class Svn(FetchMethod):
>  
>          ud.localfile = data.expand('%s_%s_%s_%s_.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision), d)
>  
> +        # The length of the filename should be less than NAME_MAX - 10
> +        ud.localfile = bb.fetch2.truncate_to_name_max(ud.pkgdir, ud.localfile)
> +
>      def _buildsvncommand(self, ud, d, command):
>          """
>          Build up an svn commandline based on ud



