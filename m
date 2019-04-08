Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id D9FD17D593
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Apr 2019 09:07:54 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3897IHB013444
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 8 Apr 2019 02:07:28 -0700
Received: from localhost.corp.ad.wrs.com (128.224.163.177) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.439.0; Mon, 8 Apr 2019 02:07:07 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1547620210.git.liezhi.yang@windriver.com>
	<52961ec262083777d20e7711fb5b1f2b9d3196ee.1547620210.git.liezhi.yang@windriver.com>
	<03b6d5b6154f87bafc132a26894d04ca1fc1f16c.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <e4506a52-1bcc-f8b8-3e29-cb31db616ce0@windriver.com>
Date: Mon, 8 Apr 2019 17:07:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <03b6d5b6154f87bafc132a26894d04ca1fc1f16c.camel@linuxfoundation.org>
Subject: Re: [PATCH 1/2] bb: siggen: Add a prefix for uuid4
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
X-List-Received-Date: Mon, 08 Apr 2019 09:07:55 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 4/8/19 5:01 PM, Richard Purdie wrote:
> On Wed, 2019-01-16 at 14:30 +0800, Robert Yang wrote:
>> This can make bitbake-diffsigs and dumpsig easier to understand,
>> otherwise,
>> it's hard to know it is a random uuid unless look into the code.
> 
> The correct fix for the problem as stated is to tweak the otuput of
> diffsigs/dumpsigs, not change the contents of the file...

Got it, thanks, I will update it.

// Robert

> 
> Cheers,
> 
> Richard
> 
> 

