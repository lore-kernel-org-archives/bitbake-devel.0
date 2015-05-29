Return-Path: <twoerner@gmail.com>
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com
	[209.85.223.176])
	by mail.openembedded.org (Postfix) with ESMTP id 49041756C1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 May 2015 18:21:17 +0000 (UTC)
Received: by iepj10 with SMTP id j10so68915955iep.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 May 2015 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=C9pETXCWstnLc29OM1wcTmR34H+u+GVbTPo0xpIeG1c=;
	b=BT9WZRR4wp8bpJkZ43WoeTHidja6sbqYQQ5NyCQiQZYvDmqvUOsZU0Xjd0L9hUIFxU
	50tRptlYIX2qllolXS/5vKzwPzi55zMj5kSEI/MjQXLTdqf/8BaRC/BPD8SVn4u1+kOr
	axrhWAYecUFVZkdvdW4pK5675HRqU+R/dw25I8K0ttc1hkEl1c4pymzn7SZv0uhP7H/G
	QeSs05fl69BY4EKU3jaAb71bzDC/aSx3NF2o1vIojUZsiD9fWoS9SAfQunxte32ksEr2
	clnd93/ledsOxaCptgJQECvdgAxGn/C9oWiN6u5zjEF2CjGRPm0NEblfLn8qRJ1JXRyZ
	supw==
X-Received: by 10.50.30.137 with SMTP id s9mr5739922igh.11.1432923679054;
	Fri, 29 May 2015 11:21:19 -0700 (PDT)
Received: from [192.168.141.85] (dsl-67-55-28-109.acanac.net. [67.55.28.109])
	by mx.google.com with ESMTPSA id
	85sm3351577iom.25.2015.05.29.11.21.18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 29 May 2015 11:21:18 -0700 (PDT)
Message-ID: <5568AE1C.3010407@gmail.com>
Date: Fri, 29 May 2015 14:21:16 -0400
From: Trevor Woerner <twoerner@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <555FA65A.1020505@gmail.com>
	<7025804.ZvuMXxFa1D@peggleto-mobl.ger.corp.intel.com>
In-Reply-To: <7025804.ZvuMXxFa1D@peggleto-mobl.ger.corp.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake-layers layerindex-fetch
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
X-List-Received-Date: Fri, 29 May 2015 18:21:19 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hi Paul,

On 05/26/15 09:51, Paul Eggleton wrote:
> Hi Trevor,
>
> On Friday 22 May 2015 17:57:46 Trevor Woerner wrote:
>> I'm curious to know what heuristic "bitbake-layers layerindex-fetch"
>> uses to determine where to place the fetched layers?
>>
>> I asked my system to:
>>
>>   $ bitbake-layers layerindex-fetch meta-qt5
>>
>> and it keeps insisting on installing meta-qt5 and meta-openembedded
>> under my openembedded-core layers resulting in:
>>
>>   /z/master/layers/openembedded-core/meta-openembedded/meta-ruby \
>>   /z/master/layers/openembedded-core/meta-qt5 \
>>
>> Is there a way that I can tell bitbake-layers that my layers are located
>> at /z/master/layers and have it work from there?
> This is controlled by BBLAYERS_FETCH_DIR; by default this is set to 
> "${COREBASE}" with ??= so you can set it to your preferred value in local.conf 
> as desired.

Awesome, thanks! :-)

>  (We should definitely document this, I acknowledge at the moment it 
> isn't documented anywhere.)
>

I've sent a patch for the Bitbake User's Manual.

