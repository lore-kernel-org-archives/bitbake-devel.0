Received: from mail-ea0-f173.google.com ([209.85.215.173])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1Twvk1-0005oy-Mg; Sun, 20 Jan 2013 15:19:34 +0100
Received: by mail-ea0-f173.google.com with SMTP id i1so1717852eaa.32
	for <multiple recipients>; Sun, 20 Jan 2013 06:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:date:message-id:in-reply-to:references
	:user-agent:subject:mime-version:content-type
	:content-transfer-encoding;
	bh=m8HC6rwluQftI/IU7PWeoOwc08FfcmYweWGCSz34WnA=;
	b=EiwctVdOGS7/w8MX6K5O9ubooBSV4jnhQZCn+LYJRiPoJKn4YQ9HEorfudNOsHcIIf
	8WJqlaG138hIfsMqYzyP7LDiObPAD4meNmyUH0JaPD+CvJFP27ScEY3XVS4hu383ziw4
	9MxvvThVOvfdiWHpPd+SBSPEbHLlCA/qyXacJVnpUs7abDMWdfm1ZvIUoGqSJZ2mOJqD
	WAH4myWzxwX/juCtJS72p+2N5CScCC3vn6Gb85NccALw0uZHxgqhS+CiZn5HeSZlLrQm
	1n/ggbQFEn/phCuHOmsKa4JqhoFfcHW3kR6HGDzG5IMxaFHr+Arp6uF1QN3LgoJ874R6
	DeQQ==
X-Received: by 10.14.224.199 with SMTP id x47mr49008169eep.19.1358690634394;
	Sun, 20 Jan 2013 06:03:54 -0800 (PST)
Received: from [92.248.13.66] (092248013066.atmpu0037.highway.a1.net.
	[92.248.13.66])
	by mx.google.com with ESMTPS id 46sm17503045eeg.4.2013.01.20.06.03.47
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Sun, 20 Jan 2013 06:03:53 -0800 (PST)
From: "Bernhard Reutner-Fischer" <rep.dot.nop@gmail.com>
To: lei yang <yanglei.fage@gmail.com>, Chris Larson <clarson@kergoth.com>
Date: Sun, 20 Jan 2013 15:05:48 +0100
Message-ID: <13c58476de5.2760.0f39ed3bcad52ef2c88c90062b7714dc@gmail.com>
In-Reply-To: <CAHsH0E_9kaYC0_9rv+zHR8FwxXyU=7vTj2eL85_jJ=uRtb0aSw@mail.gmail.com>
References: <CAHsH0E96h=aT6t-u-ACY7MGFHJv4_TTqSMfCmMpSKiq3NBjciw@mail.gmail.com>
	<CABcZANkpo5qMnPkL903SQjfkPhwUF-7rK+i5LaqxTFUdqE3H2Q@mail.gmail.com>
	<CAHsH0E_9kaYC0_9rv+zHR8FwxXyU=7vTj2eL85_jJ=uRtb0aSw@mail.gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:9.0) Gecko/20111222 Thunderbird/9.0.1 AquaMail/1.2.1.2 (build:
	2100174)
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: git address in SRC_URI, doesn't works for me
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
X-List-Received-Date: Sun, 20 Jan 2013 14:19:35 -0000
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 8bit

On 20 January 2013 07:08:35 lei yang <yanglei.fage@gmail.com> wrote:
> On Sun, Jan 20, 2013 at 10:15 AM, Chris Larson <clarson@kergoth.com> wrote:
> >
> > On Sat, Jan 19, 2013 at 2:13 AM, lei yang <yanglei.fage@gmail.com> wrote:
> >>
> >> SRC_URI = "git://git.opensvc.com/multipath-tools/.git;protocol=http"
> >> it doe noting,and trying to find COPING,but it doesn't clone it
> >
> >
> > This is the correct syntax. The URL scheme (git://) determines what bitbake
> > fetcher, and therefore what tool, is used to fetch. If you use http://,
> > it'll try to download it with wget, not git.
> > -
>
>
> Correct, now it works for me, what protocol determines, , I thought
> SRC_URS="address;protocol=*"
> The address should be a real address, now I know it's not , a strange usage

Yes, it is very counterintuitive (but cannot be corrected easily due to 
gazillions of recipes that use this unfortunate scheme).


Sent with AquaMail for Android
http://www.aqua-mail.com




