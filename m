Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 929BC60017
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 06:14:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u086EDMC002477
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 7 Jan 2016 22:14:13 -0800 (PST)
Received: from [128.224.162.155] (128.224.162.155) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.248.2;
	Thu, 7 Jan 2016 22:14:13 -0800
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1452152302.git.liezhi.yang@windriver.com>
	<60b4483fa1dfbd45dc1835dca1759ee5f6a27f4f.1452152302.git.liezhi.yang@windriver.com>
	<1452175001.7598.117.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <568F53B3.4060001@windriver.com>
Date: Fri, 8 Jan 2016 14:14:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <1452175001.7598.117.camel@linuxfoundation.org>
Subject: Re: [PATCH 1/1] fetch2/git.py:_latest_revision: respect BB_FETCH_PREMIRRORONLY
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
X-List-Received-Date: Fri, 08 Jan 2016 06:14:13 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 01/07/2016 09:56 PM, Richard Purdie wrote:
> On Wed, 2016-01-06 at 23:38 -0800, Robert Yang wrote:
>> Fixed when use a local BB_FETCH_PREMIRRORONLY for AUTOREV recipes:
>> SRCREV = "${AUTOREV}"
>> BB_NO_NETWORK = "1"
>> For example, the refpolicy-mls from meta-selinux:
>> $ bitbake refpolicy-mls -ccleanall/fetch
>
>
> This test case is incorrect, you shouldn't set BB_NO_NETWORK if you
> want to BB_FETCH_PREMIRRORONLY...

Sorry, I'm a little confused about this, the PREMIRROR can be on local
disk, so I think that we can set both BB_NO_NETWORK and BB_FETCH_PREMIRRORONLY ?

The commit message isn't correct enough, it should be:
"Fixed when use a local PREMIRROR for AUTOREV recipes"

// Robert

>
> Cheers,
>
> Richard
>

