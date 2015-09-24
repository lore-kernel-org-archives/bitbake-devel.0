Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 14FC77404E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Sep 2015 08:23:04 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id t8O8N5m5029676
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Sep 2015 01:23:05 -0700 (PDT)
Received: from [128.224.162.200] (128.224.162.200) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.235.1;
	Thu, 24 Sep 2015 01:23:04 -0700
Message-ID: <5603B2E7.6060606@windriver.com>
Date: Thu, 24 Sep 2015 16:23:03 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <cover.1443082777.git.liezhi.yang@windriver.com>
In-Reply-To: <cover.1443082777.git.liezhi.yang@windriver.com>
Subject: Re: [PATCH 0/1] siggen.py: fix clean_basepath()
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
X-List-Received-Date: Thu, 24 Sep 2015 08:23:05 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit


Hi RP,

I'm not sure what patch causes this problem, this patch can fix it,
but I'm not sure whether it is a correct fix or not.

// Robert

On 09/24/2015 04:20 PM, Robert Yang wrote:
> The following changes since commit 9f66aa1a11b5b45280aa41bf4517ec56ee5f2ab2:
>
>    bitbake: toaster: start script warning text formatting small improvement (2015-09-23 22:44:56 +0100)
>
> are available in the git repository at:
>
>    git://git.pokylinux.org/poky-contrib rbt/sig
>    http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/sig
>
> Robert Yang (1):
>    siggen.py: fix clean_basepath()
>
>   bitbake/lib/bb/siggen.py |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>

