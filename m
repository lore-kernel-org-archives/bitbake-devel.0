Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8E1976C963
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Nov 2018 10:25:45 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wANAPiMe026780
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 23 Nov 2018 02:25:45 -0800 (PST)
Received: from [128.224.163.177] (128.224.163.177) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Fri, 23 Nov 2018 02:25:44 -0800
To: "da Silva Filho, Josias Inacio" <jdasilva@ciena.com>
References: <BY2PR0401MB1062E20E143B0318E7B03B9DDBDB0@BY2PR0401MB1062.namprd04.prod.outlook.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <2ca14555-de68-244a-7b86-459ae916a08f@windriver.com>
Date: Fri, 23 Nov 2018 18:30:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BY2PR0401MB1062E20E143B0318E7B03B9DDBDB0@BY2PR0401MB1062.namprd04.prod.outlook.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Sumo to Thud migration: Fetch failure from gitsm.py
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
X-List-Received-Date: Fri, 23 Nov 2018 10:25:45 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi,

Please refer to the following 2 commits in bitbake which may help:

commit a042179a784bab6a6f4bd5d63db80c1c02624b1c
Author: Mark Hatle <mark.hatle@windriver.com>
Date:   Wed Oct 31 15:21:44 2018 -0400

     bitbake: fetch2/gitsm.py: Fix the references when the module and path are 
different

commit a28637abbceb05b52a6e38ab2340d3da9d0b1b37
Author: Mark Hatle <mark.hatle@windriver.com>
Date:   Wed Oct 31 15:21:43 2018 -0400

     bitbake: fetch2/gitsm.py: Disable branch checking on submodules


// Robert

On 11/22/18 11:31 PM, da Silva Filho, Josias Inacio wrote:
> Hi folks,
> 
> I’m working on migrating my environment from Sumo to Thud. After fixing a few 
> quirks, it seems the fetch is failing for my foo.bb which uses gitsm.
> 
> *.gitmodules content in foo repo:*
> 
> [submodule "common-lib"]
> 
>                  path = common-lib
> 
>                  url = ssh://git@<url_to_common-lib>/common-lib.git
> 
> *foo.bb:*
> 
> SRC_URI="gitsm://git@b<url_to_foo>.git;protocol=ssh;branch=master"
> 
> SRCREV="f55fae9dc9b476f8ed193f15e2d5cd6747777451"
> 
> Digging inside gitsm.py it looks like module_hash is not being set correctly 
> (empty) and that causes the issue:
> 
> http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/fetch2/gitsm.py#n87
> 
> I added the following right after line 87, so I could dump the variables 
> content. This is how I confirmed module_hash is empty:
> 
> *raise bb.fetch2.FetchError('module: %s, submodules: %s, module_hash: %s, 
> basecmd: %s, revisions: %s, paths: %s, clonedir: %s ' % ( module, submodules, 
> module_hash, ud.basecmd, ud.revisions[name], paths[module], ud.clonedir))*
> 
> And the output:
> 
> ERROR: Fetcher failure: module: common-lib, submodules: ['common-lib'], 
> *module_hash*: , basecmd: git -c core.fsyncobjectfiles=0, revisions: 
> f55fae9dc9b476f8ed193f15e2d5cd6747777451, paths: common-lib, clonedir: 
> /localdata/yocto/downloads/git2/<foo's path>.git
> 
> Any ideas why module_hash is not being set correctly?
> 
> 

