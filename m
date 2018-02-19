Return-Path: <A.Baumfalk@astro-kom.de>
Received: from mailrelay-out2.netcologne.de (mailrelay-out2.netcologne.de
	[81.173.193.132])
	by mail.openembedded.org (Postfix) with ESMTP id 1EF996022F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Feb 2018 14:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mailrelay-out2.netcologne.de (Postfix) with ESMTP id 50BC110B15E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Feb 2018 15:48:43 +0100 (CET)
Received: from [213.196.222.82] (helo=mailrelay-out2.netcologne.de)
	by localhost with ESMTP (eXpurgate 4.3.1)
	(envelope-from <A.Baumfalk@astro-kom.de>)
	id 5a8ae3cb-0bdc-7f0000012729-7f000001a513-1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Feb 2018 15:48:43 +0100
Received: from ASTRO-EX1.Bensberg.de (unknown [213.196.222.82])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailrelay-out2.netcologne.de (Postfix) with ESMTPS
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Feb 2018 15:48:42 +0100 (CET)
Received: from [192.168.8.2] (192.168.100.114) by ASTRO-EX1.Bensberg.de
	(192.168.100.26) with Microsoft SMTP Server (TLS) id 15.0.775.38;
	Mon, 19 Feb 2018 15:48:25 +0100
From: "Dr. Arno Baumfalk" <a.baumfalk@astro-kom.de>
To: <bitbake-devel@lists.openembedded.org>
References: <a2f951c8-72a9-49a8-362b-a176577f351a@astro-kom.de>
	<0892eb5f-5b52-0e09-6bde-84fa8bda55f1@astro-kom.de>
Message-ID: <592246d2-845d-6953-03f1-abdc33e27afc@astro-kom.de>
Date: Mon, 19 Feb 2018 15:48:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0892eb5f-5b52-0e09-6bde-84fa8bda55f1@astro-kom.de>
X-Originating-IP: [192.168.100.114]
X-ClientProxiedBy: ASTRO-EX1.Bensberg.de (192.168.100.26) To
	ASTRO-EX1.Bensberg.de (192.168.100.26)
X-purgate-ID: 153929::1519051723-00000BDC-6283E614/0/0
X-purgate: clean
Subject: Re: exception in checksum.py
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
X-List-Received-Date: Mon, 19 Feb 2018 14:48:43 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE

Hi all,

I made some small progress - I found a piece of code in base.bbclass, 
which seems responsible for activation of the srcrev mechanism for the 
git fetcher, so I added my custom gitsmlocal fetcher here, too:

# Git packages should DEPEND on git-native
elif scheme in ("git", "gitsm", "gitsmlocal"):
     needsrcrev = True
     d.appendVarFlag('do_fetch', 'depends', ' 
git-native:do_populate_sysroot')

It seems that ${SRCPV} is no longer left unexpanded now, but instead the 
expansion fails with the following error:

ERROR: ExpansionError during parsing /path/to/recipe/foo.bb: Failure 
expanding variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)} 
which triggered exception NameError: global name 'data' is not defined

I hope I am on the right track now - any help still appreciated!

Arno

