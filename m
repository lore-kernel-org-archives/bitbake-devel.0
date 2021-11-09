Return-Path: <mikko.rapeli@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B241C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 08:50:55 +0000 (UTC)
Received: from esa4.hc324-48.eu.iphmx.com (esa4.hc324-48.eu.iphmx.com
 [207.54.71.48])
 by mx.groups.io with SMTP id smtpd.web10.9529.1636447853000066409
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 00:50:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=Q1HdP8Xu;
 spf=pass (domain: bmw.de, ip: 207.54.71.48,
 mailfrom: prvs=940d9f5b3=mikko.rapeli@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1636447853; x=1667983853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Lx5K/70fPgDGAMsw1g+D9WVH3p25M2hvssUi8o0K0EM=;
  b=Q1HdP8XuDXiP0Ah6YBWutmJ7l81vVJtbcl/31PVTOWLJdhFbV8vayQpQ
   PqBZeTV+X0lIJ7u5M8Fh2UHRUyijdeFKMP1TRGGDJIiQIRo1nggmOw1Rg
   rOi/Dubh5ZN9DqImWax4sRZjfvOq9YgiJWVRLYjS2lmY0NBHc/iNkG+mN
   M=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa4.hc324-48.eu.iphmx.com with ESMTP/TLS; 09 Nov 2021 09:50:50 +0100
Received: from esabb2.muc ([160.50.100.34])  by esagw6.muc with ESMTP/TLS;
 09 Nov 2021 09:50:49 +0100
Received: from smucm33j.bmwgroup.net (HELO smucm33j.europe.bmw.corp)
 ([160.46.167.66])
 by esabb2.muc with ESMTP/TLS; 09 Nov 2021 09:49:47 +0100
Received: from smucm33l.europe.bmw.corp (160.46.167.68) by
 smucm33j.europe.bmw.corp
 (160.46.167.66) with Microsoft SMTP Server (TLS;
 Tue, 9 Nov 2021 09:49:47 +0100
Received: from smucm33l.europe.bmw.corp ([160.46.167.68]) by
 smucm33l.europe.bmw.corp ([160.46.167.68]) with mapi id 15.00.1497.024; Tue,
 9 Nov 2021 09:49:47 +0100
From: <Mikko.Rapeli@bmw.de>
To: <marius.kriegerowski@gmail.com>
CC: <alex.kanavin@gmail.com>, <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] bitbake style/workflow
Thread-Topic: [bitbake-devel] bitbake style/workflow
Thread-Index: 
 AQHX1MdmVMApIsNeAEOrWCEJZRdwT6v6GgmAgAAP9ICAAAz/AIAAeg6AgAAVogCAAAQfgIAAA30AgAAE4wA=
Date: Tue, 9 Nov 2021 08:49:47 +0000
Message-ID: <YYo2KsoUeMTZ6y5C@korppu>
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
 <CAMaS9hNpp9QsUqkpXvNj_F5R4aQoe+qHg+_mtxnZRL0PoAYaGw@mail.gmail.com>
 <589e9863e78ed9f8234a3756b37ffb979daa770c.camel@linuxfoundation.org>
 <CANNYZj8_zPhh_XCZrxaPvXd_Oz5kzbzHNLvT6qzvtztquKA0ew@mail.gmail.com>
 <CAMaS9hO8yU+T3tKb-dQj-DFx-vqGsUTLc7Jkta1sAM+eDr45BA@mail.gmail.com>
 <CANNYZj9G7YaHpQgCzVZaCjTTAmNXgEiGnkf-GyrXzbxckqp4oA@mail.gmail.com>
 <CAMaS9hNwT5iK8X3NKAq6cJq1qk4mHS99a36kTogc6_=fDHALFA@mail.gmail.com>
In-Reply-To: 
 <CAMaS9hNwT5iK8X3NKAq6cJq1qk4mHS99a36kTogc6_=fDHALFA@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <228CEB70F896EB44B3411CE7616CE759@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 08:50:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12958

Hi,

I'm a heavy user of yocto and bitbake, CI systems and automation, even Gerr=
it
and GitHub, yet I also perfer they way email allows for a completely distri=
buted
review and possibility to follow and join the discussions when ever a subje=
ct
or a change triggers me to respond or hits a nerve. Gerrit, github, gitlab =
etc
they just don't scale this well. I understand that for drive-by contributio=
ns working
with email can be tricky if you are not used it, but same goes for github, =
gerrit,
gitlab etc.

This community is also very welcoming, well behaving and helping first time
contributors. I do see the problem that some first time contributions may b=
e
see the hurdle of "git send-email" as too hard, especially if corporate ema=
il systems
mangle emails. Maybe some tooling could be setup to allow for pull request =
type
contributions to popup on mailing list if sending emails just doesn't work,=
 but I
don't see the benefits of moving fully to gerrit/github/gitlabl style devel=
opment.

ps. maybe I'm also part of the old generation which still actually reads al=
l emails.
I don't see any of the chat/collaboration tools really replacing email in g=
lobal
R&D development world even if chat tools/Slack/MS Teams etc are being propo=
sed
as replacements (they simply don't scale so well in the end).

Cheers,

-Mikko=

