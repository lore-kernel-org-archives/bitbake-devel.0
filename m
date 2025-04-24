Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F20C369AB
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 07:48:12 +0000 (UTC)
Received: from esa14.hc324-48.eu.iphmx.com (esa14.hc324-48.eu.iphmx.com [207.54.69.24])
 by mx.groups.io with SMTP id smtpd.web11.10064.1745480891237880984
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Apr 2025 00:48:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=Tb+7UHSG;
 spf=pass (domain: bmw.de, ip: 207.54.69.24, mailfrom: prvs=2029e21cc=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745480891; x=1777016891;
  h=message-id:date:mime-version:subject:to:references:from:
   cc:in-reply-to:content-transfer-encoding;
  bh=ZWcV1XkAu3kMvA9BGmqHk77MBAsJZWG/FPNBExL2UlY=;
  b=Tb+7UHSGgL45CycPdy7m/0h4/UAFQrdHv9udUbixzePqph2dR553Drio
   i3MctGal4En56YxDwtmKhpHO/jn9sSWNPqFVOuf91LPVrj6oTAkQTiq2i
   8YTcbhdzMXVqnZrd3+jxErgE5etQpQ+7AhQu+8xzFDqwBG5/flY85GuEd
   M=;
X-CSE-ConnectionGUID: ADBqcI+nR86FoIEBEABQ/A==
X-CSE-MsgGUID: fwSA5rWBRGCWzK4HQsxOqw==
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa14.hc324-48.eu.iphmx.com with ESMTP/TLS; 24 Apr 2025 09:48:08 +0200
Received: from esabb1.muc ([160.50.100.31])  by esagw6.muc with ESMTP/TLS;
 24 Apr 2025 09:48:08 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb1.muc with ESMTP/TLS; 24 Apr 2025 09:48:08 +0200
Received: from [10.242.8.39] (10.30.85.200) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Thu, 24 Apr 2025 09:48:08 +0200
X-CSE-ConnectionGUID: dqTj63RUQ1eiY8LiOfG49Q==
X-CSE-MsgGUID: TDFKy9QHT66myyRmyPZ8kQ==
X-CSE-ConnectionGUID: Z9RuHH3FRrqGqx2ObnrdZQ==
X-CSE-MsgGUID: kC3741s1QE20SBnOB/kOxw==
Message-ID: <404982c1-3b75-48e9-9182-1b66aa3d3b43@bmw.de>
Date: Thu, 24 Apr 2025 09:48:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 3/8] fetch2: Check for git-lfs existence
 before using it
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
References: <20250423151901.1300944-1-philip.lorenz@bmw.de>
 <20250423151901.1300944-4-philip.lorenz@bmw.de>
 <D9EOJ22QSMAC.3LNDP3MSMSGCG@bootlin.com>
From: Philip Lorenz <philip.lorenz@bmw.de>
CC: <bitbake-devel@lists.openembedded.org>
In-Reply-To: <D9EOJ22QSMAC.3LNDP3MSMSGCG@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SMUCMP12E.europe.bmw.corp (2a03:1e80:a15:58f::1:320) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Apr 2025 07:48:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17552

Hi Mathieu,

On 24.04.25 09:10, Mathieu Dubois-Briand wrote:
> Sent from outside the BMW organization  - be CAUTIOUS, particularly with links and attachments.
> Absender außerhalb der BMW Organisation - Bitte VORSICHT beim Öffnen von Links und Anhängen.
> -----------------------------------------------------------------------------------------------
>
> On Wed Apr 23, 2025 at 5:18 PM CEST, Philip Lorenz via lists.openembedded.org wrote:
>> So far, existence of `git-lfs` was only checked during unpacking. As the
>> binary is also used in earlier steps also check for its existence there.
>>
>> Additionally, factor out the LFS existence check into a dedicated
>> function and call it wherever git-lfs is used for the first time.
>>
>> Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
>> ---
>
>
> I was not able to test this series on the autobuilder so far, as I
> believe git-lfs is not installed in there. Now maybe this has to be a
> new requirement on the host and maybe this is fine. Just two points:
> - Is that really a new requirement and is it needed?

The requirement isn't new but simply was never checked before (so users 
would've seen a git-lfs not found error rather than the helpful error 
message that is raised during unpacking). Support for LFS can be 
explicitly disabled for per URI by adding lfs=0 to its parameter list. 
git-lfs is already needed during downloading as this is the point in 
time at which the large file objects need to be retrieved. During unpack 
pointers in the repository (this process is called smudging) are 
replaced by those downloaded objects.

However I just noticed that I was missing parentheses in patch 6 (it 
should have been `url += ";lfs=%s" % ("1" if self._need_lfs(ud) else 
"0")`) which would explain any possible failures (for example in 
vulkan-samples). If there are no further comments on this series I'll 
push a revised series in the next couple of days.

> - We probably need to update a bit of documentation about that.

I would've hoped that this is already documented since the LFS feature 
has been around for quite a while (but have to admit that I couldn't 
find anything on it inside the bitbake documentation). This patch series 
merely ensures that it also works correctly when used via the "gitsm" 
fetcher (and while at it improves some of the existing implementation). 
I'm happy to write up something for the documentation but I'd suggest to 
send this in via a dedicated patch series.

Philip


-- 
Philip Lorenz
BMW Car IT GmbH, Software-Plattform, -Integration Connected Company, Lise-Meitner-Straße 14, 89081 Ulm
-------------------------------------------------------------------------
BMW Car IT GmbH
Management: Chris Brandt, Michael Böttrich, Christian Salzmann
Domicile and Court of Registry: München HRB 134810
-------------------------------------------------------------------------


