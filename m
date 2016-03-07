Return-Path: <gary@mlbassoc.com>
Received: from mail.analogue-micro.com (mail.analogue-micro.com
	[217.144.149.242])
	by mail.openembedded.org (Postfix) with ESMTP id 94E0265CB5
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 11:43:34 +0000 (UTC)
Received: by mail.analogue-micro.com (Postfix, from userid 999)
	id 895DA68A01A; Mon,  7 Mar 2016 11:43:34 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	loki.analogue-micro-ltd.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=5.0 tests=ALL_TRUSTED,BAYES_40,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from zeus.mlbassoc.com (unknown [10.8.0.2])
	by mail.analogue-micro.com (Postfix) with ESMTP id 595E668A019;
	Mon,  7 Mar 2016 11:43:28 +0000 (GMT)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by zeus.mlbassoc.com (Postfix) with ESMTP id 117996740D1C;
	Mon,  7 Mar 2016 12:43:28 +0100 (CET)
To: Khem Raj <raj.khem@gmail.com>,
	Praveenreddy Padamati <praveenreddy.p@hcl.com>
References: <09856974BCEE6F48AB378E52E4CAA73C226D79DD@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
	<56DD45D3.5030506@mlbassoc.com>
	<09856974BCEE6F48AB378E52E4CAA73C226D7C15@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
	<CAMKF1spOi8RbduxxwJHtUx_Xv69YO9nX7kr3fWBd4haMsL8OGQ@mail.gmail.com>
From: Gary Thomas <gary@mlbassoc.com>
Message-ID: <56DD6960.40902@mlbassoc.com>
Date: Mon, 7 Mar 2016 12:43:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAMKF1spOi8RbduxxwJHtUx_Xv69YO9nX7kr3fWBd4haMsL8OGQ@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: chromium browser
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
X-List-Received-Date: Mon, 07 Mar 2016 11:43:35 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2016-03-07 12:05, Khem Raj wrote:
> What is your build machine configuration and look at log.do_cpmpile it might have some info
>

Also note that depending on your linker choice the build can need a lot of RAM and if your
build machine doesn't have enough you'll spend a lot of time swapping.  I would suggest that
your build host has at least 4GB RAM to build chromium.

> On Mar 7, 2016 5:57 PM, "Praveenreddy Padamati" <praveenreddy.p@hcl.com <mailto:praveenreddy.p@hcl.com>> wrote:
>
>     Hi,
>
>     Thanks for the reply. It took more than 24 hours and then we stopped it.
>
>     Thanks
>     Praveen Reddy P
>
>     -----Original Message-----
>     From: bitbake-devel-bounces@lists.openembedded.org <mailto:bitbake-devel-bounces@lists.openembedded.org>
>     [mailto:bitbake-devel-bounces@lists.openembedded.org <mailto:bitbake-devel-bounces@lists.openembedded.org>] On
>     Behalf Of Gary Thomas
>     Sent: Monday, March 07, 2016 2:42 PM
>     To: bitbake-devel@lists.openembedded.org <mailto:bitbake-devel@lists.openembedded.org>
>     Subject: Re: [bitbake-devel] chromium browser
>
>     On 2016-03-07 09:30, Praveenreddy Padamati wrote:
>      > Hi,
>      >
>      > When I added chromium browser in yocto build configuration then bitbake is stucking at do compile. Can you please
>     help me?
>      >
>
>     How long have you waited?  Depending on your target and host/build settings, building chromium can take a LONG time
>     (measured in hours)
>

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

