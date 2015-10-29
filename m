Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 517E0755F4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Oct 2015 22:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9TM34gW022048; Thu, 29 Oct 2015 22:03:04 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gBzD0_Au0AGD; Thu, 29 Oct 2015 22:03:04 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9TM2o5E022036
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Oct 2015 22:03:01 GMT
Message-ID: <1446156170.4521.38.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jens Rehsack <rehsack@gmail.com>
Date: Thu, 29 Oct 2015 22:02:50 +0000
In-Reply-To: <1E04A439-8ACF-42D3-A910-086C750001E2@gmail.com>
References: <2BE45156-5280-4DFC-9773-F761B9F4B48B@gmail.com>
	<1E04A439-8ACF-42D3-A910-086C750001E2@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetcher: svn: Add support for checkout to a custom path
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
X-List-Received-Date: Thu, 29 Oct 2015 22:03:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-10-29 at 14:00 +0100, Jens Rehsack wrote:
> > Am 16.10.2015 um 19:14 schrieb Jens Rehsack <rehsack@gmail.com>:
> > 
> > 
> > Add support for the Subversion fetcher to checkout modules to a custom path
> > than the module name to avoid checkout is always module - svn is path
> > based and tag/branch-checkout might break builds because of invaid path specs.
> > 
> > Signed-off-by: Jens Rehsack <sno@netbsd.org>
> > ---
> > bitbake/lib/bb/fetch2/svn.py | 9 +++++++--
> > 1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
> > index 1733c2b..8a29193 100644
> > --- a/bitbake/lib/bb/fetch2/svn.py
> > +++ b/bitbake/lib/bb/fetch2/svn.py
> > @@ -54,6 +54,11 @@ class Svn(FetchMethod):
> > 
> >         ud.module = ud.parm["module"]
> > 
> > +        if not "path_spec" in ud.parm:
> > +            ud.path_spec = ud.module
> > +        else:
> > +            ud.path_spec = ud.parm["path_spec"]
> > +
> >         # Create paths to svn checkouts
> >         relpath = self._strip_leading_slashes(ud.path)
> >         ud.pkgdir = os.path.join(data.expand('${SVNDIR}', d), ud.host, relpath)
> > @@ -102,7 +107,7 @@ class Svn(FetchMethod):
> > 
> >             if command == "fetch":
> >                 transportuser = ud.parm.get("transportuser", "")
> > -                svncmd = "%s co %s %s://%s%s/%s%s %s" % (ud.basecmd, " ".join(options), proto, transportuser, svnroot, ud.module, suffix, ud.module)
> > +                svncmd = "%s co %s %s://%s%s/%s%s %s" % (ud.basecmd, " ".join(options), proto, transportuser, svnroot, ud.module, suffix, ud.path_spec)
> >             elif command == "update":
> >                 svncmd = "%s update %s" % (ud.basecmd, " ".join(options))
> >             else:
> > @@ -149,7 +154,7 @@ class Svn(FetchMethod):
> > 
> >         os.chdir(ud.pkgdir)
> >         # tar them up to a defined filename
> > -        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.module), d, cleanup = [ud.localpath])
> > +        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.path_spec), d, cleanup = [ud.localpath])
> > 
> >     def clean(self, ud, d):
> >         """ Clean SVN specific files and dirs """
> > -- 
> > 2.4.3
> 
> Ping :)

It merged 3 days ago:

http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=dcd9cd0f9e117d5cc1440ddbf7582e3440d0cc66

Cheers,

Richard


