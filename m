Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2917A731D6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 20 Aug 2016 15:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7KF9kU4013561; Sat, 20 Aug 2016 16:10:31 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6PABnQ1nUoOJ; Sat, 20 Aug 2016 16:10:31 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7KFATQj013746
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 20 Aug 2016 16:10:30 +0100
Message-ID: <1471705829.16712.70.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matt Madison <matt@madison.systems>, bitbake-devel@lists.openembedded.org
Date: Sat, 20 Aug 2016 16:10:29 +0100
In-Reply-To: <1470848896-23041-2-git-send-email-matt@madison.systems>
References: <1470848896-23041-1-git-send-email-matt@madison.systems>
	<1470848896-23041-2-git-send-email-matt@madison.systems>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH v2] fetch2: preserve current working directory
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
X-List-Received-Date: Sat, 20 Aug 2016 15:10:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-08-10 at 10:08 -0700, Matt Madison wrote:
> Fix the methods in all fetchers so they don't change
> the current working directory of the calling process, which
> could lead to "changed cwd" warnings from bitbake.
> 
> Signed-off-by: Matt Madison <matt@madison.systems>
> ---
>  lib/bb/fetch2/__init__.py  | 21 +++++++++++----------
>  lib/bb/fetch2/bzr.py       | 11 ++++-------
>  lib/bb/fetch2/clearcase.py |  6 ++----
>  lib/bb/fetch2/cvs.py       | 15 ++++++++-------
>  lib/bb/fetch2/git.py       | 45 ++++++++++++++++++++----------------
> ---------
>  lib/bb/fetch2/gitannex.py  | 24 +++++++++++-------------
>  lib/bb/fetch2/gitsm.py     | 23 ++++++++++-------------
>  lib/bb/fetch2/hg.py        | 28 ++++++++++------------------
>  lib/bb/fetch2/npm.py       | 22 +++++++---------------
>  lib/bb/fetch2/osc.py       | 10 ++++------
>  lib/bb/fetch2/perforce.py  |  6 ++----
>  lib/bb/fetch2/repo.py      | 13 ++++++-------
>  lib/bb/fetch2/svn.py       | 13 +++++--------
>  13 files changed, 100 insertions(+), 137 deletions(-)

Thanks for this, sorry it took a while to merge. It does looks like a
pretty good cleanup of this code and is much appreciated!

I did wonder if we still needed the try_mirror chdir now we've cleaned
up the individual fetchers?

Cheers,

Richard

