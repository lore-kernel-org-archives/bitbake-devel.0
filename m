Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id A44B260B60
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2013 23:32:05 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rATNVwEL024743; Fri, 29 Nov 2013 23:31:58 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iU6J-t79eW1H; Fri, 29 Nov 2013 23:31:58 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rATNVrhO024739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 29 Nov 2013 23:31:55 GMT
Message-ID: <1385767911.11222.81.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 29 Nov 2013 23:31:51 +0000
In-Reply-To: <20131129232730.GD2860@jama>
References: <1385766956.11222.80.camel@ted> <20131129232730.GD2860@jama>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] parse/ConfHander/BBHandler/utils: Fix cache dependency bugs
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
X-List-Received-Date: Fri, 29 Nov 2013 23:32:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2013-11-30 at 00:27 +0100, Martin Jansa wrote:
> On Fri, Nov 29, 2013 at 11:15:56PM +0000, Richard Purdie wrote:
> > 
> > Currently bitbake only adds files to its dependency list if they exist.
> > If you add 'include foo.inc' to your recipe and the file doesn't exist,
> > then later you add the file, the cache will not be invalidated.
> > 
> > This leads to another bug which is that if files don't exist and then
> > you add them and they should be found first due to BBPATH, again the
> > cache won't invalidate.
> > 
> > This patch adds in tracking of files we check for the existence of so
> > that if they are added later, the cache correctly invalidates. This
> > necessitated a new version of bb.utils.which which returns a list of
> > files tested for.
> > 
> > The patch also adds in checks for duplicate file includes and for now
> > prints a warning about this. That will likely become a fatal error at
> > some point since its never usually desired to include a file twice.
> > 
> > The same issue is also fixed for class inheritance. Now when a class 
> > is added which would be found in the usual search path, it will cause
> > the cache to be invalidated.
> > 
> > Unfortunately this is old code in bitbake and the patch isn't the
> > neatest since we have to work within that framework.
> 
> Does it depend on any other patches? Even after removing extra bitbake/
> prefix (I guess the patch is for poky not bitbake repo) it doesn't apply
> in current master:
> 
> error: patch failed: lib/bb/parse/parse_py/ConfHandler.py:82
> error: lib/bb/parse/parse_py/ConfHandler.py: patch does not apply
> Patch failed at 0001 parse/ConfHander/BBHandler/utils: Fix cache
> dependency bugs
> The copy of the patch that failed is found in:
>    /OE/bitbake/.git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> 

Sorry, I screwed up the patch I sent out. The right version is applied
in master-next of bitbake though:

http://git.openembedded.org/bitbake/commit/?h=master-next&id=78d285871e4b8c54ccc4602d571e85f922e37ccd

Cheers,

Richard


