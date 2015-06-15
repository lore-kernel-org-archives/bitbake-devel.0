Return-Path: <danismostlikely@gmail.com>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
	[209.85.192.170])
	by mail.openembedded.org (Postfix) with ESMTP id 393C3608B6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 14:38:13 +0000 (UTC)
Received: by pdbnf5 with SMTP id nf5so74523728pdb.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=YRR6rL1Hpi9vpxMWHINyINf1SluUrZK2Srx1V3tt/E0=;
	b=ZmZcuRGPMW1v797Xa6doLWB1whClUUP5wjZ+j9LRfzWqoRTw7ZNK3LcrDg+qfTgtMT
	vVGmHRtNj5TgNMAefLPtPl/QnTd/PceRqQiYVD1XalEScsIINsEHytAi/8sX2sjOAvF1
	ZTaRmQq7H7JuKdyEpO11/v+EHRU/L2p6Wf2biMRh6HMn9vFMGHte8ez8F9RCzo9zPnnn
	s3GNJOl3wxCkgpso7YoipKji5iBxDNPxCMIWPPrSqrc5k3272oyGVNm0jY3xd++j+EKc
	s/vCVXliD9LbeMXNH238QQCT59jmrxZn+8LewL+iWt8yV7kSHMUhdJwy/VfHDp+VaeEe
	EDDA==
MIME-Version: 1.0
X-Received: by 10.70.135.106 with SMTP id pr10mr48316184pdb.156.1434379095113; 
	Mon, 15 Jun 2015 07:38:15 -0700 (PDT)
Received: by 10.70.42.79 with HTTP; Mon, 15 Jun 2015 07:38:15 -0700 (PDT)
In-Reply-To: <557A35BC.9010801@windriver.com>
References: <1433260860-4674-1-git-send-email-danismostlikely@gmail.com>
	<1433260860-4674-2-git-send-email-danismostlikely@gmail.com>
	<556E4C1B.6080109@windriver.com>
	<CACS+7ZScXmkPeDJnsNfnkHFQfJc6XSYUbaHYVHe6wQuKs8XouQ@mail.gmail.com>
	<1434063642.28975.248.camel@linuxfoundation.org>
	<557A35BC.9010801@windriver.com>
Date: Mon, 15 Jun 2015 08:38:15 -0600
Message-ID: <CACS+7ZQhJCf1Y8tekmO0-24KttCzsPn538gE+cHozRkDf35YLA@mail.gmail.com>
From: Dan McGregor <danismostlikely@gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/hg.py: Several fixes
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
X-List-Received-Date: Mon, 15 Jun 2015 14:38:15 -0000
Content-Type: text/plain; charset=UTF-8

Sounds good to me, Robert. Let's merge yours and I'll rebase mine on
top. I was about to send a v2 of my RFC, but instead my v2 will be
based on your patch.

On 11 June 2015 at 19:28, Robert Yang <liezhi.yang@windriver.com> wrote:
>
> On 06/12/2015 07:00 AM, Richard Purdie wrote:
>>
>> On Wed, 2015-06-10 at 08:42 -0600, Dan McGregor wrote:
>>>
>>> Excellent question; I'll try that soon.
>>
>>
>> Can you both agree on which patch(es) should merge please as I'm a
>> little confused with what is currently on the list for this?
>
>
> Yes, part of our code are similar.
>
> Hi Dan,
>
> How about RP merge my patch firstly, it fixes two things:
> 1) Fix the broken hg:// protocol, it doesn't work atm.
> 2) Fix hg's MIRROR TARBALL.
>
> And then you can rebase your code, I'd like to help testing
> when you send the formal patch.
>
> // Robert
>
>>
>> Cheers,
>>
>> Richard
>>
>>
>>
>

