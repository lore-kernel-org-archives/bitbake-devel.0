Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S6v1E-0003wS-TD for bitbake-devel@lists.openembedded.org;
	Mon, 12 Mar 2012 03:29:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2C2L99d009747;
	Mon, 12 Mar 2012 02:21:09 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08271-08; Mon, 12 Mar 2012 02:21:05 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2C2L0oP009741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Mar 2012 02:21:01 GMT
Message-ID: <1331518860.15192.12.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Mon, 12 Mar 2012 02:21:00 +0000
In-Reply-To: <789e78d1de4f36657addeb3a7264a6fabfa697e2.1331076902.git.paul.eggleton@linux.intel.com>
References: <cover.1331076902.git.paul.eggleton@linux.intel.com>
	<789e78d1de4f36657addeb3a7264a6fabfa697e2.1331076902.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake/siggen: output filename on error in finalise
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
X-List-Received-Date: Mon, 12 Mar 2012 02:29:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-03-06 at 23:37 +0000, Paul Eggleton wrote:
> If an error occurs during finalise() (when for example we might get an
> expansion error in SRCPV), log a note which mentions which recipe was
> being finalised.
> 
> Fixes [YOCTO #1782]
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/lib/bb/siggen.py |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



