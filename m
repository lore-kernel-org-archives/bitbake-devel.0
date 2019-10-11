Return-Path: <paul@betafive.co.uk>
X-Greylist: delayed 542 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 11 Oct 2019 20:26:07 UTC
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25])
	by mail.openembedded.org (Postfix) with ESMTP id 5AFCF7F399
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 20:26:07 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7281021F48;
	Fri, 11 Oct 2019 16:17:06 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
	by compute1.internal (MEProxy); Fri, 11 Oct 2019 16:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=betafive.co.uk;
	h=mime-version:message-id:in-reply-to:references:date:from:to
	:subject:content-type; s=fm2; bh=+mdRWq/fYwlRQaksGxa6Ok/c7EN0Pfw
	fbF0gpDKVGWY=; b=Ubcue040qZ+qoGWP8Nf9ots+W+scY8axhOzmkxKOZkzL3i9
	GkzhJDGr2H6JlxGHkIc/1365ocoIqitLl3Hcrscb7HXPW9FRzmuPShk63Qexi+gd
	3ipkI43dRGQMiH0IEqBZTA0eqa93Uxmm8nAFbO83ivPstOkSbhs+vxaLSJIbZFIu
	7seLgGv7wNnQPS6sgD11+NYsqMvYk40wxbiyjroaiHy5gUkJc6WKyidpKAFmzZri
	klnD7P42Uarhe71BxoSOduTtiX5ZOzhwBb+e2ZPFumw1bpam8zzOBqCi4klocGa3
	sl5qPGxmaETPPvaPM3OKHqRz9iSDwpFB4jwnjgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+mdRWq
	/fYwlRQaksGxa6Ok/c7EN0PfwfbF0gpDKVGWY=; b=GbtBJsIQ0hCExcuIDUrh6t
	JNe6itKGj/EvwtNmQXJV6yfnSncVGvPkdbugBIFZYwstXW2dskWecJN9A1EkaD6w
	6B1TlaQu5lYAP158fl7Aq9hm7s2sPlSLuLRx9bi0c/JHruJqJaTHsJOaNimp2Aio
	9aFMhfERbvyD9e9WDNk/lYsPjBn8W8xPl19mNu21OGM4duW+OREpI3A8/0SbVB+R
	iQNjGYXSjwovfXcGXDd06bOpKoFypGFV/pvqRYmFbY9CbU0LKJ44w8wug/Jvudwl
	F6oAWcbj03F1rC6Vujf9t65BYtgw8Z6C3ayP2SV2DMJW9ziwBnbzA3cR/HwEmHkQ
	==
X-ME-Sender: <xms:QeOgXSiQT9laEIhc6p9T7duJ-5IlfvFU9nvCBpZKP3gHpIiCS7XZ1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrieehgddugeelucetufdoteggodetrfdotf
	fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
	uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
	cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfrrghu
	lhcuuegrrhhkvghrfdcuoehprghulhessggvthgrfhhivhgvrdgtohdruhhkqeenucfrrg
	hrrghmpehmrghilhhfrhhomhepphgruhhlsegsvghtrghfihhvvgdrtghordhukhenucev
	lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:QeOgXW8Q-zJyUn-R3fhKRdSlqzQitRMxeJsvB1RbEVlZKkff4GdZsw>
	<xmx:QeOgXepv9LGOjoJb1N7oQzYkunjs0YIU5dWSmOOosNpDa1qxFRCnsQ>
	<xmx:QeOgXTPs_Y6_M5YwCvr7-0tX3wzpttiATkSbjPcasg6w6QUeGiuVcQ>
	<xmx:QuOgXZ3ReVxZ90-eOmvx_gJTq4LDkK4Q699eWQpO1bygzjpWM_7jfw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9EBD5E00A6; Fri, 11 Oct 2019 16:17:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-360-g7dda896-fmstable-20191004v2
Mime-Version: 1.0
Message-Id: <b243b0e4-2415-4556-a665-4c58d2d43e01@www.fastmail.com>
In-Reply-To: <d14ef26853f00ec375884830e627c2c7a454cb5d.1570810590.git.chris.laplante@agilent.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
	<d14ef26853f00ec375884830e627c2c7a454cb5d.1570810590.git.chris.laplante@agilent.com>
Date: Fri, 11 Oct 2019 21:16:47 +0100
From: "Paul Barker" <paul@betafive.co.uk>
To: "Chris Laplante" <chris.laplante@agilent.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/9] bitbake: contrib/vim: initial commit,	with unmodified code from indent/python.vim
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
X-List-Received-Date: Fri, 11 Oct 2019 20:26:07 -0000
Content-Type: text/plain

On Fri, 11 Oct 2019, at 17:23, Chris Laplante via bitbake-devel wrote:
> The intention of this commit is so that git history will clearly
> show the changes I made to the Python indent code.

It would be good to record the license for the imported code along with the location of the original python.vim (I'm guessing it's in the vim source tree but I may be wrong).

-- 
Paul Barker

