Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id AB6A4740AA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 08:26:34 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.9/8.14.9) with ESMTP id t4I8QYZm009596
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 18 May 2015 01:26:34 -0700 (PDT)
Received: from [128.224.162.200] (128.224.162.200) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.224.2;
	Mon, 18 May 2015 01:26:33 -0700
Message-ID: <5559A238.4090003@windriver.com>
Date: Mon, 18 May 2015 16:26:32 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: Dan McGregor <danismostlikely@gmail.com>,
	<bitbake-devel@lists.openembedded.org>
References: <1431401118-17064-1-git-send-email-danismostlikely@gmail.com>
In-Reply-To: <1431401118-17064-1-git-send-email-danismostlikely@gmail.com>
Subject: Re: [PATCH v4] fetch/hg: support submodules
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
X-List-Received-Date: Mon, 18 May 2015 08:26:35 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit


Hello,

This patches breaks the BB_GENERATE_MIRROR_TARBALLS, it doesn't generate
or untar the local tarball any more, the local tarball's mirror doesn't
work any more.

// Robert

On 05/12/2015 11:25 AM, Dan McGregor wrote:
> From: Daniel McGregor <daniel.mcgregor@vecima.com>
>
> Use hg clone and hg pull to copy the source into the build
> directory rather than taring up the cloned repository and
> untarring in the destination.
>
> This allows submodules to be cloned. While here, make the default
> behaviour keep the hg scm data to match the behaviour of the git
> fetcher.
>
> Signed-off-by: Daniel McGregor <daniel.mcgregor@vecima.com>
> ---
>   lib/bb/fetch2/hg.py | 55 +++++++++++++++++++++++++++++++++++------------------
>   1 file changed, 36 insertions(+), 19 deletions(-)
>
> diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
> index 81592f6..6547cca 100644
> --- a/lib/bb/fetch2/hg.py
> +++ b/lib/bb/fetch2/hg.py
> @@ -64,7 +64,9 @@ class Hg(FetchMethod):
>           elif not ud.revision:
>               ud.revision = self.latest_revision(ud, d)
>
> -        ud.localfile = data.expand('%s_%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision), d)
> +        ud.localfile = ud.moddir
> +
> +        ud.basecmd = data.getVar("FETCHCMD_hg", d, True) or "/usr/bin/env hg"
>
>       def need_update(self, ud, d):
>           revTag = ud.parm.get('rev', 'tip')
> @@ -80,8 +82,6 @@ class Hg(FetchMethod):
>           command is "fetch", "update", "info"
>           """
>
> -        basecmd = data.expand('${FETCHCMD_hg}', d)
> -
>           proto = ud.parm.get('protocol', 'http')
>
>           host = ud.host
> @@ -98,7 +98,7 @@ class Hg(FetchMethod):
>                   hgroot = ud.user + "@" + host + ud.path
>
>           if command == "info":
> -            return "%s identify -i %s://%s/%s" % (basecmd, proto, hgroot, ud.module)
> +            return "%s identify -i %s://%s/%s" % (ud.basecmd, proto, hgroot, ud.module)
>
>           options = [];
>
> @@ -111,22 +111,22 @@ class Hg(FetchMethod):
>
>           if command == "fetch":
>               if ud.user and ud.pswd:
> -                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (basecmd, ud.user, ud.pswd, proto, " ".join(options), proto, hgroot, ud.module, ud.module)
> +                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (ud.basecmd, ud.user, ud.pswd, proto, " ".join(options), proto, hgroot, ud.module, ud.module)
>               else:
> -                cmd = "%s clone %s %s://%s/%s %s" % (basecmd, " ".join(options), proto, hgroot, ud.module, ud.module)	
> +                cmd = "%s clone %s %s://%s/%s %s" % (ud.basecmd, " ".join(options), proto, hgroot, ud.module, ud.module)
>           elif command == "pull":
>               # do not pass options list; limiting pull to rev causes the local
>               # repo not to contain it and immediately following "update" command
>               # will crash
>               if ud.user and ud.pswd:
> -                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull" % (basecmd, ud.user, ud.pswd, proto)
> +                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull" % (ud.basecmd, ud.user, ud.pswd, proto)
>               else:
> -                cmd = "%s pull" % (basecmd)
> +                cmd = "%s pull" % (ud.basecmd)
>           elif command == "update":
>               if ud.user and ud.pswd:
> -                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" update -C %s" % (basecmd, ud.user, ud.pswd, proto, " ".join(options))
> +                cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" update -C %s" % (ud.basecmd, ud.user, ud.pswd, proto, " ".join(options))
>               else:
> -                cmd = "%s update -C %s" % (basecmd, " ".join(options))
> +                cmd = "%s update -C %s" % (ud.basecmd, " ".join(options))
>           else:
>               raise FetchError("Invalid hg command %s" % command, ud.url)
>
> @@ -163,15 +163,6 @@ class Hg(FetchMethod):
>           logger.debug(1, "Running %s", updatecmd)
>           runfetchcmd(updatecmd, d)
>
> -        scmdata = ud.parm.get("scmdata", "")
> -        if scmdata == "keep":
> -            tar_flags = ""
> -        else:
> -            tar_flags = "--exclude '.hg' --exclude '.hgrags'"
> -
> -        os.chdir(ud.pkgdir)
> -        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.module), d, cleanup = [ud.localpath])
> -
>       def supports_srcrev(self):
>           return True
>
> @@ -191,3 +182,29 @@ class Hg(FetchMethod):
>           Return a unique key for the url
>           """
>           return "hg:" + ud.moddir
> +
> +    def localpath(self, ud, d):
> +        return ud.moddir
> +
> +    def unpack(self, ud, destdir, d):
> +        """
> +        Make a local clone or export for the url
> +        """
> +
> +        revflag = "-r %s" % ud.revision
> +        subdir = ud.parm.get("destsuffix", ud.module)
> +        codir = "%s/%s" % (destdir, subdir)
> +
> +        scmdata = ud.parm.get("scmdata", "")
> +        if scmdata != "nokeep":
> +            if not os.access(os.path.join(codir, '.hg'), os.R_OK):
> +                logger.debug(2, "Unpack: creating new hg repository in '" + codir + "'")
> +                runfetchcmd("%s init %s" % (ud.basecmd, codir), d)
> +            logger.debug(2, "Unpack: updating source in '" + codir + "'")
> +            os.chdir(codir)
> +            runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d)
> +            runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d)
> +        else:
> +            logger.debug(2, "Unpack: extracting source to '" + codir + "'")
> +            os.chdir(ud.moddir)
> +            runfetchcmd("%s archive -t files %s %s" % (ud.basecmd, revflag, codir), d)
>

