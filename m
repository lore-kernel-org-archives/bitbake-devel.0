Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RAg9O-0000mv-U7 for bitbake-devel@lists.openembedded.org;
	Mon, 03 Oct 2011 12:53:35 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p93AsR8c008548; Mon, 3 Oct 2011 11:54:27 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gaMeo9Ou-mnY; Mon,  3 Oct 2011 11:54:27 +0100 (BST)
Received: from [192.168.1.40] (tim [93.97.173.237]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p93AsMHo008530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 3 Oct 2011 11:54:24 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matthew McClintock <msm@freescale.com>
Date: Mon, 03 Oct 2011 11:47:53 +0100
In-Reply-To: <1317159699-3823-1-git-send-email-msm@freescale.com>
References: <1317159699-3823-1-git-send-email-msm@freescale.com>
X-Mailer: Evolution 3.1.91- 
Message-ID: <1317638882.4454.71.camel@ted>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Make git fetch run with -f so rebased branches don't fail
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
X-List-Received-Date: Mon, 03 Oct 2011 10:53:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-09-27 at 16:41 -0500, Matthew McClintock wrote:
> git fetches can fail (or at least return failed) when trying to
> fetch and prune rebased branches. This patch simply adds a -f
> to the git fetch command so these failure are ignore
> 
> Generally, if some SHA was rebased away it's not coming back so
> there is no point in not doing this force
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> This seems to fix the issue when building against our internal trees
> which are constantly rebased wrt to git fetch throwing errors if a
> non fast-forward-able branch is found
> 
>  lib/bb/fetch2/git.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



