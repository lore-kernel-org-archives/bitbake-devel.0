Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (unknown [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B317C6FC83
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 May 2014 12:21:53 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4TCLf6F023205; Thu, 29 May 2014 13:21:41 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dFDs91jUdHKg; Thu, 29 May 2014 13:21:41 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4TCLYvE023194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 29 May 2014 13:21:35 +0100
Message-ID: <1401366086.2607.86.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Saul Wold <sgw@linux.intel.com>
Date: Thu, 29 May 2014 13:21:26 +0100
In-Reply-To: <cover.1400862889.git.sgw@linux.intel.com>
References: <cover.1400862889.git.sgw@linux.intel.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [Daisy - Initial Pull 0/9] Please Review
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
X-List-Received-Date: Thu, 29 May 2014 12:21:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2014-05-23 at 09:40 -0700, Saul Wold wrote:
> Richard,
> 
> This is a set of fixes that I backported from 1.7 for Daisy.
> 
> Sau!
> 
> The following changes since commit fe083b674b20b254877a6d8249b11c9a7373866e:
> 
>   bitbake-user-manual-hello.xml: Edits to the "Hello World" Appendix. (2014-04-21 22:51:42 +0100)
> 
> are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib sgw/bitbake-1.22
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=sgw/bitbake-1.22
> 
> Jacob Kroon (1):
>   bitbake: bitbake-diffsigs: Fix runtime error when no arguments are
>     given
> 
> Nick Lewis (1):
>   bitbake: Fix refetch of local files when they are read only
> 
> Richard Purdie (5):
>   bitbake: runqueue: Fix handling of zero priority task
>   bitbake: runqueue: Fix task weighting algorithm
>   bitbake: fetch2/git: Stop git from triggering fsync() calls
>   bitbake: fetch2/perforce: Ensure command has a default
>   bitbake: data_smart: Fix an unusual variable reference bug
> 
> Volker Vogelhuber (2):
>   bitbake: HG Fetch with username and password in url
>   bitbake: fix cloning of mercurial repository with username and
>     password specified in url

I took most of this, I didn't take the fsync() change and added an extra
recent hg fetcher one.

Cheers,

Richard


