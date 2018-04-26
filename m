Return-Path: <mauro@faresoftware.it>
X-Greylist: delayed 442 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 26 Apr 2018 10:00:52 UTC
Received: from smtpcmd0756.aruba.it (smtpcmd0756.aruba.it [62.149.156.56])
	by mail.openembedded.org (Postfix) with ESMTP id AFA1B6AC37
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Apr 2018 10:00:51 +0000 (UTC)
Received: from [10.0.3.130] ([78.6.3.122])
	by smtpcmd07.ad.aruba.it with bizsmtp
	id extT1x00g2dwwGE01xtVp8; Thu, 26 Apr 2018 11:53:31 +0200
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
References: <490261f1-ed2d-286c-a75d-6798008cef2c@faresoftware.it>
	<447bb621-fe80-b89c-53ec-d366fda05375@windriver.com>
From: Mauro Ziliani <mauro@faresoftware.it>
Message-ID: <8b60a288-0044-21a5-2432-92f350aaf48c@faresoftware.it>
Date: Thu, 26 Apr 2018 11:53:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <447bb621-fe80-b89c-53ec-d366fda05375@windriver.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
	t=1524736411; bh=2mRVEMXuW3dgjDn8FTgBwLNLsZOo2v5Vavb2AqmzTBc=;
	h=Subject:To:From:Date:MIME-Version:Content-Type;
	b=fndAokEYrxhe11hbSiONK6S/fWE9CToSLp7IaxpJL0HGmNMfE2x7Xw1A42CHvdYrg
	fHSONZ7XUSA0325koATT39J/ifed5+dQkfaeNKKH3RHQt4fYGnG7iQlsgOwesJebvy
	dd5iHFjOtKOLOoRRbtnmmOMiBHFGJc1svf4RCpphqlDXsP8gM146ym8QR2g5mOTNA9
	aBkIf10h4Zfvg6pQLAwYcwn7ivPeWlf2RdtDFqy7zoZHjF4kp/olJ4be2pg6dtkNHS
	nD51mZSqT/5FjcTv9anq+vdSl5JRDO8MeqTLRuFdiWSbIIrwNkgeBAiKiRpgFM1fr/
	S8eaQa8v+w4HQ==
Subject: Re: PREFERRED_VERSION_db-native doesn't work?
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
X-List-Received-Date: Thu, 26 Apr 2018 10:00:55 -0000
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: it

Thank you for the idea.
I've not investigate deepest into allrecipes includes.


I'll try it.

Regards,
    Mauro

Il 26/04/2018 08:57, Robert Yang ha scritto:
>
> Hi,
>
> On 04/20/2018 05:42 PM, Mauro Ziliani wrote:
>> Hi all
>>
>> I'm Mauro from Parma, Italy.
>>
>> I hope this is not OT from this mailing-list.
>>
>>
>> I'm working with Krogoth 15.0.3.
>>
>> When I bitbake core-image-minimal bitbake fails compiling db-native 
>> recipe because it can't apply a patch
>>
>> This is the error.
>>
>> ERROR: db-native-6.0.30-r0 do_patch: Command Error: 'quilt --quiltrc 
>> /media/mauro/Sviluppo/CatellaniGroup/ibr115/bsp/clini5-build/tmp/sysroots/x86_64-linux/etc/quiltrc 
>> push' exited with 1  Output:
>> Applying patch fix-parallel-build.patch
>> patching file Makefile.in
>> Hunk #1 FAILED at 1034.
>> 1 out of 1 hunk FAILED -- rejects in file Makefile.in
>> Patch fix-parallel-build.patch can be reverse-applied
>>
>> So I try to compile against db-native_5.3.28 setting 
>> PREFERRED_VERSION_db-native = "5.%" in my conf/local.conf.
>
> Maybe it is because of:
>
> meta/conf/distro/include/default-versions.inc:PREFERRED_VERSION_db-native 
> = "${@incompatible_license_contains('AGPL-3.0', '5.%', '6.%', d)}"
>
> Try:
> PREFERRED_VERSION_db-native_forcevariable = "5.%"
>
> // Robert
>
>>
>>
>> But bitbake keep on running db-native_6.0.30-r0 recipe.
>>
>>
>> Why?
>>
>>
>> Best regards,
>>
>>     Mauro
>>


