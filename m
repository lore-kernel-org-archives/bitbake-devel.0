Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web08.8095.1627371209410878989
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jul 2021 00:33:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 83967E0011;
	Tue, 27 Jul 2021 07:33:26 +0000 (UTC)
Cc: docs@lists.yoctoproject.org, Quentin Schulz <foss@0leil.net>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [bitbake-devel] [docs] [PATCH] doc: bitbake-user-manual: replace ``FOO`` by :term:`FOO` where possible
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20210726153357.2502731-1-quentin.schulz@theobroma-systems.com>
 <169566A198715102.2010@lists.openembedded.org>
Organization: Bootlin
Message-ID: <ffbf353b-9992-1b1f-a3ff-108052aa7ae8@bootlin.com>
Date: Tue, 27 Jul 2021 09:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <169566A198715102.2010@lists.openembedded.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi Richard

On 7/26/21 7:14 PM, Michael Opdenacker wrote:
> Hello again Quentin,
>
> Thanks for the new patch!
>
> On 7/26/21 5:33 PM, Quentin Schulz wrote:
>> If a variable has a glossary entry and some rST files write about those
>> variables, it's better to point to the glossary entry instead of just
>> highlighting it by surrounding it with two tick quotes.
>>
>> The script that is used to do the replacement of ``FOO`` by :term:`FOO`
>> is the following Python code:
>>
>> import re
>> from pathlib import Path
>> from runpy import run_module
>> import contextlib
>> import io
>> import sys
>>
>> re_term = re.compile(r'variables.html#term-([a-zA-Z_0-9]*)')
>> terms = []
>> new_terms = set()
>>
>> with contextlib.redirect_stdout(io.StringIO()) as f:
>>     run_module('sphinx.ext.intersphinx', run_name='__main__')
>>
>> objects = f.getvalue()
>>
>> match = re_term.search(objects)
>> while match:
>>     if match.group(1):
>>         terms.append(match.group(1))
>>     match = re_term.search(objects, match.end())
>>
>> for rst in Path('.').rglob('*.rst'):
>>     with open(rst, 'r') as f:
>>         content = "".join(f.readlines())
>>     for term in terms:
>>         content = re.sub(r'``({})``(?!.*\s+[~=-]{{{:d},}})'.format(term, len(term)), r':term:`\1`', content)
>>
>>     with open(rst, 'w') as f:
>>         f.write(content)
>>
>> This script takes one argument as input: an objects.inv which can be
>> gotten from doc/_build/html/objetcs.inv after running `make html`.
>>
>> Note that this excludes from replacement terms that appear in section
>> titles as it requires refs to be changed too. This can be automated too
>> if need be but right now it looks a bit confusing to have an anchor link
>> (for sections) also have a term/reference link in it. I am not sure this
>> is desired today.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> Signed-off-by: Quentin Schulz <foss@0leil.net>
> Tested-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> Richard, could you merge it from the patch that was sent to the [docs]
> mailing list, please? Given the size of it, it would be great if you
> could apply it pretty quickly, so that we can have it when proposing
> further updates to the BitBake user manual.


Thanks for having merged this big one, and all the others!
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

