Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5049EE77188
	for <webhook@archiver.kernel.org>; Wed,  8 Jan 2025 11:45:01 +0000 (UTC)
Received: from esa13.hc324-48.eu.iphmx.com (esa13.hc324-48.eu.iphmx.com [207.54.72.35])
 by mx.groups.io with SMTP id smtpd.web10.17152.1736336691808251215
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jan 2025 03:44:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=qXqMO3Dd;
 spf=pass (domain: bmw.de, ip: 207.54.72.35, mailfrom: prvs=0961682e6=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1736336692; x=1767872692;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hi6tZuvJKcet3o4hbMSlkW/GKvzjqfx8oiK5s8cRBsA=;
  b=qXqMO3DdsYd4M5gZ7JIQ1ghQWnGZyTw82TlisqeML4wbN7noMvJf9D+k
   eypLC7jg8IzSZLxhYZ9qciiDM/sWe2BuQRsBmdXWqz0kGw5Onvw/NVkQZ
   qj2CEHqNQhdHxTxGuevfJB4DZpqKiGWaaTB48UTga2tde87/3siE4qgTb
   o=;
X-CSE-ConnectionGUID: 0emxCvLjSqOcrmL+NEg2cg==
X-CSE-MsgGUID: inLEdZwlSaW81Lk8XadjcQ==
Received: from esagw3.bmwgroup.com (HELO esagw3.muc) ([160.46.252.35]) by
 esa13.hc324-48.eu.iphmx.com with ESMTP/TLS; 08 Jan 2025 12:44:50 +0100
Received: from esabb2.muc ([160.50.100.34])  by esagw3.muc with ESMTP/TLS;
 08 Jan 2025 12:44:50 +0100
Received: from smucmp07b.bmwgroup.net (HELO SMUCMP07b.europe.bmw.corp) ([10.30.13.60])
 by esabb2.muc with ESMTP/TLS; 08 Jan 2025 12:44:50 +0100
Received: from [10.130.76.55] (10.30.85.213) by SMUCMP07b.europe.bmw.corp
 (2a03:1e80:a15:58f::220b) with Microsoft SMTP Server (version=TLS;
 Wed, 8 Jan 2025 12:44:49 +0100
X-CSE-ConnectionGUID: Dkfs54pKT8eXnHscMgHNjA==
X-CSE-MsgGUID: W3kH7B3fQmqOl/Xhl+Tm/A==
X-CSE-ConnectionGUID: al9JsOXOQRmCLCd6gpGb3w==
X-CSE-MsgGUID: Ina1oTczQ2m5hbPIdop6Ug==
Message-ID: <db4bb2e8-a1c7-4fe9-8864-2c8e9fecd6e1@bmw.de>
Date: Wed, 8 Jan 2025 12:44:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] asyncrpc: Handle websockets exceptions
To: Ross Burton <Ross.Burton@arm.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <20241230123547.2593913-1-philip.lorenz@bmw.de>
 <589E07F9-08E5-4997-B1FF-D11DEADDA500@arm.com>
From: Philip Lorenz <philip.lorenz@bmw.de>
In-Reply-To: <589E07F9-08E5-4997-B1FF-D11DEADDA500@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: smucmp18b.europe.bmw.corp (2a03:1e80:a15:58f::1:51) To
 SMUCMP07b.europe.bmw.corp (2a03:1e80:a15:58f::220b)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Jan 2025 11:45:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16988

Hi Ross,

On 08.01.25 12:36, Ross Burton wrote:
> On 30 Dec 2024, at 12:35, Philip Lorenz via lists.openembedded.org <philip.lorenz=bmw.de@lists.openembedded.org> wrote:
>> +            except asyncio.exceptions.TimeoutError:
>> +                raise ConnectionError("Timeout while connecting to websocket")
>> +            except (OSError, websockets.InvalidHandshake, websockets.InvalidURI) as exc:
>> +                raise ConnectionError(f"Could not connect to websocket: {exc}") from exc
> Is there a reason to not use the original exception in the TimeoutError case, but use it in the OSError case?

I added an explicit block for the timeout case as unfortunately the 
string representation of a TimeoutError is the empty string (so the 
error message for that case would not be very helpful):

> Python 3.13.1 (main, Dec  4 2024, 18:05:56) [GCC 14.2.1 20240910] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>> import asyncio
> >>> str(asyncio.exceptions.TimeoutError())
> ''
> >>>
Br,

Philip

-- 
Philip Lorenz
BMW Car IT GmbH, Software-Plattform, -Integration Connected Company, Lise-Meitner-Straße 14, 89081 Ulm
-------------------------------------------------------------------------
BMW Car IT GmbH
Management: Chris Brandt, Michael Böttrich, Christian Salzmann
Domicile and Court of Registry: München HRB 134810
-------------------------------------------------------------------------


