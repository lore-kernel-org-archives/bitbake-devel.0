Return-Path: <adrian.ambrozewicz@linux.intel.com>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by mail.openembedded.org (Postfix) with ESMTP id EB0607FD9C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2020 15:49:26 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	22 Jan 2020 07:49:28 -0800
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; d="scan'208";a="220350635"
Received: from aambroze-mobl1.ger.corp.intel.com (HELO [10.102.85.150])
	([10.102.85.150])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
	22 Jan 2020 07:49:27 -0800
To: Alexander Kanavin <alex.kanavin@gmail.com>
References: <4bee3ba1-3608-5598-b168-1e6009bdc986@linux.intel.com>
	<CANNYZj8CRSC3V8K08-dpEmGg5zbY9N4jiJPQhia04d7NRKiTEw@mail.gmail.com>
	<b64ada55-a892-09a5-13b2-f76e2b0507d1@linux.intel.com>
	<a4d78a27-50e6-ee87-bcd7-71694b7da60f@linux.intel.com>
	<CANNYZj8S5A1qKy8m_=pPfP_Hbqs7qzYqE-rwMf+DGE0ivnBxpA@mail.gmail.com>
From: =?UTF-8?Q?Adrian_Ambro=c5=bcewicz?= <adrian.ambrozewicz@linux.intel.com>
Message-ID: <4fef2d1e-5fcc-5143-5cf9-cac5ea30b442@linux.intel.com>
Date: Wed, 22 Jan 2020 16:49:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
	Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CANNYZj8S5A1qKy8m_=pPfP_Hbqs7qzYqE-rwMf+DGE0ivnBxpA@mail.gmail.com>
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
X-List-Received-Date: Wed, 22 Jan 2020 15:49:27 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

It looks like git:// fetcher option 'subpath' might be good alternative 
designed to address those kind of issues.

Setting:
SRC_URI = '[repopath];subpath=project_dir'
S = '${WORKDIR}/project_dir'
works exactly the same as my previous approach when it comes to 'bitbake 
-c patch [project]'

Unfortunately it looks like devtool ignores that param and clones whole 
repository structure. I'll try fiddling around to implement that support 
in devtool.


W dniu 1/22/2020 o 16:10, Alexander Kanavin pisze:
> On Wed, 22 Jan 2020 at 16:06, Adrian Ambrożewicz 
> <adrian.ambrozewicz@linux.intel.com 
> <mailto:adrian.ambrozewicz@linux.intel.com>> wrote:
> 
> 
>     My question is - is there a way to have both of these patchers working
>     with such folder structure? Maybe 'S' overwriting was not a good idea
>     after all?
> 
> 
> I guess the problem here is that S is used for both patching and 
> building, and the 'root' for these may not necessarily match. Maybe 
> there could be a variable that, when set, overrides S for the purpose of 
> patching.
> 
> Alex

