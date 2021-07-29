Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web09.9821.1627567211068374074
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jul 2021 07:00:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 85E70FF820;
	Thu, 29 Jul 2021 14:00:08 +0000 (UTC)
Cc: docs@lists.yoctoproject.org, Quentin Schulz <foss@0leil.net>
Subject: Re: [bitbake-devel] [docs] [PATCH v2] doc: bitbake-user-manual: grammar fix for the number of "metadata"
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <16964500F28F0291.7588@lists.openembedded.org>
 <20210729131311.164092-1-michael.opdenacker@bootlin.com>
 <1e3abc561a0492b2908acb0cfb83c81a50479210.camel@linuxfoundation.org>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <45d80029-ad50-14bd-9991-0c6726e2a1b1@bootlin.com>
Date: Thu, 29 Jul 2021 16:00:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1e3abc561a0492b2908acb0cfb83c81a50479210.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

Hi Richard,

On 7/29/21 3:51 PM, Richard Purdie wrote:
> On Thu, 2021-07-29 at 15:13 +0200, Michael Opdenacker wrote:
>> "metadata" is used both as singular and as plural.
>> The first change fixes a case in which the verb has a singular conjugation
>> but absence of article indicates a plural case.
>>
>> The second and third changes are for consistency with the first one inside
>> the same paragraph.
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>> Reviewed-by: Quentin Schulz <foss@0leil.net>
>> ---
>>  doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> index eb140665..55effc35 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> @@ -27,11 +27,11 @@ Linux software stacks using a task-oriented approach.
>>  Conceptually, BitBake is similar to GNU Make in some regards but has
>>  significant differences:
>>  
>>
>> --  BitBake executes tasks according to provided metadata that builds up
>> -   the tasks. Metadata is stored in recipe (``.bb``) and related recipe
>> +-  BitBake executes tasks according to provided metadata that build up
>> +   the tasks. Metadata are stored in recipe (``.bb``) and related recipe
>>     "append" (``.bbappend``) files, configuration (``.conf``) and
>>     underlying include (``.inc``) files, and in class (``.bbclass``)
>> -   files. The metadata provides BitBake with instructions on what tasks
>> +   files. The metadata provide BitBake with instructions on what tasks
>>     to run and the dependencies between those tasks.
> This change doesn't sound like an improvement to me. I would always say 
> "The metadata provides", not what you have here which doesn't read 
> correctly to me. "builds up" also sounds better to me than "build up". I'd
> also say "Metadata is" sounds more correct too.
>
> I'm not sure I like the original wording but this doesn't sound right, at
> least to me.


Many thanks for the review. I know what to update then :)
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

