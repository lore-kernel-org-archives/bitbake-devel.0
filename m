Return-Path: <bluelightning@bluelightning.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768DCC43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 22:02:23 +0000 (UTC)
Received: from mail-49-r22.ipv4.per01.ds.network
 (mail-49-r22.ipv4.per01.ds.network [27.123.26.153])
 by mx.groups.io with SMTP id smtpd.web12.865.1657058534488734027
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Jul 2022 15:02:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@softec.co.nz header.s=default
 header.b=LFDNbhVc;
 spf=none, err=permanent DNS error (domain: bluelightning.org,
 ip: 27.123.26.153, mailfrom: bluelightning@bluelightning.org)
Received: from server-72-r70.ipv4.per01.ds.network (cp-fp06.syd02.ds.network
 [122.201.124.108])
	by halon-out01.au.ds.network (Halon) with ESMTPS
	id 4f87b076-fcae-11ec-8884-f8db88ea9a09;
	Wed, 06 Jul 2022 06:03:33 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softec.co.nz; s=default; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+gpLMIi/tplE/4ou6Wzyq2euVIv56O5H6lYs1cv72Zc=; b=LFDNbhVchMNEe0I++5Wz+AJREe
	RB/d1IKPIgjfnZvscgjdStY3T5fiwni65IzXW+wX/yR9VCKGy6gEztWX/T3xfIO4VXiy0ke8YoZ8E
	yn37Fi8A72VftqbbtYf7dgMfsLek7cAe8+wNGYFbk1MhKUvzJopzN6t9x2ccjCbteG/a/4NizsyI+
	FCuuXnz6Ervt4GrHyc1cJiXKLDrWxFoNOWYfQQ3izbGxWgXsVKVq4iIosVvqQZO7ymrpBguOtnAMd
	j8f8lNu2ak7C2w6GXLlPstumIC282zB44eYRAtfHrRG/GdKKCQCOGxldfmlOgLjmVQAWLFJmzjQB5
	ggBu1kWw==;
Received: from [151.210.149.158] (port=47582 helo=linc.localnet)
	by cp-fp06.syd02.ds.network with esmtpsa  (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <bluelightning@bluelightning.org>)
	id 1o8qcT-0000uU-CM; Wed, 06 Jul 2022 10:02:09 +1200
From: Paul Eggleton <bluelightning@bluelightning.org>
To: Maia Xiao <t-maiaxiao@linux.microsoft.com>,
 bitbake-devel@lists.openembedded.org
Cc: Paul Eggleton <Paul.Eggleton@microsoft.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Ross Burton <ross.burton@arm.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Check srcrev exists in
 checkstatus()
Date: Wed, 06 Jul 2022 10:02:07 +1200
Message-ID: <4791753.GXAFRqVoOG@linc>
In-Reply-To: 
 <1ce72dadf44e9ee42094cc3d8afd906373fdc043.camel@linuxfoundation.org>
References: <20220705174630.13360-1-t-maiaxiao@linux.microsoft.com>
 <1ce72dadf44e9ee42094cc3d8afd906373fdc043.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp-fp06.syd02.ds.network
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bluelightning.org
X-Get-Message-Sender-Via: cp-fp06.syd02.ds.network: authenticated_id:
 paul@softec.co.nz
X-Authenticated-Sender: cp-fp06.syd02.ds.network: paul@softec.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Jul 2022 22:02:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13801

On Wednesday, 6 July 2022 09:27:38 NZST Richard Purdie wrote:
> On Tue, 2022-07-05 at 17:46 +0000, Maia Xiao wrote:
> > Currently we only check that we can list the remote, but do not validate
> > if the srcrev actually exists. Now we ensure that the rev exists by
> > attempting to shallow clone it from the remote.
> > 
> > Fixes [YOCTO #11199].
> > 
> > Signed-off-by: Maia Xiao <t-maiaxiao@linux.microsoft.com>
> > ---
> > 
> >  lib/bb/fetch2/git.py  | 28 +++++++++++++++++++++++-----
> >  lib/bb/tests/fetch.py | 34 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 57 insertions(+), 5 deletions(-)
> > 
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index 07b3d9a7..99780de8 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > 
> > @@ -832,8 +832,26 @@ class Git(FetchMethod):
> >              return True, str(rev)
> >      
> >      def checkstatus(self, fetch, ud, d):
> > -        try:
> > -            self._lsremote(ud, d, "")
> > -            return True
> > -        except bb.fetch2.FetchError:
> > -            return False
> > +        repourl = self._get_repo_url(ud)
> > +        for name in ud.names:
> > +            tmpdir = tempfile.mkdtemp()
> > +            revision = ud.revisions[name]
> > +
> > +            try:
> > +                # Initialise an empty git repo for shallow fetching
> > +                runfetchcmd("%s init" % ud.basecmd, d, workdir=tmpdir)
> > +                runfetchcmd("%s remote add origin %s" %
> > +                            (ud.basecmd, shlex.quote(repourl)),
> > +                            d,
> > +                            workdir=tmpdir)
> > +
> > +                # Try to fetch only the specified srcrev
> > +                runfetchcmd("%s fetch -f --progress --depth 1 origin %s"
> > %
> > +                            (ud.basecmd, revision),
> > +                            d,
> > +                            workdir=tmpdir)
> > +            except bb.fetch2.FetchError:
> > +                return False
> > +            finally:
> > +                bb.utils.remove(tmpdir, recurse=True)
> > +        return True
> 
> This makes the git backend do something quite different from the
> design. For instance the wget backend will only check that an http file
> exists, it won't attempt to actually download it.
> 
> I'm therefore not convinced this is the right thing to make
> checkstatus() do...

I'm not sure there is a better way to do it currently - git ls-remote lists 
only certain refs (corresponding to tags and branches), so checking the output 
of that would be a potential shortcut and would work in a lot of cases, but 
this would still have to be a fallback. There is support for fetching a 
particular revision in recent versions of git (2.5+), but apparently the 
server has to support and enable it [1] and that would still count as 
downloading.

I guess it just depends on how much we need/want checkstatus to check the 
revision. Adding Ross as the original reporter of the bug.

Cheers
Paul

[1] https://stackoverflow.com/questions/14872486/retrieve-specific-commit-from-a-remote-git-repository/30701724#30701724




