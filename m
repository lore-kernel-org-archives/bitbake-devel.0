Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DD2CC6B1C
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 17:56:28 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4027.1791914184526360842
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 10:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=iuifRnGJ;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 46B27C653FE
	for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 17:57:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A38C260362
	for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 17:56:22 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 2843E11D718C5; Tue, 13 Oct 2026 19:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791914182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Rz/M0spMYr87LLrl7V66u5Uhn+7iQMIS3Hp14iQ32eg=;
	b=iuifRnGJ7APgCEyQ41DaM9wDrMkQ1bF9bAe7XSmZdUVPE0/NyepzJ99YcjKKmsKTyIidDi
	NAi9SgdVi/eMegsC6OhiJAvR7OTEpkfxTCMDU9GmiFqf4xtLBajGtUlFJrHNqFlLhY1Vlx
	oaOGofY7FlBmtDOUtYj6Ev5M27WTyYe7T02oNMqxWVi1ellEDwE3FB6+xV9tXkdQC3GAcH
	Db5KEoHcz2vCOF1B8ehYESHbJy5PVgDg9PW06w9bsH6nioKFeAiB2SY1UrpnJ21xGTd3aV
	jv/fexDJEW78pibv1rJ5wClUWP7/jVU0OYqpuXkxGmjUNwRuIsLd5S1ut3lS5w==
Authentication-Results: mail.galae.net;
	none
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Oct 2026 15:20:45 +0200
Message-Id: <DM2W2QFSWNBT.2A6RT11K7VMT1@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] doc: document dependency tracking
 associated with addpylib
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yann.dirson@vates.tech>, <bitbake-devel@lists.openembedded.org>
References: <1791793541.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7@vates.tech> <DM2VSZ91PNOJ.YXQAWC84B6NR@bootlin.com>
In-Reply-To: <DM2VSZ91PNOJ.YXQAWC84B6NR@bootlin.com>
X-TUID: c057SQE5LC48
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 2843E11D718C5
X-Spamd-Result: default: False [-4.10 / 30.00];
	BAYES_HAM(-5.50)[100.00%];
	DATE_IN_PAST(1.00)[28];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	BCC(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	URIBL_BLOCKED(0.00)[openembedded.org:url,openembedded.org:email,galae.net:url,localhost:rdns,localhost:helo,vates.tech:email,bootlin.com:email,bootlin.com:mid,bootlin.com:url,groups.io:url,yoctoproject.org:url,yoctoproject.org:email];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim]
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 17:56:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20339

On Mon Oct 12, 2026 at 3:08 PM CEST, Antonin Godard via lists.openembedded.=
org wrote:
> Hi,
>
> On Mon Oct 12, 2026 at 10:25 AM CEST, Yann Dirson via lists.openembedded.=
org wrote:
>> Reported-by: Claude Opus 5.5
>> Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
>> ---
>>  doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/=
doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> index 621aab253..eef1f9624 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> @@ -2264,6 +2264,14 @@ The specified <namespace> is imported automatical=
ly, and if the imported
>>  module specifies an attribute named ``BBIMPORTS``, that list of
>>  sub-modules is iterated and imported too.
>> =20
>> +Additionally, Bitbake will detect usage of functions from such a
>> +library and include them in task hashes, so changes in those functions
>> +trigger task rebuilds.  Note that only functions inside modules
>> +declared using ``BBIMPORTS`` benefit from this dependency tracking,
>> +any name defined directly in the specified namespace (e.g. in
>> +`<namespace>/__init__.py`, or in a library hat would be defined as
>
> s/hat/that/
>
>> +`<namespace>.py`) would *not* benefit from this tracking.
>
> Otherwise, this is clear to me. I did not know about this limitation/feat=
ure,
> and this is definitely important to document, thanks!

Reading the code[1], it seems that functions prefixed with _ are not includ=
ed
in the task checksums - if I understood correctly. I think it would be also
important to mention that. Could you add it in a v2?

[1]: https://git.openembedded.org/bitbake/tree/lib/bb/parse/ast.py#n319

Antonin
text:
Return-Path: <bounce+61381+10659+8963659+13628082@lists.yoctoproject.org>
Delivered-To: antonin.godard@bootlin.com
Received: from mail.galae.net ([172.22.1.253])
	by 9e7fea892943 with LMTP
	id 8F29A7fezGqxcRAAtaWaaQ
	(envelope-from <bounce+61381+10659+8963659+13628082@lists.yoctoproject.org>)
	for <antonin.godard@bootlin.com>; Mon, 12 Oct 2026 15:20:55 +0200
X-Original-To: antonin.godard@bootlin.com
Received: from smtpin-01.galae.net (smtpin-01.galae.net [51.159.2.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.galae.net (Postcow) with ESMTPS id 9B76311D70CC0
	for <antonin.godard@bootlin.com>; Mon, 12 Oct 2026 15:20:54 +0200 (CEST)
Authentication-Results: mail.galae.net;
	dkim=pass header.d=lists.yoctoproject.org header.s=groups1 header.b=lRnThJv5;
	dmarc=pass (policy=none) header.from=lists.yoctoproject.org;
	spf=pass (mail.galae.net: domain of bounce+61381+10659+8963659+13628082@lists.yoctoproject.org designates 173.255.243.56 as permitted sender) smtp.mailfrom=bounce+61381+10659+8963659+13628082@lists.yoctoproject.org
ARC-Seal: i=1; s=dkim; d=bootlin.com; t=1791811254; a=rsa-sha256; cv=none;
	b=tr3e6cjjwvxJLmiuO4JUgvm8+jxh9kwzxyLLkCGLxMmpNHwuX+CbzwxyGzqTnk7YJ381Tx
	XCVWft8eu/Bb14PYnmoR8ZMmWh5B7UeIz5YdBrYwT2RJv3LX+H8EFTLDQc4a7vn+qiiEL1
	REIek443xPVbqVvJhgPH5D9FmfJvrCkUGOy/rlvQT5GkuVnJZ4BgX1hZKt60Sx+D2PNUVP
	Z2J50AF5NKwPLtobE0E1iT7SQj0A9DFxPy+1GZ8X0zoHN0ObrXG/NILgwMYooia8FGngUr
	vShMPthcMwuZVpZBKE/Jxm3Bs9Nnrlwl8o0mGXfmuPJVm51GM+y/UJDdnXdKSQ==
ARC-Authentication-Results: i=1;
	mail.galae.net;
	dkim=pass header.d=lists.yoctoproject.org header.s=groups1 header.b=lRnThJv5;
	dmarc=pass (policy=none) header.from=lists.yoctoproject.org;
	spf=pass (mail.galae.net: domain of bounce+61381+10659+8963659+13628082@lists.yoctoproject.org designates 173.255.243.56 as permitted sender) smtp.mailfrom=bounce+61381+10659+8963659+13628082@lists.yoctoproject.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com;
	s=dkim; t=1791811254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:resent-from:in-reply-to:in-reply-to:
	 references:references:list-id:list-help:list-unsubscribe:
	 list-unsubscribe-post:list-subscribe:list-post:dkim-signature;
	bh=wXiUO+/F3j16NwadboMlN5lI4U9Ddtpc12kUBpnn4jA=;
	b=GGE6F3+7a4hduD64k9r3Rv33JaOfLjVdSnEq30Ogr7dlv5svQiu7vSshyKz2ScVWkZmM42
	fkMyj2qsENHpGJflmox9dhRh2YWKOuAxOtVQXvAPHiWRlAf8qhjPb+cDLtFQ0GCvtdfB0z
	yXKFSy5ufqyqM/Ytqzo64yFEpMO2gplBIGmc3imsJdaEdUxBqPFg9RbrnhCijWhVjnnQo1
	6dJbF49jUq9BZ7ZsqHgf9agxLR6bSdwaJRCWY3HVRz6r2oYsgOXmLOCEOVrl6joIqDtRrr
	BRKX3lyQhsrmHQ4WDPdGShINd6xmmfSHhKLXPyQhHKWyEKSIinj9LyTz5fjqmg==
Received: from mail07.groups.io (mail07.groups.io [173.255.243.56])
	by smtpin-01.galae.net (Postfix) with ESMTPS id 1883C343DE4
	for <antonin.godard@bootlin.com>; Mon, 12 Oct 2026 13:20:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=wXiUO+/F3j16NwadboMlN5lI4U9Ddtpc12kUBpnn4jA=;
 c=relaxed/relaxed; d=lists.yoctoproject.org;
 h=From:Subject:Date:Message-ID:To:Cc:In-Reply-To:References:Reply-To:Sender:List-Id:List-Post:List-Subscribe:List-Unsubscribe:List-Help:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=groups1; t=1791811252; v=1; x=1792070452;
 b=lRnThJv5NnYJYPWvoOlkh64C33HLWCfUi5vUxZvFchcGX0036qWkw0TJZdPJy8zkU35EnbVQ
 JYxzAD1TaX0PI2Dzj1P0d4gZoVOj9qZxUh/ludFaPevcyyictF+XQApqRF3WMHtSSqVC+Bhzi71
 XB5HCF6XfNoTyTj3dUnPpjhm0EGAGBTuxAKm1mxBw9s2J682ha6oQwAymQpJ+x18Uj8U9Sg6+ng
 0XxMUMR70K6txUaD5gSrFpIQUGndjznH8MhDxV9EO/lAW7kri/IDEuMcu4uFhjPAwIm6ZTsfVm5
 swzEwigIf6eTSpDpVE+vVbiM3xLTXwv5WEIAY1VfUbcHQ==
X-Received: by 127.0.0.2 with SMTP id fEjoYY8964994xEZ0kRGdCyr; Mon, 12 Oct 2026 06:20:52 -0700
X-Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13163.1791811249370348145
 for <docs@lists.yoctoproject.org>;
 Mon, 12 Oct 2026 06:20:50 -0700
X-Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 49B124E411F8
	for <docs@lists.yoctoproject.org>; Mon, 12 Oct 2026 13:20:47 +0000 (UTC)
X-Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 112BD601A6;
	Mon, 12 Oct 2026 13:20:47 +0000 (UTC)
X-Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9307711D70D17;
	Mon, 12 Oct 2026 15:20:45 +0200 (CEST)
Mime-Version: 1.0
Date: Mon, 12 Oct 2026 15:20:45 +0200
Message-Id: <DM2W2QFSWNBT.2A6RT11K7VMT1@bootlin.com>
Subject: Re: [docs] [bitbake-devel] [PATCH] doc: document dependency tracking associated with addpylib
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard via lists.yoctoproject.org" <antonin.godard=bootlin.com@lists.yoctoproject.org>
To: <yann.dirson@vates.tech>, <bitbake-devel@lists.openembedded.org>
References: <1791793541.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7@vates.tech> <DM2VSZ91PNOJ.YXQAWC84B6NR@bootlin.com>
In-Reply-To: <DM2VSZ91PNOJ.YXQAWC84B6NR@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: Bulk
List-Subscribe: <mailto:docs+subscribe@lists.yoctoproject.org>
List-Help: <mailto:docs+help@lists.yoctoproject.org>
Sender: docs@lists.yoctoproject.org
List-Id: <docs.lists.yoctoproject.org>
Mailing-List: list docs@lists.yoctoproject.org; contact docs+owner@lists.yoctoproject.org
Delivered-To: mailing list docs@lists.yoctoproject.org
Resent-Date: Mon, 12 Oct 2026 06:20:50 -0700
Resent-From: antonin.godard@bootlin.com
Reply-To: antonin.godard@bootlin.com
List-Post: <mailto:docs@lists.yoctoproject.org>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
List-Unsubscribe: <https://lists.yoctoproject.org/g/docs/leave/13628082/8963659/2084302499/plugh>
X-Gm-Message-State: dwRW08oTAk9mX8DAYqfZ8rGQx8963659AA=
Content-Type: multipart/mixed; boundary="W3XM4wu3PdhQOzBYMFuF"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 9B76311D70CC0
X-Spamd-Result: default: False [-11.92 / 30.00];
	BAYES_HAM(-5.50)[99.99%];
	REPLY(-4.00)[];
	IP_REPUTATION_HAM(-1.35)[asn: 63949(-0.40), country: SG(-0.01), ip: 173.255.243.56(-0.94)];
	DMARC_POLICY_ALLOW(-0.50)[lists.yoctoproject.org,none];
	MV_CASE(0.50)[];
	RWL_MAILSPIKE_EXCELLENT(-0.40)[173.255.243.56:from];
	R_DKIM_ALLOW(-0.20)[lists.yoctoproject.org:s=groups1];
	R_SPF_ALLOW(-0.20)[+ip4:173.255.243.56:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MX_GOOD(-0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_FROM(0.00)[61381,10659,8963659,13628082];
	URIBL_BLOCKED(0.00)[yoctoproject.org:email,yoctoproject.org:url,bootlin.com:mid,bootlin.com:email,bootlin.com:replyto,vates.tech:email,lists.yoctoproject.org:dkim,mail07.groups.io:helo,mail07.groups.io:rdns,openembedded.org:url];
	RCPT_MAILCOW_DOMAIN(0.00)[bootlin.com];
	BCC(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ARC_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ARC_SIGNED(0.00)[bootlin.com:s=dkim:i=1];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[173.255.243.56:from];
	DWL_DNSWL_BLOCKED(0.00)[yoctoproject.org:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonin.godard=bootlin.com@lists.yoctoproject.org,bounce@lists.yoctoproject.org];
	DKIM_TRACE(0.00)[lists.yoctoproject.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	EXTERNAL_RELAY_AUTHENTICATED(0.00)[];
	CTYPE_MIXED_BOGUS(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:173.255.240.0/20, country:SG];
	RCVD_COUNT_ONE(0.00)[1];
	HAS_REPLYTO(0.00)[antonin.godard@bootlin.com]

--W3XM4wu3PdhQOzBYMFuF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Oct 12, 2026 at 3:08 PM CEST, Antonin Godard via lists.openembedded.=
org wrote:
> Hi,
>
> On Mon Oct 12, 2026 at 10:25 AM CEST, Yann Dirson via lists.openembedded.=
org wrote:
>> Reported-by: Claude Opus 5.5
>> Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
>> ---
>>  doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/=
doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> index 621aab253..eef1f9624 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> @@ -2264,6 +2264,14 @@ The specified <namespace> is imported automatical=
ly, and if the imported
>>  module specifies an attribute named ``BBIMPORTS``, that list of
>>  sub-modules is iterated and imported too.
>> =20
>> +Additionally, Bitbake will detect usage of functions from such a
>> +library and include them in task hashes, so changes in those functions
>> +trigger task rebuilds.  Note that only functions inside modules
>> +declared using ``BBIMPORTS`` benefit from this dependency tracking,
>> +any name defined directly in the specified namespace (e.g. in
>> +`<namespace>/__init__.py`, or in a library hat would be defined as
>
> s/hat/that/
>
>> +`<namespace>.py`) would *not* benefit from this tracking.
>
> Otherwise, this is clear to me. I did not know about this limitation/feat=
ure,
> and this is definitely important to document, thanks!

Reading the code[1], it seems that functions prefixed with _ are not includ=
ed
in the task checksums - if I understood correctly. I think it would be also
important to mention that. Could you add it in a v2?

[1]: https://git.openembedded.org/bitbake/tree/lib/bb/parse/ast.py#n319

Antonin

--W3XM4wu3PdhQOzBYMFuF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#10659): https://lists.yoctoproject.org/g/docs/message/1=
0659
Mute This Topic: https://lists.yoctoproject.org/mt/121714583/8963659
Group Owner: docs+owner@lists.yoctoproject.org
Unsubscribe: https://lists.yoctoproject.org/g/docs/unsub [antonin.godard@bo=
otlin.com]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--W3XM4wu3PdhQOzBYMFuF--
text:
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Oct 2026 15:20:45 +0200
Message-Id: <DM2W2QFSWNBT.2A6RT11K7VMT1@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] doc: document dependency tracking
 associated with addpylib
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yann.dirson@vates.tech>, <bitbake-devel@lists.openembedded.org>
References: <1791793541.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7@vates.tech> <DM2VSZ91PNOJ.YXQAWC84B6NR@bootlin.com>
In-Reply-To: <DM2VSZ91PNOJ.YXQAWC84B6NR@bootlin.com>
X-TUID: 1m7vuXXFecP5

On Mon Oct 12, 2026 at 3:08 PM CEST, Antonin Godard via lists.openembedded.=
org wrote:
> Hi,
>
> On Mon Oct 12, 2026 at 10:25 AM CEST, Yann Dirson via lists.openembedded.=
org wrote:
>> Reported-by: Claude Opus 5.5
>> Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
>> ---
>>  doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/=
doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> index 621aab253..eef1f9624 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> @@ -2264,6 +2264,14 @@ The specified <namespace> is imported automatical=
ly, and if the imported
>>  module specifies an attribute named ``BBIMPORTS``, that list of
>>  sub-modules is iterated and imported too.
>> =20
>> +Additionally, Bitbake will detect usage of functions from such a
>> +library and include them in task hashes, so changes in those functions
>> +trigger task rebuilds.  Note that only functions inside modules
>> +declared using ``BBIMPORTS`` benefit from this dependency tracking,
>> +any name defined directly in the specified namespace (e.g. in
>> +`<namespace>/__init__.py`, or in a library hat would be defined as
>
> s/hat/that/
>
>> +`<namespace>.py`) would *not* benefit from this tracking.
>
> Otherwise, this is clear to me. I did not know about this limitation/feat=
ure,
> and this is definitely important to document, thanks!

Reading the code[1], it seems that functions prefixed with _ are not includ=
ed
in the task checksums - if I understood correctly. I think it would be also
important to mention that. Could you add it in a v2?

[1]: https://git.openembedded.org/bitbake/tree/lib/bb/parse/ast.py#n319

Antonin

