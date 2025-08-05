Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8744CC87FD1
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 12:11:35 +0000 (UTC)
Received: from esa7.hc324-48.eu.iphmx.com (esa7.hc324-48.eu.iphmx.com [207.54.71.126])
 by mx.groups.io with SMTP id smtpd.web10.20463.1754395889379152253
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Aug 2025 05:11:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=jyzyXe+w;
 spf=pass (domain: bmw.de, ip: 207.54.71.126, mailfrom: prvs=3058a794e=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1754395889; x=1785931889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5bGfu0J8PAnqPm1EeWDr6y6BPdsCX8Ok1XAFcJhvJCc=;
  b=jyzyXe+wclThiVz42Fm2JfaXGYSBpGF8Eycr0oWXZ2pnfZd1tR3XuREG
   3l0V6Q0+TzcNJiEW6D6K573orZyNFTIzGqbib5Eyl4T163ghgWMk7Uc/1
   Yx8Zf0Q/XEFzgrj/7KswckdHZjmP7JPmCkAqCfr0VNdRdSOj3hMnfHexC
   k=;
X-CSE-ConnectionGUID: Dr0qmDmASxS3C/6xzfhG6w==
X-CSE-MsgGUID: Jpbsl7qoSFCvHgmkUXIE2A==
Received: from 160.46.252.46.spf.bmwgroup.com (HELO esagw5.muc) ([160.46.252.46]) by
 esa7.hc324-48.eu.iphmx.com with ESMTP/TLS; 05 Aug 2025 14:11:26 +0200
Received: from unknown (HELO esabb4.muc) ([10.31.187.135]) by esagw5.muc with
 ESMTP/TLS; 05 Aug 2025 14:11:09 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb4.muc with ESMTP/TLS; 05 Aug 2025 14:11:09 +0200
Received: from [10.242.8.41] (10.30.85.203) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Tue, 5 Aug 2025 14:11:08 +0200
X-CSE-ConnectionGUID: XsfQ+52LTtO+k7kn6qUe3A==
X-CSE-MsgGUID: z/sOn1W6TeyxMLKqwu8Gkg==
X-CSE-ConnectionGUID: 6cu4p/h7QtOaQgX1uzPBaQ==
X-CSE-MsgGUID: iwggSupwRuuZ7XT/gm2XvA==
Message-ID: <2609feef-e483-4d57-b061-b0a002ee0277@bmw.de>
Date: Tue, 5 Aug 2025 14:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] Hash equivalence server garbage collection and
 *_qa tasks
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>
References: <74e41b81-6c18-46cf-a808-b28e955a5fe2@bmw.de>
 <CANNYZj-XMgeaF3GyTWoXFcg+dPYSmZg09MKd4NKh2R9ZK56Q5g@mail.gmail.com>
Content-Language: en-US
From: Philip Lorenz <philip.lorenz@bmw.de>
In-Reply-To: <CANNYZj-XMgeaF3GyTWoXFcg+dPYSmZg09MKd4NKh2R9ZK56Q5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: smucmp10c.europe.bmw.corp (2a03:1e80:a15:58f::2007) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Aug 2025 12:11:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17838

Hi Alex,

On 05.08.25 12:17, Alexander Kanavin wrote:
> On Tue, 5 Aug 2025 at 11:58, Philip Lorenz via lists.openembedded.org
> <philip.lorenz=bmw.de@lists.openembedded.org> wrote:
>> we have deployed the clean up strategy proposed on IRC (mark all
>> unihashes with a corresponding central sstate entry as alive, then
>> sweep) for a couple of months and are observing that the *_qa tasks
>> (e.g. do_package_qa) contribute a significant amount of "stale" hash
>> equivalence entries to our database.
> I wonder if you can simply remove all package_qa entries once their
> amount exceeds a certain threshold. Such tasks with empty output are
> generally cheap to re-run.

This would eliminate that particular task (and admittedly also the 
biggest "offender" in our database) but similar issues remain for other 
tasks (e.g. do_recipe_qa where an equivalence removal would invalidate 
do_fetch and I guess therefore trigger a partial rebuild). On a closer 
look we also have some package_write_ipk tasks for packagegroup which 
have accumulated several thousand hash equivalence entries over the past 
couple of months.

> Also, if you are using multiple hosts with distinct uids/gids for the
> users running the build, then pre-walnascar there was a bug that
> prevented sstate reuse and multiplied unnecessary package_qa entries,
> so taking this fix may help:
>
> Author: Alexander Kanavin <alex@linutronix.de>
> Date:   Tue Feb 25 13:09:22 2025 +0100
>
>      classes/insane: do not leak host uid/gid into package_qa sstate signatures
>
>      This prevented package_qa sstate from being reusable unless host uid/gid
>      values would  match exactly (and they unfortunately do on the
> yocto autobuilder
>      worker machines which all share a 'pokybuild' user).
>
>      I noticed this when testing CDN sstate reuse, which otherwise works well.

Luckily we're not hit by that one (all builds happen in containers with 
static UIDs). The prime offenders are recipes with "nostamp" tasks 
before packaging (which we are going to refactor) and recipes which 
inject DISTRO_VERSION in their output (and we add the build input hash 
into DISTRO_VERSION so pretty much each build input change causes 
repackaging of said recipes).

Philip

-- 
Philip Lorenz
BMW Car IT GmbH, Software-Plattform, -Integration Connected Company, Lise-Meitner-Straße 14, 89081 Ulm
-------------------------------------------------------------------------
BMW Car IT GmbH
Management: Michael Böttrich, Chris Brandt, Christian Salzmann
Domicile and Court of Registry: München HRB 134810
-------------------------------------------------------------------------


