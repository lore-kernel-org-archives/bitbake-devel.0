Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 9CFC4600BB
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Sep 2017 15:53:34 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v86Fr58s025278
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 6 Sep 2017 08:53:05 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.361.1;
	Wed, 6 Sep 2017 08:53:04 -0700
To: <Mikko.Rapeli@bmw.de>, <kergoth@gmail.com>
References: <1504701210-10424-1-git-send-email-mikko.rapeli@bmw.de>
	<1504701210-10424-2-git-send-email-mikko.rapeli@bmw.de>
	<CABcZANnvs4pZ5Ziuh3zNJjy1vbO4mk14+VNyOw_XaQnN+E0YFQ@mail.gmail.com>
	<20170906154729.hz4z5od5nc2g62ul@hiutale>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <5d06b973-f7ca-f900-fa95-8afcbb789e95@windriver.com>
Date: Wed, 6 Sep 2017 10:53:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
	Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170906154729.hz4z5od5nc2g62ul@hiutale>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2 2/2] gitsm.py: support BB_NO_NETWORK during do_unpack
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
X-List-Received-Date: Wed, 06 Sep 2017 15:53:35 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 9/6/17 10:47 AM, Mikko.Rapeli@bmw.de wrote:
> On Wed, Sep 06, 2017 at 08:24:14AM -0700, Christopher Larson wrote:
>> On Wed, Sep 6, 2017 at 5:33 AM, Mikko Rapeli <mikko.rapeli@bmw.de> wrote:
>>
>>> 'git submodule update --init -recursive' will clone remote repositories
>>> if local tree does not have the referenced commits. Add --no-fetch
>>> to git submodule update if BB_NO_NETWORK is defined and only local
>>> download caches should be used.
>>>
>>> Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
>>>
>>
>> If we’re unpacking, there’s no reason to be contacting anything remote
>> regardless of the value of BB_NO_NETWORK. We should be passing —no-fetch
>> all the time. We also need to be running a submodule sync to update any
>> changes urls in the submodule remotes, but there are other issues to be
>> resolved beyond that.
> 
> Yes, I thought about this but decided not to change current behavior.
> Should have mentioned that in the commit message.
> 
> I can send a new version where --no-fetch is the default but it might break
> in some setups, especially when the DL_DIR cache is not used for submodules...

(without truely understanding the ramifications), I would prefer the system to
fail with an error then attempt to contact a network resources if BB_NO_NETWORK
is set.

An error (with a resolution of somehow getting the item local either in the
DL_DIR or a file:// mirror seems like the best alternative for a user who needs
to prevent network access.

So if --no-fetch will help ensure that, I'm all for it.

--Mark

> -Mikko
> 


