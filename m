Return-Path: <danismostlikely@gmail.com>
Received: from mail-qg0-f43.google.com (mail-qg0-f43.google.com
	[209.85.192.43])
	by mail.openembedded.org (Postfix) with ESMTP id DD71A7568F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Jun 2015 17:08:04 +0000 (UTC)
Received: by qgf2 with SMTP id 2so61464291qgf.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 02 Jun 2015 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=wTlfa+rWFgl8A5JGLbG6hURttr/B6tKHKlSI2dJ7WkI=;
	b=KfVgl0IHTM4bwpmYiIbCHYGsedeQ22N09j73suZ+OAPcAFrx8lfHBGF+bYMKtnwGPo
	EeVzLB9nlhqeygpEahw+LdJ4jC9bY8V4G9iZjnaJgbjcQKK/s88f/VRzAvZcO022NHOu
	dIAkKeobrH69gkANJGU+N1HKOubTsjHUwoOp1OtjrOoLemPQjKR7ca7v+dngPi/GFppQ
	UcximvbZBp6v4GNd0WqzVkc3MQwEHLjM69Qu+vdz2yWdM0IGQSi+F9QbI5zJ7lL/cYYO
	bt//kqJJdOExobplOg+iOyfPDlErTGSaSSPkbEPVpb/6fbu+VdBXjCA7ULSxV0iUgTT6
	5YlA==
MIME-Version: 1.0
X-Received: by 10.55.56.205 with SMTP id f196mr50424197qka.68.1433264885746;
	Tue, 02 Jun 2015 10:08:05 -0700 (PDT)
Received: by 10.229.237.200 with HTTP; Tue, 2 Jun 2015 10:08:05 -0700 (PDT)
In-Reply-To: <556DBEDE.8070801@windriver.com>
References: <cover.1433235612.git.liezhi.yang@windriver.com>
	<9d25d04fa525b37dff0b51c0ea66365f52e5a596.1433235612.git.liezhi.yang@windriver.com>
	<556DBEDE.8070801@windriver.com>
Date: Tue, 2 Jun 2015 11:08:05 -0600
Message-ID: <CACS+7ZSrwgjAMJS2Xxfg29iKMSDsdgwEVT-HZ1bi79cqsgg-wA@mail.gmail.com>
From: Dan McGregor <danismostlikely@gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: fetch2/hg.py: fix unpack error and mirror tarball
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
X-List-Received-Date: Tue, 02 Jun 2015 17:08:05 -0000
Content-Type: text/plain; charset=UTF-8

This looks good. It does some things my patch didn't. I still like the
idea of sharing the hg checkout though. I'll look at merging them this
afternoon or tomorrow.

On 2 June 2015 at 08:34, Robert Yang <liezhi.yang@windriver.com> wrote:
> Sorry, I updated the patch a little in the repo:
>
>   git://git.pokylinux.org/poky-contrib rbt/hg
>
> Add the following code to hg.py: (refer to git.py)
>
> +    def try_premirror(self, ud, d):
> +        # If we don't do this, updating an existing checkout with only
> premirrors
> +        # is not possible
> +        if d.getVar("BB_FETCH_PREMIRRORONLY", True) is not None:
> +            return True
> +        if os.path.exists(ud.moddir):
> +            return False
> +        return True
>
> Otherwise we may get the error like the following when there is a local
> mirror tarball in DL_DIR:
>
> ERROR: No checksum specified for
> /path/to/downloads/hg_vim_vim.googlecode.com_.hg.tar.gz, please add at least
> one to the recipe:
> SRC_URI[md5sum] = "18598f5ad0f30083a3715154bd326d26"
> SRC_URI[sha256sum] =
> "450c989b89d4738d051ae0628c50fbeaaa7acd15927a1ecc16e0fc0dd38ec25e"
> ERROR: Function failed: Fetcher failure for URL:
> 'http://downloads.yoctoproject.org/mirror/sources/hg_vim_vim.googlecode.com_.hg.tar.gz'.
> Missing SRC_URI checksum
>
> // Robert
>
>
> On 06/02/2015 05:04 PM, Robert Yang wrote:
>>
>> Fixed:
>> * do_unpack error:
>>    abort: repository DL_DIR/hg/vim.googlecode.com/hg/vim not found!
>>
>> * The mirror tarball doesn't work
>>    - Add the build_mirror_data to create the tarball
>>    - Unpack the mirror tarball when needed
>>
>> * The hg files will put in the dir like git: DL_DIR/hg, it was
>>    DL_DIR/hg/path/to/src/uri/path in the past.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/hg.py |   70
>> +++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 57 insertions(+), 13 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
>> index cdef4aa..2c8c25d 100644
>> --- a/bitbake/lib/bb/fetch2/hg.py
>> +++ b/bitbake/lib/bb/fetch2/hg.py
>> @@ -59,10 +59,12 @@ class Hg(FetchMethod):
>>
>>           ud.module = ud.parm["module"]
>>
>> -        # Create paths to mercurial checkouts
>> -        relpath = self._strip_leading_slashes(ud.path)
>> -        ud.pkgdir = os.path.join(data.expand('${HGDIR}', d), ud.host,
>> relpath)
>> -        ud.moddir = os.path.join(ud.pkgdir, ud.module)
>> +        if 'protocol' in ud.parm:
>> +            ud.proto = ud.parm['protocol']
>> +        elif not ud.host:
>> +            ud.proto = 'file'
>> +        else:
>> +            ud.proto = "hg"
>>
>>           ud.setup_revisons(d)
>>
>> @@ -71,10 +73,20 @@ class Hg(FetchMethod):
>>           elif not ud.revision:
>>               ud.revision = self.latest_revision(ud, d)
>>
>> -        ud.localfile = ud.moddir
>> +        # Create paths to mercurial checkouts
>> +        hgsrcname = '%s_%s_%s' % (ud.module.replace('/', '.'), \
>> +                            ud.host, ud.path.replace('/', '.'))
>> +        ud.mirrortarball = 'hg_%s.tar.gz' % hgsrcname
>> +        ud.fullmirror = os.path.join(d.getVar("DL_DIR", True),
>> ud.mirrortarball)
>>
>> +        hgdir = d.getVar("HGDIR", True) or (d.getVar("DL_DIR", True) +
>> "/hg/")
>> +        ud.pkgdir = os.path.join(hgdir, hgsrcname)
>> +        ud.moddir = os.path.join(ud.pkgdir, ud.module)
>> +        ud.localfile = ud.moddir
>>           ud.basecmd = data.getVar("FETCHCMD_hg", d, True) or
>> "/usr/bin/env hg"
>>
>> +        ud.write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS", True)
>> +
>>       def need_update(self, ud, d):
>>           revTag = ud.parm.get('rev', 'tip')
>>           if revTag == "tip":
>> @@ -142,18 +154,36 @@ class Hg(FetchMethod):
>>       def download(self, ud, d):
>>           """Fetch url"""
>>
>> +        ud.repochanged = not os.path.exists(ud.fullmirror)
>> +
>>           logger.debug(2, "Fetch: checking for module directory '" +
>> ud.moddir + "'")
>>
>> +        # If the checkout doesn't exist and the mirror tarball does,
>> extract it
>> +        if not os.path.exists(ud.pkgdir) and
>> os.path.exists(ud.fullmirror):
>> +            bb.utils.mkdirhier(ud.pkgdir)
>> +            os.chdir(ud.pkgdir)
>> +            runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
>> +
>>           if os.access(os.path.join(ud.moddir, '.hg'), os.R_OK):
>> -            updatecmd = self._buildhgcommand(ud, d, "pull")
>> -            logger.info("Update " + ud.url)
>> -            # update sources there
>> +            # Found the source, check whether need pull
>> +            updatecmd = self._buildhgcommand(ud, d, "update")
>>               os.chdir(ud.moddir)
>>               logger.debug(1, "Running %s", updatecmd)
>> -            bb.fetch2.check_network_access(d, updatecmd, ud.url)
>> -            runfetchcmd(updatecmd, d)
>> -
>> -        else:
>> +            try:
>> +                runfetchcmd(updatecmd, d)
>> +            except bb.fetch2.FetchError:
>> +                # Runnning pull in the repo
>> +                pullcmd = self._buildhgcommand(ud, d, "pull")
>> +                logger.info("Pulling " + ud.url)
>> +                # update sources there
>> +                os.chdir(ud.moddir)
>> +                logger.debug(1, "Running %s", pullcmd)
>> +                bb.fetch2.check_network_access(d, pullcmd, ud.url)
>> +                runfetchcmd(pullcmd, d)
>> +                ud.repochanged = True
>> +
>> +        # No source found, clone it.
>> +        if not os.path.exists(ud.moddir):
>>               fetchcmd = self._buildhgcommand(ud, d, "fetch")
>>               logger.info("Fetch " + ud.url)
>>               # check out sources there
>> @@ -174,6 +204,8 @@ class Hg(FetchMethod):
>>           """ Clean the hg dir """
>>
>>           bb.utils.remove(ud.localpath, True)
>> +        bb.utils.remove(ud.fullmirror)
>> +        bb.utils.remove(ud.fullmirror + ".done")
>>
>>       def supports_srcrev(self):
>>           return True
>> @@ -195,8 +227,20 @@ class Hg(FetchMethod):
>>           """
>>           return "hg:" + ud.moddir
>>
>> +    def build_mirror_data(self, ud, d):
>> +        # Generate a mirror tarball if needed
>> +        if ud.write_tarballs == "1" and (ud.repochanged or not
>> os.path.exists(ud.fullmirror)):
>> +            # it's possible that this symlink points to read-only
>> filesystem with PREMIRROR
>> +            if os.path.islink(ud.fullmirror):
>> +                os.unlink(ud.fullmirror)
>> +
>> +            os.chdir(ud.pkgdir)
>> +            logger.info("Creating tarball of hg repository")
>> +            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, ud.module), d)
>> +            runfetchcmd("touch %s.done" % (ud.fullmirror), d)
>> +
>>       def localpath(self, ud, d):
>> -        return ud.moddir
>> +        return ud.pkgdir
>>
>>       def unpack(self, ud, destdir, d):
>>           """
>>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

