Return-Path: <richard.purdie@linuxfoundation.org>
X-Greylist: delayed 441 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 07 Mar 2019 17:51:57 UTC
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4FB847CF00
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Mar 2019 17:51:56 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	x27HiYfK012945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 7 Mar 2019 17:44:35 GMT
Message-ID: <a5dd6f7d91309137d23d134c22a5f8375c4f1b87.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>, Krzysztof Zawadzki
	<mr.k.zawadzki@gmail.com>, bitbake-devel@lists.openembedded.org
In-Reply-To: <a6cfe2ad-8684-b375-b0f4-b06d04d35fd6@windriver.com>
References: <20190215032539.5297-1-mr.k.zawadzki@gmail.com>
	<7dd4a96220566dc8d9a1db6a6430aba8bed8b596.camel@linuxfoundation.org>
	<a6cfe2ad-8684-b375-b0f4-b06d04d35fd6@windriver.com>
MIME-Version: 1.0
Date: Thu, 07 Mar 2019 17:44:28 +0000
User-Agent: Evolution 3.31.90-1 
X-Virus-Scanned: clamav-milter 0.100.2 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] fetch2/svn: adds svn --ignore-externals option
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
X-List-Received-Date: Thu, 07 Mar 2019 17:51:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-03-07 at 11:26 -0600, Mark Hatle wrote:
> Ping, anything further happen with this?  (Accepted/rejected/etc)?
> 
> I didn't see any discussion after Feb 19th, but I'm still trying to
> resolve a
> customer's issue that appears to be directly related to this.. but I
> don't have
> enough SVN knowledge to say if this is good or bad.

I'd take a patch to explicitly disable externals so we're
deterministic...

Cheers,

Richard


