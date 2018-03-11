Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4B1CE78916
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Mar 2018 13:36:47 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w2BDaiKn012399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sun, 11 Mar 2018 13:36:47 GMT
Message-ID: <1520775403.10851.182.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Bach, Pascal" <pascal.bach@siemens.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Sun, 11 Mar 2018 06:36:43 -0700
In-Reply-To: <355BE46A91031048906B695426A8D8E617342693@DEFTHW99EH4MSX.ww902.siemens.net>
References: <355BE46A91031048906B695426A8D8E617342693@DEFTHW99EH4MSX.ww902.siemens.net>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: Re: Issue with bitbake fetch/unpack when using MIRRORS rewrite
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
X-List-Received-Date: Sun, 11 Mar 2018 13:36:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2018-03-09 at 09:40 +0000, Bach, Pascal wrote:
> Hello Everyone
> 
> I finally got to pin down an issue that I occasionally observed in
> the past:
> 
> When using the git fetcher with shallow tarballs
> (BB_GIT_SHALLOW,BB_GIT_SHALLOW_DEPTH) experience the following issues
> during the do_unpack task:
> 
> ERROR: pseudo-native-1.9.0+gitAUTOINC+d7c31a25e4-r0 do_unpack:
> Fetcher failure: [...]
> tar (child): /home/projects/ccp3-
> labs/oe/build/../../../downloads2/gitshallow_git.yoctoproject.org.pse
> udo_d7c31a2-1_master.tar.gz: Cannot open: No such file or directory
> tar (child): Error is not recoverable: exiting now
> tar: Child returned status 2
> tar: Error is not recoverable: exiting now
> 
> The issue is that the do_unpack is trying to find the following file
> in the downloads directory:
> downloads2/gitshallow_git.yoctoproject.org.pseudo_d7c31a2-
> 1_master.tar.gz
> 
> However this file doesn't exist, instead the following file was
> created by the fetch task:
> downloads2/gitshallow_git.yoctoproject.org.git.pseudo_d7c31a2-
> 1_master.tar.gz
> 
> After some digging I suspect that the following rewrite rule is
> causing the issue:
> MIRRORS +=
> "git://git.yoctoproject.org/.*                               git://gi
> t.yoctoproject.org/git/PATH;protocol=https \n"
> 
> The line exists because we don't have access to git.yoctoproject.org
> via the git protocol. So we use the above rule to make access work
> via HTTPS.
> However due to the way the Yocto git server is structured the rewrite
> causes the URL path to change from / to /git which causes the
> additional .git in the
> resulting tarball, which then makes the unpack task look for the
> wrong file.
> 
> I think the proper behavior would be to always name the tarball after
> the original SRC_URI not the rewritten one.
> 
> BTW: I was able to reproduce the issue with the shallow git tarballs
> but I think it also applies to normal git tarballs and possibly other
> fetchers.
> 
> The issue still exists with bitbake 1.37.0 on Poky master.

I do think there are likely problems in this area.

This gets tricky as one mirror tarball could in theory match against
multiple different parent urls. I'm therefore torn on whether it should
use the "parent" naming for the tarball, or create a chain of symlinks
back to the high level name. 

Its something I'd have to sit and look at a bit further and understand
what the code is doing. I know when Chris added the shallow code, he
did add multiple mirror tarball support so it could be related to that
too...

Just thinking out loud, you could have a "full" mirror tarball as well
as a shallow one too so it does get quite complex. Which corner cases
we care about is a tricky one too.

Did you have a fix to propose?

With the fetcher, I do ask when we make changes, we do add unit tests
so that we can protect use cases going forward.

Cheers,

Richard




