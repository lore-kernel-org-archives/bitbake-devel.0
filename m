Return-Path: <gary@mlbassoc.com>
Received: from mail.analogue-micro.com (mail.analogue-micro.com
	[217.144.149.242])
	by mail.openembedded.org (Postfix) with ESMTP id DDE686012C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Mar 2016 09:39:43 +0000 (UTC)
Received: by mail.analogue-micro.com (Postfix, from userid 999)
	id 3B62068A01A; Thu, 17 Mar 2016 09:39:44 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	loki.analogue-micro-ltd.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=5.0 tests=ALL_TRUSTED,BAYES_50,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from zeus.mlbassoc.com (unknown [10.8.0.2])
	by mail.analogue-micro.com (Postfix) with ESMTP id C3FA168A019;
	Thu, 17 Mar 2016 09:39:43 +0000 (GMT)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by zeus.mlbassoc.com (Postfix) with ESMTP id 7DC57674053F;
	Thu, 17 Mar 2016 10:39:43 +0100 (CET)
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: Gary Thomas <gary@mlbassoc.com>
Message-ID: <56EA7B5F.9030700@mlbassoc.com>
Date: Thu, 17 Mar 2016 10:39:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.6.0
MIME-Version: 1.0
Subject: bitbake hang
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 17 Mar 2016 09:39:46 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Typing ^C very early on causes a complete hang:

$ bitbake some-image
NOTE: Started PRServer with DBfile: /local/p7619_2016-02-23/cache/prserv.sqlite3, IP: 127.0.0.1, PORT: 43616, PID: 14386
Parsing recipes:  11% |########### 
         | ETA:  00:00:21
Keyboard Interrupt, closing down...

WARNING: Timeout while attempting to communicate with bitbake server
WARNING: Timeout while attempting to communicate with bitbake server
WARNING: Timeout while attempting to communicate with bitbake server
WARNING: Timeout while attempting to communicate with bitbake server
ERROR: Gave up; Too many tries: timeout while attempting to communicate with bitbake server

Tested using poky:8debfea81e69d038bd2d56314b272cb74f5582ed

Should I file a bug?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

