Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R5cCC-0001Z1-N1 for bitbake-devel@lists.openembedded.org;
	Mon, 19 Sep 2011 13:39:32 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8JBePCh013583; Mon, 19 Sep 2011 12:40:26 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ORM9bKRntJLy; Mon, 19 Sep 2011 12:40:25 +0100 (BST)
Received: from [192.168.250.158] ([116.246.20.131]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p8JBeI3O013578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 19 Sep 2011 12:40:22 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Mon, 19 Sep 2011 12:34:06 +0100
In-Reply-To: <c35e1623f87902aebcf5f8dcac9d218acd9c01e0.1316257305.git.paul.eggleton@linux.intel.com>
References: <cover.1316257305.git.paul.eggleton@linux.intel.com>
	<c35e1623f87902aebcf5f8dcac9d218acd9c01e0.1316257305.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1316432051.14488.6.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] fetch2/git: fix subpath destination directory
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 19 Sep 2011 11:39:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2011-09-17 at 12:03 +0100, Paul Eggleton wrote:
> Make the git fetcher's subpath (path within the git repo to fetch)
> option set the destsuffix (destination directory) option by default.
> This reverts the behaviour of subpath to the same as when it was
> introduced.
> 
> Based on a patch by Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/fetch2/git.py |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



