Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 392E179456
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  8 Dec 2018 17:19:46 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	wB8HJjft024735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Sat, 8 Dec 2018 17:19:46 GMT
Message-ID: <9400d4c05f292c83ebbf4f9f69e9047c64d65955.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Sat, 08 Dec 2018 17:19:45 +0000
In-Reply-To: <20181207215928.11957-1-JPEWhacker@gmail.com>
References: <20181207215928.11957-1-JPEWhacker@gmail.com>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.2 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] bitbake: persist_data: Retry database setup
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 08 Dec 2018 17:19:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2018-12-07 at 15:59 -0600, Joshua Watt wrote:
> The configuration of the sqlite database can timeout due to locking
> under heavy load and should be subject to the same retry logic as the
> other statements.
> 
> [YOCTO #13069]
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/bb/persist_data.py | 85 ++++++++++++++++++------------
> ----
>  1 file changed, 45 insertions(+), 40 deletions(-)

Thanks for quickly sorting this one!

I've merged this but I had to tweak it to apply since I haven't taken
the "drop at fork" patch. The other patches will need rebasing once we
figure out the best naming...

Cheers,

Richard


