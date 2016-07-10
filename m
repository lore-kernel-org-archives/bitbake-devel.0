Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4A7EE601F6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Jul 2016 22:23:37 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 10 Jul 2016 15:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,343,1464678000"; d="scan'208";a="843805317"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.164.140])
	by orsmga003.jf.intel.com with ESMTP; 10 Jul 2016 15:23:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 11 Jul 2016 10:23:30 +1200
Message-ID: <2108760.2DEpCLmkyV@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.5.7-202.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <1467779170-28649-1-git-send-email-paul.eggleton@linux.intel.com>
References: <3b15ae1a30cb247128e003512c036b1f95909674.1466679280.git.paul.eggleton@linux.intel.com>
	<1467779170-28649-1-git-send-email-paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v3] fetch2: implement progress support
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
X-List-Received-Date: Sun, 10 Jul 2016 22:23:43 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wed, 06 Jul 2016 16:26:10 Paul Eggleton wrote:
> Implement progress reporting support specifically for the fetchers. For
> fetch tasks we don't necessarily know which fetcher will be used (we
> might initially be fetching a git:// URI, but if we instead download a
> mirror tarball we may fetch that over http using wget). These programs
> also have different abilities as far as reporting progress goes (e.g.
> wget gives us percentage complete and rate, git gives this some of the
> time depending on what stage it's at). Additionally we filter out the
> progress output before it makes it to the logs, in order to prevent the
> logs filling up with junk.
> 
> At the moment this is only implemented for the wget and git fetchers
> since they are the most commonly used (and svn doesn't seem to support
> any kind of progress output, at least not without doing a relatively
> expensive remote file listing first).
> 
> Line changes such as the ones you get in git's output as it progresses
> don't make it to the log files, you only get the final state of the line
> so the logs aren't filled with progress information that's useless after
> the fact.
> 
> Part of the implementation for [YOCTO #5383].
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
> 
> Changes since v2:
>  * Use -v instead of --show-progress in the wget command line since the
>    latter is only available with wget 1.16 and newer, and we still need
>    to support distros that have older versions than that. This does
>    override the default of -nv if present (which it will be via the
>    FETCHCMD_wget set in bitbake.conf within OE), but the added verbosity
>    is minimal since the progress information is filtered out of the logs
>    by the progress handler.

So, you asked me to send this, but unfortunately it looks like you merged the 
old version - I guess I should send an additional patch now.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

