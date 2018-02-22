Return-Path: <A.Baumfalk@astro-kom.de>
Received: from mailrelay-out2.netcologne.de (mailrelay-out2.netcologne.de
	[81.173.193.132])
	by mail.openembedded.org (Postfix) with ESMTP id 1BD3271A32
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Feb 2018 08:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mailrelay-out2.netcologne.de (Postfix) with ESMTP id 7ACA810B2FB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Feb 2018 09:13:31 +0100 (CET)
Received: from [213.196.222.82] (helo=mailrelay-out2.netcologne.de)
	by localhost with ESMTP (eXpurgate 4.3.1)
	(envelope-from <A.Baumfalk@astro-kom.de>)
	id 5a8e7bab-0bdc-7f0000012729-7f0000018e85-1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Feb 2018 09:13:31 +0100
Received: from ASTRO-EX1.Bensberg.de (unknown [213.196.222.82])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailrelay-out2.netcologne.de (Postfix) with ESMTPS
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Feb 2018 09:13:30 +0100 (CET)
Received: from [192.168.8.2] (192.168.100.114) by ASTRO-EX1.Bensberg.de
	(192.168.100.26) with Microsoft SMTP Server (TLS) id 15.0.775.38;
	Thu, 22 Feb 2018 09:13:29 +0100
From: "Dr. Arno Baumfalk" <a.baumfalk@astro-kom.de>
To: <bitbake-devel@lists.openembedded.org>
References: <a2f951c8-72a9-49a8-362b-a176577f351a@astro-kom.de>
Message-ID: <69a3da2f-d650-3dc7-10dc-fe0986996d43@astro-kom.de>
Date: Thu, 22 Feb 2018 09:13:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a2f951c8-72a9-49a8-362b-a176577f351a@astro-kom.de>
X-Originating-IP: [192.168.100.114]
X-ClientProxiedBy: ASTRO-EX1.Bensberg.de (192.168.100.26) To
	ASTRO-EX1.Bensberg.de (192.168.100.26)
X-purgate-ID: 153929::1519287211-00000BDC-239BE731/0/0
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
X-List-Received-Date: Thu, 22 Feb 2018 08:13:31 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE

Hi,

just for reference: I have split my migration problem into smaller steps 
and solved the reported error, which occured during migration from 
jethro to krogoth.

The point was, that I had to add my custom gitsmlocal fetcher to a list 
of git fetchers (git and gitsm) in base.bbclass, where "needsrcrev" is 
set. This was a bit surprising for me, for I thought that returning 
"True" on supports_srcrev in the fetcher code should suffice, but maybe 
I missed something here.

Anyhow, I successfully migrated to morty and now I am working on pyro, 
where I found a problem with a crashing Cooker, which seems to run int 
an endless recursion - I might come back to this in another thread.

One final question: I was looking for some description of the fetcher 
interface, but could not find anything. This would help a lot, as for 
now I can only do try-and-error and analyse the other fetchers; could 
someone provide my with some hints here (anything appreciated, no matter 
if incomplete or outdated)?

Arno

