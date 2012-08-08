Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1Sz2x9-0002qH-HX
	for bitbake-devel@lists.openembedded.org;
	Wed, 08 Aug 2012 11:53:23 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q789fY1f017451
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 8 Aug 2012 02:41:34 -0700 (PDT)
Received: from [128.224.163.142] (128.224.163.142) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 8 Aug 2012 02:41:34 -0700
Message-ID: <5022344C.9070008@windriver.com>
Date: Wed, 8 Aug 2012 17:41:32 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:13.0) Gecko/20120615 Thunderbird/13.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1344346253.git.liezhi.yang@windriver.com>
	<16599840.OqlgMUDr4l@helios> <1344373262.9756.300.camel@ted>
	<5021DF9E.3090709@windriver.com> <1344417719.9756.324.camel@ted>
In-Reply-To: <1344417719.9756.324.camel@ted>
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/1] bitbake-whatchanged: print what is about to happen
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
X-List-Received-Date: Wed, 08 Aug 2012 09:53:23 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 08/08/2012 05:21 PM, Richard Purdie wrote:
> On Wed, 2012-08-08 at 11:40 +0800, Robert Yang wrote:
>>>> 2) I'm a little concerned with the general approach - is there no way of
>>>> avoiding having to copy and move around the stamps directory? It seems
>>>> a little risky if nothing else.
>>>
>>> I think adding a parameter to -S would be a good move for this, its
>>> something people likely want in conjunction with that.
>>>
>>
>> Yes, add a parameter to "bitbake -S recipe" would be the correct way, but
>> as far as I know, the "-S" is a bool option currently, it doesn't accept
>> an argument, I think that we have the following 2 solutions:
>>
>> 1) Modify the "-S" to accept an argument, but this may break the the usage
>>      of the "bitbake -S", the currently usage is:
>>
>>      bitbake -S <recipe>
>>
>>      We may change it to:
>>
>>      bitbake -S <tmpdir>(or stampsdir) <recipe>
>>
>>      But it seems that it's not easy differentiate the argument behind "-S".
>
> Hmm, we probably could change this option as long as we update the
> manuals too. Ideally I would like some way to say "use the default
> stamps directory" without having to put a full path in.
>
>> 2) Use "TMPDIR(or STAMP)=<path> bitbake -S recipe", but we don't support it
>>      currently, but we can add an os.getenv("TMPDIR") in bitbake to achieve it,
>>      the BB_TMPDIR or BB_STAMP would be better, but I'm not sure whether it will
>>      cause other problems.
>>
>> I'd like to send a patch for 2) if you are OK with it.
>
> Please don't use TMPDIR, bitbake has no knowledge of that variable, nor
> should it have and it will change the cache directory. I'd suggest using
> STAMP, that is what the variable is designed for. We just need to allow
> it from the environment which Paul mentions and this is what I
> originally proposed.
>
> I'm leaning towards 2) and STAMP with BB_ENV_WHITELIST (or whatever the
> variable is called) updated accordingly.
>

Thank you very much, the STAMP is:

STAMP = "${TMPDIR}/stamps/${MULTIMACH_TARGET_SYS}/${PF}"

How about add a variable STAMP_DIR, it would be:

STAMP_DIR ?= "${TMPDIR}/stamps/"
STAMP = "${STAMP_DIR}/${MULTIMACH_TARGET_SYS}/${PF}"

Then add STAMP_DIR to BB_ENV_WHITELIST and we can run bitbake -S like:
STAMP_DIR=/what/we/want bitbake -S

Thanks

// Robert


> Cheers,
>
> Richard
>
>
>



