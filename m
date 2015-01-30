Return-Path: <Chong.Lu@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0608760034
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Jan 2015 01:20:55 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id t0U1KuoA018670
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 29 Jan 2015 17:20:56 -0800 (PST)
Received: from [128.224.162.204] (128.224.162.204) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.174.1;
	Thu, 29 Jan 2015 17:20:56 -0800
Message-ID: <54CADC75.4020305@windriver.com>
Date: Fri, 30 Jan 2015 09:20:53 +0800
From: Chong Lu <Chong.Lu@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>, <paul.eggleton@linux.intel.com>
References: <cover.1421990461.git.Chong.Lu@windriver.com>
In-Reply-To: <cover.1421990461.git.Chong.Lu@windriver.com>
X-Originating-IP: [128.224.162.204]
Subject: Re: [PATCH V3 0/2] bitbake-layers: add a ability to query layer dependencies from layer index
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
X-List-Received-Date: Fri, 30 Jan 2015 01:21:02 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

ping

//Chong

On 01/23/2015 01:28 PM, Chong Lu wrote:
> Change since V2:
> re-split for IPv6 URL parsing
>
> The following changes since commit 35c9fa0588ed8e88b541a6c80cc1517324616cea:
>
>    maintainers: Update for non-maintained recipes (2015-01-20 21:39:41 +0000)
>
> are available in the git repository at:
>
>    git://git.pokylinux.org/poky-contrib chonglu/layerindex
>    http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=chonglu/layerindex
>
> Chong Lu (2):
>    bitbake.conf: Add two variables for layer index
>    bitbake-layers: add a ability to query layer dependencies from layer index
>
>   bitbake/bin/bitbake-layers | 190 +++++++++++++++++++++++++++++++++++++++++++++
>   meta/conf/bitbake.conf     |   6 ++
>   2 files changed, 196 insertions(+)
>


