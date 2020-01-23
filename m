Return-Path: <adrian.ambrozewicz@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 09DF97FD81
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jan 2020 10:02:46 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Jan 2020 02:02:48 -0800
X-IronPort-AV: E=Sophos;i="5.70,353,1574150400"; d="scan'208";a="220617250"
Received: from aambroze-mobl1.ger.corp.intel.com (HELO [10.102.85.150])
	([10.102.85.150])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
	23 Jan 2020 02:02:47 -0800
To: bitbake-devel@lists.openembedded.org
References: <4bee3ba1-3608-5598-b168-1e6009bdc986@linux.intel.com>
	<CANNYZj8CRSC3V8K08-dpEmGg5zbY9N4jiJPQhia04d7NRKiTEw@mail.gmail.com>
	<b64ada55-a892-09a5-13b2-f76e2b0507d1@linux.intel.com>
	<a4d78a27-50e6-ee87-bcd7-71694b7da60f@linux.intel.com>
	<CANNYZj8S5A1qKy8m_=pPfP_Hbqs7qzYqE-rwMf+DGE0ivnBxpA@mail.gmail.com>
	<4fef2d1e-5fcc-5143-5cf9-cac5ea30b442@linux.intel.com>
From: =?UTF-8?Q?Adrian_Ambro=c5=bcewicz?= <adrian.ambrozewicz@linux.intel.com>
Message-ID: <f9dbd756-6bed-d3ec-f3db-8b2da765b99f@linux.intel.com>
Date: Thu, 23 Jan 2020 11:02:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
	Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4fef2d1e-5fcc-5143-5cf9-cac5ea30b442@linux.intel.com>
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
X-List-Received-Date: Thu, 23 Jan 2020 10:02:47 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

I've tried yet another approach, leveraging that this project is built 
using cmake and it worked! I know it's not a generic fix, but it looks 
like in bitbake nothing is really generic...

Instead of having project set like this:
SRC_URI = '[path_to_repo]'
S = '${WORKDIR}/git/project_dir'

I've set it like this:
SRC_URI = "[path_to_repo]"
S = "${WORKDIR}/git"
OECMAKE_SOURCEPATH = "${S}/virtual-media"

In that way both quilt and git patcher uses proper 'S' directory, while 
Cmake perform compilation from desired subdirectory.

I just hope I won't stumble into this kind of problem with another build 
system :)

Thanks a lot for your input, it lead me to correct track.

Regards,
Adrian

W dniu 1/22/2020 o 16:49, Adrian Ambrożewicz pisze:
> It looks like git:// fetcher option 'subpath' might be good alternative 
> designed to address those kind of issues.
> 
> Setting:
> SRC_URI = '[repopath];subpath=project_dir'
> S = '${WORKDIR}/project_dir'
> works exactly the same as my previous approach when it comes to 'bitbake 
> -c patch [project]'
> 
> Unfortunately it looks like devtool ignores that param and clones whole 
> repository structure. I'll try fiddling around to implement that support 
> in devtool.
> 
> 
> W dniu 1/22/2020 o 16:10, Alexander Kanavin pisze:
>> On Wed, 22 Jan 2020 at 16:06, Adrian Ambrożewicz 
>> <adrian.ambrozewicz@linux.intel.com 
>> <mailto:adrian.ambrozewicz@linux.intel.com>> wrote:
>>
>>
>>     My question is - is there a way to have both of these patchers 
>> working
>>     with such folder structure? Maybe 'S' overwriting was not a good idea
>>     after all?
>>
>>
>> I guess the problem here is that S is used for both patching and 
>> building, and the 'root' for these may not necessarily match. Maybe 
>> there could be a variable that, when set, overrides S for the purpose 
>> of patching.
>>
>> Alex

