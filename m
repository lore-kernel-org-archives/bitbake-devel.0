Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6091C433F5
	for <webhook@archiver.kernel.org>; Tue, 26 Apr 2022 21:54:08 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.989.1651010040785006124
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Apr 2022 14:54:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=X/Uej/T8;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 67C4B1BF206;
	Tue, 26 Apr 2022 21:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1651010039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2LYROdb6VQz/USWntbxDsuS5CqDOHbHSmewGnkp0II=;
	b=X/Uej/T8taDMNpbN9S8zwhz+Pc8EU7EMJkXWRWowUNG4CxlccRviFX0JTKb5obZOeoRZPp
	BIS0XSCVGUfuZpNfu8/ukMDjiwmME/0+JNZzgPmciBqXwk3+oyy2FnaWgr/akHUdRl4mLh
	4eZDdjuTRxFe9lQXPlDDuM7vwxkH0/uP+sdwGGekiso0NX49PG5FptoeT079M7X2nZJtx+
	FGWLfZl2K1SAwftcogH5j8uvNuUf76fPEL5Gp/6eWp6/URIGv2PT2DfRp+9n7zh9Pbk3qv
	o9bdkQFZ6jGV5YNVxbbT63Yq5be3UtjKIYGUtan5hgADH4EjNgRrGCMPM/1tDg==
Message-ID: <85d42805-0691-ccec-1f0b-f4be34ff8cc0@bootlin.com>
Date: Tue, 26 Apr 2022 23:53:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [bitbake-devel] [PATCH] bitbake-user-manual: document
 TEMPLATECONF environment variable
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20220426214901.201802-1-michael.opdenacker@bootlin.com>
 <99a5bd79f212a830d28427c72dcf83f924c13cb9.camel@linuxfoundation.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: 
 <99a5bd79f212a830d28427c72dcf83f924c13cb9.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Apr 2022 21:54:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13660


On 4/26/22 23:51, Richard Purdie wrote:
> On Tue, 2022-04-26 at 23:49 +0200, Michael Opdenacker via lists.openembedded.org
> wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>> ---
>>  .../bitbake-user-manual-ref-variables.rst        | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> index af4ff980..80005580 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> @@ -1483,6 +1483,22 @@ overview of their function and contents.
>>        consist mostly of task logs and scripts, when building a particular
>>        recipe.
>>  
>> +   :term:`TEMPLATECONF`
>> +      Specifies the directory used by the build system to find templates
>> +      from which to build the ``bblayers.conf`` and ``local.conf`` files.
>> +      Use this variable if you wish to customize such files, and the default
>> +      BitBake targets shown when sourcing the ``oe-init-build-env`` script.
>> +
>> +      For details, see the
>> +      :yocto_docs:`Creating a Custom Template Configuration Directory
>> +      </dev-manual/common-tasks.html#creating-a-custom-template-configuration-directory>`
>> +      section in the Yocto Project Development Tasks manual.
>> +
>> +      .. note::
>> +
>> +         You must set this variable in the external environment in order
>> +         for it to work.
>> +
> I don't think this is a bitbake variable, it is an OE one?


Actually, it's used in toaster.
But I don't mind adding it in Yocto Docs instead...

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


