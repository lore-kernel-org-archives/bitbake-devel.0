Return-Path: <ola.x.nilsson@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E87C4332F
	for <webhook@archiver.kernel.org>; Mon, 12 Dec 2022 10:30:39 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.39841.1670841034101668285
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Dec 2022 02:30:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=WuXcUZlf;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: ola.x.nilsson@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1670841034;
  x=1702377034;
  h=from:to:subject:date:message-id:mime-version;
  bh=wdu4ZGbPifNjuamw9IoSoyHs/bjXyA5w93G+3pJ4hHI=;
  b=WuXcUZlfT4XogKFgv/tDySUTnUp2yB5NdUwaakh3uAwvrqb6HcfIE0x5
   pTNBKB9uVBF/Ob90CBzPO6pDk6ApaZoaIEMjVINspfZ0wmWnY65/oObYQ
   GZV5ViMKwZy8WKpGjqfFrPtDscSbR8mx4SrWDojulsbW8WZX1lDaXe+Rt
   u/Dq5hY42QYuikYLYrAh91nOv5qxFVQP/Lr6f04W4NQyipqnfvLKX/Kyr
   5KkZCoYxlN9+B13b40SfmYxadca+OHNAaXmEjJ3/u/SWxL0kdjf2VRjuT
   kwEV/mUwp4DwQhUULaJRwoc9MLKlBb/jKNeOLclkhIuPMbEvR/JKRbuT2
   w==;
User-agent: mu4e 1.8.9; emacs 29.0.60
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: Bitbake PSI checker
Date: Mon, 12 Dec 2022 11:07:56 +0100
Organization: Axis Communications AB
Message-ID: <jwq5yegq5h5.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 10:30:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14178

Hi,

I've been looking into using the pressure stall information awareness of
bitbake but I have some problems getting it to work.  Actually I think
it just doesn't work at all.

Reading the code I find that
runqueue.QunQueueScheduler.exceeds_max_pressure claims to "Monitor the
difference in pressure at least once per second".  But using some
debugprints added to that method I see output like

1670840023.757171 cpu_pressure 0.0 io_pressure 0.0 mem_pressure 0.0
1670840023.758697 cpu_pressure 0.0 io_pressure 0.0 mem_pressure 0.0
1670840023.760158 cpu_pressure 0.0 io_pressure 0.0 mem_pressure 0.0
1670840023.761733 cpu_pressure 0.0 io_pressure 0.0 mem_pressure 0.0
1670840023.959357 cpu_pressure 969.0 io_pressure 16135.0 mem_pressure 0.0
1670840042.384582 cpu_pressure 8978077.0 io_pressure 1353882.0 mem_pressure 20922.0
1670840042.384582 cpu io  pressure exceeded over 18.677629 seconds
1670840042.486946 cpu_pressure 466.0 io_pressure 30792.0 mem_pressure 0.0
1670840042.490340 cpu_pressure 466.0 io_pressure 30792.0 mem_pressure 0.0

where the first column is the value of 'now', and the pressure values
are the calculated deltas.  The 0-pressure values are probably because
this is very early in the run and the time delta is less than 0.01
seconds. 

But there is a time delta of almost 19 seconds between line 5 and 6, and
unsurprisingly the pressure exceeds my max settings of CPU:600000 and
IO:200000.

But the very next check is only 0.1 second later and while the
prev-values wont be updated, the calculated pressure will be used.  This
pressure will be below my settings and a new task will be started.

Am I missing something here?  If the pressure should be monitored each
second, isn't it reasonable to have some sort of tick to update the
pre-values?  And using the pressure delta of intervals of less than a
second also seems to give too low pressure values.

/Ola Nilsson

