Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88829C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:57:49 +0000 (UTC)
Received: from esa14.hc324-48.eu.iphmx.com (esa14.hc324-48.eu.iphmx.com [207.54.69.24])
 by mx.groups.io with SMTP id smtpd.web11.5854.1745585858087601183
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 05:57:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=bqbHC8Vw;
 spf=pass (domain: bmw.de, ip: 207.54.69.24, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745585858; x=1777121858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=13j63eu8fsrZKRObJ13h/WHPDYQj6nNqMb9VIn4ry3w=;
  b=bqbHC8VwTM9Tq9UzcUoyHozhN5O7+PW3YVuyNiv5OncsfJb81o+vEvYk
   +igmK1WCyKSkTH0Dp3y9pR5rGU/KLa2tnbSIzzZ07sLMHNTh0PgdoUWKw
   wfi47vQ9ZozsLDQ+faU8av+wbpiG2qNN3xO5ys/G4XL139r/qdbdyMwMa
   M=;
X-CSE-ConnectionGUID: SVTAm0qkTcSqGMleSYplGw==
X-CSE-MsgGUID: pwZK2MMiQBCcsX6ELfdlRQ==
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa14.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Apr 2025 14:57:35 +0200
Received: from esabb1.muc ([160.50.100.31])  by esagw6.muc with ESMTP/TLS;
 25 Apr 2025 14:57:35 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb1.muc with ESMTP/TLS; 25 Apr 2025 14:57:35 +0200
Received: from [10.242.8.37] (10.30.85.212) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 14:57:35 +0200
X-CSE-ConnectionGUID: 40W3DT8tTcyAweEB6ZqqlQ==
X-CSE-MsgGUID: C2WuDwG5TSKZsSfJidCx2g==
X-CSE-ConnectionGUID: 2E9S4XFYShW2bVTyTX5TLA==
X-CSE-MsgGUID: bJ+NS0/1Sy2hYPgHB2SFSg==
Message-ID: <be12185b-f117-407a-a829-8f4c00b6efc2@bmw.de>
Date: Fri, 25 Apr 2025 14:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2 0/8] Fix gitsm LFS support
To: "Marko, Peter" <Peter.Marko@siemens.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>
CC: "mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <20250425101155.2905972-1-philip.lorenz@bmw.de>
 <522a15ccc1ed1597a5a6b92803536484a3f008a4.camel@linuxfoundation.org>
 <AS1PR10MB569750ACF9183A75F2389811FD842@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
From: Philip Lorenz <philip.lorenz@bmw.de>
In-Reply-To: <AS1PR10MB569750ACF9183A75F2389811FD842@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SMUCMP08B.europe.bmw.corp (2a03:1e80:a15:58f::22fd) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 12:57:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17567

Hi Peter, hi Richard,

On 25.04.25 14:45, Marko, Peter wrote:
>> With this series applied, OE-Core throws a lot of errors, see below.
>> I'm not convinced we have that much LFS use so something seems wrong...
>>
>> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/1465/steps/13/log
>> s/stdio
> I think what is wrong is the default for lfs (enabled).
> It badly chosen default if lfs is not a requirement and whole core builds without it.
>
> Adding additional commit to switch lfs default to disabled should solve it.
> I think it will not break the core itself as until now it built successfully without git-lfs installed, but migration note will be needed for the custom layers.

This is actually caused by a bad placement of the new validation code. 
This slipped in while porting the change to latest master (and I didn't 
hit this code path while doing the retesting). I'll add a test for this 
scenario and send a follow up. Sorry for all the noise...

Philip

-- 
Philip Lorenz
BMW Car IT GmbH, Software-Plattform, -Integration Connected Company, Lise-Meitner-Straße 14, 89081 Ulm
-------------------------------------------------------------------------
BMW Car IT GmbH
Management: Chris Brandt, Michael Böttrich, Christian Salzmann
Domicile and Court of Registry: München HRB 134810
-------------------------------------------------------------------------


