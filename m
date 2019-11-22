Return-Path: <Yi.Zhao@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 7BCC57FC80
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2019 06:54:40 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id xAM6sflW017322
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2019 22:54:41 -0800 (PST)
Received: from [128.224.158.241] (128.224.158.241) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0;
	Thu, 21 Nov 2019 22:54:40 -0800
To: <bitbake-devel@lists.openembedded.org>
References: <20191108034600.13103-1-yi.zhao@windriver.com>
From: Yi Zhao <yi.zhao@windriver.com>
Message-ID: <55101889-406e-5848-6d5c-768f194b3420@windriver.com>
Date: Fri, 22 Nov 2019 14:54:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108034600.13103-1-yi.zhao@windriver.com>
X-Originating-IP: [128.224.158.241]
Subject: Re: [PATCH] contrib/vim/indent/bitbake.vim: move it to correct directory
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
X-List-Received-Date: Fri, 22 Nov 2019 06:54:41 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Ping...


On 11/8/19 11:46 AM, Yi Zhao wrote:
> Move bitbake.vim from bitbake/contrib/vim/indent to contrib/vim/indent.
>
> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> ---
>   {bitbake/contrib => contrib}/vim/indent/bitbake.vim | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename {bitbake/contrib => contrib}/vim/indent/bitbake.vim (100%)
>
> diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/contrib/vim/indent/bitbake.vim
> similarity index 100%
> rename from bitbake/contrib/vim/indent/bitbake.vim
> rename to contrib/vim/indent/bitbake.vim

