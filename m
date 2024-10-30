Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6CDD5CC86
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 10:12:01 +0000 (UTC)
Received: from esa3.hc324-48.eu.iphmx.com (esa3.hc324-48.eu.iphmx.com [207.54.68.121])
 by mx.groups.io with SMTP id smtpd.web10.11640.1730283120831699329
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 03:12:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=mBUHsOGZ;
 spf=pass (domain: bmw.de, ip: 207.54.68.121, mailfrom: prvs=026b2e8c7=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1730283121; x=1761819121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vlnBdjkreFGVYYPRGyQqUaKfdBlzUMfAsrRa3w65sKw=;
  b=mBUHsOGZd9Utbuh69PbRFRtH+jvN8QK632iTKUdRM2iq7j5Qw8m4KqPm
   EHXdTk7g8wF9E4md6oaw4gtEc53W3q3JrgFC/4yXNKy2uqAqKR2P+Hh4d
   mTu8eu8t7fxd7HU6cEKPF6qLKHkhTSwm+bHlQsLyFZ2WadJFWM93GY2Wo
   Q=;
X-CSE-ConnectionGUID: bD+I2Q6RSyOolfbGrmvBCw==
X-CSE-MsgGUID: tKl/l7ksRSygw3SUBRtMxQ==
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa3.hc324-48.eu.iphmx.com with ESMTP/TLS; 30 Oct 2024 11:11:58 +0100
Received: from esabb2.muc ([160.50.100.34])  by esagw4.muc with ESMTP/TLS;
 30 Oct 2024 11:11:58 +0100
Received: from smucmp10e.bmwgroup.net (HELO SMUCMP10E.europe.bmw.corp) ([10.30.13.87])
 by esabb2.muc with ESMTP/TLS; 30 Oct 2024 11:11:56 +0100
Received: from [10.242.8.35] (10.30.85.201) by SMUCMP10E.europe.bmw.corp
 (2a03:1e80:a15:58f::2027) with Microsoft SMTP Server (version=TLS;
 Wed, 30 Oct 2024 11:11:55 +0100
X-CSE-ConnectionGUID: bvJahqesRPqNzqElCkVCSA==
X-CSE-MsgGUID: Dyj3BhyCThu6JVxoQHm5+Q==
X-CSE-ConnectionGUID: oGvNnMgHQJ6wSW2Z98+2aw==
X-CSE-MsgGUID: 7Z4kNOo5QCC+5vZcuXtWCA==
Message-ID: <83985784-9451-4f7d-95b8-1589ef5c2883@bmw.de>
Date: Wed, 30 Oct 2024 11:11:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] codeparser: Fix handling of string AST
 nodes with older Python versions
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>, <steve@sakoman.com>
References: <20241030091721.1598782-1-philip.lorenz@bmw.de>
 <CANNYZj_M50TJAWxhUX7vGHAso0YdKdxfMsmp7d0H8zy230251Q@mail.gmail.com>
From: Philip Lorenz <philip.lorenz@bmw.de>
In-Reply-To: <CANNYZj_M50TJAWxhUX7vGHAso0YdKdxfMsmp7d0H8zy230251Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SMUCMP08B.europe.bmw.corp (2a03:1e80:a15:58f::22fd) To
 SMUCMP10E.europe.bmw.corp (2a03:1e80:a15:58f::2027)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 10:12:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16744

Hi Alex,

On 30.10.24 10:38, Alexander Kanavin wrote:
> I guess this is only aimed for kirkstone? If so, you need to put
> [kirkstone] in the subject.

There seems to be some significant delay in mail delivery somewhere (I 
just received this mail 30 minutes "late"). I have in the meantime 
already resent the patch with a [2.0] prefix. I hope that's fine but can 
also resend with [kirkstone] if this is needed to make sure it shows up 
in the correct filters.

Philip


-- 
Philip Lorenz
BMW Car IT GmbH, Software-Plattform, -Integration Connected Company, Lise-Meitner-Straße 14, 89081 Ulm
-------------------------------------------------------------------------
BMW Car IT GmbH
Management: Chris Brandt and Michael Böttrich
Domicile and Court of Registry: München HRB 134810
-------------------------------------------------------------------------


