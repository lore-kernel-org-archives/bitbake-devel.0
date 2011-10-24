Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RINXz-0004tv-79 for bitbake-devel@lists.openembedded.org;
	Mon, 24 Oct 2011 18:38:48 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p9OGWnDq031115;
	Mon, 24 Oct 2011 17:32:49 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30391-07; Mon, 24 Oct 2011 17:32:45 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p9OGWiRQ031107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Oct 2011 17:32:44 +0100
Message-ID: <1319473964.26563.14.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Mon, 24 Oct 2011 17:32:44 +0100
In-Reply-To: <db59297aa1861614ffaea4295b9b054baa8a12b9.1318353511.git.josh@linux.intel.com>
References: <cover.1318353511.git.josh@linux.intel.com>
	<db59297aa1861614ffaea4295b9b054baa8a12b9.1318353511.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] hob: fix backtrace when dismissing open dialog
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
X-List-Received-Date: Mon, 24 Oct 2011 16:38:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-10-11 at 10:20 -0700, Joshua Lock wrote:
> Clearly a logic/indentation error - we should only try and load the recipe
> should the file-chooser return OK.
> 
> Fixes [YOCTO #1668]
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/ui/hob.py |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Merged to master, thanks.

Richard



