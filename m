Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Sr4dz-0008H1-Ac for bitbake-devel@lists.openembedded.org;
	Tue, 17 Jul 2012 12:04:39 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6H9rJx7010266;
	Tue, 17 Jul 2012 10:53:19 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08807-05; Tue, 17 Jul 2012 10:53:14 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6H9rCPl010255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2012 10:53:12 +0100
Message-ID: <1342518795.10484.3.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jeffrey C Honig <jeffrey.honig@windriver.com>
Date: Tue, 17 Jul 2012 10:53:15 +0100
In-Reply-To: <1342486137-9149-1-git-send-email-jeffrey.honig@windriver.com>
References: <1342486137-9149-1-git-send-email-jeffrey.honig@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] siggen.py: Insure .siginfo files writes into shared sstate cache are atomic
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
X-List-Received-Date: Tue, 17 Jul 2012 10:04:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-07-16 at 20:48 -0400, Jeffrey C Honig wrote:
> Use tempfile.mkstemp to create a temporary file in the sstate dir and move it
>    into place after closing.  The previous code would fail in the chmod() if two
>    users were running jobs that touched the same signature file.
> 
> Signed-off-by: Jeffrey C Honig <jeffrey.honig@windriver.com>
> ---
>  lib/bb/siggen.py |   19 +++++++++++++++----
>  1 files changed, 15 insertions(+), 4 deletions(-)

Merged to master, thanks.

Richard



