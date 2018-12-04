Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 735E16C52E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Dec 2018 01:54:54 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB41sY9K008483
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 3 Dec 2018 17:54:45 -0800
Received: from [128.224.163.177] (128.224.163.177) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Mon, 3 Dec 2018 17:54:24 -0800
To: <bitbake-devel@lists.openembedded.org>
References: <cover.1543889029.git.liezhi.yang@windriver.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <6f848efd-de37-0232-5067-095defede76b@windriver.com>
Date: Tue, 4 Dec 2018 09:59:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cover.1543889029.git.liezhi.yang@windriver.com>
Subject: Re: [PATCH 0/4] fixes for pysh
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
X-List-Received-Date: Tue, 04 Dec 2018 01:54:54 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

I Received a message from bitbake list:

     [PATCH 1/4] pysh: Remove unused modules

Is being held until the list moderator can review it for approval.

The reason it is being held:

     Message body is too big: 93560 bytes with a limit of 80 KB


Here is the stat of the patch:

  bitbake/lib/bb/pysh/builtin.py        |  710 
---------------------------------------------------
  bitbake/lib/bb/pysh/interp.py         | 1367 
---------------------------------------------------------------------------------------------------
  bitbake/lib/bb/pysh/lsprof.py         |  116 ---------
  bitbake/lib/bb/pysh/pysh.py           |  167 ------------
  bitbake/lib/bb/pysh/subprocess_fix.py |   77 ------
  5 files changed, 2437 deletions(-)


// Robert

On 12/4/18 10:05 AM, Robert Yang wrote:
> Hi RP,
> 
> The pysh's code looks a little out of date, and the author declared that pysh
> is no longer maintained:
> http://pysh.sourceforge.net/
> 
> These are fixes for it.
> 
> // Robert
> 
> The following changes since commit 016e3dda2d6acc9b457079d11b5346a5352a431d:
> 
>    btrfs-tools: update to 4.19 (2018-12-03 12:20:01 +0000)
> 
> are available in the git repository at:
> 
>    git://git.pokylinux.org/poky-contrib rbt/pysh
>    http://git.pokylinux.org/cgit.cgi//log/?h=rbt/pysh
> 
> Robert Yang (4):
>    pysh: Remove unused modules
>    pysh/sherrors.py: Remove unused classes
>    pysh/pyshlex.py: Set is not importable
>    bitbake: pysh: Improve error handling for shell code
> 
>   bitbake/lib/bb/codeparser.py          |    5 +-
>   bitbake/lib/bb/pysh/builtin.py        |  710 -----------------
>   bitbake/lib/bb/pysh/interp.py         | 1367 ---------------------------------
>   bitbake/lib/bb/pysh/lsprof.py         |  116 ---
>   bitbake/lib/bb/pysh/pysh.py           |  167 ----
>   bitbake/lib/bb/pysh/pyshlex.py        |    5 -
>   bitbake/lib/bb/pysh/pyshyacc.py       |   17 +-
>   bitbake/lib/bb/pysh/sherrors.py       |   26 -
>   bitbake/lib/bb/pysh/subprocess_fix.py |   77 --
>   9 files changed, 13 insertions(+), 2477 deletions(-)
>   delete mode 100644 bitbake/lib/bb/pysh/builtin.py
>   delete mode 100644 bitbake/lib/bb/pysh/interp.py
>   delete mode 100644 bitbake/lib/bb/pysh/lsprof.py
>   delete mode 100644 bitbake/lib/bb/pysh/pysh.py
>   delete mode 100644 bitbake/lib/bb/pysh/subprocess_fix.py
> 

