Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id B4E3871984
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Aug 2017 18:18:04 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v73II57L019383
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 3 Aug 2017 11:18:05 -0700
Received: from soho-mhatle-m.local (172.25.36.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.361.1;
	Thu, 3 Aug 2017 11:18:04 -0700
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
	<1501256242-37784-5-git-send-email-mark.hatle@windriver.com>
	<7053389.oLP1XTmJTf@peggleto-mobl.ger.corp.intel.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <1fcf3861-fd8e-042d-2a05-0bfe9c6aab14@windriver.com>
Date: Thu, 3 Aug 2017 13:18:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
	Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <7053389.oLP1XTmJTf@peggleto-mobl.ger.corp.intel.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@yoctoproject.org
Subject: Re: [PATCH 4/5] toaster/orm/management/commands/lsupdates.py: Use new layerindex module
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
X-List-Received-Date: Thu, 03 Aug 2017 18:18:04 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 8/3/17 1:06 PM, Paul Eggleton wrote:
> On Friday, 28 July 2017 5:37:21 PM CEST Mark Hatle wrote:
>> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> 
> Missing a commit message - and you wrote the book on proper commit messages :p

In this case, what is wrong with the message.  The change doesn't do anything
but use the new layer index module.  Functionality remains the same.

I can duplicate it in the commit message, but this isn't a place where I see any
added value.

--Mark

> Cheers,
> Paul
> 


