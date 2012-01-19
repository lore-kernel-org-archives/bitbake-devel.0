Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Rnfng-00054U-CX for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jan 2012 01:24:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0J0GeF3026231;
	Thu, 19 Jan 2012 00:16:40 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25843-03; Thu, 19 Jan 2012 00:16:36 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0J0GXkv026225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Jan 2012 00:16:34 GMT
Message-ID: <1326932192.2511.47.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Lianhao Lu <lianhao.lu@intel.com>
Date: Thu, 19 Jan 2012 00:16:32 +0000
In-Reply-To: <554ae4c9ee0ac70254c6ca6a5ba44db844cf86b3.1326686612.git.lianhao.lu@intel.com>
References: <cover.1326686612.git.lianhao.lu@intel.com>
	<554ae4c9ee0ac70254c6ca6a5ba44db844cf86b3.1326686612.git.lianhao.lu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake/persist_data: Reconnect when DB is locked
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
X-List-Received-Date: Thu, 19 Jan 2012 00:24:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-01-16 at 12:07 +0800, Lianhao Lu wrote:
> [YOCTO #1761]
> Reconnect to the backend Sqlite DB in 'database is locked' exception so
> the timeout can be leveraged in each time retry.
> 
> Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
> ---
>  bitbake/lib/bb/persist_data.py |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)

Merged to master, thanks. Good to finally have a handle on why this kept
coming up! :)

Cheers,

Richard



