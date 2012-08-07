Received: from almaty.radix50.net ([85.214.25.173] helo=almaty.kz-easy.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ibr@radix50.net>) id 1SyrWw-0001Jp-3U
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 Aug 2012 23:41:34 +0200
Received: from alatau.radix50.net (dslb-088-065-252-033.pools.arcor-ip.net
	[88.65.252.33]) (authenticated bits=0)
	by almaty.kz-easy.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id
	q77LKD8c008594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 7 Aug 2012 23:20:14 +0200
Received: from medeu.radix50.net (root@medeu [192.168.0.3])
	by alatau.radix50.net (8.14.3/8.14.3/Debian-5) with ESMTP id
	q77LK8tu028223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 7 Aug 2012 23:20:08 +0200
Received: from medeu.radix50.net (ibr@localhost [127.0.0.1])
	by medeu.radix50.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id
	q77LK8UX015132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 7 Aug 2012 23:20:08 +0200
Received: (from ibr@localhost)
	by medeu.radix50.net (8.14.3/8.14.3/Submit) id q77LK8Sv015131
	for bitbake-devel@lists.openembedded.org; Tue, 7 Aug 2012 23:20:08 +0200
Date: Tue, 7 Aug 2012 23:20:08 +0200
From: Baurzhan Ismagulov <ibr@radix50.net>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20120807212006.GC13756@radix50.net>
MIME-Version: 1.0
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Flag: YES
X-Spam-Status: Yes, score=6.6 required=5.0 tests=RCVD_IN_BRBL_LASTEXT,
	RCVD_IN_PBL, RCVD_IN_SORBS_DUL, RDNS_DYNAMIC,
	TO_NO_BRKTS_DYNIP autolearn=no version=3.3.1
X-Spam-Report: * 0.0 RCVD_IN_SORBS_DUL RBL: SORBS: sent directly from dynamic IP
	address *      [88.65.252.33 listed in dnsbl.sorbs.net]
	*  3.6 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
	*      [88.65.252.33 listed in zen.spamhaus.org]
	*  1.6 RCVD_IN_BRBL_LASTEXT RBL: RCVD_IN_BRBL_LASTEXT
	*      [88.65.252.33 listed in bb.barracudacentral.org]
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  1.0 TO_NO_BRKTS_DYNIP TO_NO_BRKTS_DYNIP
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on almaty.kz-easy.com
Subject: bitbake under msys
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 07 Aug 2012 21:41:34 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I've tried to use bitbake under msys. First, I used python 2.6 for
Windows; this failed due to import fcntl. Then I tried cygwin python;
this failed with the following message:

ERROR: Unable to parse conf/bitbake.conf: file conf/bitbake.conf not
found in c:/Data/home/ibr/src/hellobb/bb

Is there a combination that works under msys?

With kind regards,
Baurzhan.


