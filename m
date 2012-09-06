Received: from almaty.radix50.net ([85.214.25.173] helo=almaty.kz-easy.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ibr@radix50.net>) id 1T9cOS-0006Gl-1v
	for bitbake-devel@lists.openembedded.org;
	Thu, 06 Sep 2012 15:45:16 +0200
Received: from burundai.radix50.net (ip-2-205-216-232.web.vodafone.de
	[2.205.216.232]) (authenticated bits=0)
	by almaty.kz-easy.com (8.14.3/8.14.3/Debian-9.4) with ESMTP id
	q86DWkBf028714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 6 Sep 2012 15:32:49 +0200
Received: from burundai.radix50.net (localhost [127.0.0.1])
	by burundai.radix50.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id
	q86DWdfE005881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 6 Sep 2012 15:32:39 +0200
Received: (from ibr@localhost)
	by burundai.radix50.net (8.14.3/8.14.3/Submit) id q86DWcOn005880
	for bitbake-devel@lists.openembedded.org; Thu, 6 Sep 2012 15:32:38 +0200
Date: Thu, 6 Sep 2012 15:32:38 +0200
From: Baurzhan Ismagulov <ibr@radix50.net>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20120906133236.GC2696@radix50.net>
References: <20120807212006.GC13756@radix50.net>
 <4900668.FanvGGHKG9@helios>
MIME-Version: 1.0
In-Reply-To: <4900668.FanvGGHKG9@helios>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Flag: YES
X-Spam-Status: Yes, score=6.2 required=5.0 tests=RCVD_IN_PBL, RCVD_IN_RP_RNBL, 
	RDNS_DYNAMIC,TO_NO_BRKTS_DYNIP autolearn=no version=3.3.1
X-Spam-Report: *  3.6 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
	*      [2.205.216.232 listed in zen.spamhaus.org]
	*  1.3 RCVD_IN_RP_RNBL RBL: Relay in RNBL,
	*      https://senderscore.org/blacklistlookup/
	*      [2.205.216.232 listed in bl.score.senderscore.com]
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  1.0 TO_NO_BRKTS_DYNIP TO_NO_BRKTS_DYNIP
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on almaty.kz-easy.com
Subject: Re: bitbake under msys
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
X-List-Received-Date: Thu, 06 Sep 2012 13:45:16 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 06, 2012 at 02:22:56PM +0100, Paul Eggleton wrote:
> > I've tried to use bitbake under msys. First, I used python 2.6 for
> > Windows; this failed due to import fcntl. Then I tried cygwin python;
> > this failed with the following message:
...
> > Is there a combination that works under msys?
> 
> I'm not sure that this is supported. Patches to improve the situation might be 
> accepted if they're not too invasive though.

Thanks for the info. For now, I ended up using Cygwin, which is
measurably slower.

With kind regards,
Baurzhan.


