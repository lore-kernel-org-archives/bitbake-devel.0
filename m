Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id E35607F012
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jul 2019 03:10:51 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x6I3ApbF008966
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 17 Jul 2019 20:10:51 -0700 (PDT)
Received: from localhost.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.468.0; Wed, 17 Jul 2019 20:10:50 -0700
To: <bitbake-devel@lists.openembedded.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
References: <cover.1562213458.git.liezhi.yang@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <31eb8ea3-76b2-74ff-dfef-f260b11b3fa3@windriver.com>
Date: Thu, 18 Jul 2019 11:11:43 +0800
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
X-List-Received-Date: Thu, 18 Jul 2019 03:10:52 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi RP,

Do you have any comments or concerns on this one, please?

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

