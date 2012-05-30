Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SZlnQ-0005ES-9h for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 18:30:52 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4UGKWlN023349;
	Wed, 30 May 2012 17:20:32 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 21779-09; Wed, 30 May 2012 17:20:27 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4UGKPtI023343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2012 17:20:26 +0100
Message-ID: <1338394825.20169.156.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 30 May 2012 17:20:25 +0100
In-Reply-To: <cd821b9cc293cda1c0f2684413fa3d5f6167c637.1338224913.git.paul.eggleton@linux.intel.com>
References: <cover.1338224913.git.paul.eggleton@linux.intel.com>
	<cd821b9cc293cda1c0f2684413fa3d5f6167c637.1338224913.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] hob: handle sanity check failures as a separate event
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
X-List-Received-Date: Wed, 30 May 2012 16:30:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-05-28 at 18:10 +0100, Paul Eggleton wrote:
> In order to show a friendlier error message that does not bury the
> actual sanity error in our typical preamble about disabling sanity
> checks, use a separate event to indicate that sanity checks failed.
> 
> This change is intended to work together with the related change to
> sanity.bbclass in OE-Core.
> 
> Fixes [YOCTO #2336].
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/event.py                     |    8 ++++++++
>  bitbake/lib/bb/ui/crumbs/builder.py         |    7 ++++++-
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    6 ++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)

Merged to master, thanks.

Richard




