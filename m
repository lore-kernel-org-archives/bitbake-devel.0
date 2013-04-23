Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>)
	id 1UUZnf-0001Xy-Mj; Tue, 23 Apr 2013 11:46:13 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r3N9SRlA005373
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 23 Apr 2013 02:28:27 -0700 (PDT)
Received: from [128.224.162.186] (128.224.162.186) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.342.3;
	Tue, 23 Apr 2013 02:28:26 -0700
Message-ID: <51765437.2090409@windriver.com>
Date: Tue, 23 Apr 2013 17:28:23 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1366640172.23738.12.camel@ted> <51758B94.8010405@linaro.org>
	<1366707875.23738.40.camel@ted>
In-Reply-To: <1366707875.23738.40.camel@ted>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] BitBake changes in the Yocto Project 1.5 cycle
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
X-List-Received-Date: Tue, 23 Apr 2013 09:46:27 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit



On 04/23/2013 05:04 PM, Richard Purdie wrote:
> On Mon, 2013-04-22 at 21:12 +0200, Marcin Juszkiewicz wrote:
>> W dniu 22.04.2013 16:16, Richard Purdie pisze:
>>> I've been giving some thought to where BitBake needs to go in the
>>> future in order to deliver for its users. It started life as a
>>> commandline utility and its grown a lot since it was first created.
>>> I think there are some key decisions that need to be taken to ensure
>>> its future growth.
>>
>> There is one thing which kind of bothers me. "ERROR" message which is
>> just a warning. Like:
>>
>> ERROR: libelf is listed in PACKAGES multiple times, this leads to packaging errors.
>> ERROR: libasm is listed in PACKAGES multiple times, this leads to packaging errors.
>> ERROR: libdw is listed in PACKAGES multiple times, this leads to packaging errors.
>> ERROR: libdw-dev is listed in PACKAGES multiple times, this leads to packaging errors.
>> ERROR: libasm-dev is listed in PACKAGES multiple times, this leads to packaging errors.
>> ERROR: libelf-dev is listed in PACKAGES multiple times, this leads to packaging errors.
>>
>> If it is error then let BitBake exit instead of doing task. If it is
>> not error but just a warning then let it be renamed?
>
> What we're trying to do is move everything to use a standard mechanism
> for reporting issues of this type. With insane.bbclass, you can elect
> whether a given type of error is a warning or errors and fails the task.
>
> There are however several places where bb.error is used without that
> mechanism. I'd love to see them fixed, please file a bug for it...
>

Filed a bug:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=4396

>> My recent build failed with:
>>
>> --------
>> NOTE: recipe linaro-image-minimal-1.0-r0: task do_rm_work_all: Started
>> NOTE: recipe linaro-image-minimal-1.0-r0: task do_rm_work_all: Succeeded
>> NOTE: Tasks Summary: Attempted 2247 tasks of which 915 didn't need to be rerun and all succeeded.
>>
>> Summary: There were 3 WARNING messages shown.
>> Summary: There were 6 ERROR messages shown, returning a non-zero exit code.
>> Build step 'Execute shell' marked build as failure
>> --------
>>
>> "all succeeded" does not look like a reason to fail a build.
>
> Agreed, please open a bug for it.
>

Filed another bug:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=4398

// Robert

> FWIW Bitbake will set a non-zero exit code if any error messages appear,
> as the message says. Whilst people find that confusing, I continue to
> believe it is the right thing to be doing and we need to tighten up
> things in other places as I describe above. That error code does help us
> catch problems on the autobuilders and so forth.
>
> Cheers,
>
> Richard
>
>
>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>
>


