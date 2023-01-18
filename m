Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6C9C004D4
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 07:31:02 +0000 (UTC)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
 by mx.groups.io with SMTP id smtpd.web11.10328.1674027053017616753
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Jan 2023 23:30:53 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm3 header.b=TWLvLClX;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.25, mailfrom: pavel@zhukoff.net)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 4E767320079B;
	Wed, 18 Jan 2023 02:30:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 18 Jan 2023 02:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1674027051; x=1674113451; bh=96
	cMrQEjbqKtxvcAKTv+TsE/6q+1svOiYaqVVeQzQdQ=; b=TWLvLClXWEv3qr9pAJ
	IRGs+XYW6RdiW6FenPz+jeVCDmBw+NwGG4RTQClPGOR+QtHe8pMirR8HYVFRbAGo
	ENpWkOTHODNWpSimFkYyZ/mL5T/pqlLSbxSU1nvvQJQ9s8kONIFBuoIsDHgiYeDQ
	RECmNj/7FOX4lJwvdn+fEkpzQb1aswXb8nIonuhwMsUbuom9Tu/7n9SESgwJeXfB
	SzgM1bgQNgoYhX59vGSLNehK1umeQDjlYO9iXVoyJ2+VHnyLSBEkvFBIvwi4N+Lf
	3gDQXv8+5iyznWS0FZnMKPmDpCKUUkZEznAnIDrsPw8uD9SGpmr+RHznnnV3+Wbd
	zixQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1674027051; x=1674113451; bh=96cMrQEjbqKtx
	vcAKTv+TsE/6q+1svOiYaqVVeQzQdQ=; b=K89/6uNUOZfLlJgJDZl54bBz5E3yA
	itj+gycMynX/cyU/nGCAOWeWj8Mj83UFKYpXjmxhWEHAQCvrh00s6ch5LFfvBI4+
	CPuTkZbQDbqMzQwKiycnVNQYY5m9MvV15yJiczuDyFyXn52kup4b8xOpw6AKtXGe
	WfYi73sYhmPkLjNlYd6sjWR+KY01457pWE6axLABffQHXsDirMNrkY8yDEWY5DZj
	9F2ohKCagw0hLRbm7LK7OjL55oNa8K9LY3pBlTDf55s3YeTJtOrItGIWT0Scacaj
	E/sDs6lZcSitkxJc3JU5sKpaVpf1V0aAB4DPCpk/4CQvegO/ReSr/ayjw==
X-ME-Sender: <xms:K6DHY3-rj9gopsYoHSxtTiUIyTst87h1e1Qgym57liLz0cdzxHyEWA>
    <xme:K6DHYzs7SsxwGbFOJB2knzDclUyiTaYnfoyICGVRvsTNQNdp9n8X2bv91DnfGeigV
    X1oSym553yWvhAmlik>
X-ME-Received: <xmr:K6DHY1CSlmiEBplA3hq-tng8w_M8Wn4x0CiB9KodJM430hkSNvvxZNKHXe6G366ED48eN3Cn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffohhrjgfkgggtsehttdertddtredtnecuhfhrohhmpefr
    rghvvghlucgkhhhukhhovhcuoehprghvvghlseiihhhukhhofhhfrdhnvghtqeenucggtf
    frrghtthgvrhhnpeevtefhffeludeuhedtgfevueeffeekudevieetffejhfekheevffeu
    gfdtvdettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehprghvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:K6DHYzeYM1ZaNExAat1XNBEHsbpm-FQrr3LfUtcqBLiXoKpW2t6KMg>
    <xmx:K6DHY8P9sE_DQEO7N5NIIKyB0lDgRmly_UWLIfN2tq3S64ti0HiWRg>
    <xmx:K6DHY1naA30tHRjrEQ7V8DRG47xHwQpFknT6FbEsvydmbOTc3rhmHA>
    <xmx:K6DHY2WpJf5gR700tIC0HkAmb62nouWJx7JpquZP1L9WC6hqHJpV7A>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jan 2023 02:30:51 -0500 (EST)
References: <20230117153643.21716-1-pavel@zhukoff.net>
 <c510d7c971e772ce0c2c50229862e2b475e5c4a3.camel@linuxfoundation.org>
User-agent: mu4e 1.8.13; emacs 28.2
From: Pavel Zhukov <pavel@zhukoff.net>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch2: kill parameters in
 uri_find_decoded
Date: Wed, 18 Jan 2023 08:28:28 +0100
Organization: Linux Private Site
Reply-To: pavel@zhukoff.net
In-reply-to: <c510d7c971e772ce0c2c50229862e2b475e5c4a3.camel@linuxfoundation.org>
Message-ID: <87lem047v9.fsf@desktop.zhukoff.net>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Jan 2023 07:31:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14322


Richard Purdie <richard.purdie@linuxfoundation.org> writes:

> On Tue, 2023-01-17 at 16:36 +0100, Pavel Zhukov wrote:
>> Fixes:
>>   File "/bitbake/./lib/bb/fetch2/__init__.py", line 446, in uri_replace
>>     if uri_decoded[loc][k] != uri_find_decoded[loc][k]:
>> KeyError: 'module'
>> 
>> Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
>> ---
>>  bitbake/lib/bb/fetch2/__init__.py | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
>> index 893ec6f6bd..b1cd6b25c2 100644
>> --- a/bitbake/lib/bb/fetch2/__init__.py
>> +++ b/bitbake/lib/bb/fetch2/__init__.py
>> @@ -469,6 +469,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>>                      basename = os.path.basename(mirrortarball)
>>                      # Kill parameters, they make no sense for mirror tarballs
>>                      uri_decoded[5] = {}
>> +                    uri_find_decoded[5] = {}
>>                  elif ud.localpath and ud.method.supports_checksum(ud):
>>                      basename = os.path.basename(ud.localpath)
>>                  if basename:
>
> The fix looks reasonable but is there a test we should be adding to
> cover this scenario?
Mercurial test (second patch in the series) covers this but it will be
executed only if network enabled and mercurial installed so I've modified
existing git premirror local test to cover this change as well:

Subject: [PATCH] fetch2/tests: Add parameter to recipe_uri

>
> Cheers,
>
> Richard


