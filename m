Received: from mail-ww0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dbaryshkov@gmail.com>)
	id 1R8xuy-0002Fw-B1; Wed, 28 Sep 2011 19:27:36 +0200
Received: by wwf27 with SMTP id 27so7464766wwf.24
	for <multiple recipients>; Wed, 28 Sep 2011 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=qP/ZN5t/BOZZlaG65+4D7lBBtjBG0etPuhGIvkSnuL4=;
	b=mh8CRKZMTREyCXTsdrenlvr+phiPALNDGPmGKRH93janT6NkFHC8UEERyaR2oYx2er
	sXRCmzyz1oeqkj0ZQOuKqoBbzVw5nTIUxUS7TPQLz0vRr/691JZCtKPFtPn0eOwGBJEA
	cX1R4cG7M59UnXxgZVoHvniSeytChaAK+q108=
Received: by 10.227.203.193 with SMTP id fj1mr8488446wbb.42.1317230529714;
	Wed, 28 Sep 2011 10:22:09 -0700 (PDT)
Received: from [137.202.140.192] (nat-rup.mentorg.com. [139.181.168.34])
	by mx.google.com with ESMTPS id k26sm38401657wbo.16.2011.09.28.10.22.08
	(version=SSLv3 cipher=OTHER); Wed, 28 Sep 2011 10:22:08 -0700 (PDT)
Message-ID: <4E835785.9090705@gmail.com>
Date: Wed, 28 Sep 2011 21:21:09 +0400
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.21) Gecko/20110831 Iceowl/1.0b2 Icedove/3.1.13
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <CALT56yN5hXMLBhHVLKyHbNb=7WDb3pZUB0Q+HNKc-2t+g6M58A@mail.gmail.com>
	<201109281116.00890.paul.eggleton@linux.intel.com>
	<4E831868.4090603@gmail.com>
	<201109281432.57331.paul.eggleton@linux.intel.com>
In-Reply-To: <201109281432.57331.paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] meta-micro problems
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
X-List-Received-Date: Wed, 28 Sep 2011 17:27:36 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/28/2011 05:32 PM, Paul Eggleton wrote:
> On Wednesday 28 September 2011 13:51:52 Dmitry Eremin-Solenikov wrote:
>> If you wish, I can retry this with smaller layer set. But if the bug
>> will still arise, I simply have no knowledge/time to look deeper into bb
>> without additional input/pointers from bb gurus.
>
> That's OK, I can spend time looking into it. It sounds like a bug in bitbake
> if metadata can influence it to behave this way. If we can produce a simplified
> test case I think it will be easier to fix.

In my test setup I could no longer reproduce this. I'll try reproducing 
this on my main builder.

-- 
With best wishes
Dmitry



