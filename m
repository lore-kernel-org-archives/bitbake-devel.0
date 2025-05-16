Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D0AC3ABC9
	for <webhook@archiver.kernel.org>; Fri, 16 May 2025 17:29:26 +0000 (UTC)
Received: from esa4.hc324-48.eu.iphmx.com (esa4.hc324-48.eu.iphmx.com [207.54.71.48])
 by mx.groups.io with SMTP id smtpd.web11.19025.1747416556282833090
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 May 2025 10:29:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=nl75WkoC;
 spf=pass (domain: bmw.de, ip: 207.54.71.48, mailfrom: prvs=2247c1a3e=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1747416555; x=1778952555;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=kvSi1mW9tGU+lBH3/wnlgF9ZqsSsFekbbuxhaYrlQXo=;
  b=nl75WkoCJYiik0thTbkXiDUj458GfwLFyWWFy0rhgxtJsUqPLhCZinRG
   onD+UuF5Mv2r+RG6RXSW6JiZDtteLMLWgG9Wv02GcLF6MAMFcBBw+LkSl
   msg2MsA9uQooU6BIBvQHRuMUFwdRC93abs952gWewXxhMKCWAe0k5FEmO
   w=;
X-CSE-ConnectionGUID: QpA9oKpdTzuc3Kb3A+Peqg==
X-CSE-MsgGUID: E/GoLgebQO6BzysYfceuog==
Received: from 160.46.252.49.spf.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa4.hc324-48.eu.iphmx.com with ESMTP/TLS; 16 May 2025 19:29:13 +0200
Received: from esabb2.muc ([160.50.100.34])  by esagw6.muc with ESMTP/TLS;
 16 May 2025 19:29:13 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb2.muc with ESMTP/TLS; 16 May 2025 19:29:14 +0200
Received: from [10.242.8.12] (10.30.85.210) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 16 May 2025 19:29:13 +0200
X-CSE-ConnectionGUID: SflgWhenTuSobWMVAHbdCg==
X-CSE-MsgGUID: nvuOadl6R/KCshKyqZN3FQ==
X-CSE-ConnectionGUID: pkCeKA5RToe/upcxMCfRkg==
X-CSE-MsgGUID: EfVaVFZ8RN6P8Qv4VDJWTg==
Message-ID: <91dd9a83-5139-4f5d-ad51-e3840271f258@bmw.de>
Date: Fri, 16 May 2025 19:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 1/1] siggen: Support non-compressed
 sigdata files
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20250515144455.2799533-1-philip.lorenz@bmw.de>
 <20250515144455.2799533-2-philip.lorenz@bmw.de>
 <9433a345bc4be0d854ed651e67ab03ac2e69104e.camel@linuxfoundation.org>
CC: <bitbake-devel@lists.openembedded.org>
From: Philip Lorenz <philip.lorenz@bmw.de>
In-Reply-To: <9433a345bc4be0d854ed651e67ab03ac2e69104e.camel@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SMUCMP12B.europe.bmw.corp (2a03:1e80:a15:58f::1:28) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 May 2025 17:29:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17621

Hi Richard,

On 16.05.25 08:39, Richard Purdie wrote:
> On Thu, 2025-05-15 at 16:44 +0200, Philip Lorenz via lists.openembedded.org wrote:
>> Compression utilities such as `zstd` can achieve significant compression
>> ratio improvements even when the low entropy data is spread over a
>> larger input window. As a result compressing a tarball containing
>> uncompressed sigdata files with zstd can reduce the amount by a factor
>> of 6-16.
>>
>> Support this by introducing the `BB_SIGDATA_COMPRESSION` variable which
>> can be used to control compression of sigdata files. Setting the
>> variable to "none" disables compression, setting it to "zstd" (its
>> default value) retains the current behaviour.
>>
>> All functions used to consume sigdata files are extended to
>> automatically detect whether input files are compressed and
>> transparently select the correct behaviour depending on that.
>>
>> Additionally, expose the compression paramater in all functions to
>> enable overriding the global setting in some scenarios (e.g. for
>> .siginfo files created by sstate.bbclass).
>>
>> Compression results for core-image-sato sigdata files produced using
>> `bitbake -S none core-image-sato` on poky
>> 122e9a49614b2ddedaae1d90c06004a7a4c43998.
>>
>> Tarball containing compressed sigdata files: 98 MB
>> Compressed tarball (zstd -3) containing compressed sigdata files: 76 MB
>> Compressed tarball (zstd -17) containing compressed sigdata files: 65 MB
>> Tarball containing uncompressed sigdata files: 310 MB
>> Compressed tarball (zstd -3) containing uncompressed sigdata files: 12 MB
>> Compressed tarball (zstd -17) containing uncompressed sigdata files: 4 MB
>>
>> Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
>> ---
>>   lib/bb/siggen.py | 84 +++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 76 insertions(+), 8 deletions(-)
> Whilst this improves the "tarball up a stamps directory" workflow, it
> comes at the expense of a significant amount more IO and disk usage of
> the build tree during the build itself. For that reason, I'd not
> recommend anyone to be running with this set by default or in general.

I benchmarked these changes and couldn't find a significant difference 
in both IO (my test core-image-sato-minimal build causes 80GB disk 
writes) and build time with uncompressed files. Disk usage of the 
.sigdata files increases by a factor of 3 (in our typical builds this 
boils down to 400 MB added) which is a trade off that we're willing to 
accept in the CI context. Are there any code paths that I'm missing 
where this would cause significant slow downs / disadvantages?

> I'm not a big fan of adding config options which add non-default
> workflows, mainly due to the doubling of the test matrix and the fact
> that one of the code paths ends up stale/broken.
I fully understand that (in particular because this change is mainly 
beneficial in one particular context). I wanted to share to see if there 
is interest from others, if there isn't its completely understandable to 
reduce complexity.
> Further, once you expose this to the siginfo files, you then have to
> either add multiple queries for sstate objects, or have extra
> configuration to setup sstate feeds. I'm not sure either is a good
> outcome. This would also imply there would be a further patch to adapt
> the code in oe-core to use this new option for the siginfo files and
> again, this is complexity I'd really prefer simply not to have.

For feeds nothing would change. I didn't include the patch to oe-core 
(which would use the exposed compression parameter) before the 
applicability of the main patch was discussed.

Thanks,

Philip

-- 
Philip Lorenz
BMW Car IT GmbH, Software-Plattform, -Integration Connected Company, Lise-Meitner-Straße 14, 89081 Ulm
-------------------------------------------------------------------------
BMW Car IT GmbH
Management: Michael Böttrich, Chris Brandt, Christian Salzmann
Domicile and Court of Registry: München HRB 134810
-------------------------------------------------------------------------


