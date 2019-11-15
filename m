Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 630AD7E549
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 17:12:44 +0000 (UTC)
Received: from Marks-MacBook-Pro.local ([76.164.61.198]) (authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id xAFHCL1D020086
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Fri, 15 Nov 2019 11:12:21 -0600
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	=?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linaro.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <20191115144723.7452-1-anibal.limon@linaro.org>
	<401cecf1881048e594574ca4d37c446c@XBOX03.axis.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <58e2fa07-4c32-a09d-0d26-0a810b1ef0f8@kernel.crashing.org>
Date: Fri, 15 Nov 2019 11:12:19 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <401cecf1881048e594574ca4d37c446c@XBOX03.axis.com>
Subject: Re: [PATCHv2] lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
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
X-List-Received-Date: Fri, 15 Nov 2019 17:12:44 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 11/15/19 10:29 AM, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
>> bounces@lists.openembedded.org> On Behalf Of Aníbal Limón
>> Sent: den 15 november 2019 15:47
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [PATCHv2] lib/bb: Add
>> BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
>>
>> The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a list
>> of directories to exclude when making taskhash, our specific case
>> is using SRC_URI that points local VCS directory.
>>
>> Use bb.fetch.module to set default to: "CVS .bzr .git .hg .osc .p4 .repo
>> .svn"
>>
>> Signed-off-by: Aníbal Limón <anibal.limon@linaro.org>
>> ---
>>  lib/bb/checksum.py        | 5 +++--
>>  lib/bb/fetch2/__init__.py | 4 ++--
>>  lib/bb/siggen.py          | 5 +++--
>>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> [cut]
> 
>> --- a/lib/bb/siggen.py
>> +++ b/lib/bb/siggen.py
>> @@ -123,6 +123,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
>>
>>          self.unihash_cache = bb.cache.SimpleCache("1")
>>          self.unitaskhashes = self.unihash_cache.init_cache(data, "bb_unihashes.dat", {})
>> +        self.localdirsexclude = (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUDE") or "CVS .bzr .git .hg .osc .p4 .repo .svn").split()
> 
> I don't like this construct, because if I do:
> 
> BB_SIGNATURE_LOCAL_DIRS_EXCLUDE_append = " some_dir"
> 
> it means that all of a sudden the SCM directories listed above will no 
> longer be excluded since BB_SIGNATURE_LOCAL_DIRS_EXCLUDE will now be 
> defined, but only contain " some_dir". Isn't it better to add:
> 
> BB_SIGNATURE_LOCAL_DIRS_EXCLUDE ??= "CVS .bzr .git .hg .osc .p4 .repo .svn"

I agree.. this really should be put into the bitbake.conf file in OE-core.  (I'd
also suggest adding it to the bitbake.conf file in bitbake itself, as an example.)

--Mark

> somewhere in OE-Core (and it can then also have a suitable 
> BB_SIGNATURE_LOCAL_DIRS_EXCLUDE[doc], though it seems BB_-variables 
> are only documented in meta/conf/documentation.conf)?
> 
> Alternatively, to keep the list above within bitbake, make it two 
> variables, one for the list of directories above that is not really 
> intended to be modified, and one for additional directories (which 
> should still be documented in meta/conf/documentation.conf).
> 
> //Peter
> 

