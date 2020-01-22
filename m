Return-Path: <adrian.ambrozewicz@linux.intel.com>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by mail.openembedded.org (Postfix) with ESMTP id E8FFB7F7E1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2020 08:49:12 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	22 Jan 2020 00:49:14 -0800
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; d="scan'208";a="220242938"
Received: from aambroze-mobl1.ger.corp.intel.com (HELO [10.102.85.150])
	([10.102.85.150])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
	22 Jan 2020 00:49:13 -0800
To: Alexander Kanavin <alex.kanavin@gmail.com>
References: <4bee3ba1-3608-5598-b168-1e6009bdc986@linux.intel.com>
	<CANNYZj8CRSC3V8K08-dpEmGg5zbY9N4jiJPQhia04d7NRKiTEw@mail.gmail.com>
From: =?UTF-8?Q?Adrian_Ambro=c5=bcewicz?= <adrian.ambrozewicz@linux.intel.com>
Message-ID: <b64ada55-a892-09a5-13b2-f76e2b0507d1@linux.intel.com>
Date: Wed, 22 Jan 2020 09:49:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
	Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CANNYZj8CRSC3V8K08-dpEmGg5zbY9N4jiJPQhia04d7NRKiTEw@mail.gmail.com>
Cc: Bitbake-Devel <bitbake-devel@lists.openembedded.org>
Subject: Re: devtool hardcodes using 'git' patchtool which causes errors
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
X-List-Received-Date: Wed, 22 Jan 2020 08:49:13 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

I see. However - this looks like quite a minefield :)

W dniu 1/21/2020 o 11:49, Alexander Kanavin pisze:
> I am not entirely sure about this, but I believe devtool is using git to 
> keep track of patches when modifying or upgrading (e.g. adding, 
> modifying or rebasing custom recipe patches), so using quilt may not be 
> an option. Fixing the scenarios that go wrong for you is probably a 
> better path.
> 
> Alex
> 
> On Tue, 21 Jan 2020 at 10:44, Adrian Ambrożewicz 
> <adrian.ambrozewicz@linux.intel.com 
> <mailto:adrian.ambrozewicz@linux.intel.com>> wrote:
> 
>     In poky sources i can see that default PATCHTOOL used is 'quilt'
>     (https://github.com/openembedded/openembedded-core/blob/master/meta/conf/bitbake.conf)
> 
>     and it works flawlessly. Devtool however still defaults to legacy 'git'
>     PATCHTOOL, as specified here:
>     http://git.yoctoproject.org/cgit.cgi/poky/plain/scripts/lib/devtool/standard.py
>        > f.write('PATCHTOOL = "git"\n')
> 
>     Request:
>     I've tried to debug the problem but I'm not very familiar with Bitbake
>     code, so I wonder if we could default to 'quilt' for devtool as well?
> 
>     Rationale:
>     'git' PATCHER doesn't work well when he have nested WORKDIR and
>     striplevel used. 'bitbake -c patch [pkg]' works fine, but 'devtool
>     modify [pkg]' fails with weird behavior. For example - new files
>     created
>     by patches are created in wrong location (WORKDIR instead of nested
>     directory) and package doesn't compile until manually fixed.
> 
>     Regards,
>     Adrian
>     -- 
>     _______________________________________________
>     bitbake-devel mailing list
>     bitbake-devel@lists.openembedded.org
>     <mailto:bitbake-devel@lists.openembedded.org>
>     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> 

