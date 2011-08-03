Received: from mail-pz0-f43.google.com ([209.85.210.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1QoQzg-0007TH-Oh
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 04:15:36 +0200
Received: by pzk1 with SMTP id 1so666965pzk.16
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 02 Aug 2011 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=V1bOsKeyiBrAVMUmhh5iY4RvBVUOhKSaNyTMhWIJZU0=;
	b=w4CnWW6IYCV5Tw04i93jTkU4hxbjnaU1Y3TUT3ZCTi4iSIjuFnVWoenyaoxr8Gd44R
	9QlGmWeyqvb2NysT1rlMiDQCcJ+vgnR3kBK87Lglcxy7JDEbCL6L6tEX0AyRTK56kA5n
	O3kG3pk4HrQpaORNV24oFwed+UmnvPst4i9+8=
Received: by 10.142.143.17 with SMTP id q17mr4333596wfd.261.1312337474150;
	Tue, 02 Aug 2011 19:11:14 -0700 (PDT)
Received: from [192.168.1.70] (99-57-141-118.lightspeed.sntcca.sbcglobal.net
	[99.57.141.118])
	by mx.google.com with ESMTPS id g4sm466727pbj.57.2011.08.02.19.11.13
	(version=SSLv3 cipher=OTHER); Tue, 02 Aug 2011 19:11:13 -0700 (PDT)
Message-ID: <4E38AE40.5080206@gmail.com>
Date: Tue, 02 Aug 2011 19:11:12 -0700
From: Khem Raj <raj.khem@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <359B10B9B28B294BAA6405D9320312E0111E93405D@naemmail08.na.leapfrog.com>
	<CABcZANmNObv54E4yW52t1wYt6pyranwAS5Hth8S1cF61ZM5N=g@mail.gmail.com>
In-Reply-To: <CABcZANmNObv54E4yW52t1wYt6pyranwAS5Hth8S1cF61ZM5N=g@mail.gmail.com>
Subject: Re: Bug with clearing SRCREV cache
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
X-List-Received-Date: Wed, 03 Aug 2011 02:15:37 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/02/2011 06:24 PM, Chris Larson wrote:
> On Tue, Aug 2, 2011 at 12:06 PM, Daniel Lazzari<dlazzari@leapfrog.com>  wrote:
>> I’m not exactly sure if this is an oe-core or a bitbake bug, so I’m trying
>> here first. I noticed the other day that one of our recipes that pulls
>> source from svn and uses SRCREV = “AUTOINC” wasn’t pulling the latest
>> revision even after a cleanall. After a lot of digging, I discovered that
>> fetcher_init() was clearing the srcrev cache in “tmp-angstrom_2010_x “
>> rather than “tmp-angstrom_2010_x-uclibc”. It appears that the following line
>> in persist_data.py is the culprit:
>>
>>
>>
>>      cachedir = (bb.data.getVar("PERSISTENT_DIR", d, True) or
>>
>>                  bb.data.getVar("CACHE", d, True))
>>
>>
>>
>> PERSISTENT_DIR doesn’t evaluate to the correct value. Changing it to just
>> pull from CACHE seems to fix it, but I’m not sure how important
>> PERSISTENT_DIR is or even what it does.
>
> What do you mean by "the correct value" here? PERSISTENT_DIR is
> exactly what it sounds like, the location where persist_data stores
> its database(s), that's it.

Actually in oe-core, original TMPDIR gets appended

meta/conf/distro/defaultsetup.conf:TCLIBCAPPEND ?= "-${TCLIBC}"
meta/conf/distro/defaultsetup.conf:TMPDIR_append = "${TCLIBCAPPEND}"

but this probably happens late in the parse cycle. So it creates

bb_codeparser.dat  bb_persist_data.sqlite3

in both TMPDIR and TMPDIR-uclibc or TMPDIR-eglibc whatever libc you are 
using.

Ideally I would have thought that TMPDIR is evaluated to final value 
before its used

Thanks
-Khem


