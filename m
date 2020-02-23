Return-Path: <bunk@stusta.de>
Received: from mail.stusta.mhn.de (mail.stusta.mhn.de [141.84.69.5])
	by mail.openembedded.org (Postfix) with ESMTP id 4B88661732
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 23 Feb 2020 19:51:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.stusta.mhn.de (Postfix) with ESMTPSA id 48QbS848Bbz3K;
	Sun, 23 Feb 2020 20:51:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stusta.de;
	s=default; t=1582487513;
	bh=ImjVFe+i05Z0ZuFLg2trTfqwPBzAzRiu0sHVgRcu3r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhmeWK8ykEqhaX/Yw/6Z1bgJFvzqs62fc/y5KKXYYUfDIjOGWdI7Luy0VxFDtQNE4
	wJqkLCzbWvzRDzyG8IEf9PwuBHvru8vNs+YfPuLEHTb8f+VawN+t7elT1wfsAuTEj8
	9hxS8+fj+pPZ/CmSQHvzVMfu3ydNzGzG5l3pINk5UNWR/7Ulv1Nf1GmkEXJyz0Wxrn
	3aBud8DMOklYjR92T+T5F5S4LZlomk7cAM4okPqoLS0k78HxallXr20neIFKjeADM7
	6ye770THEbfTjf5hikw1lbyScywzohO83qSJGOXzKDAHOO1TTbrCdsuhWEXXyVA2H+
	to+qu+XCcYszFfO4GVm9iDMczp1aomWk1iPUeyKq0AphOJ+p9oIMm1Y6VJh78PZSgN
	Bt9bpSNMCPe3m1u4rWXpk9rUTNr/Yoy9g9AFkqjMbHRjAXERx18FsV/N6YiirpE+ZX
	ndpd+FNUqS/Rl5gKCfI3kM/yEJVh44hOkT9pLJUsG6NQLJqfpd7JX4dvjue4TLv85Z
	Hq4Ah5UdzgVWbCyv7X5io7UwjsQ8OY4FwaZklIB9MtDFJ40h12Hkus1yBkg0uu/PHR
	yHOFK1FrCfx8R3i5kmB4r5I53afLpfda2npK4y7t95SLwTNCq1ceDUr4KjiAHAUXvm
	xQ3aA7+3w3+2fL7rOinIpwdg=
Date: Sun, 23 Feb 2020 21:51:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20200223195148.GB3444@localhost>
References: <20200221205213.16130-1-bunk@stusta.de>
	<e349f1cc1d3b36fdff330dc7eab1f213a67d32b1.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <e349f1cc1d3b36fdff330dc7eab1f213a67d32b1.camel@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Lower priority of debug messages that should not be shown on the console
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
X-List-Received-Date: Sun, 23 Feb 2020 19:51:53 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Feb 22, 2020 at 03:54:54PM +0000, Richard Purdie wrote:
>...
> b) We actually fix/improve the way logging works.
> 
> I'd prefer b).

Makes sense, I've submitted this as bug #13813.

> Cheers,
> 
> Richard

cu
Adrian

