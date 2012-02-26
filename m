Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S1nNg-0006Mq-51
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 00:19:52 +0100
Received: by eaae1 with SMTP id e1so353055eaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Feb 2012 15:11:23 -0800 (PST)
Received-SPF: pass (google.com: domain of martin.jansa@gmail.com designates
	10.213.31.134 as permitted sender) client-ip=10.213.31.134; 
Authentication-Results: mr.google.com;
	spf=pass (google.com: domain of martin.jansa@gmail.com
	designates 10.213.31.134 as permitted sender)
	smtp.mail=martin.jansa@gmail.com;
	dkim=pass header.i=martin.jansa@gmail.com
Received: from mr.google.com ([10.213.31.134])
	by 10.213.31.134 with SMTP id y6mr3317958ebc.1.1330297883975 (num_hops
	= 1); Sun, 26 Feb 2012 15:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=resent-from:resent-date:resent-message-id:resent-to:mime-version
	:in-reply-to:references:date:delivered-to:message-id:subject:from:to
	:content-type; bh=YmFrJ9y23PawQ9Z/S2EnzyfwAvbPILbUBubQxqWxQFo=;
	b=nxDoYJQq9OSQ714iHuYWVC8x2DtkG8h44xlcx0Al/nI7AzBDGq8o+p7rCw1YFavDEh
	/R2NaApJFK2lggggdZ8ryu/Fp++Ta0THeNM8TUwwaLpvzGWfH+33G++3y/3VwKLcLL0g
	AFabEsoewa1LZ+82aAjzfQTwHWu/JUeQWxUrU=
Received: by 10.213.31.134 with SMTP id y6mr2497876ebc.1.1330297883861;
	Sun, 26 Feb 2012 15:11:23 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id w60sm50702537eeb.4.2012.02.26.15.11.22
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sun, 26 Feb 2012 15:11:23 -0800 (PST)
Resent-From: Martin Jansa <Martin.Jansa@gmail.com>
Resent-Date: Mon, 27 Feb 2012 00:11:21 +0100
Resent-Message-ID: <20120226231121.GB3859@jama.jama.net>
Resent-To: bitbake-devel@lists.openembedded.org
MIME-Version: 1.0
Received: by 10.236.63.180 with HTTP; Sun, 26 Feb 2012 15:05:37 -0800 (PST)
In-Reply-To: <4F4A7A46.9060104@opendreambox.org>
References: <4F48217F.6040406@opendreambox.org>
	<1330153006.1957.10.camel@dongxiao-osel>
	<4F4A7A46.9060104@opendreambox.org>
Date: Mon, 27 Feb 2012 00:05:37 +0100
Message-ID: <CA+chaQc0Oh1LL_P5ynnt-E6QSe9OBa-DT9UgxUeyj0SGooHpXA@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
To: Andreas Oberritter <obi@opendreambox.org>
Subject: Re: cache broken in master
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
X-List-Received-Date: Sun, 26 Feb 2012 23:19:52 -0000
Content-Type: text/plain; charset=UTF-8

On Sun, Feb 26, 2012 at 7:30 PM, Andreas Oberritter
<obi@opendreambox.org> wrote:
> Hello Dongxiao,
>
> On 25.02.2012 07:56, Xu, Dongxiao wrote:
>> On Sat, 2012-02-25 at 00:47 +0100, Andreas Oberritter wrote:
>>> Hi,
>>>
>>> commit 1c1df03a6c4717bfd5faab144c4f8bbfcbae0b57 broke bitbake's
>>> dependency cache for me, i.e. it parses all recipes on every invocation
>>> and always displays "(0 cached, 1269 parsed)". Deleting tmp/cache didn't
>>> help. Reverting this commit restores the functionality.
>>
>> Hi Andreas,
>>
>> Sorry for the inconvenience that this commit brought to you.
>>
>> Could you help to try the following and send me your "/tmp/1.log
>> and /tmp/2.log"?
>>
>> 1) apply the attached "cache_debug.patch"
>> 2) remove tmp/cache
>> 3) bitbake -p &> /tmp/1.log
>> 4) bitbake -p &> /tmp/2.log
>>
>> Besides, you can have a try of the attached cache_whitelist.patch to see
>> if it fixes your problem.

I see the same change in behavior here.

> your patch cache_whitelist.patch fixes the problem. Thanks!

unfortunately doesn't seem to fix it here.

I'll send requested debug info tomorrow, unless someone beats me to it

>
> Regards,
> Andreas
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


