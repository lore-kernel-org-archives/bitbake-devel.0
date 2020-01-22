Return-Path: <adrian.ambrozewicz@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 3AE537FEFB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2020 15:06:00 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	22 Jan 2020 07:06:01 -0800
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; d="scan'208";a="220339365"
Received: from aambroze-mobl1.ger.corp.intel.com (HELO [10.102.85.150])
	([10.102.85.150])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
	22 Jan 2020 07:05:59 -0800
From: =?UTF-8?Q?Adrian_Ambro=c5=bcewicz?= <adrian.ambrozewicz@linux.intel.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
References: <4bee3ba1-3608-5598-b168-1e6009bdc986@linux.intel.com>
	<CANNYZj8CRSC3V8K08-dpEmGg5zbY9N4jiJPQhia04d7NRKiTEw@mail.gmail.com>
	<b64ada55-a892-09a5-13b2-f76e2b0507d1@linux.intel.com>
Message-ID: <a4d78a27-50e6-ee87-bcd7-71694b7da60f@linux.intel.com>
Date: Wed, 22 Jan 2020 16:05:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
	Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b64ada55-a892-09a5-13b2-f76e2b0507d1@linux.intel.com>
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
X-List-Received-Date: Wed, 22 Jan 2020 15:06:00 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

I actually gave the problem some thought and I believe i must take back 
my first assumption that 'git' patcher is wrong. In fact - is either 
quilt or the way we achieve certain thing described here:

We have repo with project in nested directory. Lets imagine repo with 
following structure
\ // repo root
  \ project_dir
  \ other_project_dir

We have a recipe, which is set to build project from this repo. We do 
that by modyfing S variable to:
S = "${WORKDIR}/git/project_dir/"

Our local patches aims the repository structure, so they modify paths 
like "+++ a/project_dir/src/file.cpp". They don't apply cleanly during 
'bitbake -c patch [project]', as quilt tries to apply them from inside S 
directory ('${WORKDIR}/git/project_dir'). To mitigate that - author of 
recipe used 'striplevel=2' to allow proper building in such case.

Now that I analyzed that I see why 'git' patcher has problems with that. 
Git patcher uses 'git am', which naturally knows where the root of 
repository is (even if it was called from subdirectory). In case of 
'git' patcher striplevel should be defaulted to 1.

My question is - is there a way to have both of these patchers working 
with such folder structure? Maybe 'S' overwriting was not a good idea 
after all?

Regards,
Adrian


W dniu 1/22/2020 o 09:49, Adrian Ambrożewicz pisze:
> I see. However - this looks like quite a minefield :)
> 
> W dniu 1/21/2020 o 11:49, Alexander Kanavin pisze:
>> I am not entirely sure about this, but I believe devtool is using git 
>> to keep track of patches when modifying or upgrading (e.g. adding, 
>> modifying or rebasing custom recipe patches), so using quilt may not 
>> be an option. Fixing the scenarios that go wrong for you is probably a 
>> better path.
>>
>> Alex
>>
>> On Tue, 21 Jan 2020 at 10:44, Adrian Ambrożewicz 
>> <adrian.ambrozewicz@linux.intel.com 
>> <mailto:adrian.ambrozewicz@linux.intel.com>> wrote:
>>
>>     In poky sources i can see that default PATCHTOOL used is 'quilt'
>>     
>> (https://github.com/openembedded/openembedded-core/blob/master/meta/conf/bitbake.conf) 
>>
>>
>>     and it works flawlessly. Devtool however still defaults to legacy 
>> 'git'
>>     PATCHTOOL, as specified here:
>>     
>> http://git.yoctoproject.org/cgit.cgi/poky/plain/scripts/lib/devtool/standard.py 
>>
>>        > f.write('PATCHTOOL = "git"\n')
>>
>>     Request:
>>     I've tried to debug the problem but I'm not very familiar with 
>> Bitbake
>>     code, so I wonder if we could default to 'quilt' for devtool as well?
>>
>>     Rationale:
>>     'git' PATCHER doesn't work well when he have nested WORKDIR and
>>     striplevel used. 'bitbake -c patch [pkg]' works fine, but 'devtool
>>     modify [pkg]' fails with weird behavior. For example - new files
>>     created
>>     by patches are created in wrong location (WORKDIR instead of nested
>>     directory) and package doesn't compile until manually fixed.
>>
>>     Regards,
>>     Adrian
>>     --     _______________________________________________
>>     bitbake-devel mailing list
>>     bitbake-devel@lists.openembedded.org
>>     <mailto:bitbake-devel@lists.openembedded.org>
>>     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>

