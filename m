Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id E6FA27CE5F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 07:20:51 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x6B7KFO6021674
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 11 Jul 2019 00:20:25 -0700
Received: from localhost.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.439.0; Thu, 11 Jul 2019 00:20:04 -0700
To: <bitbake-devel@lists.openembedded.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
References: <cover.1562213458.git.liezhi.yang@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <4392375c-3a49-f366-33b2-1eca879fbce0@windriver.com>
Date: Thu, 11 Jul 2019 15:21:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cover.1562213458.git.liezhi.yang@windriver.com>
Subject: Re: [PATCH 0/1] cache: Create a symlink for current cachefile
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
X-List-Received-Date: Thu, 11 Jul 2019 07:20:52 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi RP,

Do you have any comments on this, please?

// Robert

On 7/4/19 12:12 PM, Robert Yang wrote:
> The following changes since commit 4fd9ee4670293632cc0ca1e64b8833eb6014435d:
> 
>    bitbake: bitbake: Add --skip-setscene option (2019-07-03 17:00:57 +0100)
> 
> are available in the git repository at:
> 
>    git://git.pokylinux.org/poky-contrib rbt/symlink
>    http://git.pokylinux.org/cgit.cgi//log/?h=rbt/symlink
> 
> Robert Yang (1):
>    cache: Create a symlink for current cachefile
> 
>   bitbake/lib/bb/cache.py | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 

