Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 64CF0761D3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 10:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 4EE602E407;
	Tue, 28 Jul 2015 12:57:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 8BaPhdeX7iSY; Tue, 28 Jul 2015 12:57:17 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 846E72E3D8;
	Tue, 28 Jul 2015 12:57:17 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 65D5710FB;
	Tue, 28 Jul 2015 12:57:17 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 55586EFB;
	Tue, 28 Jul 2015 12:57:17 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 51FE834005;
	Tue, 28 Jul 2015 12:57:17 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Tue, 28 Jul 2015
	12:57:16 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id E1C169C68B; 
	Tue, 28 Jul 2015 12:57:16 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: Peter Urbanec <openembedded-devel@urbanec.net>,
	<bitbake-devel@lists.openembedded.org>
In-Reply-To: <55B71765.6070901@urbanec.net>
References: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
	<CABcZANkHbT0R6HY5jtuCN+LLnJ2fVJV2nSVa5u_VCcTdzrct9w@mail.gmail.com>
	<6E51916E4A1F32428260031F4C7CD2B6101D2743@ORSMSX109.amr.corp.intel.com>
	<55B71765.6070901@urbanec.net>
Date: Tue, 28 Jul 2015 12:57:16 +0200
Message-ID: <1438080227-sup-10@axis.com>
User-Agent: Sup/0.20.0
MIME-Version: 1.0
Subject: Re: [PATCH] wget.py: support for semi-colons in URL
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
X-List-Received-Date: Tue, 28 Jul 2015 10:57:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Excerpts from Peter Urbanec's message of 2015-07-28 07:47:17 +0200:
> I have not examined the code, but could the URL use the standard URL 
> encoding mechanism to represent ; as %3B ?
> 
> The idea being that the initial "Bitbake URL" is parsed / split using 
> the original string with semicolons and the URL escaped semicolon is 
> passed through to a lower layer that uses that part of the string as an 
> "Internet URL"

URI encoded enitities today are handled correctly in my opinion. If I
have a filename including a ;, I don't want it to be parsed as part of
the URL, neither by bitbake nor the remote server --- that's where URI
encoding comes in.

By hijacking URI encoding to mean "part of the URI, not parsed by
bitbake", you will suprise users that expect it to mean "URI data, not
URI control character" if I understand your proposal correctly.

That could be solved by double encoding, but I don't think that would be
worth it, all occurences of URI encoding in SRC_URI today would have to
be updated. E.g. %20 -> %2520.

-- 
olof johansson

