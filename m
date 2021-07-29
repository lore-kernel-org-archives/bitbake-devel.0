Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.9121.1627564185215170661
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jul 2021 06:09:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2D18CFF805;
	Thu, 29 Jul 2021 13:09:42 +0000 (UTC)
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [docs] [bitbake-devel] [PATCH] doc: bitbake-user-manual: grammar fix for the number of "metadata"
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <9aebdc2ca149587d39cd23628c392423148f22ba.camel@linuxfoundation.org>
 <20210729130133.163787-1-michael.opdenacker@bootlin.com>
 <20210729130521.e5dkww5yktdf3uno@fedora>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <e615c396-4b32-dc86-24bc-b559ac48cc70@bootlin.com>
Date: Thu, 29 Jul 2021 15:09:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210729130521.e5dkww5yktdf3uno@fedora>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi Quentin,

On 7/29/21 3:05 PM, Quentin Schulz wrote:
> Hi Michael,
>
> On Thu, Jul 29, 2021 at 03:01:33PM +0200, Michael Opdenacker wrote:
>> "metadata" is used both as singular and as plural.
>> The first change fixes a case in which the verbs have a singular conjugation
>> but articles that indicate a plural case.
>>
>> The second change is for consistency with the first one inside
>> the same paragraph.
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>> ---
>>  doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> index eb140665..64e7305d 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> @@ -27,11 +27,11 @@ Linux software stacks using a task-oriented approach.
>>  Conceptually, BitBake is similar to GNU Make in some regards but has
>>  significant differences:
>>  
>> --  BitBake executes tasks according to provided metadata that builds up
>> +-  BitBake executes tasks according to provided metadata that build up
>>     the tasks. Metadata is stored in recipe (``.bb``) and related recipe
> Then "Metadata are" here seems appropriate to me. What do you think?

Good catch, many thanks! I paid attention to the following case, but
missed that one.
Cheers,
Michael.
-- 

Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

