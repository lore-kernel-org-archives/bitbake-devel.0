Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1T02HN-0008Tl-0G
	for bitbake-devel@lists.openembedded.org;
	Sat, 11 Aug 2012 05:22:21 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7B3AT3V017305
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 10 Aug 2012 20:10:29 -0700 (PDT)
Received: from [128.224.163.142] (128.224.163.142) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Fri, 10 Aug 2012 20:10:28 -0700
Message-ID: <5025CD22.6020505@windriver.com>
Date: Sat, 11 Aug 2012 11:10:26 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <cover.1344569166.git.liezhi.yang@windriver.com>
	<9608773.T2XBm9ArBe@helios> <5025BDE5.8060805@windriver.com>
In-Reply-To: <5025BDE5.8060805@windriver.com>
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/1 V2] bitbake-whatchanged: print what is about to happen
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 11 Aug 2012 03:22:21 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit


On 08/11/2012 10:05 AM, Robert Yang wrote:
>
>
> On 08/10/2012 10:28 PM, Paul Eggleton wrote:
>> On Friday 10 August 2012 11:47:38 Robert Yang wrote:
>>> Changes of V2:
>>>
>>> * Fix a typo fn -> 'fn'
>>>
>>> * Use "bitbake -e" rather than "bitbake -e recipe" to get the BB_STAMPS_DIR
>>>
>>> * Use "BB_STAMPS_DIR=<path> bitbake -S recipe" to regenerate the stamps
>>>
>>> * Change the summary format a little, now it looks like:
>>>    - (without -v):
>>>      === Summary: (3653 changed, 1927 unchanged)
>>>      Newly added: 807
>>>      PV changed: 48
>>>      PR changed: 276
>>>      Depends changed: 2522
>>>
>>>    - (with -v):
>>>      === Summary: (3653 changed, 1927 unchanged)
>>>      Newly added: 807
>>>      Depends changed: 2846
>>>
>>> // Robert
>>>
>>> The following changes since commit 2dec760b79bb7e2e79c33c5127fa64685bd86a18:
>>>
>>>    foomatic: fix perl path for target (2012-08-08 10:06:00 +0100)
>>
>> So leaving Chris's objections aside for a moment, I applied this and the
>> BB_STAMPS_DIR change, and ran the script on my build directory which is out of
>> date with respect to the metadata (i.e. metadata has been updated since the
>> last build). The output seems to suggest that no changes have been made, which
>> is not the case:
>>
>
> Thanks Paul, did you re-run the oe-init-build-env, please? Otherwise the
> BB_STAMPS_DIR would have no effect since it would not  be in the BB_ENV_EXTRAWHITE.
>

It seems that you had re-run the oe-init-build-env since when no BB_STAMPS_DIR
it would print errors., I think that the problem is  the "bitbake -S" didn't
work well since it has bugs, I have updated the related code a little, and it
would tell what's wrong:

         # FIXME
         # The "bitbake -S" may fail, not fatal error, the stamps will still
         # be generated, this might be a bug of "bitbake -S".
         try:
             bb.process.run(cmdline)
         except Exception as exc:
             print(exc)

I have pushed it to git repo, it would be great if you can help me to test it,
and I will invite you beer when you come to Beijing:-)

// Robert

> // Robert
>
>> ----------- snip -----------
>> $ bitbake-whatchanged core-image-minimal
>> Figuring out the BB_STAMPS_DIR ...
>> Generating the new stamps ... (need several minutes)
>>
>> === Summary: (0 changed, 0 unchanged)
>> Newly added: 0
>> PV changed: 0
>> PR changed: 0
>> Depends changed: 0
>> ----------- snip -----------
>>
>> Cheers,
>> Paul
>>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>
>


