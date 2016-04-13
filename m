Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id BD60D6FEE0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Apr 2016 06:13:23 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u3D6DM9f012050
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Tue, 12 Apr 2016 23:13:22 -0700
Received: from [128.224.162.236] (128.224.162.236) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.248.2;
	Tue, 12 Apr 2016 23:13:21 -0700
To: Khem Raj <raj.khem@gmail.com>, Gary Thomas <gary@mlbassoc.com>
References: <570DE199.3010802@mlbassoc.com>
	<CAMKF1soC0Yy13GyVVoe3KY3SjP26MvrHSbr3WS6x=dRW0uy=0Q@mail.gmail.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <570DE380.5060903@windriver.com>
Date: Wed, 13 Apr 2016 14:13:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CAMKF1soC0Yy13GyVVoe3KY3SjP26MvrHSbr3WS6x=dRW0uy=0Q@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Analyzing dependencies
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
X-List-Received-Date: Wed, 13 Apr 2016 06:13:24 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit



On 04/13/2016 02:08 PM, Khem Raj wrote:
> Use any program that reads dotty files

Such as dot from graphviz.

// Robert

>
> On Apr 12, 2016 11:05 PM, "Gary Thomas" <gary@mlbassoc.com
> <mailto:gary@mlbassoc.com>> wrote:
>
>     If I generate the dependency files (-g => *.dot files) for
>     my target recipe, is there a way to view/analyze them "off line"
>     much the same way as using "bitbake -u depexp"?
>
>     --
>     ------------------------------------------------------------
>     Gary Thomas                 |  Consulting for the
>     MLB Associates              |    Embedded world
>     ------------------------------------------------------------
>     --
>     _______________________________________________
>     bitbake-devel mailing list
>     bitbake-devel@lists.openembedded.org
>     <mailto:bitbake-devel@lists.openembedded.org>
>     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>
>

