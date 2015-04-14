Return-Path: <Qi.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C410465CF5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Apr 2015 02:17:52 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t3E2HrF8010507
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Apr 2015 19:17:53 -0700 (PDT)
Received: from [128.224.162.236] (128.224.162.236) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.224.2;
	Mon, 13 Apr 2015 19:17:56 -0700
Message-ID: <552C78D3.4030603@windriver.com>
Date: Tue, 14 Apr 2015 10:17:55 +0800
From: ChenQi <Qi.Chen@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <cover.1427962176.git.Qi.Chen@windriver.com>
In-Reply-To: <cover.1427962176.git.Qi.Chen@windriver.com>
X-Originating-IP: [128.224.162.236]
Subject: Re: [PATCH 0/1] bitbake-layers: change the behaviour of show-cross-depends
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
X-List-Received-Date: Tue, 14 Apr 2015 02:17:54 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

Ping

Any comment on this one?

Best Regards,
Chen Qi

On 04/02/2015 04:11 PM, Chen Qi wrote:
> The following changes since commit 9e4adec98db325112ca7a8b9dd95722d4d0ab642:
>
>    distro_alias.inc: update/sort alias information. (2015-03-31 22:54:54 +0100)
>
> are available in the git repository at:
>
>    git://git.pokylinux.org/poky-contrib ChenQi/bitbake-layers-show-cross-depends
>    http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=ChenQi/bitbake-layers-show-cross-depends
>
> Chen Qi (1):
>    bitbake-layers: change the behaviour of show-cross-depends
>
>   bitbake/bin/bitbake-layers | 60 ++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 50 insertions(+), 10 deletions(-)
>


