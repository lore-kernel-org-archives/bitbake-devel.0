Return-Path: <gary@mlbassoc.com>
Received: from mail.analogue-micro.com (mail.analogue-micro.com
	[217.144.149.242])
	by mail.openembedded.org (Postfix) with ESMTP id 5BAC874197
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  5 Aug 2016 09:06:18 +0000 (UTC)
Received: by mail.analogue-micro.com (Postfix, from userid 999)
	id B75CA68A019; Fri,  5 Aug 2016 10:06:17 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	loki.analogue-micro-ltd.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=5.0 tests=ALL_TRUSTED,BAYES_40,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from zeus.mlbassoc.com (unknown [10.8.0.2])
	by mail.analogue-micro.com (Postfix) with ESMTP id 0F69168A019;
	Fri,  5 Aug 2016 10:06:17 +0100 (BST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by zeus.mlbassoc.com (Postfix) with ESMTP id 4656B674028F;
	Fri,  5 Aug 2016 11:06:16 +0200 (CEST)
To: bitbake-devel@lists.openembedded.org
References: <1c7e8f51.d202.1564ba890a5.Coremail.zzs213@126.com>
From: Gary Thomas <gary@mlbassoc.com>
Message-ID: <392cebab-0b2d-6e0b-ae3f-ef58e7049aa0@mlbassoc.com>
Date: Fri, 5 Aug 2016 11:06:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1c7e8f51.d202.1564ba890a5.Coremail.zzs213@126.com>
Subject: Re: howto build specific version package
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
X-List-Received-Date: Fri, 05 Aug 2016 09:06:22 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2016-08-02 16:29, zzs wrote:
> Hello, everyone
>
> I have two version .bb recipe, sya test_1.0.bb and test_2.0.bb.
> When build the `test` package  using the flowwing cmd:
>     bitbake test
> Always 2.0 was built.
> My question is: how to let bitbake to build version 1.0 of the test package
>

Put this line in your in local.conf:

PREFERRED_VERSION_test = "1.0"

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

