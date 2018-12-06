Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B72AC6B07F
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Dec 2018 22:05:08 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	wB6M56Wp008193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 6 Dec 2018 22:05:07 GMT
Message-ID: <76873c27c0f7da4f8339b25f009150d7b38d1e72.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 06 Dec 2018 22:05:06 +0000
In-Reply-To: <20181206185535.12523-1-JPEWhacker@gmail.com>
References: <20181206185535.12523-1-JPEWhacker@gmail.com>
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
X-List-Received-Date: Thu, 06 Dec 2018 22:05:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2018-12-06 at 12:55 -0600, Joshua Watt wrote:
> It is occasionally useful to pass additional flags to fakeroot
> (pseudo)
> either for debugging or for behavioral system changes. Add a variable
> called "FAKEROOTARGS" that can be used for this purpose.

Why wouldn't you just append to FAKEROOT/FAKEROOTCMD ?

Cheers,

Richard


