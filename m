Return-Path: <danismostlikely@gmail.com>
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com
	[209.85.216.170])
	by mail.openembedded.org (Postfix) with ESMTP id B542E72491
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:42:56 +0000 (UTC)
Received: by qcnj1 with SMTP id j1so18070561qcn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=7taoZYNnAGskiar2600ckE64xO2HiWawfxoZ2u6H4fM=;
	b=VkwjMIIkvi7ClKrPgoJaZIY9jFe+l6DZdynd7/9TjH2WKwF/UGEJIkv8t/LbrsujH+
	uV0tBiIrz+2ZgXwBeVyqfxw/9tD2vrlzHyPo5RVRA2L7E1dxGvpURuwyiTHoLMOcXHQF
	wlEf768cG1UYb/IU0YyDBDeTtukeqVl0m+FCxYayAzj8mLCs+E/nr+AOcTbn+kvRHkCz
	a044g1DTZlZDf2BI0d0NEsLLidHwtY71JBGOSDxwJ3q9UwFZoVxoswFjWqC0BBA1tnwz
	xMrFfj82jbwYT6JDocpwAPZG6XS1opuBKBK9XSYjJRH68xHS01uxjO9POHoiVgPw26jp
	WUOw==
MIME-Version: 1.0
X-Received: by 10.140.86.239 with SMTP id p102mr4355388qgd.49.1433947377334;
	Wed, 10 Jun 2015 07:42:57 -0700 (PDT)
Received: by 10.229.237.200 with HTTP; Wed, 10 Jun 2015 07:42:57 -0700 (PDT)
In-Reply-To: <556E4C1B.6080109@windriver.com>
References: <1433260860-4674-1-git-send-email-danismostlikely@gmail.com>
	<1433260860-4674-2-git-send-email-danismostlikely@gmail.com>
	<556E4C1B.6080109@windriver.com>
Date: Wed, 10 Jun 2015 08:42:57 -0600
Message-ID: <CACS+7ZScXmkPeDJnsNfnkHFQfJc6XSYUbaHYVHe6wQuKs8XouQ@mail.gmail.com>
From: Dan McGregor <danismostlikely@gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/hg.py: Several fixes
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
X-List-Received-Date: Wed, 10 Jun 2015 14:42:57 -0000
Content-Type: text/plain; charset=UTF-8

Excellent question; I'll try that soon.

On 2 June 2015 at 18:36, Robert Yang <liezhi.yang@windriver.com> wrote:
>
>
> On 06/03/2015 12:01 AM, Dan McGregor wrote:
>>
>> From: Daniel McGregor <daniel.mcgregor@vecima.com>
>>
>> Generate a full mirror bundle of the repository.
>> Share the repository with the working directory checkout.
>> Remove option to keep scm data; always keep it.
>>
>> Signed-off-by: Daniel McGregor <daniel.mcgregor@vecima.com>
>> ---
>>   lib/bb/fetch2/hg.py | 181
>> +++++++++++++++++++++++++++++++++-------------------
>>   1 file changed, 115 insertions(+), 66 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
>> index cdef4aa..4b476c4 100644
>> --- a/lib/bb/fetch2/hg.py
>> +++ b/lib/bb/fetch2/hg.py
>> @@ -63,6 +63,10 @@ class Hg(FetchMethod):
>>           relpath = self._strip_leading_slashes(ud.path)
>>           ud.pkgdir = os.path.join(data.expand('${HGDIR}', d), ud.host,
>> relpath)
>>           ud.moddir = os.path.join(ud.pkgdir, ud.module)
>> +        ud.localfile = ud.moddir
>> +
>> +        ud.mirrortarball = data.expand('hg_%s_%s_%s.bundle' % (ud.host,
>> relpath.rstrip('/').replace('/', '.'), ud.module.replace('/', '.')), d)
>
>
> Does the mirror tarball work when the mirror is not on the local disk ?
> for example, when the mirror tarball is on the server via http, something
> like yocto's mirror server:
>
> PREMIRRORS ??= "\
> bzr://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
> cvs://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
> git://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
> gitsm://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
> hg://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \n \
> osc://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
> p4://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \n \
> svn://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n"
>
> You can setup something familiar server to test the mirror tarball, it
> should be able to down from the mirror rather than SRC_URI.
>
> // Robert
>
>
>> +        ud.fullmirror = os.path.join(d.getVar("DL_DIR", True),
>> ud.mirrortarball)
>>
>>           ud.setup_revisons(d)
>>
>> @@ -71,15 +75,19 @@ class Hg(FetchMethod):
>>           elif not ud.revision:
>>               ud.revision = self.latest_revision(ud, d)
>>
>> -        ud.localfile = ud.moddir
>> -
>>           ud.basecmd = data.getVar("FETCHCMD_hg", d, True) or
>> "/usr/bin/env hg"
>> +        ud.write_bundle = (data.getVar("BB_GENERATE_MIRROR_TARBALLS", d,
>> True) or "0") != "0"
>>
>>       def need_update(self, ud, d):
>>           revTag = ud.parm.get('rev', 'tip')
>>           if revTag == "tip":
>>               return True
>> -        if not os.path.exists(ud.localpath):
>> +        if ud.write_bundle and not os.path.exists(ud.fullmirror):
>> +            return True
>> +        if not os.path.exists(ud.moddir):
>> +            return True
>> +        os.chdir(ud.moddir)
>> +        if not self._contains_ref(ud, d):
>>               return True
>>           return False
>>
>> @@ -89,51 +97,33 @@ class Hg(FetchMethod):
>>           command is "fetch", "update", "info"
>>           """
>>
>> +        repourl = self._get_repo_url(ud)
>>           proto = ud.parm.get('protocol', 'http')
>>
>> -        host = ud.host
>> -        if proto == "file":
>> -            host = "/"
>> -            ud.host = "localhost"
>> +        options = [];
>>
>> -        if not ud.user:
>> -            hgroot = host + ud.path
>> -        else:
>> -            if ud.pswd:
>> -                hgroot = ud.user + ":" + ud.pswd + "@" + host + ud.path
>> -            else:
>> -                hgroot = ud.user + "@" + host + ud.path
>> +        if ud.user and ud.pswd:
>> +            options.append(" --config auth.default.prefix=*")
>> +            options.append(" --config auth.default.username=%s" %
>> (ud.user))
>> +            options.append(" --config auth.default.password=%s" %
>> (ud.pswd))
>> +            options.append(" --config \"auth.default.schemes=%s\"" %
>> (proto))
>>
>>           if command == "info":
>> -            return "%s identify -i %s://%s/%s" % (ud.basecmd, proto,
>> hgroot, ud.module)
>> -
>> -        options = [];
>> +            return "%s identify %s -i %s%s" % (ud.basecmd, "
>> ".join(options), repourl, ud.module)
>>
>> -        # Don't specify revision for the fetch; clone the entire repo.
>> +        # Don't specify revision for fetch or pull; fetch the entire
>> repo.
>>           # This avoids an issue if the specified revision is a tag,
>> because
>>           # the tag actually exists in the specified revision + 1, so it
>> won't
>>           # be available when used in any successive commands.
>> -        if ud.revision and command != "fetch":
>> -            options.append("-r %s" % ud.revision)
>>
>>           if command == "fetch":
>> -            if ud.user and ud.pswd:
>> -                cmd = "%s --config auth.default.prefix=* --config
>> auth.default.username=%s --config auth.default.password=%s --config
>> \"auth.default.schemes=%s\" clone %s %s://%s/%s %s" % (ud.basecmd, ud.user,
>> ud.pswd, proto, " ".join(options), proto, hgroot, ud.module, ud.module)
>> -            else:
>> -                cmd = "%s clone %s %s://%s/%s %s" % (ud.basecmd, "
>> ".join(options), proto, hgroot, ud.module, ud.module)
>> +            cmd = "%s clone -U %s %s%s %s" % (ud.basecmd, "
>> ".join(options), repourl, ud.module, ud.module)
>>           elif command == "pull":
>> -            # do not pass options list; limiting pull to rev causes the
>> local
>> -            # repo not to contain it and immediately following "update"
>> command
>> -            # will crash
>> -            if ud.user and ud.pswd:
>> -                cmd = "%s --config auth.default.prefix=* --config
>> auth.default.username=%s --config auth.default.password=%s --config
>> \"auth.default.schemes=%s\" pull" % (ud.basecmd, ud.user, ud.pswd, proto)
>> -            else:
>> -                cmd = "%s pull" % (ud.basecmd)
>> +            cmd = "%s pull %s %s%s" % (ud.basecmd, " ".join(options),
>> repourl, ud.module)
>>           elif command == "update":
>> -            if ud.user and ud.pswd:
>> -                cmd = "%s --config auth.default.prefix=* --config
>> auth.default.username=%s --config auth.default.password=%s --config
>> \"auth.default.schemes=%s\" update -C %s" % (ud.basecmd, ud.user, ud.pswd,
>> proto, " ".join(options))
>> -            else:
>> -                cmd = "%s update -C %s" % (ud.basecmd, " ".join(options))
>> +            if ud.revision:
>> +                options.append("-r %s" % ud.revision)
>> +            cmd = "%s update -C %s" % (ud.basecmd, " ".join(options))
>>           else:
>>               raise FetchError("Invalid hg command %s" % command, ud.url)
>>
>> @@ -142,38 +132,49 @@ class Hg(FetchMethod):
>>       def download(self, ud, d):
>>           """Fetch url"""
>>
>> +        if not os.path.exists(os.path.join(ud.moddir, '.hg')):
>> +            logger.debug(2, "Fetch: creating module directory '" +
>> ud.moddir + "'")
>> +            bb.utils.mkdirhier(ud.moddir)
>> +            runfetchcmd("%s init %s" % (ud.basecmd, ud.moddir), d)
>> +            self._generate_hgrc(ud, ud.moddir, d)
>> +
>> +        if os.path.exists(ud.fullmirror):
>> +            logger.debug(2, "Fetch: unbundling module directory '" +
>> ud.moddir + "'")
>> +            runfetchcmd("%s unbundle -R %s %s" % (ud.basecmd, ud.moddir,
>> ud.fullmirror), d)
>> +
>>           logger.debug(2, "Fetch: checking for module directory '" +
>> ud.moddir + "'")
>>
>> -        if os.access(os.path.join(ud.moddir, '.hg'), os.R_OK):
>> +        os.chdir(ud.moddir)
>> +        if not self._contains_ref(ud, d):
>> +            self._generate_hgrc(ud, ud.moddir, d)
>>               updatecmd = self._buildhgcommand(ud, d, "pull")
>>               logger.info("Update " + ud.url)
>>               # update sources there
>> -            os.chdir(ud.moddir)
>>               logger.debug(1, "Running %s", updatecmd)
>>               bb.fetch2.check_network_access(d, updatecmd, ud.url)
>>               runfetchcmd(updatecmd, d)
>>
>> -        else:
>> -            fetchcmd = self._buildhgcommand(ud, d, "fetch")
>> -            logger.info("Fetch " + ud.url)
>> -            # check out sources there
>> -            bb.utils.mkdirhier(ud.pkgdir)
>> -            os.chdir(ud.pkgdir)
>> -            logger.debug(1, "Running %s", fetchcmd)
>> -            bb.fetch2.check_network_access(d, fetchcmd, ud.url)
>> -            runfetchcmd(fetchcmd, d)
>> -
>> -        # Even when we clone (fetch), we still need to update as hg's
>> clone
>> -        # won't checkout the specified revision if its on a branch
>> -        updatecmd = self._buildhgcommand(ud, d, "update")
>> -        os.chdir(ud.moddir)
>> -        logger.debug(1, "Running %s", updatecmd)
>> -        runfetchcmd(updatecmd, d)
>> +        # When we clone (fetch), we disable the working directory.
>> +        # We don't want a checkout at all.
>> +
>> +    def build_mirror_data(self, ud, d):
>> +        # Generate a mirror tarball if needed
>> +        if ud.write_bundle and not os.path.exists(ud.fullmirror):
>> +            # it's possible that this symlink points to read-only
>> filesystem with PREMIRROR
>> +            if os.path.islink(ud.fullmirror):
>> +                os.unlink(ud.fullmirror)
>> +
>> +            os.chdir(ud.moddir)
>> +            logger.info("Creating bundle of mercurial repository")
>> +            runfetchcmd("%s bundle --base null --all %s" % (ud.basecmd,
>> ud.fullmirror), d)
>> +            runfetchcmd("touch %s.done" % (ud.fullmirror), d)
>>
>>       def clean(self, ud, d):
>>           """ Clean the hg dir """
>>
>>           bb.utils.remove(ud.localpath, True)
>> +        bb.utils.remove(ud.fullmirror)
>> +        bb.utils.remove(ud.fullmirror + ".done")
>>
>>       def supports_srcrev(self):
>>           return True
>> @@ -200,23 +201,71 @@ class Hg(FetchMethod):
>>
>>       def unpack(self, ud, destdir, d):
>>           """
>> -        Make a local clone or export for the url
>> +        Make a local clone
>>           """
>>
>>           revflag = "-r %s" % ud.revision
>>           subdir = ud.parm.get("destsuffix", ud.module)
>>           codir = "%s/%s" % (destdir, subdir)
>>
>> -        scmdata = ud.parm.get("scmdata", "")
>> -        if scmdata != "nokeep":
>> -            if not os.access(os.path.join(codir, '.hg'), os.R_OK):
>> -                logger.debug(2, "Unpack: creating new hg repository in '"
>> + codir + "'")
>> -                runfetchcmd("%s init %s" % (ud.basecmd, codir), d)
>> -            logger.debug(2, "Unpack: updating source in '" + codir + "'")
>> -            os.chdir(codir)
>> -            runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d)
>> -            runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d)
>> +        if not os.access(os.path.join(codir, '.hg'), os.R_OK):
>> +            logger.debug(2, "Unpack: creating new hg repository in '" +
>> codir + "'")
>> +            runfetchcmd("%s init %s" % (ud.basecmd, codir), d)
>> +        logger.debug(2, "Unpack: updating source in '" + codir + "'")
>> +        self._generate_hgrc(ud, codir, d)
>> +        os.chdir(codir)
>> +        runfetchcmd("printf %s/.hg > %s/.hg/sharedpath" % (ud.moddir,
>> codir), d, quiet=True)
>> +        runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d)
>> +
>> +    def _contains_ref(self, ud, d):
>> +        cmd = "%s log --limit 1 -r %s --template '{firstline(desc)}\\n'
>> 2> /dev/null | wc -l" % (
>> +            ud.basecmd, ud.revision)
>> +        try:
>> +            output = runfetchcmd(cmd, d, quiet=True)
>> +        except bb.fetch2.FetchError:
>> +            return False
>> +        if len(output.split()) > 1:
>> +            raise bb.fetch2.FetchError("The command '%s' gave output with
>> more then 1 line unexpectedly, output: '%s'" % (cmd, output))
>> +        return output.split()[0] != "0"
>> +
>> +    def _get_repo_url(self, ud):
>> +        """
>> +        Return the repository URL
>> +        """
>> +        proto = ud.parm.get('protocol', 'http')
>> +
>> +        host = ud.host
>> +        if proto == "file":
>> +            host = "/"
>> +            ud.host = "localhost"
>> +        if not ud.user:
>> +            root = host
>>           else:
>> -            logger.debug(2, "Unpack: extracting source to '" + codir +
>> "'")
>> -            os.chdir(ud.moddir)
>> -            runfetchcmd("%s archive -t files %s %s" % (ud.basecmd,
>> revflag, codir), d)
>> +            if ud.pswd:
>> +                root = ud.user + ":" + ud.pswd + "@" + host
>> +            else:
>> +                root = ud.user + "@" + host
>> +
>> +        return "%s://%s%s" % (proto, root, ud.path)
>> +
>> +    def _generate_hgrc(self, ud, destdir, d):
>> +        """
>> +        Generate hgrc for this repo
>> +        """
>> +        root = self._get_repo_url(ud)
>> +        proto = ud.parm.get('protocol', 'http')
>> +        config_path = os.path.join(destdir, '.hg/hgrc')
>> +
>> +        f = open(config_path, 'w')
>> +        f.write("[paths]\n")
>> +        f.write("default = %s%s\n" % (root, ud.module))
>> +        f.write("\n")
>> +        f.write("[auth]\n")
>> +        f.write("default.prefix=*\n")
>> +        f.write("default.username=%s\n" % (ud.user))
>> +        f.write("default.password=%s\n" % (ud.pswd))
>> +        f.write("default.schemes=%s\n" % (proto))
>> +        f.write("\n")
>> +        f.write("[extensions]\n")
>> +        f.write("share =\n")
>> +        f.close()
>>
>

