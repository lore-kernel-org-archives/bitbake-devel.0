Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RiRo8-0000Mr-Js for bitbake-devel@lists.openembedded.org;
	Wed, 04 Jan 2012 15:27:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q04EJhtH019620;
	Wed, 4 Jan 2012 14:19:43 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18742-08; Wed,  4 Jan 2012 14:19:39 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q04EJY3E019614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jan 2012 14:19:35 GMT
Message-ID: <1325686773.20759.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Juraj Hercek <juraj.hercek@jhksoftware.com>
Date: Wed, 04 Jan 2012 14:19:33 +0000
In-Reply-To: <1324563672-26403-2-git-send-email-juraj.hercek@jhksoftware.com>
References: <1324563672-26403-1-git-send-email-juraj.hercek@jhksoftware.com>
	<1324563672-26403-2-git-send-email-juraj.hercek@jhksoftware.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Bitbake Devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: change colon to dot in ud.host
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
X-List-Received-Date: Wed, 04 Jan 2012 14:27:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-12-22 at 15:21 +0100, Juraj Hercek wrote:
> Local cloning of git repositories from DL_DIR into WORKDIR fails when
> using ssh URL with port specification e.g.
> "ssh://user@host:port/path/to/repo.git". Git fetcher clones such remote
> repository into "${DL_DIR}/git2/host:port.path.to.repo.git". However,
> when clonging from ${DL_DIR}/git2/host:port.path.to.repo.git into
> ${WORKDIR}, git fetcher fails with "ssh: Could not resolve hostname
> ${DLDIR}/git2/host: Name or service not known".
> 
> A solution is to replace ":" by "." in host component, similarly as it
> is done when replacing "/" with "." in path component, so that local
> clone directory in DL_DIR looks like this: "host.port.path.to.repo.git".
> 
> Signed-off-by: Juraj Hercek <juraj.hercek@jhksoftware.com>
> ---
>  lib/bb/fetch2/git.py |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



