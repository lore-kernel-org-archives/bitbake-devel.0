Return-Path: <gary@mlbassoc.com>
Received: from mail.analogue-micro.com (mail.analogue-micro.com
	[217.144.149.242])
	by mail.openembedded.org (Postfix) with ESMTP id DAF556FEE0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Apr 2016 06:20:39 +0000 (UTC)
Received: by mail.analogue-micro.com (Postfix, from userid 999)
	id D735A68A01D; Wed, 13 Apr 2016 07:20:39 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	loki.analogue-micro-ltd.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=5.0 tests=ALL_TRUSTED,BAYES_40,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from zeus.mlbassoc.com (unknown [10.8.0.2])
	by mail.analogue-micro.com (Postfix) with ESMTP id 1280568A019;
	Wed, 13 Apr 2016 07:20:39 +0100 (BST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by zeus.mlbassoc.com (Postfix) with ESMTP id BD2E36740343;
	Wed, 13 Apr 2016 08:20:38 +0200 (CEST)
To: Khem Raj <raj.khem@gmail.com>
References: <570DE199.3010802@mlbassoc.com>
	<CAMKF1soC0Yy13GyVVoe3KY3SjP26MvrHSbr3WS6x=dRW0uy=0Q@mail.gmail.com>
From: Gary Thomas <gary@mlbassoc.com>
Message-ID: <570DE536.9020701@mlbassoc.com>
Date: Wed, 13 Apr 2016 08:20:38 +0200
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
X-List-Received-Date: Wed, 13 Apr 2016 06:20:40 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2016-04-13 08:08, Khem Raj wrote:
> Use any program that reads dotty files
>

Know of any interactive ones that let you explore like the 'depexp'?

> On Apr 12, 2016 11:05 PM, "Gary Thomas" <gary@mlbassoc.com <mailto:gary@mlbassoc.com>> wrote:
>
>     If I generate the dependency files (-g => *.dot files) for
>     my target recipe, is there a way to view/analyze them "off line"
>     much the same way as using "bitbake -u depexp"?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

