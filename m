Return-Path: <gary@mlbassoc.com>
Received: from mail.analogue-micro.com (mail.analogue-micro.com
	[217.144.149.242])
	by mail.openembedded.org (Postfix) with ESMTP id 1FA1A60746
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 06:33:55 +0000 (UTC)
Received: by mail.analogue-micro.com (Postfix, from userid 999)
	id 47A1168A01C; Tue, 19 Jul 2016 07:33:55 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	loki.analogue-micro-ltd.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=5.0 tests=ALL_TRUSTED,BAYES_50,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from zeus.mlbassoc.com (unknown [10.8.0.2])
	by mail.analogue-micro.com (Postfix) with ESMTP id F3C1068A019;
	Tue, 19 Jul 2016 07:33:54 +0100 (BST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by zeus.mlbassoc.com (Postfix) with ESMTP id A8B506740021;
	Tue, 19 Jul 2016 08:33:54 +0200 (CEST)
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: Gary Thomas <gary@mlbassoc.com>
Message-ID: <578DC9D2.1060607@mlbassoc.com>
Date: Tue, 19 Jul 2016 08:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.8.0
MIME-Version: 1.0
Subject: New progress meters
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
X-List-Received-Date: Tue, 19 Jul 2016 06:33:58 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I quite like the new progress meters, but they seem to not be very
accurate.  I was just rebuilding webkitgtk and got this:

0: webkitgtk-2.12.3-r0 do_compile (pid 30494)  96% |#######################################  | ETA:  0:02:58

Sadly, it sat there, waffling between 02:58 and 03:44 for about
10 minutes...

* How is this [estimate] calculated?
* Should I be concerned when it's not accurate (or even moving)?

n.b. I wasn't sure the best place for this question, the bitbake
list, generic Yocto or OE-core.  Feel free to redirect as needed.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

