Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RoHe9-0003vL-94 for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:49:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0KGfJW5020237;
	Fri, 20 Jan 2012 16:41:19 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 19776-10; Fri, 20 Jan 2012 16:41:14 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0KGfA1m020230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jan 2012 16:41:11 GMT
Message-ID: <1327077670.4268.17.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 20 Jan 2012 16:41:10 +0000
In-Reply-To: <b806660e895fe6160d7e6cd527709879d4f6cd21.1326725777.git.paul.eggleton@linux.intel.com>
References: <cover.1326725777.git.paul.eggleton@linux.intel.com>
	<b806660e895fe6160d7e6cd527709879d4f6cd21.1326725777.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake/fetch2: allow resuming interrupted fetch
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
X-List-Received-Date: Fri, 20 Jan 2012 16:49:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-01-16 at 15:01 +0000, Paul Eggleton wrote:
> A lot of our checks in the fetcher code assume that if the downloaded
> file exists, the download finished successfully; this meant that if
> BitBake was interrupted in the middle of a fetch then it would not
> resume the fetch the next time, but instead attempt to use the
> half-fetched file and usually fail as a result.
> 
> Since we're already writing a ".done" stamp file when a fetch completes,
> just check for its existence and assume the download didn't complete
> successfully if it isn't present.
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Merged to master, thanks.

Richard



