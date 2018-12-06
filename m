Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 884C879585
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Dec 2018 22:05:48 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	wB6M5lmn008242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 6 Dec 2018 22:05:48 GMT
Message-ID: <7e797d261279179d8544c17ab73af6546ae7bf32.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>, Joshua Watt <jpewhacker@gmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 06 Dec 2018 22:05:47 +0000
In-Reply-To: <8f81fa22-3b5a-09a5-a128-f8d0f6b3fed8@windriver.com>
References: <20181206185535.12523-1-JPEWhacker@gmail.com>
	<8f81fa22-3b5a-09a5-a128-f8d0f6b3fed8@windriver.com>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.2 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] Add a variable to pass flags to fakeroot (pseudo)
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
X-List-Received-Date: Thu, 06 Dec 2018 22:05:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2018-12-06 at 13:08 -0600, Mark Hatle wrote:
> (No objection to this patch......)
> 
> Would anyone be interested in a comment that changes aware from
> 'fakeroot' and
> to 'pseudo'?
> 
> Just curious, as I don't actually think 'fakeroot' would work
> anymore.  (Ya, I
> know there would be compatibility issues, but those could likely be
> addressed by
> variables and/or 'or' statements.)
> 
> Just wondering if that kind of a change/cleanup makes sense or not
> just thinking of bitbake.

I've wondered but I think it would cause churn for little gain...

Cheers,

Richard


