Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1B9CB7D6B5
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Apr 2019 08:56:08 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x388u9cX012254
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 8 Apr 2019 01:56:09 -0700 (PDT)
Received: from localhost.corp.ad.wrs.com (128.224.163.177) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.439.0; Mon, 8 Apr 2019 01:56:09 -0700
To: <bitbake-devel@lists.openembedded.org>
References: <cover.1547620210.git.liezhi.yang@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <a355fcbb-cc79-ce61-9ed5-7853888c5da1@windriver.com>
Date: Mon, 8 Apr 2019 16:56:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1547620210.git.liezhi.yang@windriver.com>
Subject: Re: [PATCH 0/2] bb: siggen: 2 fixes
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
X-List-Received-Date: Mon, 08 Apr 2019 08:56:09 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Ping.

// Robert

On 1/16/19 2:30 PM, Robert Yang wrote:
> The following changes since commit 1ee53881eea3a7ca4d4f6a5ca9c4c6e6488d2348:
> 
>    perl: fix yet another race failure (2019-01-14 17:38:24 +0000)
> 
> are available in the git repository at:
> 
>    git://git.pokylinux.org/poky-contrib rbt/siggen
>    http://git.pokylinux.org/cgit.cgi//log/?h=rbt/siggen
> 
> Robert Yang (2):
>    bb: siggen: Add a prefix for uuid4
>    bb: siggen: Print more info when basehash are mis-matched
> 
>   bitbake/lib/bb/build.py  | 2 +-
>   bitbake/lib/bb/siggen.py | 8 +++++++-
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 

