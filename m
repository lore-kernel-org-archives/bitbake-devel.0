Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 017C9609B2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Apr 2014 16:35:25 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s3TGZJI2021503; Tue, 29 Apr 2014 17:35:20 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7V0f8SIslJVZ; Tue, 29 Apr 2014 17:35:19 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s3TGZG0W021500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 29 Apr 2014 17:35:18 +0100
Message-ID: <1398789310.16672.440.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>
Date: Tue, 29 Apr 2014 17:35:10 +0100
In-Reply-To: <1398698854-15713-1-git-send-email-kergoth@gmail.com>
References: <1398698854-15713-1-git-send-email-kergoth@gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] codeparser: don't interact with the cache for subshells
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
X-List-Received-Date: Tue, 29 Apr 2014 16:35:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-04-28 at 08:27 -0700, Christopher Larson wrote:
> Doing so was causing leakage between the execs of the main value and that of
> the subshell value, and was causing the cached subshell value to be used for
> the overall variable. At the least this could cause execs contamination
> between two variables that while differing, run the same subshell. Beyond
> that, it's possible we could have been using an incomplete cached value of
> a subshell for that of the main value.
> 
> Before this, bb_codeparser.dat would change between parses with differing
> bbfile parse order. After, it does not change.
> 
> The codeparser cache version is bumped, to ensure we don't use potentially
> incorrect cached values from previous runs.
> 
> This should hopefully resolve the difficult-to-reproduce issues we've seen at
> Mentor Graphics where bitbake emits a script to run a task and misses
> dependent functions, resulting in 'command not found' failures. This issue has
> also been mentioned on the oe devel list, where someone hit a case where
> oe_runmake was missing from a do_install task (IIRC). Adding debug information
> showed that bitbake's information about the variable dependencies for this
> task is inaccurate in the failure cases.
> 
> Signed-off-by: Christopher Larson <kergoth@gmail.com>
> ---
>  lib/bb/codeparser.py | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

That is nasty bug, nicely found!

Cheers,

Richard


