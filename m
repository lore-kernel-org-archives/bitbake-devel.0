Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB34FD44C42
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 12:59:13 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35070.1768481952073829762
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 04:59:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ROH/RnBc;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7B28D1A287E;
	Thu, 15 Jan 2026 12:59:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 508EE606B6;
	Thu, 15 Jan 2026 12:59:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDD0410B685E5;
	Thu, 15 Jan 2026 13:59:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768481949; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eHPkRLOHEjQ/Sbn/2HeQJ3IJkdD7PRbfb6xTpIg8ZBw=;
	b=ROH/RnBc6irZqLs8tw/agsZUiU9EzbnRXmSwJtcy2xmWSwD0S/bDoWc7JKZjulNpA95rmz
	6PoWwSbYQSLLcV/e75A35RYDiLfeVpD5KtzDuvqN9XrybRqDzPzMLj0rua42qwhuvCAsY3
	x3Kqzv7xE8tfw5wtW5GpFHqx4k4ELheTUxNM0YNZqs3tj40iKR6BPZLTKJHMMVd6rRfwZ7
	U79HRI2reuUH0jRn8XiT6ehAikWmDRUNXrJBC36smRfWVruc2bCoEd+zija4AsPZ/yJ8lm
	ZImoxdQGlhhrZsWxwzM3d0u1K2qCRxHgtJarDRu2upFg8yB52F25NDvu3cTDuA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jan 2026 13:59:08 +0100
Message-Id: <DFP6J3BORRRT.3KAGZWA93LLB0@bootlin.com>
To: <quentin.schulz@cherry.de>, <alex.kanavin@gmail.com>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 1/5] doc: document fixed revisions
 override in bitbake-setup manual
Cc: "Alexander Kanavin" <alex@linutronix.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20260109132000.2372791-1-alex.kanavin@gmail.com>
 <842ad162-22d4-4ff5-916b-7c8a4450f650@cherry.de>
In-Reply-To: <842ad162-22d4-4ff5-916b-7c8a4450f650@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 12:59:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18777

Hi,

On Thu Jan 15, 2026 at 12:50 PM CET, Quentin Schulz via lists.openembedded.=
org wrote:
> Hi Alex,
>
> On 1/9/26 2:19 PM, Alexander Kanavin via lists.openembedded.org wrote:
>> From: Alexander Kanavin <alex@linutronix.de>
>>=20
>> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
>> ---
>>   .../bitbake-user-manual-environment-setup.rst | 48 +++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>=20
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-set=
up.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
>> index ec1bdeecd..fcffab812 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
>> @@ -938,3 +938,51 @@ Here is an example file that overrides the branch o=
f the BitBake repository to
>>   -  The ``sources`` section contains the same options as the ``sources`=
` option
>>      of a :term:`Generic Configuration` file. See the
>>      :ref:`ref-bbsetup-section-config-reference` section for more inform=
ation.
>> +
>> +.. _ref-bbsetup-fixed-revisions:
>> +
>
> We have autosectionlabel sphinx extension enabled, so this shouldn't be=
=20
> necessary. I know Antonin's got some opinion on when to use manual=20
> labels vs autolabels so up to him to decide. Would be nice to have some=
=20
> sort of rule documented somewhere :)

I don't think having a custom ref prevents from using autosectionlabels, so=
 I'm
fine either way.

[...]
>> +
>> +Also, as it is an override file, it can be combined with the original c=
onfigurations
>> +to initialize a setup in a reproducible way that guarantees an exact, n=
ever-changing
>> +set of revisions, by using the ``--source-overrides`` option of the
>> +:ref:`ref-bbsetup-command-init` command.
>> +
>> +For example if the original configuration had specified only a master b=
ranch
>> +for a source::
>> +
>
> This is JSON I believe? So probably:
>
> .. code-block:: json

Careful with that I think Sphinx is not happy when the underlying JSON is n=
ot
valid JSON (missing comma or unmatched curly braces etc.)

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


