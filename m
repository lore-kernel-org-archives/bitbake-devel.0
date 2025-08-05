Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD72BC87FCB
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 09:58:54 +0000 (UTC)
Received: from esa5.hc324-48.eu.iphmx.com (esa5.hc324-48.eu.iphmx.com [207.54.71.60])
 by mx.groups.io with SMTP id smtpd.web10.18344.1754387925892299486
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Aug 2025 02:58:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=Kmzcq4bb;
 spf=pass (domain: bmw.de, ip: 207.54.71.60, mailfrom: prvs=3058a794e=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1754387925; x=1785923925;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=yw9+rlk8EmC7SzU5qcxPUrwsR5BjO5giNmlGAC6/ysM=;
  b=Kmzcq4bbP3dphRiLlBMkmKeDjuYHgtUrQNiddEwAsbM/VtWeIOZZEJow
   fzNXBn52eq7l5oPgVXHTWC0sVvsO/fYwdOc5djOsPaGM1k867xutS/oUD
   kAFWls9nMGR4EodtiPgyvgVYKF3v4tZQ4j7sl9rf575b9GjTTOyboPoKj
   A=;
X-CSE-ConnectionGUID: R7OEae6qS0yv7ob592qMuw==
X-CSE-MsgGUID: MPLoDMkHT2a/WaGYFt0geA==
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa5.hc324-48.eu.iphmx.com with ESMTP/TLS; 05 Aug 2025 11:58:21 +0200
Received: from unknown (HELO esabb4.muc) ([10.31.187.135]) by esagw6.muc with
 ESMTP/TLS; 05 Aug 2025 11:58:21 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb4.muc with ESMTP/TLS; 05 Aug 2025 11:58:20 +0200
Received: from [10.242.8.41] (10.30.85.200) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Tue, 5 Aug 2025 11:58:20 +0200
X-CSE-ConnectionGUID: w+QDMVsBRf6rouDBiVRz+Q==
X-CSE-MsgGUID: u9vH/BTNRzeqzkNSdhDnBQ==
X-CSE-ConnectionGUID: WEzUiongRCiUtzm403f2BQ==
X-CSE-MsgGUID: kj0OzVETSZCA/YkAIhQRNw==
Message-ID: <74e41b81-6c18-46cf-a808-b28e955a5fe2@bmw.de>
Date: Tue, 5 Aug 2025 11:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <bitbake-devel@lists.openembedded.org>
From: Philip Lorenz <philip.lorenz@bmw.de>
Subject: Hash equivalence server garbage collection and *_qa tasks
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: smucmp18a.europe.bmw.corp (2a03:1e80:a15:58f::1:50) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Aug 2025 09:58:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17836

Hi all,

we have deployed the clean up strategy proposed on IRC (mark all 
unihashes with a corresponding central sstate entry as alive, then 
sweep) for a couple of months and are observing that the *_qa tasks 
(e.g. do_package_qa) contribute a significant amount of "stale" hash 
equivalence entries to our database.

Technically this is expected as the tasks always produce the same 
outhash (and are thus mapped to the same unihash every time they are 
rebuilt) however the database schema currently does not seem to carry 
enough metadata (e.g. a creation timestamp) to identify those unihash 
entries and to mark them for removal.

Are there any known strategies to address this?

If not I see some possibilities to deal with this but I'd like to 
collect some feedback before proposing an actual change:

* Add a created column to the unihashes_v3 table and parametrize marking 
to omit entries older than a certain timestamp.
* Add a access time column to unihashes_v3. I do realize that this code 
path is performance critical so this would involve some mechanism to 
only update the access time of an entry once per day (similar to what 
relatime does for file systems). The advantage of this would be more 
sophisticated clean up strategies which keep all entries that have 
actually been used in the past x days.

Philip

-- 
Philip Lorenz
BMW Car IT GmbH, Software-Plattform, -Integration Connected Company, Lise-Meitner-Straße 14, 89081 Ulm
-------------------------------------------------------------------------
BMW Car IT GmbH
Management: Michael Böttrich, Chris Brandt, Christian Salzmann
Domicile and Court of Registry: München HRB 134810
-------------------------------------------------------------------------


