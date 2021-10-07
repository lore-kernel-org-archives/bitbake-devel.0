Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7439C433FE
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 09:04:39 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web09.9085.1633597477705235616
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 02:04:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8F94A60005;
	Thu,  7 Oct 2021 09:04:35 +0000 (UTC)
Cc: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [docs] [PATCH 1/2] documentation: update sources
 mirror URL
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Jon Mason <jdmason@kudzu.us>
References: <20211005224513.14134-1-jdmason@kudzu.us>
 <35bcdc42-9ed6-5232-c94e-c69f3fd7af94@bootlin.com>
 <CAPoiz9xhmQ+dCEUibDV7_evNhLVb5i83LjU_uo3k1f_4Q3Y-fA@mail.gmail.com>
 <755f3e7bd1d40628a911b9c1d165785ad6d5a494.camel@linuxfoundation.org>
 <16ABB308824CB520.3789@lists.yoctoproject.org>
Organization: Bootlin
Message-ID: <a03f461f-2956-05ae-de8d-a137e6437612@bootlin.com>
Date: Thu, 7 Oct 2021 11:04:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <16ABB308824CB520.3789@lists.yoctoproject.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 09:04:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12738


On 10/7/21 10:42 AM, Michael Opdenacker wrote:
> Hi,
>
> On 10/7/21 12:17 AM, Richard Purdie wrote:
>> On Wed, 2021-10-06 at 15:53 -0400, Jon Mason wrote:
>>>> Thanks for the proposed update !
>>>>
>>>> On 10/6/21 12:45 AM, Jon Mason wrote:
>>>>> The URL for the sources mirror no longer works.  Update to the new
>>>>> location.
>>>>>
>>>>> Signed-off-by: Jon Mason <jdmason@kudzu.us>
>>>>> ---
>>>>>  documentation/ref-manual/faq.rst       | 15 ++++++++-------
>>>>>  documentation/ref-manual/variables.rst |  8 ++++----
>>>>>  2 files changed, 12 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/documentation/ref-manual/faq.rst b/documentation/ref-manual/faq.rst
>>>>> index d3a603d4a438..f06abc84ee6f 100644
>>>>> --- a/documentation/ref-manual/faq.rst
>>>>> +++ b/documentation/ref-manual/faq.rst
>>>>> @@ -302,10 +302,10 @@ attempt before any others by adding something like the following to the
>>>>>  ``local.conf`` configuration file::
>>>>>
>>>>>     PREMIRRORS:prepend = "\
>>>>> -       git://.*/.* http://www.yoctoproject.org/sources/ \n \
>>>>> -       ftp://.*/.* http://www.yoctoproject.org/sources/ \n \
>>>>> -       http://.*/.* http://www.yoctoproject.org/sources/ \n \
>>>>> -       https://.*/.* http://www.yoctoproject.org/sources/ \n"
>>>>> +       git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
>>>>> +       ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
>>>>> +       http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
>>>>> +       https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
>>>> Hey, doesn't it sound weird to show an example that proposes to use http
>>>> when https is usually recommended?
>>>> What about proposing https://downloads.yoctoproject.org/mirror/sources/
>>>> instead?
>>>>
>>>> Or we don't really care because we use source checksums anyway?
>>>>
>>>> Just my two cents. I don't mind accepting the patch as is.
>>> A quick and dirty grep of the trees shows many occurrences of
>>> downloads.yoctoproject.org without https.  Perhaps it would be good to
>>> correct all of these in a follow-on patch.  I can do a quick patch of
>>> all of these and get that out in the next day or so.
>
>
> OK to do it as a follow-up patch. This way, I can already take yours (at
> least the ones for yocto-docs, which I maintain).


Merged your first patch into master-next. If you make a follow-up patch
to replace "http" by "https" (I could do that if you wish), that's
better if you base it on master-next.

Thanks again
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


