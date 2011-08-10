Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qr81F-00085p-Uh for bitbake-devel@lists.openembedded.org;
	Wed, 10 Aug 2011 14:36:22 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7ACVntm021517;
	Wed, 10 Aug 2011 13:31:49 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 20866-05; Wed, 10 Aug 2011 13:31:46 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7ACVg9V021511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Aug 2011 13:31:42 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Yu Ke <ke.yu@intel.com>
In-Reply-To: <4c2fb51bccffc783352bb7f261a527caebcaed39.1312881309.git.ke.yu@intel.com>
References: <cover.1312881309.git.ke.yu@intel.com>
	<4c2fb51bccffc783352bb7f261a527caebcaed39.1312881309.git.ke.yu@intel.com>
Date: Wed, 10 Aug 2011 13:31:07 +0100
Message-ID: <1312979467.14274.366.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] fetcher2: show warning message when checksum is mismatch
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
X-List-Received-Date: Wed, 10 Aug 2011 12:36:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-08-09 at 17:17 +0800, Yu Ke wrote:
> Currently, if checksum mismatch, fetcher will try mirror,
> and if mirror fetching fail, it will show error "Unable
> to fetch URL xxx from from any source" which actually
> hide the real reason and make user confuse.
> 
> so showing warning message will make it more clear.
> 
> Fix [YOCTO #1256]
> 
> Signed-off-by: Yu Ke <ke.yu@intel.com>

Merged to master, thanks.

Richard



