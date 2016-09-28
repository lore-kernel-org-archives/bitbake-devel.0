Return-Path: <akuster@mvista.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id A13CE60079
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Sep 2016 15:25:38 +0000 (UTC)
Received: by mail-pa0-f49.google.com with SMTP id dw4so4059436pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Sep 2016 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding;
	bh=Bv3hQooG+Aza49gF4eDBUm2Ivu7+eWM7trvE1EdPdpk=;
	b=tQOfkEyQzDz1x+rQa88jB81xL4NAUo6D++JfNNOXecUNeN7sycdT/YNRmpmlH29jA+
	6/XPIl1AenGrNA5to1pvihwiKYjajS6c1+a4+vlEnrw22isVKabfkDAu0K5g/xrvH2BC
	TXi87aZBCA5ujreR3FTNdQaUaLwMUskxXwx/2NW1HB9DK0F9+QkZb8HEww2kvFODOthI
	tyt4Q0HkzNeawTrbsFVWlVvRO1cPRgQOV4HRXMZxBN9Q115vn6fTwpEQeH2nONCooRp6
	wlUQnFq69zy+WrvoikiLDJpwnlTUOM1YBQ1HY5N0eIuP46gCNGKu9dE8e79LzGPtFtS2
	PWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=Bv3hQooG+Aza49gF4eDBUm2Ivu7+eWM7trvE1EdPdpk=;
	b=UGPXt5F4VB3DuyNdX+gRJCvisUWOCk6qbanvCMEkeW5ipJnZn3OivfpK3Rhoqc/Uuf
	jRsgJ+INMsye7rwSXkqAxFN4R/dL8IkoiamlOubGr59grP0QhYpoRVkWsx/2R+PFRwto
	htuHMDAawzIOb+3PKLCqql5r1jWX+Qn2qdvu2fOMiV0xaXgBBadmrFAjYO7sSB1FWlhE
	5cc1JCJnUpGV925A6J8c+HijBGzpeEW1CEHgYN2fm7ZdCLwQksBTn7F5VB4vAv2qO1Gb
	l0O4JMOdnMeJaRsJQpYESfjgokXVf5dOgwdLvB61MK4tQypec9HKrqsDV0XCs5uxU0nf
	bnPw==
X-Gm-Message-State: AE9vXwPaq30M1+rAJOv0gsdbP3ZiJOApo9mQ3XW98FqBE7sTwwsFCmyxwn6JMVPL/fVsIWeU
X-Received: by 10.66.1.36 with SMTP id 4mr58009276paj.56.1475076339598;
	Wed, 28 Sep 2016 08:25:39 -0700 (PDT)
Received: from ?IPv6:2601:202:4001:9ea0:8d18:8d09:2d56:eaa1?
	([2601:202:4001:9ea0:8d18:8d09:2d56:eaa1])
	by smtp.gmail.com with ESMTPSA id
	h82sm13495451pfh.22.2016.09.28.08.25.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 28 Sep 2016 08:25:39 -0700 (PDT)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Armin Kuster <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org
References: <1475075217-17547-1-git-send-email-akuster808@gmail.com>
	<1475075668.30475.72.camel@linuxfoundation.org>
From: akuster <akuster@mvista.com>
Message-ID: <49f3c7f6-b330-b11d-e5c5-7a96b2e2a367@mvista.com>
Date: Wed, 28 Sep 2016 08:25:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1475075668.30475.72.camel@linuxfoundation.org>
Subject: Re: [PATCH] codeparser: Use hashlib for hashing, not hash()
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
X-List-Received-Date: Wed, 28 Sep 2016 15:25:38 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/28/2016 08:14 AM, Richard Purdie wrote:
> On Wed, 2016-09-28 at 08:06 -0700, Armin Kuster wrote:
>> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>>
>> "hash() is randomised by default each time you start a new instance
>> of
>> recent
>> versions (Python3.3+) to prevent dictionary insertion DOS attacks"
>>
>> which means we need to use hashlib.md5 to get consistent values for
>> the codeparser cache under python 3. Prior to this, the codeparser
>> cache was effectively useless under python3 as shown by performance
>> regressions.
>>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> (cherry picked from commit 12d43cf45ba48e3587392f15315d92a1a53482ef)
>>
>> We kept running into an issue where shell scripts were not
>> getting generated on 32bit hosts. It seemed to be caused by this
>> code.
> I'm puzzled. This patch is in master. I'm therefore assuming you're
> suggesting this for 1.30 but it doesn't say that anywhere.

We made a similar change in our bitbake sources for 1.28 which needed to 
be submitted per the Yocto compatible requirements.   I could have sent 
that one but then you might have said "Hey, this looks like the one in 
Master, why are you not using that one?".   I personally like to 
reference upstream official fixes than hand crafted ones that achieve 
the same result. I can send you the one we did if you want.

>
> 1.30 isn't python3 based and therefore doesn't have the problem
> described above?

This fixed an issue we found building on 32bit hosts.

- Armin
>
> Cheers,
>
> Richard
>


