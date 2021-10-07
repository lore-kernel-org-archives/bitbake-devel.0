Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E3EC433F5
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 08:42:20 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.8874.1633596138142929815
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 01:42:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id DC83740008;
	Thu,  7 Oct 2021 08:42:15 +0000 (UTC)
Cc: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [docs] [PATCH 1/2] documentation: update sources
 mirror URL
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Jon Mason <jdmason@kudzu.us>
References: <20211005224513.14134-1-jdmason@kudzu.us>
 <35bcdc42-9ed6-5232-c94e-c69f3fd7af94@bootlin.com>
 <CAPoiz9xhmQ+dCEUibDV7_evNhLVb5i83LjU_uo3k1f_4Q3Y-fA@mail.gmail.com>
 <755f3e7bd1d40628a911b9c1d165785ad6d5a494.camel@linuxfoundation.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <c03b4f8c-a44d-a064-f467-a11b210ad2c6@bootlin.com>
Date: Thu, 7 Oct 2021 10:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: 
 <755f3e7bd1d40628a911b9c1d165785ad6d5a494.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 08:42:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12737

Hi,

On 10/7/21 12:17 AM, Richard Purdie wrote:
> On Wed, 2021-10-06 at 15:53 -0400, Jon Mason wrote:
>>
>>> Thanks for the proposed update !
>>>
>>> On 10/6/21 12:45 AM, Jon Mason wrote:
>>>> The URL for the sources mirror no longer works.  Update to the new
>>>> location.
>>>>
>>>> Signed-off-by: Jon Mason <jdmason@kudzu.us>
>>>> ---
>>>>  documentation/ref-manual/faq.rst       | 15 ++++++++-------
>>>>  documentation/ref-manual/variables.rst |  8 ++++----
>>>>  2 files changed, 12 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/documentation/ref-manual/faq.rst b/documentation/ref-manual/faq.rst
>>>> index d3a603d4a438..f06abc84ee6f 100644
>>>> --- a/documentation/ref-manual/faq.rst
>>>> +++ b/documentation/ref-manual/faq.rst
>>>> @@ -302,10 +302,10 @@ attempt before any others by adding something like the following to the
>>>>  ``local.conf`` configuration file::
>>>>
>>>>     PREMIRRORS:prepend = "\
>>>> -       git://.*/.* http://www.yoctoproject.org/sources/ \n \
>>>> -       ftp://.*/.* http://www.yoctoproject.org/sources/ \n \
>>>> -       http://.*/.* http://www.yoctoproject.org/sources/ \n \
>>>> -       https://.*/.* http://www.yoctoproject.org/sources/ \n"
>>>> +       git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
>>>> +       ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
>>>> +       http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
>>>> +       https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
>>>
>>> Hey, doesn't it sound weird to show an example that proposes to use http
>>> when https is usually recommended?
>>> What about proposing https://downloads.yoctoproject.org/mirror/sources/
>>> instead?
>>>
>>> Or we don't really care because we use source checksums anyway?
>>>
>>> Just my two cents. I don't mind accepting the patch as is.
>> A quick and dirty grep of the trees shows many occurrences of
>> downloads.yoctoproject.org without https.  Perhaps it would be good to
>> correct all of these in a follow-on patch.  I can do a quick patch of
>> all of these and get that out in the next day or so.



OK to do it as a follow-up patch. This way, I can already take yours (at
least the ones for yocto-docs, which I maintain).

>>
>> Also, looking at documentation/profile-manual/usage.rst (where most of
>> the occurrences in the docs are), shouldn't we have a newer kernel
>> than 2.6.19.2 as an example?  I mean, it's almost 15 years old.
> Careful, some of us remember working on the 2.6.19 kernel and have patches in it
> :)


I can take care of this one too.

>
> I don't think we've worried too much about http vs https for the downloads as
> they are checksumed but it is probably cleaner just to convert them.


Agreed, but let's do it as a follow-up patch.

Cheers,
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


