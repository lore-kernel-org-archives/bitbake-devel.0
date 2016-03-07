Return-Path: <gary@mlbassoc.com>
X-Greylist: delayed 559 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 07 Mar 2016 09:21:08 UTC
Received: from mail.analogue-micro.com (mail.analogue-micro.com
	[217.144.149.242])
	by mail.openembedded.org (Postfix) with ESMTP id 5B7726FF22
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 09:21:08 +0000 (UTC)
Received: by mail.analogue-micro.com (Postfix, from userid 999)
	id 84FAD68A01D; Mon,  7 Mar 2016 09:11:48 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	loki.analogue-micro-ltd.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=5.0 tests=ALL_TRUSTED,BAYES_20,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from zeus.mlbassoc.com (unknown [10.8.0.2])
	by mail.analogue-micro.com (Postfix) with ESMTP id 31DBE68A019;
	Mon,  7 Mar 2016 09:11:48 +0000 (GMT)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by zeus.mlbassoc.com (Postfix) with ESMTP id D39A16740716;
	Mon,  7 Mar 2016 10:11:47 +0100 (CET)
To: bitbake-devel@lists.openembedded.org
References: <09856974BCEE6F48AB378E52E4CAA73C226D79DD@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
From: Gary Thomas <gary@mlbassoc.com>
Message-ID: <56DD45D3.5030506@mlbassoc.com>
Date: Mon, 7 Mar 2016 10:11:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <09856974BCEE6F48AB378E52E4CAA73C226D79DD@CHN-HCLT-MBS02.HCLT.CORP.HCL.IN>
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
X-List-Received-Date: Mon, 07 Mar 2016 09:21:08 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2016-03-07 09:30, Praveenreddy Padamati wrote:
> Hi,
>
> When I added chromium browser in yocto build configuration then bitbake is stucking at do compile. Can you please help me?
>

How long have you waited?  Depending on your target and host/build
settings, building chromium can take a LONG time (measured in hours)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

