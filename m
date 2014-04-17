Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E29D565E30
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Apr 2014 05:15:48 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s3H5FZ8W009169; Thu, 17 Apr 2014 06:15:35 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xfpNg-2GaCCg; Thu, 17 Apr 2014 06:15:35 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s3H5FP7B009152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 17 Apr 2014 06:15:30 +0100
Message-ID: <1397711720.15843.184.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Wyse <CWyse@accu-time.com>
Date: Thu, 17 Apr 2014 06:15:20 +0100
In-Reply-To: <4749E398ABC0754A82239442E1B13E2A6144EFD7@ATSSBS2K11.Accu-Time.com>
References: <4749E398ABC0754A82239442E1B13E2A6144EFD7@ATSSBS2K11.Accu-Time.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: AUTOREV with different branches
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
X-List-Received-Date: Thu, 17 Apr 2014 05:15:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2014-04-15 at 14:48 +0000, Christopher Wyse wrote:
> I'd like to auto-increment my package revision.  I have 'SRCREV =
> "${AUTOREV}" ', and 'PR_append = "+gitr${SRCPV}" ' set.  This is
> working fine as long as I stay on a single branch.  However, my
> SRC_URI has the branch parameter set to branch=${BRANCH}, and BRANCH
> is set in the environment prior to calling bitbake.  This has resulted
> in the following issue.
> 
> On the develop branch, my package name is:
> 
> setup-utility_0.90-r24+gitr9
> +537d03f5ed3a78caa8148448c8c92053be99010d_armv7a-vfp-neon.ipk
> 
> and on the release branch:
> 
> setup-utility_0.90-r24+gitr1
> +db553099700f4b6a5e2db0475957700afe6cbcab_armv7a-vfp-neon.ipk
> 
> The release branch had been built most recently.  I want opkg to use
> the latest package regardless of which branch it was built on, but in
> this case opkg will use the develop build.
> 
> I'm not sure how to correct this.  I see references to LOCALCOUNT and
> AUTOINC, and it seems like other people have had similar issues, but
> after reviewing them I'm still not sure of the best solution.
> 
> Here's a the relevant snippets from my recipe:
> 
>    SRC_URI =
> "git://gitolite@....com/universal/SetupUtility.git;protocol=ssh;branch=${BRANCH}"
>    PV = "0.90"
> 
>    SRCREV = "${AUTOREV}"
> 
>    # Package Revision, Update this whenever you change the recipe. 
>    PR = "r24"
>    PR_append = "+gitr${SRCPV}"
> 
> If anyone could provide any help/suggestions, I would really
> appreciate it.

I suspect the problem here is we're keying the data either in the PR
server or in the fetcher incorrectly. It should be keyed off the PN
value. In reality I suspect branchname and some other info gets used to
key the data and causes this problem. I don't have the time to dig into
this right now but please do file a bug report about this and if you
don't figure it out, we will try and do so in due course.

Cheers,

Richard



