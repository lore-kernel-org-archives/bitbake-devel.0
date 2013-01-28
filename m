Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1Tzprf-0004J2-VH
	for bitbake-devel@lists.openembedded.org;
	Mon, 28 Jan 2013 15:39:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id B3A8F19DDA;
	Mon, 28 Jan 2013 15:23:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UyThtL7KkBZf; Mon, 28 Jan 2013 15:23:37 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by anubis.se.axis.com (Postfix) with ESMTP id E63DE19DD8;
	Mon, 28 Jan 2013 15:23:36 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id E471034166;
	Mon, 28 Jan 2013 15:23:36 +0100 (CET)
Received: from axis.com (10.92.17.1) by xmail2.se.axis.com (10.0.5.74) with
	Microsoft SMTP Server (TLS) id 8.2.176.0;
	Mon, 28 Jan 2013 15:23:36 +0100
Date: Mon, 28 Jan 2013 15:23:35 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Martin Jansa <martin.jansa@gmail.com>
Message-ID: <20130128142335.GZ28382@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
	<20130128140526.GZ16904@jama.palm1.palmone.com>
MIME-Version: 1.0
In-Reply-To: <20130128140526.GZ16904@jama.palm1.palmone.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/6] fetch2: SFTP fetcher and restructure of decodeurl
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
X-List-Received-Date: Mon, 28 Jan 2013 14:39:16 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 2013-01-28 15:05, Martin Jansa wrote:
> Can you please rebase your patchset on latest master?
> 
> 2nd patch conflicts with
> commit 22bd19d208f0251f5a1f9b98f3cac66181f3fc07
> Author: Tyler Hall <tylerwhall@gmail.com>
> Date:   Wed Dec 19 18:26:50 2012 -0500
> fetch2: Sort file checksums by value, not path
> 
> Are those patches generated from bitbake repo?
> They start with 'lib/' so patch -p0 is needed instead of default -p1 and
> cannot be applied directly from pw-am.sh :/.

Sorry, will fix, but not until later this evening unfortunately.

(I've set `git config diff.noprefix=true` without realizing the
implications in cases like this. Will remove it.)

-- 
Olof Johansson


