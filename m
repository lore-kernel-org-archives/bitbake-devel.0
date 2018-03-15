Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id A7B38787F1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Mar 2018 02:00:14 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w2F20FM7021776
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Mar 2018 19:00:15 -0700 (PDT)
Received: from localhost.corp.ad.wrs.com (128.224.163.240) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.361.1; Wed, 14 Mar 2018 19:00:14 -0700
To: <bitbake-devel@lists.openembedded.org>
References: <cover.1519716375.git.liezhi.yang@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <bd1ee4f1-c565-d2aa-e6d0-8ee8785b2d49@windriver.com>
Date: Thu, 15 Mar 2018 10:00:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1519716375.git.liezhi.yang@windriver.com>
Subject: Re: [resend][PATCH 0/3 V2] cooker: fixes event notifications
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
X-List-Received-Date: Thu, 15 Mar 2018 02:00:14 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi RP,

Do you have any comments on this, please ?

// Robert

On 02/27/2018 03:28 PM, Robert Yang wrote:
> Hi RP,
> 
> I think that I've answered your questions' in V1, do you have any comments on
> these patches, please ?
> 
> // Robert
> 
> The following changes since commit 1b7a9d4f63d07d61d53daac12da275e8ef2feb24:
> 
>    buildhistory-diff: honour report_all flag (2018-02-24 10:35:59 +0000)
> 
> are available in the git repository at:
> 
>    git://git.pokylinux.org/poky-contrib rbt/cooker
>    http://git.pokylinux.org/cgit.cgi//log/?h=rbt/cooker
> 
> Robert Yang (3):
>    bitbake: cooker: don't preserve BB_CONSOLELOG
>    bitbake: cooker: fix event notifications
>    bitbake: cooker: improve inotify handling
> 
>   bitbake/lib/bb/cache.py  |  9 ++++---
>   bitbake/lib/bb/cooker.py | 66 ++++++++++++++++++++++++------------------------
>   2 files changed, 39 insertions(+), 36 deletions(-)
> 

