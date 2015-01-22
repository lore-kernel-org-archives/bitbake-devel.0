Return-Path: <Chong.Lu@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 584C960DD7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 01:46:37 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t0M1kaqU020301
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
	Wed, 21 Jan 2015 17:46:36 -0800 (PST)
Received: from [128.224.162.204] (128.224.162.204) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.174.1;
	Wed, 21 Jan 2015 17:46:36 -0800
Message-ID: <54C05679.3010507@windriver.com>
Date: Thu, 22 Jan 2015 09:46:33 +0800
From: Chong Lu <Chong.Lu@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To: Trevor Woerner <twoerner@gmail.com>, <bitbake-devel@lists.openembedded.org>
References: <cover.1421827025.git.Chong.Lu@windriver.com>
	<54BFED9D.50701@gmail.com>
In-Reply-To: <54BFED9D.50701@gmail.com>
X-Originating-IP: [128.224.162.204]
Subject: Re: [PATCH 0/2] bitbake-layers: add a ability to query layer dependencies from layer index
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
X-List-Received-Date: Thu, 22 Jan 2015 01:46:48 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit


On 01/22/2015 02:19 AM, Trevor Woerner wrote:
> On 01/21/15 03:02, Chong Lu wrote:
>> $ bitbake-layers show-layer-deps errorlayer,meta-openstack
>> Parsing recipes..done.
>> Layer                 Dependencies          Git repository                                           Subdirectory
>> ===================================================================================================================
>> meta-openstack        meta-ruby             git://git.openembedded.org/meta-openembedded             meta-ruby
>> meta-openstack        meta-networking       git://git.openembedded.org/meta-openembedded             meta-networking
>> meta-openstack        meta-virtualization   git://git.yoctoproject.org/meta-virtualization
>> meta-openstack        openembedded-core     git://git.openembedded.org/openembedded-core             meta
>> meta-openstack        meta-oe               git://git.openembedded.org/meta-openembedded             meta-oe
>> WARNING: errorlayer is not found in layer index.
>> Cloning into '/buildarea2/clu1/source/poky/meta-cloud-services'...
>> Add "meta-openstack" to conf/bblayers.conf
>> Cloning into '/buildarea2/clu1/source/poky/meta-openembedded'...
>> Add "meta-ruby" to conf/bblayers.conf
>> Add "meta-networking" to conf/bblayers.conf
>> Cloning into '/buildarea2/clu1/source/poky/meta-virtualization'...
>> Add "meta-virtualization" to conf/bblayers.conf
>> Add "meta-oe" to conf/bblayers.conf
> I wouldn't expect a sub-command called "show-layer-deps" to go ahead and
> add the shown dependencies to my configuration. Maybe either an explicit
> switch or separate "add-layer-deps" command should be added instead?
>

OK, Thanks for your suggestion, I will add two options for fetch and add 
layers.

Best Regards
Chong



