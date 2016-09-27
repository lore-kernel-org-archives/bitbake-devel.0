Return-Path: <akuster808@gmail.com>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
	[209.85.220.66])
	by mail.openembedded.org (Postfix) with ESMTP id 548A960248
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 18:43:02 +0000 (UTC)
Received: by mail-pa0-f66.google.com with SMTP id my20so1027123pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding;
	bh=VN+3DtXzIO0Fe4IuLIBgqRV5K+FlfNhWFOdDeDtHxFc=;
	b=gtpSbwiHENk4Fpz1Drupki2C7U2N3HQObCfcUTipnufckrPud3mJGn6xlm0FY+V/Rf
	dMXHcP5dtdR6gOtB51U7yU8q1GF82nxTeF9mJAOBc6O5hERongq4TU1WVhKT6SOx2mPc
	HD8dHH56P8/vTSDygHzd1yQiVhJ6Lc64S5//qBCG96HHywMAn62G2KFkK26sGa65aB1A
	U6e59FTfWpymXAiakVAKa9AuwlUAoS2KwQWEogC8wwGTRfVpUIhXlMLcA0peIsrXMnFk
	btG5FouVWlpW1iHzbv2N1RLlRJpX0nAANyJtDyeKSy/un/r7OdSEKfGR3meZlx2swfLL
	nNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=VN+3DtXzIO0Fe4IuLIBgqRV5K+FlfNhWFOdDeDtHxFc=;
	b=lYTI0JS6+ucRRdh3G8ilfbhfPg/Ya8sGEp4SRkFVC1/a/bBYvx/BlGGU1CLksqrnX6
	HsUEI9fZGbFxN6AoLVlr5AAj3i5nFHxyabdkvpEym35FlXHoCXjeIghV6k6uzorwZj6k
	Pyz+fQa9uGXkbkUItnsny/YylDvdoH5/pp8FqeuneGzUejMHfCIZyXJobRkzN6zWKSD1
	oNkADFu1LPTksqf0pOZGQxLRxUuolSmmgvR8MB8Y/X1coJNYTpMCqxv1K5nLtGH6wAq5
	noUxjLKQF1+ZZ0Akpd91qTxIhBRsCZTmli1jT+k+U7xj7W4tMP8D9j5ruFublxb2ANv7
	usxA==
X-Gm-Message-State: AE9vXwM8k21lPjAIX9fwmSlTmBPu+ukP2E10UXX5Fpn6CdOEzFPl1ErvkUZsOgncVw8qWA==
X-Received: by 10.67.7.170 with SMTP id dd10mr50645227pad.152.1475001783540;
	Tue, 27 Sep 2016 11:43:03 -0700 (PDT)
Received: from [10.22.11.190] (50-233-148-156-static.hfc.comcastbusiness.net.
	[50.233.148.156])
	by smtp.gmail.com with ESMTPSA id j1sm6597006pfg.95.2016.09.27.11.43.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Sep 2016 11:43:03 -0700 (PDT)
To: Stefan Lengfeld <s.lengfeld@phytec.de>,
	bitbake-devel@lists.openembedded.org
References: <1474373528-5865-1-git-send-email-s.lengfeld@phytec.de>
	<20160927081311.GA3984@lws-christ>
From: akuster808 <akuster808@gmail.com>
Message-ID: <c02e1cc0-e211-1164-7d1c-233307d40fba@gmail.com>
Date: Tue, 27 Sep 2016 11:43:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160927081311.GA3984@lws-christ>
Subject: Re: [PATCH krogoth] bitbake: fetch: copy files with -H
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
X-List-Received-Date: Tue, 27 Sep 2016 18:43:03 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/27/2016 01:13 AM, Stefan Lengfeld wrote:
> Hi,
>
> *ping.
>
> Is there a way I can help to speed up the backport of this patch to krogoth?
Good German beer might help ; )

I pulled this in and running a few local builds. it is my staging branch

- armin
> Should I send the patch to a different mailing list? Thanks.
>
> Mit freundlichen Grüßen / Kind regards,
> 	Stefan Lengfeld
>
> On Tue, Sep 20, 2016 at 02:12:08PM +0200, Stefan Lengfeld wrote:
>> From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
>>
>> When using a PREMIRROR with plain (non-unpack) files, a SRC_URI like
>>
>> SRC_URI = "file://devmem2.c"
>>
>> will cause devmem2.c to be a symlink in the WORKDIR pointing to the
>> local PREMIRROR.
>>
>> Trying to apply a patch on this file will either modify the file on
>> the PREMIRROR or will fail due to sanity checks:
>>
>> ERROR: devmem2-1.0-r7 do_patch: Command Error: 'quilt --quiltrc /cache/build-ubuntu/sysroots/x86_64-oe-linux/etc/quiltrc push' exited with 1  Output:
>> Applying patch devmem2-fixups-2.patch
>> File devmem2.c is not a regular file -- refusing to patch
>>
>> (Bitbake rev: cfd481fe9799e7a4c6bfac32e56cc91cfcd81088)
>>
>> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> ---
>> Hi,
>>
>> this patch was already applied on poky's master branch. Can you please backport
>> it to krogoth. The bug is there, too. I already posted a different patch some
>> time ago:
>>
>>      http://lists.openembedded.org/pipermail/bitbake-devel/2016-June/007621.html
>>
>> Thanks.
>>
>> Kind regards,
>> 	Stefan Lengfeld
>> ---
>>   bitbake/lib/bb/fetch2/__init__.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
>> index 6ef0c6f..7773c16 100644
>> --- a/bitbake/lib/bb/fetch2/__init__.py
>> +++ b/bitbake/lib/bb/fetch2/__init__.py
>> @@ -1424,7 +1424,7 @@ class FetchMethod(object):
>>                       if urlpath.find("/") != -1:
>>                           destdir = urlpath.rsplit("/", 1)[0] + '/'
>>                           bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
>> -                cmd = 'cp -fpPR %s %s' % (file, destdir)
>> +                cmd = 'cp -fpPRH %s %s' % (file, destdir)
>>   
>>           if not cmd:
>>               return
>> -- 
>> 1.9.1
>>
>> -- 
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


